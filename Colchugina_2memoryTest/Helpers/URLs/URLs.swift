//
//  URLs.swift
//  Colchugina_2memoryTest
//
//  Created by Ирина Кольчугина on 23.09.2021.
//

import Foundation

final class URLs {
    static func searchPhotos(photosName: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.unsplash.com"
        urlComponents.path = "/search/photos"
        urlComponents.queryItems = [
            URLQueryItem(name: "query", value: "\(photosName)"),
            URLQueryItem(name: "client_id", value: "qKoc_QPEN6oCKwrhEU47MtpKt8Yw6IwDRLSPlWka654")
        ]
        return urlComponents.url
    }
}
