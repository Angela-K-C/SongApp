//
//  SongDetailView.swift
//  SongApp
//
//  Created by etud on 10/06/2026.
//



import SwiftUI



struct SongDetailView: View {
    

    
    let song: Song
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            AsyncImage(url: URL(string: song.artworkUrl), content: { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 250, height: 250)
                        .clipped()
                        .cornerRadius(16)
                }else if phase.error != nil {
                    Image(systemName: "music.note")
                        .font(.system(size: 50))
                        .frame(width: 250, height: 250)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(16)
                        
                }else {
                    ProgressView()
                }
                }
             )

            
            VStack(alignment: .leading, spacing: 6) {
                
                Text(song.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                    .lineLimit(2)
                
                Text(song.artist)
                    .font(.headline)
                    .foregroundStyle(.secondary)
                
                Text(song.album)
                    .font(.subheadline)
                    .foregroundStyle(.secondary.opacity(0.8))
                
                Text(song.releaseDate.prefix(10))
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
            
            
        }
        .padding()
        .navigationTitle("Song Details")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}
