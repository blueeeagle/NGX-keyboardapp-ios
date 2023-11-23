//
//  CheckBox.swift
//  Social Keyboard (iOS)
//
//  Created by Alex Appadurai on 04/04/22.
//

import SwiftUI
//
struct FeatureRow: View {
    @State var text: String
    var iconName: String
    var action: (String)-> Void
    
    var body: some View {
        VStack{
            HStack{
                Image(iconName)
                    .resizable()
                    .frame(width: 30 , height: 30, alignment: .center)
                VStack{
                    TextField("", text: $text, prompt: Text("Enter"))
                        .padding(.horizontal, 5).padding(.top, 20)
                    Divider()
                }
                
            }
            VStack(alignment: .center){
                Button(action: {
                    action($text.wrappedValue)
                }) {
                    Text("Save")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.system(size: 16))
                        .padding()
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.white, lineWidth: 2)
                        )
                }
                .frame(width: 70, height: 32)
                .background(Color.purple) // If you have this
                .cornerRadius(25)
            }
        } .buttonStyle(PlainButtonStyle())
    }
}

struct FeatureRow_Previews: PreviewProvider {
    static var previews: some View {
        FeatureRow(text: "SMP", iconName: "facebook", action: {_ in 
            
        }) .padding(30)
    }
}
