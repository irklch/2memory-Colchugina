//
//  Search.swift
//  Colchugina_2memoryTest
//
//  Created by Ирина Кольчугина on 22.09.2021.
//

import Foundation

final class SearchResponse: Decodable {
    var results = [SearchResults]()
}

final class SearchResults: Decodable {
    var urls = SearchPhotosUrls()
}

final class SearchPhotosUrls: Decodable {
    var regular = ""
}



