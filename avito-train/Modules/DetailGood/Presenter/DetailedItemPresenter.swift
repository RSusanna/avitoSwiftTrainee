import Foundation

final class DetailedItemPresenter {

    weak var view: DetailedItemViewInput?
    
    private let itemId: String
    private let router: DetailedItemRouter
    private let networkSerive: AvitoNetworkServiceProtocol
    
    init(router: DetailedItemRouter, itemId: String, network: AvitoNetworkServiceProtocol) {
        self.router = router
        self.itemId = itemId
        self.networkSerive = network
    }
    
    func viewDidLoad() {
        networkSerive.fetchDetailAdvertisement(itemId: itemId) { [weak self] result in
            switch result {
            case .success(let detail):
                self?.generateViewModel(model: detail)
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.router.showAlert(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
}

extension DetailedItemPresenter: DetailedItemPresenterProtocol {
    
}

private extension DetailedItemPresenter {
    func generateViewModel(model: AdvertisementDetail) {
        let viewModel: DetailItemViewModel = .init(
            imageUrl: model.imageURL, description: model.description,
            title: model.title, price: model.price, location: model.location,
            createdAt: model.createdDate, email: model.email,
            phone: model.phoneNumber, address: model.address
        )
        DispatchQueue.main.async {
            self.view?.updateViewModel(viewModel: viewModel)
        }
    }
}
