//
//  NetworkLayer.swift
//  Colchugina_2memoryTest
//
//  Created by Ирина Кольчугина on 23.09.2021.
//

import Foundation

//MARK: - NetworkLayerProtocol

protocol NetworkLayerProtocol: AnyObject {
    func fetchPhotos(photosName: String, complition: @escaping(Result<SearchResponse, Error>) -> Void)
}

// MARK: - NetworkLayer

final class NetworkLayer: NetworkLayerProtocol {

    // MARK: - Public methods

    func fetchPhotos(photosName: String, complition: @escaping(Result<SearchResponse, Error>) -> Void) {
        downloadJson(url: URLs.searchPhotos(photosName: photosName), completion: complition)
    }

    // MARK: - Private methods

    private func downloadJson<T: Decodable>(url: URL?, completion: @escaping(Result<T, Error>) -> Void) {

        guard let urls = url else { return }

        let session = URLSession.shared

        session.dataTask(with: urls) { data, response, eror in
            if let error = eror {
                completion(.failure(error))
            }

            if let data = data {
                do {
                    let json = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(json))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }

}

