//
//  LocationSearchResultCell.swift
//  UberClone
//
//  Created by Ahmed Fathi on 26/01/2024.
//

import SwiftUI

struct LocationSearchResultCell: View {
    let title1: String
    let subTitle1: String
    var body: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.blue)
                .accentColor(.white)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title1)
                    .font(.body)
                
                Text(subTitle1)
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                Divider()
            }
            .padding(.leading, 8)
            .padding(.vertical,8)
        }
        .padding(.leading)
    }
}

struct LocationSearchResultCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchResultCell(title1: "", subTitle1: "")
    }
}
