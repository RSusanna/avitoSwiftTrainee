import Foundation

final class GoodsPresenter {
    weak var view: GoodsViewInput?
    
    private let router: GoodsRouterProtocol
    private let networkService: AvitoNetworkServiceProtocol
    
    init(router: GoodsRouterProtocol, networkService: AvitoNetworkServiceProtocol) {
        self.router = router
        self.networkService = networkService
    }
}

extension GoodsPresenter: GoodsPresenterProtocol {
    func viewDidLoad() {
        fetchData()
    }
}

private extension GoodsPresenter {
    func fetchData() {
        networkService.fetchMainGoods { [weak self] result in
            switch result {
            case .success(let goods):
                self?.generateViewModels(models: goods.advertisements)
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.router.showAlert(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
    
    func generateViewModels(models: [Advertisement]) {
        var viewModels = [GoodCollectionViewCellViewModel]()
        
        models.forEach({
            viewModels.append(.init(
                id: $0.id, title: $0.title, price: $0.price, imageUrl: $0.imageURL,
                createdDate: $0.createdDate, location: $0.location) { [weak self] itemId in
                    DispatchQueue.main.async {
                        self?.router.routeToDetail(itemId: itemId)
                    }
                }
            )
        })
        updateCollectionView(viewModels: viewModels)
    }
    
    func updateCollectionView(viewModels: [GoodCollectionViewCellViewModel]) {
        DispatchQueue.main.async {
            self.view?.updateCollection(viewModels: viewModels)
        }
    }
}
