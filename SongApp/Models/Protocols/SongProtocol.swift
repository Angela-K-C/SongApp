//
//  SongProtocol.swift
//  SongApp
//
//  Created by etud on 09/06/2026.
//

import Foundation

protocol SongProtocol {
    var id: Int { get }
    var title: String { get }
    var artist: String { get }
    var album: String { get }
    var releaseDate: String { get }
    var previewUrl: String { get }
}

