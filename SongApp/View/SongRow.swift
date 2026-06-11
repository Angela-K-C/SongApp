import SwiftUI

struct SongRow: View {

    let song: Song
    let isFavorite: Bool
    let favoriteAction: () -> Void
    


    var body: some View {

        HStack {
            
            AsyncImage(url: URL(string: song.artworkUrl), content: { phase in
                if let image = phase.image {
                    image
                }else if phase.error != nil {
                    Image(systemName: "music.note")
                        
                }else {
                    ProgressView()
                }
                }
             )
            
            
//            if let url = URL(string: song.artworkUrl),
//               !song.artworkUrl.isEmpty {
//            
//            AsyncImage(url: url)
//             { image in
//
//                image
//                    .resizable()
//                    .scaledToFill()
//
//            } placeholder: {
//                ProgressView()
//            }
//            .frame(width: 50, height: 50)
//            .clipShape(RoundedRectangle(cornerRadius: 8))
//                
//            }
//            else {
//                Image(systemName: "music.note")
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 50, height: 50)
//                    .clipShape(RoundedRectangle(cornerRadius: 8))
//            }

            VStack(alignment: .leading) {
                Text(song.title)
                    .font(.headline)

                Text(song.artist)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button(action: favoriteAction) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
            }
            .buttonStyle(.plain)
        }
    }
}
