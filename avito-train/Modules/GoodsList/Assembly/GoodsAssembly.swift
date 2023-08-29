import UIKit

final class GoodsAssembly {
    static func assemble() -> UIViewController {
        let networkService = AvitoNetworkService()
        let router = GoodsPresenterRouter()
        let presenter = GoodsPresenter(router: router, networkService: networkService)
        let view = GoodsListViewController(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
