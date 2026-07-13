//
//  Webservice.swift
//  PetInfo.
//
//  Created by Young Jin Ju on 7/12/26.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case decodingError
    case unknownError
}

class Webservice {
    
    private let session: URLSession
    private let decoder = JSONDecoder()   // reuse the decoder
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - Async/Await (recommended)
    
    func fetch<T: Decodable>(url: URL) async throws -> T {
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.badRequest
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    // MARK: - Completion handler (legacy, kept for compatibility)
 /*
    func fetch<T: Decodable>(url: URL,
                             completion: @escaping (Result<T, NetworkError>) -> Void) {
        Task {
            do {
                let result: T = try await fetch(url: url)
                completion(.success(result))
            } catch let error as NetworkError {
                completion(.failure(error))
            } catch {
                completion(.failure(.unknownError))
            }
        }
    } */
}
