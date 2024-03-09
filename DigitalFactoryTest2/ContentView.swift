//
//  ContentView.swift
//  DigitalFactoryTest
//
//  Created by Taha Tuna on 9.03.2024.
//

import SwiftUI


struct ContentView: View {
    
    @State var value = "0"
    @State var runningNumber = 0
    @State private var didCalculate = false
    @State private var didEnterOperator = false
    @State var displayValue = "0"
    
    var buttons: [[CalculatorButton]] {
        switch UIDevice.current.orientation {
        case .portrait, .portraitUpsideDown:
            return [
                [.clear, .cos, .sin, .tan],
                [.seven, .eight, .nine, .divide],
                [.four, .five, .six, .multiply],
                [.one, .two, .three, .subtract],
                [.zero, .decimal, .add],
                [.equals]
            ]
        case .landscapeLeft, .landscapeRight:
            // Add your landscape or other orientation layout here
            return [
                [.six, .seven, .eight, .nine, .divide, .multiply],
                [.two, .three, .four, .five, .add, .subtract],
                [.zero, .one, .decimal, .cos, .tan],
                [.equals, .clear, .sin]
            ]
            
        default:
            
            return [
                [.clear, .cos, .sin, .tan],
                [.seven, .eight, .nine, .divide],
                [.four, .five, .six, .multiply],
                [.one, .two, .three, .subtract],
                [.zero, .decimal, .add],
                [.equals]
            ]
        }
        
    }
    
    var body: some View {
        ZStack {
            Color.gray.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        
                        Text(displayValue)
                            .font(.title3)
                        
                    }
                    .foregroundColor(.white)
                    
                    HStack {
                        Spacer()
                        Text(value)
                            .fontWeight(.ultraLight)
                            .font(.system(size: 80))
                            .minimumScaleFactor(0.3)
                        
                    }
                    .foregroundColor(.white)
                }
                .padding(.horizontal, 10)
                .padding(.top, 20)
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { button in
                            
                            
                            
                            Button(action: {
                                self.didTap(button)
                            }, label: {
                                ButtonView(operand: button.rawValue,
                                           width: self.calculateButtonWidth(button),
                                           height: self.calculateButtonHeight(),
                                           buttonColor: button.color)
                                
                                
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
                
            }
        }
    }
    
    func didTap(_ button: CalculatorButton) {
        switch button {
            
        case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero, .decimal:
            
            if self.displayValue != "0" {
                self.displayValue += button.rawValue
            } else {
                self.displayValue = button.rawValue
            }
            self.didEnterOperator = false
        case .add, .subtract, .divide, .multiply:
            if self.displayValue != "0" && !self.didEnterOperator {
                self.displayValue += button.rawValue
                self.didEnterOperator = true
            }
        case .clear:
            self.displayValue = "0"
            self.value = "0"
        case .cos:
            if let displayValueDouble = Double(self.displayValue) {
                let result = cos(displayValueDouble)
                self.value = String(result)
            }
        case .sin:
            if let displayValueDouble = Double(self.displayValue) {
                let result = sin(displayValueDouble)
                self.value = String(result)
            }
        case .tan:
            if let displayValueDouble = Double(self.displayValue) {
                let result = tan(displayValueDouble)
                self.value = String(result)
            }
        case .equals:
            if !self.didEnterOperator {
                let expression = NSExpression(format: self.displayValue)
                if let result = expression.expressionValue(with: nil, context: nil) as? NSNumber {
                    self.value = result.stringValue
                } else {
                    self.displayValue = "Error"
                }
                self.didCalculate = true
                self.didEnterOperator = false
            }
        }
    }
    
    func calculateButtonWidth(_ button: CalculatorButton) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        
        
        if UIDevice.current.orientation.isLandscape {
            if button == .equals {
                return screenWidth / 2 + 12
            } else if button == .zero {
                return ((screenWidth - (4 * 12)) / 4) + 12
            }
            
            
            return (screenWidth - (5 * 12)) / 8
        } else {
            if button == .zero {
                return ((screenWidth - (4 * 12)) / 4) * 2
            } else if button == .equals {
                return screenWidth - (4 * 12)
            }
            
            return (screenWidth - (5 * 12)) / 4
        }
        
    }
    
    func calculateButtonHeight() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        
        if UIDevice.current.orientation.isLandscape {
            
            return (screenWidth - (5 * 12)) / 15
        } else {
            
            return (screenWidth - (5 * 12)) / 4
        }
    }
}


#Preview {
    ContentView()
}


enum CalculatorButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case multiply = "*"
    case equals = "="
    case clear = "C"
    case decimal = "."
    case cos = "cos"
    case sin = "sin"
    case tan = "tan"
    
    var color: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equals:
            return .red.opacity(0.7)
        case .clear, .cos, .sin, .tan:
            return Color.black.opacity(0.2)
        default:
            return Color.black.opacity(0.6)
        }
    }
}
