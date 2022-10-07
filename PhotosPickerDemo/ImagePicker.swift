import PhotosUI
import SwiftUI

@MainActor
class ImagePicker: ObservableObject {
    // For selecting a single image ...
    @Published var image: Image?

    // For selecting multiple images ...
    @Published var images: [Image] = []

    // For selecting a single image ...
    @Published var imageSelection: PhotosPickerItem? {
        didSet {
            if let imageSelection {
                Task {
                    try await loadTransferable(from: imageSelection)
                }
            }
        }

    }

    // For selecting multiple images ...
    @Published var imageSelections: [PhotosPickerItem] = [] {
        didSet {
            if imageSelections.isEmpty { return }
            Task {
                try await loadTransferable(from: imageSelections)
                imageSelections = []
            }
        }
    }

    func loadTransferable(from imageSelection: PhotosPickerItem?) async throws {
        do {
            if let data = try await imageSelection?.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    self.image = Image(uiImage: uiImage)
                }
            }
        } catch {
            print("ImagePicker.loadTransferable error:", error)
            image = nil
        }
    }

    func loadTransferable(from imageSelections: [PhotosPickerItem]) async throws {
        do {
            for selection in imageSelections {
                if let data = try await selection.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        self.images.append(Image(uiImage: uiImage))
                    }
                }
            }
        } catch {
            print("ImagePicker.loadTransferable error:", error)
            image = nil
        }
    }
}
