////
////  ViewController+Document.swift
////  JRTI
////
////  Created by Kordel France on 8/27/23.
////
//
//import UIKit
//import MobileCoreServices
//import UniformTypeIdentifiers
//
//
//extension ViewController: UIDocumentMenuDelegate,UIDocumentPickerDelegate {
//    
//    func openFilePicker() {
//        let types = UTType.types(tag: "pdf",
//                                 tagClass: UTTagClass.filenameExtension,
//                                 conformingTo: nil)
//        let documentPickerController = UIDocumentPickerViewController(
//                forOpeningContentTypes: types)
//        documentPickerController.delegate = self
//        self.present(documentPickerController, animated: true, completion: nil)
//    }
//    
//    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//        guard let myURL = urls.first else {
//            return
//        }
//        print("import result : \(myURL)")
//    }
//          
//
//    public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
//        documentPicker.delegate = self
//        present(documentPicker, animated: true, completion: nil)
//    }
//
//
//    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
//        print("view was cancelled")
//        dismiss(animated: true, completion: nil)
//    }
//}
