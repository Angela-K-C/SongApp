//
//  ITunesSongDTO.swift
//  SongApp
//
//  Created by etud on 10/06/2026.
//

import Foundation

struct ITunesSongDTO: Codable {
    var trackId: Int
    var trackName: String
    var artistName: String
    var collectionName: String?
    var releaseDate: String?
    var artworkUrl100: String?
    var previewlUrl: String?


}


