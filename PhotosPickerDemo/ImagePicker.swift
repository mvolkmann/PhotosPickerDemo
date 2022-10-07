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

    func loadImage(from imageSelection: PhotosPickerItem?) async throws -> Image? {
        guard let data = try await imageSelection?.loadTransferable(
            type: Data.self
        ) else { return nil }

        guard let uiImage = UIImage(data: data) else { return nil }

        return Image(uiImage: uiImage)
    }

    func loadTransferable(from selection: PhotosPickerItem?) async throws {
        do {
            self.image = try await loadImage(from: selection)
        } catch {
            print("ImagePicker.loadTransferable error:", error)
            image = nil
        }
    }

    func loadTransferable(from imageSelections: [PhotosPickerItem]) async throws {
        do {
            for selection in imageSelections {
                if let image = try await loadImage(from: selection) {
                    images.append(image)
                }
            }
        } catch {
            print("ImagePicker.loadTransferable error:", error)
            image = nil
        }
    }
}
