//
//  ErrorCallout.swift
//  Kanto
//
//  Created by Antoine Borrelly on 14/07/2023.
//

import SwiftUI

struct ErrorCallout: View {
    var body: some View {
        VStack(){
            VStack(alignment: .leading, spacing: 8){
                Text("Ooops ⚠️")
                    .font(
                        Font.custom("Montserrat", size: 16)
                    )
                    .fontWeight(.bold)
                    .padding(.leading,8)
                Text("You doesn’t seem connected to the proper network. Kanto only works within your local SnapCast network.")
                    .padding(.leading,8)
                    .font(
                        Font.custom("Proxima Nova", size: 16)
                    )
          
                    .fontWeight(.ultraLight)
                
            }
            .padding(20)
          .background(Color(red: 0.93, green: 0.93, blue: 0.93).opacity(0.74))
          .clipShape(RoundedRectangle(cornerRadius: 16))
            Spacer()
        }

          
        
        
    }
}

struct ErrorCallout_Previews: PreviewProvider {
    static var previews: some View {
        ErrorCallout()
    }
}
