import UIKit

final class DetailedItemAssembly {
    static func asseble(itemId: String) -> UIViewController {
        let router = DetailedItemRouter()
        let networkService = AvitoNetworkService()
        let presenter = DetailedItemPresenter(router: router, itemId: itemId, network: networkService)
        let view = DetailedItemViewController(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
