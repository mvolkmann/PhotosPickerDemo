import PhotosUI
import SwiftUI

struct MultipleImagePicker: View {
    @StateObject var imagePicker = ImagePicker()

    let columns = [GridItem(.adaptive(minimum: 100))]

    var body: some View {
        NavigationStack {
            VStack {
                if imagePicker.images.isEmpty {
                    Text("Tap upper-right button\nto select multiple photos.")
                        .multilineTextAlignment(.center)
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(0 ..< imagePicker.images.count, id: \.self) { index in
                                imagePicker.images[index].resizable().scaledToFit()
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
                        selection: $imagePicker.imageSelections,
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
struct MultipleImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        MultipleImagePicker()
    }
}
