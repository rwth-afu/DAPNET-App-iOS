//
//  UserSettings.swift
//  DAPNET
//
//  Created by Thomas Gatzweiler on 29.05.20.
//  Copyright © 2020 Thomas Gatzweiler. All rights reserved.
//

import Foundation
import Combine

class UserSettings: ObservableObject {
    @Published var server: String {
        didSet {
            UserDefaults.standard.set(server, forKey: "server")
        }
    }
    
    @Published var username: String {
        didSet {
            UserDefaults.standard.set(username, forKey: "username")
        }
    }
    
    @Published var password: String {
        didSet {
            UserDefaults.standard.set(password, forKey: "password")
        }
    }
    
    init() {
        self.server = UserDefaults.standard.object(forKey: "server") as? String ?? "dapnetdc2.db0sda.ampr.org"
        self.username = UserDefaults.standard.object(forKey: "username") as? String ?? ""
        self.password = UserDefaults.standard.object(forKey: "password") as? String ?? ""
    }
}
