//
//  Song.swift
//  Kanto
//
//  Created by Antoine Borrelly on 30/06/2023.
//

import Foundation
import SwiftUI

class Song:Codable{
    var name: String
    var artist: String
    var image: Image?
    
    enum CodingKeys:CodingKey{
        case name, artist
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        artist = try container.decode(String.self, forKey: .artist)
    }
    
    init(name: String, artist:String){
        self.artist = artist
        self.name = name
    }
    
    static let exampleSong = Song(name: "La Purée", artist: "Salut C'est Cool")
}
