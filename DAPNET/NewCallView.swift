//
//  NewCallView.swift
//  DAPNET
//
//  Created by Thomas Gatzweiler on 27.05.20.
//  Copyright © 2020 Thomas Gatzweiler. All rights reserved.
//

import SwiftUI

struct NewCallView: View {
    @Binding var showSheetView: Bool
    
    var body: some View {
        NavigationView {
            NewCallViewForm()
                
            .navigationBarTitle(Text("New Call"), displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    self.showSheetView = false
                }) {
                    Text("Cancel")
                },
                trailing: Button(action: {
                    print("Dismissing sheet view...")
                    self.showSheetView = false
                }) {
                    Image(systemName: "paperplane")
                })
        }
    }
}

struct NewCallViewForm: View {
    @State var subscribers: String = ""
    @State var subscriberGroups: String = ""
    @State var transmitters: String = ""
    @State var transmitterGroups: String = ""
    @State var priority = "3"
    @State var expires_at: Date = Date().advanced(by: 3600)
    @State var message: String = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Message", text: $message)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Picker(selection: $priority, label: Text("Priority")) {
                    ForEach(1 ..< 6) {
                        Text("\($0)").tag("\($0)")
                    }
                }
                
                DatePicker("Expiration", selection: $expires_at, displayedComponents: .init(arrayLiteral: [.date, .hourAndMinute]))

            }
            
            Section(header: Text("Recipients")) {
                TextField("Subscribers", text: $subscribers)
                TextField("Subscriber Groups", text: $subscriberGroups)
            }
            
            Section(header: Text("Distribution")) {
                TextField("Transmitters", text: $transmitters)
                TextField("Transmitter Groups", text: $transmitterGroups)
            }
            
        }
    }
}

struct NewCallView_Previews: PreviewProvider {
    @State static var showSheetView = true
    
    static var previews: some View {
        NewCallView(showSheetView: $showSheetView)
    }
}
