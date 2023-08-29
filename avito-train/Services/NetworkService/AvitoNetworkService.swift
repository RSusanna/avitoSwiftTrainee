import Foundation

enum AvitoNetworkServiceEndPoint {
    case main
    case detail(itemId: String)
    
    var point: String {
        switch self {
        case .main:
            return "main-page.json"
        case .detail(let itemId):
            return "details/\(itemId).json"
        }
    }
}

protocol AvitoNetworkServiceProtocol {
    func fetchMainGoods(completion: @escaping (Result<AvitoItem, Error>) -> Void)
    func fetchDetailAdvertisement(itemId: String, completion: @escaping (Result<AdvertisementDetail, Error>) -> Void)
}

final class AvitoNetworkService: AvitoNetworkServiceProtocol {
    private let baseUrl = "https://www.avito.st/s/interns-ios/"
    
    func fetchMainGoods(completion: @escaping (Result<AvitoItem, Error>) -> Void) {
        fetchData(endPoint: .main) { result in
            switch result {
            case .success(let data):
                do {
                    let jsonData = try JSONDecoder().decode(AvitoItem.self, from: data)
                    completion(.success(jsonData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchDetailAdvertisement(itemId: String, completion: @escaping (Result<AdvertisementDetail, Error>) -> Void) {
        fetchData(endPoint: .detail(itemId: itemId)) { result in
            switch result {
            case .success(let detailData):
                do {
                    let detail = try JSONDecoder().decode(AdvertisementDetail.self, from: detailData)
                    completion(.success(detail))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

private extension AvitoNetworkService {
    func fetchData(endPoint: AvitoNetworkServiceEndPoint, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: baseUrl)?.appendingPathComponent(endPoint.point) else {
            completion(.failure(AvitoNetworkError.badUrl))
            return
        }
        var request: URLRequest = .init(url: url, timeoutInterval: 30.0)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(AvitoNetworkError.decode))
                return
            }
            guard let _ = response as? HTTPURLResponse else {
                completion(.failure(AvitoNetworkError.noResponse))
                return
            }
            if let data {
                completion(.success(data))
            }
        }.resume()
    }
}
