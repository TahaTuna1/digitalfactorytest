//
//  ButtonView.swift
//  DigitalFactoryTest2
//
//  Created by Taha Tuna on 9.03.2024.
//

import SwiftUI

struct ButtonView: View {
    let operand: String
    var width: CGFloat = 70
    var height: CGFloat = 70
    let buttonColor: Color
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(buttonColor)
                .frame(width: width, height: height, alignment: .center)
            
            Text(operand)
                .font(.title)
                .fontWeight(.light)
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    ButtonView(operand: "X", buttonColor: Color.gray)
}
