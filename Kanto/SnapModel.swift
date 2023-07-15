// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let snap = try? JSONDecoder().decode(Snap.self, from: jsonData)

import Foundation


// MARK: - Result
class Result: Codable, Equatable {
    static func == (lhs: Result, rhs: Result) -> Bool {
        print(ObjectIdentifier(lhs),ObjectIdentifier(rhs))
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    let server: ResultServer

    init(server: ResultServer) {
        self.server = server
    }
    
    static let example = Result(server: ResultServer.example)
}

// MARK: - ResultServer
class ResultServer: Codable {
    let groups: [Group]
    let server: ServerServer
    let streams: [Stream]

    init(groups: [Group], server: ServerServer, streams: [Stream]) {
        self.groups = groups
        self.server = server
        self.streams = streams
    }
    
    static let example = ResultServer(groups: [Group.example], server: ServerServer.example, streams: [Stream.example])
}

// MARK: - Group
class Group: Codable, ObservableObject {
    let clients: [Client]
    let id: String
    let muted: Bool
    let name, streamID: String

    enum CodingKeys: String, CodingKey {
        case clients, id, muted, name
        case streamID = "stream_id"
    }

    init(clients: [Client], id: String, muted: Bool, name: String, streamID: String) {
        self.clients = clients
        self.id = id
        self.muted = muted
        self.name = name
        self.streamID = streamID
    }
    
    static let example = Group(clients: [Client.example], id: "1", muted: false, name: "Groupe Salon", streamID: "airplay")
}

// MARK: - Client
class Client: Codable, Equatable, ObservableObject, Identifiable {
    static func == (lhs: Client, rhs: Client) -> Bool {
        lhs.id == rhs.id
    }
    
    let identifier = UUID()
    @Published var config: Config
    let connected: Bool
    let host: Host
    let id: String
    let lastSeen: LastSeen
    let snapclient: SnapserverClass
    
    enum CodingKeys: CodingKey {
        case config, connected, host, id, lastSeen, snapclient
    }

    init(config: Config, connected: Bool, host: Host, id: String, lastSeen: LastSeen, snapclient: SnapserverClass) {
        self.config = config
        self.connected = connected
        self.host = host
        self.id = id
        self.lastSeen = lastSeen
        self.snapclient = snapclient
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        config = try container.decode(Config.self, forKey: .config)
        connected = try container.decode(Bool.self, forKey: .connected)
        host = try container.decode(Host.self, forKey: .host)
        id = try container.decode(String.self, forKey: .id)
        lastSeen = try container.decode(LastSeen.self, forKey: .lastSeen)
        snapclient = try container.decode(SnapserverClass.self, forKey: .snapclient)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(config, forKey: .config)
        try container.encode(connected, forKey: .connected)
        try container.encode(host, forKey: .host)
        try container.encode(id, forKey: .id)
        try container.encode(lastSeen, forKey: .lastSeen)
        try container.encode(snapclient, forKey: .snapclient)
    }
    
    static let example = Client(config: Config.example, connected: true, host: Host.example, id: "airplay", lastSeen: LastSeen.example, snapclient: SnapserverClass.example)
    
}

// MARK: - Config
class Config: Codable {
    let instance, latency: Int
    let name: String
    let volume: Volume

    init(instance: Int, latency: Int, name: String, volume: Volume) {
        self.instance = instance
        self.latency = latency
        self.name = name
        self.volume = volume
    }
    static let example = Config(instance: 3, latency: 1, name: "Salon", volume: Volume.example)
}

// MARK: - Volume
class Volume: Codable {
    let muted: Bool
    var percent: Int

    init(muted: Bool, percent: Int) {
        self.muted = muted
        self.percent = percent
    }
    
    static let example = Volume(muted: false, percent: 36)
}

// MARK: - Host
class Host: Codable {
    let arch, ip, mac, name: String
    let os: String

    init(arch: String, ip: String, mac: String, name: String, os: String) {
        self.arch = arch
        self.ip = ip
        self.mac = mac
        self.name = name
        self.os = os
    }
    
    static let example = Host(arch: "Intel", ip: "192.168.1.16", mac: "BB:AA:BB:C8:4A", name: "BochellyPi", os: "Raspbian")
}

// MARK: - LastSeen
class LastSeen: Codable {
    let sec, usec: Int

    init(sec: Int, usec: Int) {
        self.sec = sec
        self.usec = usec
    }
    
    static let example = LastSeen(sec: 35550006, usec: 540023)
}

// MARK: - SnapserverClass
class SnapserverClass: Codable {
    let name: Name
    let protocolVersion: Int
    let version: Version
    let controlProtocolVersion: Int?

