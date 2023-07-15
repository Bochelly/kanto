//
//  ContentView.swift
//  Kanto
//
//  Created by Antoine Borrelly on 30/06/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    @State var selectedClient:Client?
    @State var showClientDetail = false
    @State var updatedNeeded = false
    
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                ZStack(alignment: .topLeading){
                    ZStack(alignment: .topLeading){
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(height: 130)
                            .background(
                                LinearGradient(
                                    stops: [
                                        Gradient.Stop(color: Color(red: 0.47, green: 0.28, blue: 0.99).opacity(0.23), location: 0.00),
                                        Gradient.Stop(color: Color(red: 0.95, green: 0.78, blue: 0.54).opacity(0.42), location: 0.38),
                                    ],
                                    startPoint: UnitPoint(x: 1.03, y: 0.31),
                                    endPoint: UnitPoint(x: 0.03, y: 1.29)
                                )
                            )
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 390, height: 130)
                            .background(
                                LinearGradient(
                                    stops: [
                                        Gradient.Stop(color: .white.opacity(0), location: 0.00),
                                        Gradient.Stop(color: .white.opacity(0.8), location: 0.65),
                                        Gradient.Stop(color: .white, location: 1.00),
                                    ],
                                    startPoint: UnitPoint(x: 0.5, y: 0),
                                    endPoint: UnitPoint(x: 0.5, y: 1)
                                )
                            )
                    }
                    VStack(alignment: .leading) { //main VStack
                        VStack(spacing:0){ //header
                            HStack{
                                Text("Kanto")
                                    .font(
                                        Font.custom("Montserrat", size: 32)
                                            .weight(.bold)
                                    )
                                Spacer()
                            }
                            .padding([.bottom],0.5)
                            HStack{
                                Text("The simple multi-room player app")
                                    .font(Font.custom("Proxima Nova", size: 16))
                                    .foregroundColor(Color(red: 0.41, green: 0.45, blue: 0.52))
                                Spacer()
                            }
                        }
                        .padding(.bottom,24)
                        .padding(.top,48)
                        
                        
                        VStack{
                            if viewModel.result != nil {
                                ScrollView{
                                    let columns = [GridItem(.flexible()), GridItem(.flexible())]
                                    
                                    LazyVGrid(columns: columns,alignment: .leading){
                                        ForEach(viewModel.getAllConnectedClients(), id: \.identifier){ client in
                                            ClientCell(client: client, selectedClient: $selectedClient, updateNeeded: $updatedNeeded)
                                        }
                                        
                                    }
                                    
                                }
                            } else if viewModel.resultIsLoaded {
                                ErrorCallout()
                            } else {
                                VStack{
                                    Spacer()
                                    HStack{
                                        Spacer()
                                        ProgressView()
                                        Spacer()
                                    }
                                    Spacer()

                                }
                            }
                            
                        }
                    }
                    .padding(16)
                    
                    
                    
                }
                Spacer()
            }
            
            .task(viewModel.fetchClients)
            .onChange(of: updatedNeeded, perform: {newValue in
                print("Update needed !")
                if updatedNeeded{
                    Task{
                        await viewModel.fetchClients()
                    }
                    updatedNeeded = false
                    print("Stream title : ",viewModel.result?.server.streams[1].properties.metadata.title ?? "")
                }
            })
            .onChange(of: selectedClient, perform: {newValue in
                if newValue != nil{
                    showClientDetail = true
                }
            })
            .sheet(isPresented: $showClientDetail,
                   onDismiss: {
                selectedClient = nil
                updatedNeeded = true
                
            },
                   content: {
                
                ClientDetail(client: selectedClient!, updateNeeded: $updatedNeeded)
                                .environmentObject(viewModel)
                       
            })
            
            .environmentObject(viewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel.getExampleModel())
    }
}
