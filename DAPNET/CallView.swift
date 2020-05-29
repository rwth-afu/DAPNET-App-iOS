//
//  ContentView.swift
//  DAPNET
//
//  Created by Thomas Gatzweiler on 26.05.20.
//  Copyright © 2020 Thomas Gatzweiler. All rights reserved.
//

import SwiftUI

struct CallView: View {
    @ObservedObject var viewModel: CallViewModel = CallViewModel();
    
    var body: some View {
        List(viewModel.calls) { call in
            CallCell(call: call)
        }
    }
}

struct CallCell: View {
    var call: Call
    
    let formatter: DateFormatter = {
        var fmt = DateFormatter();
        fmt.dateStyle = .short;
        fmt.timeStyle = .short;
        return fmt;
    }()
    
    static func priorityColor(_ priority : Int) -> Color {
        switch (priority) {
            case 1: return Color.gray
            case 2: return Color.blue
            case 3: return Color.green
            case 4: return Color.yellow
            case 5: return Color.red
            default: return Color.green
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(call.createdBy.uppercased()).fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(formatter.string(for: call.createdAt)!)
                    .foregroundColor(Color.blue)
                    .fontWeight(Font.Weight.light)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5.0) .fill().foregroundColor(CallCell.priorityColor(call.priority))
                        .frame(width: 25, height: 25)
                    Text(String(call.priority))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
            }
            HStack {
                Text(call.data)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            HStack() {
                Text("To: ")
                ForEach(0 ..< (call.recipients.subscribers ?? []).count) { i in
                    Text(self.call.recipients.subscribers![i].uppercased())
                }
            }.font(.footnote).padding(.top).frame(maxWidth: .infinity)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CallView(viewModel: CallViewModel(calls: CallTestData.calls()))
    }
}
