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
    @State private var storedValue:Double? = 0
    @State private var currentOperator:String?
    
    var body: some View {
        VStack (alignment: .trailing, spacing: 18) {
            
            //PARTE SUPERIOR: Texto numérico
            Text(displayText)
                .font(.system(size: 75))
                .fontWeight(.light)
                .foregroundStyle(.white)
                .padding(.horizontal, 20)
                .padding(.top, 100)
            
            //BUTTONS
            
            //HStack to get the AC button funcionality
            HStack (spacing: 12){
                Button {
                    clearButton()
                    
                } label : {
                    Text("AC")
                }.buttonStyle(MainButtonStyle(color: LightGray, textColor: .black))
                
                MainButtonRow(textButton: ["+/-", "%", "÷"], colors: [LightGray, LightGray, LightGray, Orange], textColors: [.black, .black, .black, .white], action: buttonTap, selectedItem: $selectedItem)
            }
            MainButtonRow(textButton: ["7", "8", "9", "x"], colors: [DarkGray, DarkGray, DarkGray, Orange], action: buttonTap, selectedItem: $selectedItem)
            MainButtonRow(textButton: ["4", "5", "6", "-"], colors: [DarkGray, DarkGray, DarkGray, Orange], action: buttonTap, selectedItem: $selectedItem)
            MainButtonRow(textButton: ["1", "2", "3", "+"], colors: [DarkGray, DarkGray, DarkGray, Orange], action: buttonTap, selectedItem: $selectedItem)
            
            //HStack to get a wide zero button
            HStack (spacing: 18){
                Button {
                    buttonTap("0")
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
                
                MainButtonRow(textButton: [",", "="], colors: [DarkGray, Orange], action: buttonTap, selectedItem:  $selectedItem)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.black.opacity(1)
                .ignoresSafeArea()
        }
        
        
        
    }
    
    //Function to button Tap
    func buttonTap(_ button: String){
        switch button {
        case "+", "-", "x", "÷":
            currentOperator = button
            storedValue = Double(selectedItem)
            selectedItem = ""
            
        case "=":
            if let operatorType = currentOperator,
               let storedNumber = storedValue,
               let currentValue = Double(selectedItem) {
                let result:Double
                
                switch operatorType {
                case "+":
                    result = storedNumber + currentValue
                    
                    
                case "-":
                    result = storedNumber - currentValue
                    
                case "x":
                    result = storedNumber * currentValue
                    
                case "÷":
                    result = storedNumber / currentValue
                    
                default:
                    fatalError("Unknown operator")
                }
                selectedItem = "\(result)"
                currentOperator = nil
            }
            
        case ",":
            selectedItem += button
            
        default:
            selectedItem += button
        }
        
        if selectedItem .isEmpty {
            displayText = " "
        } else {
            displayText = selectedItem
        }
    }
    
    func clearButton() {
        selectedItem = ""
        storedValue = nil
        currentOperator = nil
        displayText = "0"
    }
}


struct MainButtonRow: View {
    
    // Variables
    var textButton: [String]
    var colors: [Color]
    var textColors: [Color]? //Optional array, just used on first line to change between black and white
    let action:(String) -> Void
    
    @Binding var selectedItem: String
    
    var body: some View {
        HStack(spacing: 12){
            ForEach(textButton, id: \.self) { buttonLabel in
                if let index = textButton.firstIndex(of: buttonLabel) {
                    Button {
                        action(buttonLabel)
                    } label: {
                        Text(buttonLabel)
                    }
                    .buttonStyle(MainButtonStyle(color: colors[index], textColor: textColors?[index]))
                }
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
