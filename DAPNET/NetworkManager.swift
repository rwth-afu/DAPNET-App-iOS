//
//  NetworkManager.swift
//  Dapnet
//
//  Created by Thomas Gatzweiler on 13.05.20.
//  Copyright © 2020 Thomas Gatzweiler. All rights reserved.
//

import Foundation

extension Formatter {
    static let iso8601withFractionalSeconds: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
    static let iso8601: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter
    }()
}

extension JSONDecoder.DateDecodingStrategy {
    static let customISO8601 = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self)
        if let date = Formatter.iso8601withFractionalSeconds.date(from: string) ?? Formatter.iso8601.date(from: string) {
            return date
        }
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(string)")
    }
}

let jsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .customISO8601
    return decoder
}()

let urlSessionConfig: URLSessionConfiguration = {
    let cfg = URLSessionConfiguration.default
    let userPasswordString = "dl2ic:test"
    let base64EncodedCredential = Data(userPasswordString.utf8).base64EncodedString()
    let authString = "Basic \(base64EncodedCredential)"
    cfg.httpAdditionalHeaders = ["Authorization" : authString]
    return cfg
}()

protocol ApiResource {
    associatedtype ModelType: Decodable
    var methodPath: String { get }
}
 
extension ApiResource {
    var url: URL {
        var components = URLComponents(string: "http://dapnetdc2.db0sda.ampr.org")!
        components.path = methodPath
        components.queryItems = [
            URLQueryItem(name: "limit", value: "20"),
            URLQueryItem(name: "order", value: "desc"),
            URLQueryItem(name: "order_by", value: "created_at")
        ]
        return components.url!
    }
}

class ApiRequest<Resource: ApiResource> {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}
 
extension ApiRequest: NetworkRequest {
    func decode(_ data: Data) -> [Resource.ModelType]? {
        do {
            let items = try jsonDecoder.decode([Resource.ModelType].self, from: data)
            return items
        }
        catch let error as NSError {
            print("\(error)")
            return nil
        }
    }
    
    func load(withCompletion completion: @escaping ([Resource.ModelType]?) -> Void) {
        load(resource.url, withCompletion: completion)
    }
}

struct CallResource: ApiResource {
    typealias ModelType = Call
    let methodPath = "/calls"
}

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) -> ModelType?
    func load(withCompletion completion: @escaping (ModelType?) -> Void)
}

extension NetworkRequest {
    fileprivate func load(_ url: URL, withCompletion completion: @escaping (ModelType?) -> Void) {
        let session = URLSession(configuration: urlSessionConfig, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: url, completionHandler: { [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data else {
                completion(nil)
                return
            }
            completion(self?.decode(data))
        })
        task.resume()
    }
}
