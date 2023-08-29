import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
}

private extension BaseViewController {
    func setupView() {
        view.backgroundColor = .systemBackground
    }
}
