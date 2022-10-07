import PhotosUI
import SwiftUI

struct MultipleImagePicker: View {
    @StateObject var imageLoader = ImageLoader()

    let columns = [GridItem(.adaptive(minimum: 100))]

    var body: some View {
        NavigationStack {
            VStack {
                if imageLoader.images.isEmpty {
                    Text("Tap upper-right button\nto select multiple photos.")
                        .multilineTextAlignment(.center)
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(
                                0 ..< imageLoader.images.count,
                                id: \.self
                            ) { index in
                                imageLoader.images[index]
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Multiple Images")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    PhotosPicker(
                        selection: $imageLoader.imageSelections,
                        maxSelectionCount: 10,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        Image(systemName: "photo.on.rectangle.angled")
                            .imageScale(.large)
                    }
                }
            }
        }
    }
}
