//
//  ContentView.swift
//  CalculatorApp
//
//  Created by Beatriz Cardozo on 12/8/24.
//

import SwiftUI

struct ContentView: View {
    
    //Colores
    var DarkGray: Color = Color("DarkGray")
    var Orange: Color = Color("Orange")
    var LightGray: Color = Color("LightGray")
    
    
    //Variables de Estado
    @State private var displayText = "0"
    @State private var selectedItem = ""
    
    var body: some View {
        VStack (alignment: .trailing, spacing: 18) {
            
            //PARTE SUPERIOR: Texto numérico
            Text(displayText)
                .font(.system(size: 75))
                .fontWeight(.light)
                .foregroundStyle(.white)
                .padding(.horizontal, 20)
                .padding(.top, 100)
            
            //BOTONES
            MainButtonRow(textButton: ["AC", "+/-", "%", "÷"], colors: [LightGray, LightGray, LightGray, Orange], textColors: [.black, .black, .black, .white], selectedItem: $selectedItem)
            MainButtonRow(textButton: ["7", "8", "9", "x"], colors: [DarkGray, DarkGray, DarkGray, Orange], selectedItem: $selectedItem)
            MainButtonRow(textButton: ["4", "5", "6", "-"], colors: [DarkGray, DarkGray, DarkGray, Orange], selectedItem: $selectedItem)
            MainButtonRow(textButton: ["1", "2", "3", "+"], colors: [DarkGray, DarkGray, DarkGray, Orange], selectedItem: $selectedItem)
            
            //HStack to get a wide zero button
            HStack (spacing: 18){
                Button {
                    self.selectedItem = "0"
                } label: {
                    HStack {
                        Text("0")
                        Spacer()
                    }.padding(.horizontal, 15)
                }
                .padding()
                .frame(width:  175, height:  (UIScreen.main.bounds.width - 5 * 12) / 4)
                .font(.system(size: 33, design: .rounded))
                .fontWeight(.medium)
                .background(DarkGray)
                .foregroundStyle(.white)
                .cornerRadius(40)
  
                MainButtonRow(textButton: [",", "="], colors: [DarkGray, Orange], selectedItem:  $selectedItem)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
           Color.black.opacity(1)
                .ignoresSafeArea()
         }
    }
}


struct MainButtonRow: View {

    // Variables
    var textButton: [String]
    var colors: [Color]
    var textColors: [Color]? //Optional array, just used on first line to change between black and white
    
    @Binding var selectedItem: String

    var body: some View {
        HStack(spacing: 12){
            ForEach(Array(textButton.enumerated()), id: \.1) {index, buttonTitle in
                Button {
                    self.selectedItem = buttonTitle
                } label: {
                    Text(buttonTitle)
                }.buttonStyle(MainButtonStyle(color: colors[index], textColor: textColors?[index]))
            }
        }
    }
}


struct MainButtonStyle: ButtonStyle {
    //Variables
    var color: Color
    var textColor: Color? //Optional value
    let buttonSize = (UIScreen.main.bounds.width - 5 * 12) / 4
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: buttonSize, height: buttonSize)
            .font(.system(size: 33, design: .rounded))
            .fontWeight(.medium)
            .background(color)
            .foregroundStyle(textColor ?? .white) //Used in case there is no value asigned to textColor, default is white
            .clipShape(Circle())
    }
}

#Preview {
    ContentView()
}
