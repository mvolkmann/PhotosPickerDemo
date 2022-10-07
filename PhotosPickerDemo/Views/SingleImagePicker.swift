import PhotosUI
import SwiftUI

struct SingleImagePicker: View {
    @StateObject var imageLoader = ImageLoader()

    var body: some View {
        NavigationStack {
            VStack {
                if let image = imageLoader.image {
                    image.resizable().scaledToFit()
                } else {
                    Text("Tap upper-right button\nto select a photo.")
                        .multilineTextAlignment(.center)
                }
            }
            .padding()
            .navigationTitle("Single Image")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    PhotosPicker(
                        selection: $imageLoader.imageSelection,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        Image(systemName: "photo")
                            .imageScale(.large)
                    }
                }
            }
        }
    }
}
