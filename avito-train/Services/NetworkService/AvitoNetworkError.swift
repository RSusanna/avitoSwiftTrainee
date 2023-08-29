import Foundation

enum AvitoNetworkError {
    case badUrl
    case decode
    case noResponse

    case unknown
}

extension AvitoNetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badUrl:
            return NSLocalizedString("Неверный URL адрес", comment: "")
        case .decode:
            return NSLocalizedString("Decode error", comment: "")
        case .noResponse:
            return NSLocalizedString("No responce", comment: "")
        default:
            return NSLocalizedString("Unknow error", comment: "")
        }
    }
}
