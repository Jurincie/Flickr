//
//  DownloadManager.swift
//  FlickrItem
//
//  Created by Ron Jurincie on 7/7/24.
//

import Foundation

enum DownloadError: Error, CustomStringConvertible {
    case badURL
    case decodingError
    case badURLResponse
    case unknownError
    
    var description: String {
        switch(self) {
        case .badURL: return "Could NOT make URL from given string."
        case .badURLResponse: return "Received response Error on fetch request."
        case .decodingError: return "Error during JSON decoding."
        case .unknownError: return "Unknown Error"
        }
    }
}

enum DownloadManager {
    static func fetch(from urlString: String) async throws -> Welcome {
        guard let url = URL(string: urlString) else { throw DownloadError.badURL }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            if let response = response as? HTTPURLResponse {
                if 200...299 ~= response.statusCode {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    return try decoder.decode(Welcome.self, from: data)
                }
                
                throw DownloadError.badURLResponse
            }
        } catch {
            throw DownloadError.decodingError
        }
        
        throw DownloadError.unknownError
    }
}

