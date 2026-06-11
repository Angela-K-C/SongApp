//
//  ITunesResponse.swift
//  SongApp
//
//  Created by etud on 10/06/2026.
//

import Foundation

struct ITunesResponse: Codable {
    let results: [ITunesSongDTO]
    
}

extension ITunesSongDTO {
     func toSong() -> Song {
        
         Song(
            id: trackId,
            title: trackName,
            artist: artistName,
            album: collectionName ?? "Unknown Album",
            releaseDate: releaseDate ?? "Unknown Date",
            artworkUrl: artworkUrl100 ?? "",
            previewUrl: previewlUrl ?? ""
         )
    }
}
