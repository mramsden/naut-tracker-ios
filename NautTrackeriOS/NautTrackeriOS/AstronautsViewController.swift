import UIKit
import NautTrackerData

class AstronautsViewController: UIViewController {

    let interactor: AstronautsInteractor
    let astronautsListViewController: AstronautsListViewController

    var hostView: AstronautsView { return view as! AstronautsView }

    init(interactor: AstronautsInteractor) {
        self.interactor = interactor
        astronautsListViewController = AstronautsListViewController(style: .plain)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = AstronautsView()
        astronautsListViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.contentView = astronautsListViewController.view
        addChildViewController(astronautsListViewController)
        astronautsListViewController.didMove(toParentViewController: self)
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hostView.title = "Astronauts In Space"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor.fetchAstronauts()
    }

}

extension AstronautsViewController: AstronautsPresenterOutputHandler {

    func state(didChangeTo state: AstronautsPresenterState) {
        switch state {
        case .loading:
            hostView.loading = true
        case .empty:
            hostView.loading = false
        case .loaded(let astronauts):
            hostView.loading = false
            astronautsListViewController.astronautDataSource = AstronautsDataSource(astronauts: astronauts)
        }
    }

}

private struct AstronautsDataSource: AstronautsListViewControllerDataSource {

    private let astronauts: [Astronaut]

    init(astronauts: [Astronaut]) {
        self.astronauts = astronauts
    }

    var count: Int {
        return astronauts.count
    }

    func astronaut(atIndex index: Int) -> Astronaut {
        return astronauts[index]
    }

}

class AstronautsView: UIView {

    var title: String? {
        get {
            return navigationBar.items?.last?.title
        }

        set {
            let item = UINavigationItem(title: newValue ?? "")
            navigationBar.setItems([item], animated: false)
        }
    }

    var loading: Bool = false {
        didSet {
            contentView?.isHidden = loading
            if loading {
                activityIndicator.startAnimating()
            } else {
                activityIndicator.stopAnimating()
            }
        }
    }

    var contentView: UIView? {
        willSet {
            contentView?.removeFromSuperview()
        }
        didSet {
            guard let contentView = contentView else { return }
            insertSubview(contentView, belowSubview: navigationBar)
            if let scrollView = contentView as? UIScrollView {
                scrollView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
            }

            NSLayoutConstraint.activate([
                contentView.widthAnchor.constraint(equalTo: widthAnchor),
                contentView.heightAnchor.constraint(equalTo: heightAnchor),
                contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
                contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
            ])
        }
    }

    private lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.color = .black
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    convenience init() {
        self.init(frame: UIApplication.shared.keyWindow?.bounds ?? .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        addSubview(navigationBar)
        addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            navigationBar.widthAnchor.constraint(equalTo: widthAnchor),
            navigationBar.centerXAnchor.constraint(equalTo: centerXAnchor),
            navigationBar.topAnchor.constraint(equalTo: topAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 64),
            activityIndicator.widthAnchor.constraint(equalToConstant: 66),
            activityIndicator.heightAnchor.constraint(equalToConstant: 66),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
