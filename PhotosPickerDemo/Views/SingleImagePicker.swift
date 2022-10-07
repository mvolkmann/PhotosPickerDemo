import PhotosUI
import SwiftUI

struct SingleImagePicker: View {
    @StateObject var imagePicker = ImagePicker()

    var body: some View {
        NavigationStack {
            VStack {
                if let image = imagePicker.image {
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
                        selection: $imagePicker.imageSelection,
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

struct SingleImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        SingleImagePicker()
    }
}
