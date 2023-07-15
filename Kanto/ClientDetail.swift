//
//  ClientDetail.swift
//  Kanto
//
//  Created by Antoine Borrelly on 01/07/2023.
//

import SwiftUI

struct ClientDetail: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @ObservedObject var client: Client
    @State var group: Group?
    @State var selectedService:String = "Spotify"
    @State var clientImage:Image?
    @State var clientSongTitle:String = "Unknown title"
    @State var clientSongArtist:String = "Unknown artist"
    @State var volumeSlider = 0.0
    
    @Binding var updateNeeded: Bool
    

    var body: some View {
            VStack(alignment: .leading){
                Text(client.config.name)
                    .font(
                        Font.custom("Montserrat", size: 24)
                    )
                    .fontWeight(.bold)
                    .padding(.leading,25)
       
                HStack{
                    Spacer()
                    Picker("Service",selection:$selectedService){
                        Text("Spotify").tag("Spotify")
                        Text("AirPlay").tag("Airplay")
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 178)
                    .padding(.vertical,8)
                    Spacer()
                }
                .onChange(of: selectedService, perform: {newValue in
                    viewModel.updateStream(client, stream: selectedService)
                    clientImage = viewModel.getStreamPicture(streamID: newValue)
                    clientSongTitle = viewModel.getStreamSongTitle(streamID: newValue)
                    clientSongArtist = viewModel.getStreamArtist(streamID: newValue)

                })

                VStack(spacing:43){ //player
                    HStack{
                        Spacer()
                        if let clientImage{
                            
                            clientImage
                                .resizable()
                                .frame(width: 330, height: 330)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(color: .black.opacity(0.25), radius: 3.5, x: 0, y: 4)
                                .animation(.default, value: clientImage)
                                
                        }
                            Spacer()
                    }
                    VStack(spacing:8){
                        Text(clientSongTitle)
                            .font(
                            Font.custom("Montserrat", size: 20)
                            .weight(.bold)
                            )
                        Text(clientSongArtist)
                            .font(Font.custom("Montserrat", size: 16))
                    }
                    Slider(value: $volumeSlider, in: 0...100)
                    {} minimumValueLabel: {
                        Image(systemName: "speaker.fill")
                            .foregroundColor(.gray)
                    } maximumValueLabel: {
                        Image(systemName: "speaker.wave.3.fill")
                            .foregroundColor(.gray)

                    } onEditingChanged: {editing in
                        viewModel.updateVolume(Int(volumeSlider), client: client)
                        updateNeeded = true
                    }
                    .frame(width:330)
                
                 
                    
                    
                }
                .padding(.vertical,16)
            }
            .frame(
                  minWidth: 0,
                  maxWidth: .infinity,
                  minHeight: 0,
                  maxHeight: .infinity,
                  alignment: .topLeading
                )
            .padding(.top,40)
            
            .onAppear(perform: {
                self.group = viewModel.getClientGroup(client: client)
                self.clientImage = viewModel.getClientImage(client)
                self.clientSongTitle = viewModel.getClientSongTitle(client)
                self.clientSongArtist = viewModel.getClientSongArtist(client)
                self.selectedService = group?.streamID ?? "Spotify"
                self.volumeSlider = Double(client.config.volume.muted ? 0 : client.config.volume.percent)
            })
        
            
    
        }
        
}


