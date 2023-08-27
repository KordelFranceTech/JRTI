//
//  ViewController.swift
//  JRTI
//
//  Created by Kordel France on 8/27/23.
//

import UIKit
import PDFKit
import MediaPlayer
import AudioToolbox
import MobileCoreServices
import UniformTypeIdentifiers


class ViewController: UIViewController, UINavigationControllerDelegate
 {
    
    var settingsButton: UIButton!
    var submitButton: UIButton!
    var playPauseButton: UIButton!
    var textView: UITextView!
    var longPress: UILongPressGestureRecognizer!
    
    var jrtiUrl: URL!
    let speaker = Voice()
    var canPresentSettings: Bool = true


    override func viewDidLoad() {
        super.viewDidLoad()        
        
        textView = UITextView(frame: CGRect(x: 20, y: 50, width: self.view.frame.width - 40, height: self.view.frame.height - 200))
        textView.textColor = UIColor.white
        textView.font = UIFont(name: Configuration.primaryFont, size: 17)
        textView.isEditable = false
        self.view.addSubview(textView)
        
        playPauseButton = UIButton(frame: CGRect(x: 60, y: self.view.frame.maxY - 130, width: self.view.bounds.size.width - 120, height: 50))
        playPauseButton.backgroundColor = UIColor.black
        playPauseButton.isOpaque = true
        playPauseButton.setTitle("Pause", for: .normal)
        playPauseButton.setTitleColor(Configuration.trimColor, for: .normal)
        playPauseButton.contentMode = .scaleAspectFit
        playPauseButton.layer.cornerRadius = 8
        playPauseButton.layer.borderWidth = 3
        playPauseButton.layer.borderColor = Configuration.trimColor.cgColor
        playPauseButton.addTarget(self, action: #selector(playPause(sender:)), for: .touchUpInside)
        playPauseButton.isHidden = true
        self.view.addSubview(playPauseButton)
        
        submitButton = UIButton(frame: CGRect(x: 60, y: self.view.frame.maxY - 70, width: self.view.bounds.size.width - 120, height: 50))
        submitButton.backgroundColor = Configuration.trimColor
        submitButton.isOpaque = true
        submitButton.setTitle("Select", for: .normal)
        submitButton.setTitleColor(UIColor.black, for: .normal)
        submitButton.contentMode = .scaleAspectFit
        submitButton.layer.cornerRadius = 8
        submitButton.layer.borderWidth = 3
        submitButton.layer.borderColor = UIColor.darkGray.cgColor
        submitButton.addTarget(self, action: #selector(openDocument(sender:)), for: .touchUpInside)
        self.view.addSubview(submitButton)
        
        longPress = UILongPressGestureRecognizer()
        longPress.minimumPressDuration = 0.5
        longPress.addTarget(self, action: #selector(showSettings(recognizer:)))
        self.view.addGestureRecognizer(longPress)
        
        self.title = "Just Read the Instructions"
    }

    @objc func openDocument(sender: UIButton!) {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        documentPicker.shouldShowFileExtensions = true
        present(documentPicker, animated: true, completion: nil)
    }
    

    func readFileContents(documentUrl: URL) -> String {
        print("documentURL: \(documentUrl)")
        var textToRead: String = "No text to read"
        if let pdf = PDFDocument(url: documentUrl) {
            let pageCount = pdf.pageCount
            print("page count: \(pageCount)")
            let documentContent = NSMutableAttributedString()
            
            for i in 0 ..< pageCount {
                guard let page = pdf.page(at: i) else { continue }
                guard let pageContent = page.attributedString else { continue }
                documentContent.append(pageContent)
            }
            print(documentContent.string)
            textToRead = documentContent.string
        }
        return textToRead
    }

    
    @objc func playPause(sender: UIButton!) {
        if speaker.synthesizer.isPaused {
            speaker.synthesizer.continueSpeaking()
            playPauseButton.setTitle("Pause", for: .normal)
        } else {
            speaker.synthesizer.pauseSpeaking(at: .word)
            playPauseButton.setTitle("Play", for: .normal)
        }
    }
    
    
    @objc func showSettings(recognizer: UIGestureRecognizer!) {
        if self.canPresentSettings {
            self.canPresentSettings = false
            self.navigationController?.present(Configuration.settingsViewController, animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0, execute: {
                self.longPress.isEnabled = true
            })
        }
    }
}

extension ViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            jrtiUrl = urls.first
            return
        }
        print("import result : \(myURL)")
        var textToRead: String = readFileContents(documentUrl: myURL)
        self.textView.text = textToRead
        speaker.speak(msg: textToRead)
        playPauseButton.isHidden = false
    }

     func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

