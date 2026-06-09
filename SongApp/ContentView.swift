import SwiftUI

// MARK: - Favorites Store
class FavoriteStore: ObservableObject {
    @Published var favoriteIDs: Set<Int> = []
    
    func toggle(_ id: Int) {
        if favoriteIDs.contains(id) {
            favoriteIDs.remove(id)
        } else {
            favoriteIDs.insert(id)
        }
    }
    
    func isFavorite(_ id: Int) -> Bool {
        favoriteIDs.contains(id)
    }
}

// MARK: - Main View
struct ContentView: View {
    
    @StateObject private var favoritesStore = FavoriteStore()
    @State private var showFavorites = false
    
    // Example data (you can replace with API decoding later)
    @State private var songs: [Song] = [
        Song(id: 1,
             title: "Imagine",
             artist: "John Lennon",
             album: "Imagine",
             releaseDate: Date()),
        
        Song(id: 2,
             title: "Bohemian Rhapsody",
             artist: "Queen",
             album: "A Night at the Opera",
             releaseDate: Date()),
        
        Song(id: 3,
             title: "Billie Jean",
             artist: "Michael Jackson",
             album: "Thriller",
             releaseDate: Date())
    ]
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                // Toggle view
                Button {
                    showFavorites.toggle()
                } label: {
                    Text(showFavorites ? "Show All Songs" : "Show Favorites")
                        .font(.subheadline)
                        .padding(8)
                }
                
                if showFavorites {
                    FavoritesView(
                        songs: songs,
                        favoritesStore: favoritesStore
                    )
                } else {
                    List(songs) { song in
                        SongRowView(
                            song: song,
                            isFavorite: favoritesStore.isFavorite(song.id),
                            onFavoriteTapped: {
                                favoritesStore.toggle(song.id)
                            }
                        )
                    }
                }
            }
            .navigationTitle("Songs")
        }
    }
}

// MARK: - Song Row View
struct SongRowView: View {
    
    let song: Song
    let isFavorite: Bool
    let onFavoriteTapped: () -> Void
    
    var body: some View {
        HStack {
            
            VStack(alignment: .leading) {
                Text(song.title)
                    .font(.headline)
                
                Text(song.artist)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(song.album)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: onFavoriteTapped) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(isFavorite ? .red : .gray)
            }
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Favorites View
struct FavoritesView: View {
    
    let songs: [Song]
    @ObservedObject var favoritesStore: FavoriteStore
    
    var favoriteSongs: [Song] {
        songs.filter { favoritesStore.isFavorite($0.id) }
    }
    
    var body: some View {
        List {
            
            if favoriteSongs.isEmpty {
                Text("No favorites yet ❤️")
                    .foregroundColor(.gray)
            } else {
                
                ForEach(favoriteSongs) { song in
                    SongRowView(
                        song: song,
                        isFavorite: true,
                        onFavoriteTapped: {
                            favoritesStore.toggle(song.id)
                        }
                    )
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
