//
//  File.swift
//  MyNetworkingLibrary
//
//  Created by Young Jin Ju on 7/12/26.
//

//    @available(iOS 13.0, *)
//    public func fetch<T: Decodable>(url: URL) async throws -> T {
//        let data = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Data, Error>) in
//            let task = session.dataTask(with: url) { data, response, error in
//                if let error = error {
//                    continuation.resume(throwing: error)
//                    return
//                }
//
//                guard let data = data, let response = response else {
//                    continuation.resume(throwing: NetworkError.unknownError)
//                    return
//                }
//
//                guard let httpResponse = response as? HTTPURLResponse,
//                      (200...299).contains(httpResponse.statusCode) else {
//                    continuation.resume(throwing: NetworkError.badRequest)
//                    return
//                }
//
//                continuation.resume(returning: data)
//            }
//            task.resume()
//        }
//
//        do {
//            return try decoder.decode(T.self, from: data)
//        } catch {
//            throw NetworkError.decodingError
//        }
//    }
    
//    public func fetch<T: Decodable>(url: URL) async throws -> T {
//        let data = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Data, Error>) in
//            let task = session.dataTask(with: url) { data, response, error in
//                if let error = error {
//                    continuation.resume(throwing: error)
//                    return
//                }
//
//                guard let data = data, let response = response else {
//                    continuation.resume(throwing: NetworkError.unknownError)
//                    return
//                }
//
//                guard let httpResponse = response as? HTTPURLResponse,
//                      (200...299).contains(httpResponse.statusCode) else {
//                    continuation.resume(throwing: NetworkError.badRequest)
//                    return
//                }
//
//                continuation.resume(returning: data)
//            }
//            task.resume()
//        }
//
//        do {
//            return try decoder.decode(T.self, from: data)
//        } catch {
//            throw NetworkError.decodingError
//        }
//    }

    //    public func fetch<T: Decodable>(url: URL) async throws -> T {
    //        let (data, response) = try await session.data(from: url)
    //
    //        guard let httpResponse = response as? HTTPURLResponse,
    //              (200...299).contains(httpResponse.statusCode) else {
    //            throw NetworkError.badRequest
    //        }
    //
    //        do {
    //            return try decoder.decode(T.self, from: data)
    //        } catch {
    //            throw NetworkError.decodingError
    //        }
    //    }

//    public func fetch<T: Decodable>(url: URL) -> AnyPublisher<T, NetworkError> {
//        session.dataTaskPublisher(for: url)
//            .tryMap { data, response -> Data in
//                guard let httpResponse = response as? HTTPURLResponse,
//                      (200...299).contains(httpResponse.statusCode) else {
//                    throw NetworkError.badRequest
//                }
//                return data
//            }
//            .decode(type: T.self, decoder: decoder)
//            .mapError { error -> NetworkError in
//                if let networkError = error as? NetworkError {
//                    return networkError
//                } else if error is DecodingError {
//                    return .decodingError
//                } else {
//                    return .unknownError
//                }
//            }
//            .eraseToAnyPublisher()
//    }

    
//    public func fetch<T: Decodable>(url: URL) async throws -> T {
//        let data: Data
//        let response: URLResponse
//
//        if #available(iOS 15.0, *) {
//            (data, response) = try await session.data(from: url)
//        } else {
//            // Fallback for earlier iOS versions using dataTask with continuation
//            if #available(iOS 13.0, *) {
//                (data, response) = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<(Data, URLResponse), Error>) in
//                    let task = session.dataTask(with: url) { data, response, error in
//                        if let error = error {
//                            continuation.resume(throwing: error)
//                            return
//                        }
//
//                        guard let data = data, let response = response else {
//                            continuation.resume(throwing: NetworkError.unknownError)
//                            return
//                        }
//
//                        continuation.resume(returning: (data, response))
//                    }
//                    task.resume()
//                }
//            } else {
//                // This branch is unreachable for async functions (requires iOS 13+).
//                // Throw to satisfy definite initialization.
//                throw NetworkError.unknownError
//            }
//        }
//
//        guard let httpResponse = response as? HTTPURLResponse,
//              (200...299).contains(httpResponse.statusCode) else {
//            throw NetworkError.badRequest
//        }
//
//        do {
//            return try decoder.decode(T.self, from: data)
//        } catch {
//            throw NetworkError.decodingError
//        }
//    }
    
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
