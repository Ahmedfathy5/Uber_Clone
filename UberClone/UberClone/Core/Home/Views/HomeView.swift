//
//  HomeView.swift
//  UberClone
//
//  Created by Ahmed Fathi on 25/01/2024.
//

import SwiftUI


struct HomeView: View {
    
    @State private var mapState = MapViewState.noInput
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    var body: some View {
        ZStack(alignment: .bottom) {
            
            
            ZStack(alignment: .top) {
                UberMapViewRepresentable(mapState: $mapState)
                    .ignoresSafeArea()
                
                if mapState == .SearchingForLocation  {
                   LocationSearchView(mapState: $mapState)
                } else if mapState == .noInput   {
                    LocationSearchActivationView()
                        .padding(.top, 72)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                mapState = .SearchingForLocation

                            }
                        }
                }
                    
                mapViewActionButton(mapState: $mapState)
                    .padding(.leading)
                    .padding(.top, 4)
            }
            
            if mapState == .LocationSelected || mapState == .polyLineAdded  {
                RideRequestView()
                    .transition(.move(edge: .bottom))
            }
                
        }
        .edgesIgnoringSafeArea(.bottom)
        .onReceive(LocationManager.shared.$userLocation) { location in
            if let location = location {
                locationViewModel.userLocation = location
            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
