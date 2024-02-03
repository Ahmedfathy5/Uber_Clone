//
//  LocationSearchActivationView.swift
//  UberClone
//
//  Created by Ahmed Fathi on 26/01/2024.
//

import SwiftUI

struct LocationSearchActivationView: View {
    var body: some View {
        HStack {
            Rectangle()
                .fill(.black)
                .frame(width: 8, height: 8)
                .padding(.horizontal)
            Text("Where to ?")
                .foregroundColor(Color(.darkGray))
            Spacer()
            
        }
        .frame(width: UIScreen.main.bounds.width - 64 , height: 50)
        .background(
        Rectangle()
            .fill(Color.white)
            .cornerRadius(10)
            .shadow(color: .black, radius: 6)
            
        )
    }
}

struct LocationSearchActivationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchActivationView()
    }
}
