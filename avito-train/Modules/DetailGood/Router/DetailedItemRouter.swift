import UIKit

protocol DetailedItemRouterProtocol {
    func showAlert(title: String, message: String)
}

final class DetailedItemRouter: DetailedItemRouterProtocol {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Cancel", style: .cancel))
        view?.present(alert, animated: true)
    }
    
    weak var view: UIViewController?
    
}
