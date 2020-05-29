//
//  Call.swift
//  DAPNET
//
//  Created by Thomas Gatzweiler on 26.05.20.
//  Copyright © 2020 Thomas Gatzweiler. All rights reserved.
//

import Foundation

struct PocsagAddress {
    let ric: Int
    let function: Int
}

extension PocsagAddress: Decodable {
    enum CodingKeys: String, CodingKey {
        case ric
        case function
    }
}

struct CallRecipients {
    let pocsag: [PocsagAddress]?
    let subscribers: [String]?
    let subscriberGroups: [String]?
}

extension CallRecipients: Decodable {
    enum CodingKeys: String, CodingKey {
        case pocsag
        case subscribers
        case subscriberGroups = "subscriber_groups"
    }
}

struct CallDistribution {
    let transmitters: [String]?
    let transmitterGroups: [String]?
}

extension CallDistribution: Decodable {
    enum CodingKeys: String, CodingKey {
        case transmitters
        case transmitterGroups = "transmitter_groups"
    }
}

struct Call: Identifiable {
    let id: String
    let data: String
    let priority: Int
    let recipients: CallRecipients
    let distribution: CallDistribution
    let local: Bool?
    let expiresAt: Date?
    let createdBy: String
    let createdAt: Date
}

extension Call: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case data
        case priority
        case local
        case recipients
        case distribution
        case expiresAt = "expires_at"
        case createdBy = "created_by"
        case createdAt = "created_at"
    }
}

struct CallTestData {
    static func calls() -> [Call] {
        return [
            Call(id: "1", data: "Hello World 1", priority: 2, recipients: CallRecipients(pocsag: nil, subscribers: nil, subscriberGroups: nil), distribution: CallDistribution(transmitters: nil, transmitterGroups: nil), local: false, expiresAt: Date(), createdBy: "DL2IC", createdAt: Date()),
            Call(id: "2", data: "Hello World 2", priority: 3, recipients: CallRecipients(pocsag: nil, subscribers: ["DL1ABC", "DK2XYZ"], subscriberGroups: nil), distribution: CallDistribution(transmitters: nil, transmitterGroups: nil), local: false, expiresAt: Date(), createdBy: "DL1ABC", createdAt: Date()),
            Call(id: "3", data: "Hello World 3", priority: 4, recipients: CallRecipients(pocsag: nil, subscribers: nil, subscriberGroups: nil), distribution: CallDistribution(transmitters: nil, transmitterGroups: nil), local: false, expiresAt: Date(), createdBy: "K1JT", createdAt: Date()),
            Call(id: "4", data: "Hello World 4", priority: 5, recipients: CallRecipients(pocsag: nil, subscribers: nil, subscriberGroups: nil), distribution: CallDistribution(transmitters: nil, transmitterGroups: nil), local: false, expiresAt: Date(), createdBy: "VK3XYZ", createdAt: Date())
        ]
    }
}
