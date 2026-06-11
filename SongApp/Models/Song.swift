//
//  Song.swift
//  SongApp
//
//  Created by etud on 09/06/2026.
//

import Foundation

struct Song: SongProtocol, Codable, Identifiable {
    
    
    let id: Int
    let title: String
    let artist: String
    let album: String
    let releaseDate: String
    var artworkUrl: String
    var previewUrl: String
    
    

    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case title = "trackName"
        case artist = "artistName"
        case album = "collectionName"
        case releaseDate = "releaseDate"
        case artworkUrl = "artworkUrl100"
        case previewUrl = "previewUrl"
    }
}
