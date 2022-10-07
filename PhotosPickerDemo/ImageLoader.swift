import PhotosUI
import SwiftUI

@MainActor
class ImageLoader: ObservableObject {
    // Holds a single selected image
    @Published var image: Image?

    // Holds multiple selected images
    @Published var images: [Image] = []

    // Holds a single image selection
    @Published var imageSelection: PhotosPickerItem? {
        didSet {
            if let imageSelection {
                Task {
                    try await loadSingleSelection(from: imageSelection)
                }
            }
        }
    }

    // Holds multiple image selections
    @Published var imageSelections: [PhotosPickerItem] = [] {
        didSet {
            if imageSelections.isEmpty { return }
            Task {
                try await loadMultipleSelections(from: imageSelections)
                imageSelections = []
            }
        }
    }

    private func loadSingleSelection(
        from selection: PhotosPickerItem?
    ) async throws {
        do {
            image = try await loadSelection(from: selection)
        } catch {
            print("ImageLoader error:", error)
            image = nil
        }
    }

    private func loadMultipleSelections(
        from selections: [PhotosPickerItem]
    ) async throws {
        do {
            for selection in selections {
                if let image = try await loadSelection(from: selection) {
                    images.append(image)
                }
            }
        } catch {
            print("ImageLoader error:", error)
            image = nil
        }
    }

    private func loadSelection(
        from selection: PhotosPickerItem?
    ) async throws -> Image? {
        guard let data = try await selection?.loadTransferable(
            type: Data.self
        ) else { return nil }

        guard let uiImage = UIImage(data: data) else { return nil }

        return Image(uiImage: uiImage)
    }
}
