//
//  MainView.swift
//  DAPNET
//
//  Created by Thomas Gatzweiler on 27.05.20.
//  Copyright © 2020 Thomas Gatzweiler. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @State var showNewCallView = false
    
    var body: some View {
        TabView {
            NavigationView() {
                CallView().navigationBarTitle("Calls").navigationBarItems(trailing: Button(action: {
                    self.showNewCallView = true
                }) {
                    Image(systemName: "square.and.pencil")
                })
            }
            .tabItem({
                Image(systemName: "paperplane")
                Text("Calls")
            }).sheet(isPresented: $showNewCallView) {
                NewCallView(showSheetView: self.$showNewCallView)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
