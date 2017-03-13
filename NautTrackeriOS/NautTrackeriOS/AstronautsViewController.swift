import UIKit

class AstronautsViewController: UIViewController {

    let interactor: AstronautsInteractor

    var hostView: AstronautsView { return view as! AstronautsView }

    init(interactor: AstronautsInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = AstronautsView()
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
        case .loaded(_):
            hostView.loading = false
        }
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
            if loading {
                activityIndicator.startAnimating()
            } else {
                activityIndicator.stopAnimating()
            }
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
