//
//  NetworkingManager.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 4/1/25.
//

import Foundation
import Combine

final class NetworkingManager {
  
  enum NetworkingError: LocalizedError {
    case badURLResponse(url: URL)
    case unknown
    
    var errorDescription: String? {
      switch self {
      case .badURLResponse(url: let url): return "[🔥] Bad response from URL:\n\(url)"
      case .unknown: return "[⚠️] Unknown error occured."
      }
    }
  }
  
  // TODO: Replace Combine to Structured Concurrency
  static func download(url: URL) -> AnyPublisher<Data, any Error> {
    return URLSession.shared.dataTaskPublisher(for: url)
      .subscribe(on: DispatchQueue.global(qos: .default))
      .tryMap({ try handleURLResponse(output: $0, url: url) })
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
  
  // TODO: Replace Combine to Structured Concurrency
  static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
    guard let response = output.response as? HTTPURLResponse,
          response.statusCode >= 200 && response.statusCode < 300
    else {
      throw NetworkingError.badURLResponse(url: url)
    }
    return output.data
  }
  
  // TODO: Replace Combine to Structured Concurrency
  static func handlingComplition(completion: Subscribers.Completion<Error>) {
    switch completion {
    case .finished:
      break
    case .failure(let error):
      print("\(error.localizedDescription)")
    }
  }
}
