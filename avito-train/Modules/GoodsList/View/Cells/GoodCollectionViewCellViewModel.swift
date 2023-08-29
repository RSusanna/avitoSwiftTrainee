import Foundation

struct GoodCollectionViewCellViewModel {
    let id: String
    let title: String
    let price: String
    let imageUrl: String
    let createdDate: String
    let location: String
    let didTapCell: (String) -> ()
}
