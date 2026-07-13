//
//  Webservice.swift
//  PetInfo.
//
//  Created by Young Jin Ju on 7/12/26.
//

import Foundation

public enum NetworkError: Error {
    case badRequest
    case decodingError
    case unknownError
}

public class Webservice {
    
    private let session: URLSession
    private let decoder = JSONDecoder()   // reuse the decoder
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    /// Fetches and decodes a decodable resource from the given URL.
    /// Calls the completion handler with a `Result` containing the decoded value or a `NetworkError`.
    /// Compatible with iOS 12 and earlier.
//    public func fetch<T: Decodable>(url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
//        let task = session.dataTask(with: url) { data, response, error in
//            if let error = error {
//                // Underlying URL error – map to .unknownError (or you could log the original error)
//                completion(.failure(.unknownError))
//                return
//            }
//            
//            guard let data = data,
//                  let httpResponse = response as? HTTPURLResponse,
//                  (200...299).contains(httpResponse.statusCode) else {
//                completion(.failure(.badRequest))
//                return
//            }
//            
//            do {
//                let decoded = try self.decoder.decode(T.self, from: data)
//                completion(.success(decoded))
//            } catch {
//                completion(.failure(.decodingError))
//            }
//        }
//        task.resume()
//    }
    public func fetch<T: Decodable & Sendable>(url: URL, completion: @escaping @Sendable (Result<T, NetworkError>) -> Void) {
        // Capture the immutable decoder explicitly to avoid sending `self` across isolation domains.
        let decoder = self.decoder
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.unknownError))
                return
            }

            guard let data = data,
                  let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.badRequest))
                return
            }

            do {
                let decoded = try decoder.decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}
