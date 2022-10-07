import SwiftUI

// See the YouTube video from Stewart Lynch at
// https://www.youtube.com/watch?v=gfUBKhZLcK0.
struct ContentView: View {
    var body: some View {
        TabView {
            SingleImagePicker()
                .tabItem {
                    Label("Single Image", systemImage: "photo")
                }
            MultipleImagePicker()
                .tabItem {
                    Label(
                        "Multiple Images",
                        systemImage: "photo.on.rectangle.angled"
                    )
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
