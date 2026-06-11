import SwiftUI

struct SongsView: View {

    @Bindable var library: MusicLibrary

    var body: some View {

        NavigationStack {

            List {
                ForEach(library.songs) { song in

                    NavigationLink {
                        SongDetailView(song: song)
                    } label: {
                        SongRow(
                            song: song,
                            isFavorite: library.isFavorite(songId: song.id)
                        ) {
                            library.toggleFavorite(songId: song.id)
                        }
                    }
                }
                .onDelete(perform: library.deleteSongs)
                .onMove(perform: library.moveSongs)
            }
            .searchable(
                text: $library.searchText,
                prompt: "Search Songs"
            )
            .onSubmit(of: .search) {
                Task {
                    await library.searchSongs()
                }
            }
            .navigationTitle("Songs")
            .toolbar {
                EditButton()
            }
        }
    }
}

#Preview {
    SongsView(library: MusicLibrary())
}
