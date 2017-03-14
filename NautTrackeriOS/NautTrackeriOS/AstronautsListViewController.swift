import UIKit
import NautTrackerData

protocol AstronautsListViewControllerDataSource {

    var count: Int { get }
    func astronaut(atIndex index: Int) -> Astronaut

}

class AstronautsListViewController: UITableViewController {

    var astronautDataSource: AstronautsListViewControllerDataSource? {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "astronaut")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return astronautDataSource?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "astronaut", for: indexPath)
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let astronaut = astronautDataSource?.astronaut(atIndex: indexPath.row)
        cell.textLabel?.text = astronaut?.name
        cell.detailTextLabel?.text = astronaut?.craft
    }

}
