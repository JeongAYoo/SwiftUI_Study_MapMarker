//
//  PhotoPickerView.swift
//  SwiftUI_Study_MapMarker
//
//  Created by Jade Yoo on 2023/05/25.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: UIViewControllerRepresentable {
    @EnvironmentObject var viewModel: PhotoViewModel
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Create & Update view
    func makeUIViewController(context: Context) -> PHPickerViewController {
        // 사진의 메타데이터를 가져오기 위해 PHPickerViewController 사용
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images
        config.selectionLimit = 1
        let controller = PHPickerViewController(configuration: config)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }
    
    func makeCoordinator() -> PhotoPickerView.Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        // MARK: - Properties
        private var model = ImageData()
        private let parent: PhotoPickerView
        
        // MARK: - Initializer
        init(_ parent: PhotoPickerView) {
            self.parent = parent
        }
        
        // MARK: - PHPickerViewControllerDelegate
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.presentationMode.wrappedValue.dismiss()
            guard !results.isEmpty else {
                return
            }
            
            let imageResult = results[0]
            
            if let assetId = imageResult.assetIdentifier {
                let assetResults = PHAsset.fetchAssets(withLocalIdentifiers: [assetId], options: nil)
                self.model.date = assetResults.firstObject?.creationDate
                self.model.location = assetResults.firstObject?.location?.coordinate
                print(self.model)

            }
            
            if imageResult.itemProvider.canLoadObject(ofClass: UIImage.self) {
                imageResult.itemProvider.loadObject(ofClass: UIImage.self) { (selectedImage, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        DispatchQueue.main.async {
                            self.model.image = selectedImage as? UIImage
                            self.parent.viewModel.imageData.append(self.model)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Preview
struct CustomPhotoPicker_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPickerView()
    }
}
