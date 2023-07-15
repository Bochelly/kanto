//
//  ModelView - ViewModel.swift
//  Kanto
//
//  Created by Antoine Borrelly on 30/06/2023.
//

import Foundation
import JsonRPC
import SwiftUI


    
    @MainActor class ViewModel: ObservableObject{
        
        @Published var result : Result?
        var resultIsLoaded = false
        
        @Sendable func fetchClients() async {
            let rpc = JsonRpc(.ws(url: URL(string:"wss://multiroom.atonneau.me/jsonrpc")!), queue: .main)
            //rpc.debug = true
            do{
                let res = try await rpc.call(method: "Server.GetStatus", params: Params(), Result.self, Result.self)
                print(res.server.groups.count)
                self.result = res
            } catch{
                print(error)


            }
            resultIsLoaded = true
        }
        
        func updateVolume(_ newVolume: Int, client: Client) {
            let rpc = JsonRpc(.ws(url: URL(string:"wss://multiroom.atonneau.me/jsonrpc")!), queue: .main)
            let updatedVolume = Volume(muted: false, percent: newVolume)
            let volumeRequest = VolumeRequest(volume: updatedVolume, id: client.id)
            rpc.call(method: "Client.SetVolume", params: volumeRequest, Result.self, Result.self){rep in

            }
        }
        
        func clientIsPlaying(_ client: Client) -> Bool{
            var isPlaying = false
            if let group = getClientGroup(client: client), let result{
                for stream in result.server.streams {
                    if stream.id == group.streamID {
                        isPlaying = (stream.status == "playing" && client.config.volume.muted == false && client.config.volume.percent > 0)
                    }
                }
            }
            return isPlaying
        }
        
        func getClientImage(_ client: Client) -> Image{
            var image = Image("artImagePlaceholder")
            if let group = getClientGroup(client: client), let result{
                for stream in result.server.streams {
                    if stream.id == group.streamID {
                        guard let stringData = Data(base64Encoded: stream.properties.metadata.artData.data), let uiImage = UIImage(data: stringData) else {
                            return image
                        }
                        image = Image(uiImage: uiImage)
                
                    }
                }
            }
            return image
        }
        
        func getStreamSongTitle(streamID : String) -> String{
            if let results = result?.server.streams{
                for stream in results {
                    if stream.id == streamID {
                        return stream.properties.metadata.title
                    }
                }
            }
            return "Unknown title"

        }
        
        func getStreamArtist(streamID : String) -> String{
            if let results = result?.server.streams{
                for stream in results {
                    if stream.id == streamID && stream.properties.metadata.artist != nil {
                        return stream.properties.metadata.artist?.joined(separator: ", ") ?? ""
                    }
                }
            }
            return "Unknown title"
        }
        
        func getStreamPicture(streamID : String) -> Image{
            if let results = result?.server.streams{
                for stream in results {
                    if stream.id == streamID {
                        if let stringData = Data(base64Encoded: stream.properties.metadata.artData.data), let uiImage = UIImage(data: stringData){
                            
                            
                            return Image(uiImage: uiImage)                                }
                    }
                }
                
            }
            return Image("artImagePlaceholder")
        }
        
        func getClientSongTitle(_ client: Client) -> String{
            var title = ""
            if let group = getClientGroup(client: client), let result{
                for stream in result.server.streams {
                    if stream.id == group.streamID {
                        title = stream.properties.metadata.title
                        }
                    }
                }
            return title
        }
        
        func getClientSongArtist(_ client: Client) -> String{
            var artist = ""
            if let group = getClientGroup(client: client), let result{
                for stream in result.server.streams {
                    if stream.id == group.streamID && stream.properties.metadata.artist != nil{
                        artist = stream.properties.metadata.artist?.joined(separator: ", ") ?? ""
                        }
                    }
                }
            return artist
        }
        
        
        
        func getClientGroup(client: Client) -> Group?{
            var clientGroup : Group?
            if let groups = result?.server.groups {
                for group in groups {
                    for group_client in group.clients{
                        if client.id == group_client.id {
                            clientGroup = group
                        }
                    }
                    
                }
            }
            return clientGroup
        }
        
        func getAllConnectedClients() -> [Client]{
            var clients = [Client]()
            if let result{
                for group in result.server.groups{
                    for client in group.clients{
                        if client.connected{
                            clients.append(client)
                        }
                    }
                }
            }
            return clients
        }
        
        func getVolume(client: Client) -> Int{
            return client.config.volume.percent
        }
        
        func updateStream(_ client: Client, stream: String) {
            if let group = getClientGroup(client: client){
                let rpc = JsonRpc(.ws(url: URL(string:"wss://multiroom.atonneau.me/jsonrpc")!), queue: .main)
                let streamRequest = StreamRequest(stream: stream, id: group.id)
                rpc.debug = true
                rpc.call(method: "Group.SetStream", params: streamRequest, Result.self, Result.self){rep in

                }
            }
        }
        
        static func getExampleModel() -> ViewModel{
            let example = ViewModel()
            example.result = Result.example
            return example
        }
        
    }



