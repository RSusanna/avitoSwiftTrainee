import UIKit

protocol GoodsRouterProtocol {
    func showAlert(title: String, message: String)
    func routeToDetail(itemId: String)
}

final class GoodsPresenterRouter: GoodsRouterProtocol {
    weak var view: UIViewController?
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Cancel", style: .cancel))
        view?.present(alert, animated: true)
    }
    
    func routeToDetail(itemId: String) {
        let detailView = DetailedItemAssembly.asseble(itemId: itemId)
        view?.navigationController?.pushViewController(detailView, animated: true)
    }
}
