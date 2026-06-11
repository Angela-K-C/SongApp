//
//  MusicLibrary.swift
//  SongApp
//
//  Created by etud on 10/06/2026.
//

import Foundation
import Observation

@Observable

class MusicLibrary {
    
    
    var songs: [Song] = []
    var searchText: String = ""
    
    var favoriteIds: [Int] = []
    
    func searchSongs() async {
        guard !searchText.trimmingCharacters(
            in: .whitespaces
        ).isEmpty else {
            return
        }
        
        do {
            
            let service = ITunesService()
            
            songs = try await service.fetchSongs(
                searchTerm: searchText
            )
        } catch {
            print(error)
        }
    }
    
    func toggleFavorite(songId: Int) {
        if favoriteIds.contains(songId) {
            favoriteIds.removeAll {
                $0 == songId
            }
        } else {
            favoriteIds.append(songId)
        }
    }
    
    func isFavorite(songId: Int) -> Bool {
        favoriteIds.contains(songId)
    }
    
    var favoriteSongs: [Song] {
        
        favoriteIds.compactMap {id in
            
            songs.first { $0.id == id }
            
        }
    }
    
    func deleteFavorites(at offsets: IndexSet) {
        favoriteIds.remove(atOffsets: offsets)
    }
    
    func moveFavorites(from source: IndexSet, to destination: Int){
        favoriteIds.move(
            fromOffsets: source,
            toOffset: destination
        )
    }
    
    func deleteSongs(at offsets: IndexSet) {
        
        let deletedIds = offsets.map { songs[$0].id }
        
        songs.remove(atOffsets: offsets)
        
        for id in deletedIds {
            favoriteIds.removeAll {
                $0 == id
            }
        }
    }
    
    func moveSongs(from source: IndexSet, to destination: Int){
        
        songs.move(
            fromOffsets: source,
            toOffset: destination
        )
    }
    
    func loadSongs() async {
         
        do {
            let service = ITunesService()
            
            songs = try await service.fetchSongs(searchTerm: "Taylor Swift")
        } catch {
            print(error)
        }
        
    }
    
    var filteredSongs: [Song] {
        
        if searchText.isEmpty {
            return songs
        }
        
        return songs.filter {
            $0.title.localizedCaseInsensitiveContains(searchText)
            ||
            $0.artist.localizedCaseInsensitiveContains(searchText)
        }
    }
    
}
