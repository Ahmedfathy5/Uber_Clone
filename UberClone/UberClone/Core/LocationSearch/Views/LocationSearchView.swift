//
//  LocationSearchView.swift
//  UberClone
//
//  Created by Ahmed Fathi on 26/01/2024.
//

import SwiftUI

struct LocationSearchView: View {
    @State private var StartLocatioText: String = ""
    @Binding var mapState: MapViewState
    @EnvironmentObject var viewModel : LocationSearchViewModel
    var body: some View {
        VStack{
            // header view
            HStack {
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)
                    
                    Rectangle()
                        .fill(.black)
                        .frame(width: 1, height: 24)
                    
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)
                }
                VStack {
                    TextField("Current Location", text: $StartLocatioText)
                        .frame(height: 32)
                        .background(Color(.systemGray5))
                        .cornerRadius(5)
                        .padding(.trailing)
                    
                    TextField("Where To ?", text: $viewModel.queryFragmant)
                        .frame(height: 32)
                        .background(Color(.systemGray4))
                        .cornerRadius(5)
                        .padding(.trailing)
                }
            }
            .padding(.horizontal)
            .padding(.top, 64)
            
            Divider()
                .padding(.vertical)
           
            
            // list view
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    ForEach(viewModel.results , id: \.self) { result in
                        LocationSearchResultCell(title1: result.title, subTitle1: result.subtitle)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    viewModel.selectLocation(result)
                                    mapState = .LocationSelected
                                    
                                }
                            }
                    }
                }
            }
        }
        .background(Color.theme.backgroundColor)
      
        
        
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(mapState: .constant(.SearchingForLocation))
    }
}
