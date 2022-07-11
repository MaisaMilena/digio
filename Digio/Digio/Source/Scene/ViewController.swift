import UIKit

public protocol ViewControlerDisplayProtocol {
    func showHighlights(views: [UIImageView])
}

class ViewController: UIViewController {
    private var interactor: InteractorProtocol
    private var tableview: UITableViewController
    
    init(interactor: InteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        interactor.fetch()
    }
}

extension ViewController: ViewControlerDisplayProtocol {
    func showHighlights(views: [UIImageView]) {
        <#code#>
    }
}
