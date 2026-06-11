//
//  ITunesService.swift
//  SongApp
//
//  Created by etud on 10/06/2026.
//

import Foundation

class ITunesService {
    
    func fetchSongs(searchTerm: String) async throws -> [Song] {
        
        let encodedTerm =
        searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        let url = URL(
            string:
                "https://itunes.apple.com/search?term=\(encodedTerm)&entity=song&limit=90"
        )!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let response = try JSONDecoder()
            .decode(ITunesResponse.self, from: data)
        
        
    
            
        return response.results.map {
            $0.toSong()
            
        }
        
        
        
    }
    
}
