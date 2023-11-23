//
//  ContentView.swift
//  Shared
//
//  Created by Alex Appadurai on 31/03/22.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Private properties
    
    @StateObject var viewModel = ContentViewModel()
    // MARK: - Render
    init() {
        UITableViewCell.appearance().selectionStyle = .none
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.red
        UITableViewCell.appearance().selectedBackgroundView = bgColorView
    }
    var body: some View {
        NavigationView{
            VStack{
                Spacer().frame(  height: 10)
                VStack {
                    VStack{
                        Toggle("Open App", isOn: $viewModel.launchApp)
                            .toggleStyle(CheckboxToggleStyle())
                        Toggle("Paste Link", isOn: $viewModel.doNotlaunchApp)
                            .toggleStyle(CheckboxToggleStyle())
                    }  .padding(10)
                        .cornerRadius(10)
                       
                }.padding(.horizontal, 20)
                   
                List(viewModel.profiles){ profile in
                    FeatureRow(text: profile.value ?? "", iconName: profile.type.icon, action: { text in
                        viewModel.save(text: text, profile: profile)
                    }).padding(.vertical, 10)
                }
                .listRowBackground(Text(""))
                .listStyle(InsetGroupedListStyle())
                
            }
            .navigationBarTitle("Social Keyboard")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
