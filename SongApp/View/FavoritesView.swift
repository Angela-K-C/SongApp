import SwiftUI

struct FavoritesView: View {

    @Bindable var library: MusicLibrary

    var body: some View {
        NavigationStack {

            if library.favoriteSongs.isEmpty {
                ContentUnavailableView(
                    "No Favorites",
                    systemImage: "heart.slash",
                    description: Text("Add songs to your favorites to see them here.")
                )
            } else {
                List {

                    ForEach(library.favoriteSongs) { song in
                        NavigationLink {
                            SongDetailView(song: song)
                        } label: {
                            SongRow(
                                song: song,
                                isFavorite: true
                            ) {
                                library.toggleFavorite(songId: song.id)
                            }
                        }
                    }
                    .onDelete(perform: library.deleteFavorites)
                    .onMove(perform: library.moveFavorites)
                }
                .toolbar {
                    EditButton()
                }
            }
        }
        .navigationTitle("Favorites")
    }
}
