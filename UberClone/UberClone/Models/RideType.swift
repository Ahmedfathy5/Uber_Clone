//
//  RideType.swift
//  UberClone
//
//  Created by Ahmed Fathi on 30/01/2024.
//

import Foundation

enum RideType: Int, CaseIterable, Identifiable {
    
    // CaseIterable it allows to us to loop all the item in the enum
    // Identifiable it uses instade the '(id: \.self)' in the loop
    // Int cause to give each of item raw value like ' case uberX = 0 ' etc...
    
    
       case uberX
       case black
       case uberXL
    
    var id: Int { return rawValue }
    
    var description: String {
        switch self {
        case .uberX: return "UberX"
        case .black: return "UberBlack"
        case .uberXL: return " UberXL"
            
        }
    }
    
    var imageName: String {
         
        switch self {
        case .uberX: return "UberXIcon"
        case .black: return "uber-black"
        case .uberXL: return "UberXIcon"
            
        }
    }
    
    var baseFare: Double {
        switch self {
        case .uberX:  return 5
        case .black:  return 20
        case .uberXL:  return 25
        }
    }
    
    func computePrice(for distanceInMetters: Double)-> Double {
        let distanceInMilles = distanceInMetters / 1600

        switch self {
        case .uberX:  return distanceInMilles * 1.5 + baseFare
        case .black: return distanceInMilles * 2.0 + baseFare
        case .uberXL:  return distanceInMilles * 1.75 + baseFare
        }
        
    }
    
    
    
}
