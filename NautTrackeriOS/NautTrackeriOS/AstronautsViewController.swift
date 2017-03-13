import UIKit

class AstronautsViewController: UIViewController {

    let interactor: AstronautsInteractor

    var hostView: AstronautsHostView { return view as! AstronautsHostView }

    init(interactor: AstronautsInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = AstronautsHostView()
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hostView.title = "Astronauts In-Space"
    }

}

extension AstronautsViewController: AstronautsView {

}

class AstronautsHostView: UIView {

    var title: String? {
        get {
            return navigationBar.items?.last?.title
        }

        set {
            let item = UINavigationItem(title: newValue ?? "")
            navigationBar.setItems([item], animated: false)
        }
    }

    private lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()

    init() {
        super.init(frame: .zero)

        addSubview(navigationBar)

        NSLayoutConstraint.activate([
            navigationBar.widthAnchor.constraint(equalTo: widthAnchor),
            navigationBar.centerXAnchor.constraint(equalTo: centerXAnchor),
            navigationBar.topAnchor.constraint(equalTo: topAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 64),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
