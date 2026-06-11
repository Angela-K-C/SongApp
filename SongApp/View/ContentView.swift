import SwiftUI


struct ContentView: View {
    
    @State private var library = MusicLibrary()
    
    var body: some View {
        
        TabView {
            
            SongsView(library: library)
                
                .tabItem {
                    Label(
                    "All Songs",
                    systemImage: "music.note.list"
                    )
                }
            
            FavoritesView(library: library)
            
                .tabItem {
                    Label(
                        "Favorites",
                        systemImage: "heart.fill"
                    )
                }
        }
        .task {
            await library.loadSongs()
            
        }
    }
    

}

#Preview {
    ContentView()
}
