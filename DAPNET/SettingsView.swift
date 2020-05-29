//
//  SettingsView.swift
//  DAPNET
//
//  Created by Thomas Gatzweiler on 29.05.20.
//  Copyright © 2020 Thomas Gatzweiler. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var userSettings = UserSettings()
    
    @State var server: String = ""
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        Form {
            Picker(selection: $userSettings.server, label: Text("Server")) {
                Text("DAPNET DC1 (Hamnet)").tag("dapnetdc1.db0sda.ampr.org")
                Text("DAPNET DC2 (Hamnet)").tag("dapnetdc2.db0sda.ampr.org")
                Text("DAPNET DC3 (Hamnet)").tag("dapnetdc3.db0sda.ampr.org")
            }
            
            TextField("Username", text: $userSettings.username)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .disableAutocorrection(true)
            SecureField("Password", text: $userSettings.password)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
