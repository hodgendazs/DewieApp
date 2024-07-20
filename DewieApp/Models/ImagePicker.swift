//
//  ImagePicker.swift
//  DewieApp
//
//  Created by Thomas Hodge on 7/5/24.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}



//import SwiftUI
//import UIKit
//
//struct ImagePicker: UIViewControllerRepresentable {
//    @Binding var image: UIImage?
//    @Environment(\.presentationMode) var presentationMode
//    
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        var parent: ImagePicker
//
//        init(parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            if let uiImage = info[.originalImage] as? UIImage {
//                // Flip the image horizontally and vertically
//                if let horizontallyFlippedImage = self.flipImageHorizontally(image: uiImage),
//                   let fullyFlippedImage = self.flipImageVertically(image: horizontallyFlippedImage) {
//                    parent.image = fullyFlippedImage
//                }
//            }
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//        
//        // Function to flip an image horizontally
//        func flipImageHorizontally(image: UIImage) -> UIImage? {
//            UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
//            guard let context = UIGraphicsGetCurrentContext() else { return nil }
//            
//            context.translateBy(x: image.size.width, y: 0)
//            context.scaleBy(x: -1.0, y: 1.0)
//            
//            context.draw(image.cgImage!, in: CGRect(origin: .zero, size: image.size))
//            let flippedImage = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            
//            return flippedImage
//        }
//
//        // Function to flip an image vertically
//        func flipImageVertically(image: UIImage) -> UIImage? {
//            UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
//            guard let context = UIGraphicsGetCurrentContext() else { return nil }
//            
//            context.translateBy(x: 0, y: image.size.height)
//            context.scaleBy(x: 1.0, y: -1.0)
//            
//            context.draw(image.cgImage!, in: CGRect(origin: .zero, size: image.size))
//            let flippedImage = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            
//            return flippedImage
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(parent: self)
//    }
//
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
//}
//
