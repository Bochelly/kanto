//
//  Client.swift
//  Kanto
//
//  Created by Antoine Borrelly on 30/06/2023.
//

import Foundation

class CustomClient:Codable {
    var name: String
    var volume: Int
    var currentSong: Song
    var selectedService: Service
    var isPlaying: Bool
    
    enum CodingKeys:CodingKey{
        case name,volume,currentSong,selectedService,isPlaying
    }
    
    required init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        volume = try container.decode(Int.self, forKey: .volume)
        currentSong = try container.decode(Song.self, forKey: .currentSong)
        selectedService = try container.decode(Service.self, forKey: .selectedService)
        isPlaying = try container.decode(Bool.self, forKey: .isPlaying)
    }
    
    init(name:String, volume:Int, currentSong:Song, selectedService: Service, isPlaying:Bool) {
        self.name = name
        self.volume = volume
        self.currentSong = currentSong
        self.selectedService = selectedService
        self.isPlaying = isPlaying
    }
    
    static let exampleClient = CustomClient(name: "Salon", volume: 30, currentSong: Song.exampleSong, selectedService: .airplay, isPlaying: false)
    
}
