//
//  mapViewActionButton.swift
//  UberClone
//
//  Created by Ahmed Fathi on 26/01/2024.
//

import SwiftUI

struct mapViewActionButton: View {
    @Binding var mapState: MapViewState
    @EnvironmentObject var viewModel: LocationSearchViewModel
    var body: some View {
        Button {
            withAnimation(.spring()) {
               acctionForState(mapState)
            }
        } label: {
            Image(systemName: imageNameForState(mapState))
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(   .white  )
                .clipShape(Circle())
                .shadow(color: .black, radius: 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct mapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        mapViewActionButton(mapState: .constant(.noInput))
    }
}



extension mapViewActionButton {
    
    func acctionForState(_ state: MapViewState) {
        switch state {
        case .noInput:
            print("noInput")
        case .LocationSelected:
            mapState = .noInput   
        case .SearchingForLocation, .polyLineAdded :
            mapState = .noInput
            viewModel.selectedUberLocation = nil
        }
    }
    func imageNameForState(_ state: MapViewState) -> String {
        switch state {
        case .noInput:
           return "line.3.horizontal"
        case .LocationSelected, .SearchingForLocation , .polyLineAdded:
           return "arrow.left"
        }
        
    }
    
    
    
}
