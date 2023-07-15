//
//  ClientCell.swift
//  Kanto
//
//  Created by Antoine Borrelly on 30/06/2023.
//

import SwiftUI
import UIKit

struct ClientCell: View {
    @ObservedObject var client: Client
    @EnvironmentObject var viewModel: ViewModel
    
    @State var volume: Int?
    @State var volumeSlider:CGFloat = 50
    
    @Binding var selectedClient: Client?
    //@Binding var showClientDetail: Bool
    
    @Binding var updateNeeded: Bool
    
    
    let cellWidth: CGFloat = 170
    let cellHeight: CGFloat = 105
    
    var body: some View {
        

        ZStack(alignment: .topLeading){
            VStack{
                
            }
            .frame(width: cellWidth, height: cellHeight)
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
            .clipShape(RoundedRectangle(cornerRadius: 22))
            
            VStack{
                
            }
            .frame(width: volumeSlider, height:cellHeight)
            .background(Color(red: 0.93, green: 0.93, blue: 0.93).opacity(0.74))
            .clipShape(RoundedRectangle(cornerRadius: 22))
            .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged({(value) in
                    if value.location.x < cellWidth && value.location.x > 0{
                        volumeSlider = value.location.x
                    } else if value.location.x >= cellWidth {
                        volumeSlider = cellWidth
                    } else if value.location.x <= 0 {
                        volumeSlider = 0
                    }
                })
                .onEnded({(value) in
                    volume = Int(Double(volumeSlider) / 1.70)
                    viewModel.updateVolume(volume ?? 0, client: client)
                })
            
            )
            
            
            VStack{
                Spacer()
                HStack(spacing:12){
                    Text(client.config.name)
                        .font(
                            Font.custom("Montserrat", size: 14)
                                
                        )
                        .fontWeight(.medium)
                        .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.08))
                    if viewModel.clientIsPlaying(client) {
                        AnimatedBArs()
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding([.vertical,.leading])
            
        }
        .frame(width: cellWidth, height: cellHeight)
            .padding(.bottom,5)
        .onAppear(perform: {volume = client.config.volume.percent ; volumeSlider = CGFloat(volume ?? 0)*1.70 })
        .highPriorityGesture(
            
                        TapGesture()
                            .onEnded { _ in
                                self.selectedClient = self.client
                                //showClientDetail = true
                                
                            }
                    )
    }
        

}

/*struct ClientCell_Previews: PreviewProvider {
    static var previews: some View {
        ClientCell()
    }
}
*/
