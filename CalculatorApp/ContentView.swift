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
            ButtonRow(textButton: ["AC", "+/-", "%", "÷"], colors: [LightGray, LightGray, LightGray, Orange])
            ButtonRow(textButton: ["7", "8", "9", "x"], colors: [DarkGray, DarkGray, DarkGray, Orange])
            ButtonRow(textButton: ["4", "5", "6", "-"], colors: [DarkGray, DarkGray, DarkGray, Orange])
            ButtonRow(textButton: ["1", "2", "3", "+"], colors: [DarkGray, DarkGray, DarkGray, Orange])
            ButtonRow(textButton: ["", "0", ",", "="], colors: [DarkGray, DarkGray, DarkGray, Orange])
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
           Color.black.opacity(1)
                .ignoresSafeArea()
         }
    }
}

////Estructura de la fila de botones
struct ButtonRow: View {

    // Variables
    var textButton: [String]
    var colors: [Color]

    var body: some View {
        HStack(spacing: 12){
            ForEach(Array(textButton.enumerated()), id: \.1) {index, buttonTitle in
                Button {
                    // TODO: functionality
                } label: {
                    Text(buttonTitle)
                }.buttonStyle(GradientButtonStyle(color: colors[index]))
            }
        }
    }
}


struct GradientButtonStyle: ButtonStyle {
    //Variables
    var color: Color
    let buttonSize = (UIScreen.main.bounds.width - 5 * 12) / 4
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: buttonSize, height: buttonSize)
            .font(.system(size: 33, design: .rounded))
            .fontWeight(.medium)
            .background(color)
            .foregroundStyle(.white)
            .clipShape(Circle())
    }
}

#Preview {
    ContentView()
}