    init(name: Name, protocolVersion: Int, version: Version, controlProtocolVersion: Int?) {
        self.name = name
        self.protocolVersion = protocolVersion
        self.version = version
        self.controlProtocolVersion = controlProtocolVersion
    }
    
    static let example = SnapserverClass(name: .snapclient, protocolVersion: 2, version: .the0230, controlProtocolVersion: 5)
}

enum Name: String, Codable {
    case snapclient = "Snapclient"
    case snapserver = "Snapserver"
    case snapweb = "Snapweb"
}

enum Version: String, Codable {
    case the0230 = "0.23.0"
    case the0270 = "0.27.0"
    case the050 = "0.5.0"
}


// MARK: - ServerServer
class ServerServer: Codable {
    let host: Host
    let snapserver: SnapserverClass

    init(host: Host, snapserver: SnapserverClass) {
        self.host = host
        self.snapserver = snapserver
    }
    
    static let example = ServerServer(host: Host.example, snapserver: SnapserverClass.example)
    
}

// MARK: - Stream
class Stream: Codable {
    let id: String
    let properties: Properties
    let status: String
    let uri: URI

    init(id: String, properties: Properties, status: String, uri: URI) {
        self.id = id
        self.properties = properties
        self.status = status
        self.uri = uri
    }
    
    static let example = Stream(id: "Airplay", properties: Properties.example, status: "playing", uri: URI(fragment: "", host: "", path: "", query: Query(bitrate: "", chunkMS: "", codec: "", devicename: "", name: "", sampleformat: ""), raw: "", scheme: ""))
}

// MARK: - Properties
class Properties: Codable {
    let canControl, canGoNext, canGoPrevious, canPause: Bool
    let canPlay, canSeek: Bool
    let metadata: Metadata

    init(canControl: Bool, canGoNext: Bool, canGoPrevious: Bool, canPause: Bool, canPlay: Bool, canSeek: Bool, metadata: Metadata) {
        self.canControl = canControl
        self.canGoNext = canGoNext
        self.canGoPrevious = canGoPrevious
        self.canPause = canPause
        self.canPlay = canPlay
        self.canSeek = canSeek
        self.metadata = metadata
    }
    
    static let example = Properties(canControl: false, canGoNext: false, canGoPrevious: false, canPause: false, canPlay: false, canSeek: false, metadata: Metadata.example)
}

// MARK: - Metadata
class Metadata: Codable {
    let artData: ArtData
    let artURL: String
    let duration: Double?
    let title: String
    let album: String?
    let artist: [String]?

    enum CodingKeys: String, CodingKey {
        case artData
        case artURL = "artUrl"
        case duration, title, album, artist
    }

    init(artData: ArtData, artURL: String, duration: Double?, title: String, album: String?, artist: [String]?) {
        self.artData = artData
        self.artURL = artURL
        self.duration = duration
        self.title = title
        self.album = album
        self.artist = artist
    }
    
    static let example = Metadata(artData: ArtData.example, artURL: "", duration: 4.35, title: "La Purée", album: "Les grandes découvertes", artist: ["Salut C'est Cool"])
}

// MARK: - ArtData
class ArtData: Codable {
    let data, artDataExtension: String

    enum CodingKeys: String, CodingKey {
        case data
        case artDataExtension = "extension"
    }

    init(data: String, artDataExtension: String) {
        self.data = data
        self.artDataExtension = artDataExtension
    }
    
    static let example = ArtData(data: "", artDataExtension: ".jpg")
}

// MARK: - URI
class URI: Codable {
    let fragment, host, path: String
    let query: Query
    let raw, scheme: String

    init(fragment: String, host: String, path: String, query: Query, raw: String, scheme: String) {
        self.fragment = fragment
        self.host = host
        self.path = path
        self.query = query
        self.raw = raw
        self.scheme = scheme
    }
    
}

// MARK: - Query
class Query: Codable {
    let bitrate: String?
    let chunkMS, codec, devicename, name: String
    let sampleformat: String

    enum CodingKeys: String, CodingKey {
        case bitrate
        case chunkMS = "chunk_ms"
        case codec, devicename, name, sampleformat
    }

    init(bitrate: String?, chunkMS: String, codec: String, devicename: String, name: String, sampleformat: String) {
        self.bitrate = bitrate
        self.chunkMS = chunkMS
        self.codec = codec
        self.devicename = devicename
        self.name = name
        self.sampleformat = sampleformat
    }
}

// MARK: - Volume request
class VolumeRequest: Codable {
    let volume: Volume
    let id: String

    init(volume: Volume, id: String) {
        self.id = id
        self.volume = volume
    }
}

// MARK: - Stream request
class StreamRequest: Codable {
    let stream_id: String
    let id: String

    init(stream: String, id: String) {
        self.id = id
        self.stream_id = stream
    }
}
