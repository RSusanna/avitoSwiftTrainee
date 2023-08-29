import Foundation

protocol GoodsViewInput: AnyObject {
    func updateCollection(viewModels: [GoodCollectionViewCellViewModel])
}
