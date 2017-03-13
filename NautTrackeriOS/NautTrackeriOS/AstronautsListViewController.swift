import UIKit

class AstronautsListViewController: UIViewController {

    let interactor: AstronautsInteractor

    init(interactor: AstronautsInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
