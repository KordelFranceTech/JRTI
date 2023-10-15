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
    var keyboardTap: UITapGestureRecognizer!
    
    var jrtiUrl: URL!
    let speaker = Voice()
    var canPresentSettings: Bool = true
    var startedSpeaking: Bool = false


    override func viewDidLoad() {
        super.viewDidLoad()        
        
        textView = UITextView(frame: CGRect(x: 20, y: 50, width: self.view.frame.width - 40, height: self.view.frame.height - 200))
        textView.textColor = UIColor.white
        textView.font = UIFont(name: Configuration.primaryFont, size: 17)
//        textView.isEditable = false
        self.view.addSubview(textView)
        
        playPauseButton = UIButton(frame: CGRect(x: 60, y: self.view.frame.maxY - 130, width: self.view.bounds.size.width - 120, height: 50))
        playPauseButton.backgroundColor = UIColor.black
        playPauseButton.isOpaque = true
        playPauseButton.setTitle("Play", for: .normal)
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
        
        keyboardTap = UITapGestureRecognizer()
        keyboardTap.addTarget(self, action: #selector(dismissKeyboard(_:)))
        self.view.addGestureRecognizer(keyboardTap)
        
        self.title = "Just Read the Instructions"
    }
    
    
    @objc func dismissKeyboard(_: UITapGestureRecognizer!) {
        self.view.endEditing(true)
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
        if !self.startedSpeaking {
            self.startedSpeaking = true
            playPauseButton.setTitle("Pause", for: .normal)
            speaker.speak(msg: self.textView.text)
        } else{
            if speaker.synthesizer.isPaused {
                speaker.synthesizer.continueSpeaking()
                playPauseButton.setTitle("Pause", for: .normal)
            } else {
                speaker.synthesizer.pauseSpeaking(at: .word)
                playPauseButton.setTitle("Play", for: .normal)
            }
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
    
    func removePreamble(fullText: String) -> String {
        var str: String = fullText
        var strToReturn: String = fullText
        
        if let range: Range<String.Index> = str.range(of: "Abstract") {
            let index: Int = str.distance(from: str.startIndex, to: range.lowerBound)
            strToReturn = String(str.dropFirst(index))
        }
        
        if let range: Range<String.Index> = strToReturn.range(of: "ABSTRACT") {
            let index: Int = strToReturn.distance(from: strToReturn.startIndex, to: range.lowerBound)
            strToReturn = String(strToReturn.dropFirst(index))
        }
        
//        start = str.startIndex
//        while let from = str.range(of: "", range: start..<str.endIndex)?.lowerBound,
//              let to = str.range(of: "Abstract", range: from..<str.endIndex)?.upperBound,
//              from != to {
//            str.removeSubrange(from..<to)
//            start = from
//        }
        return strToReturn
    }
    
    func removeCitations(fullText: String) -> String {
        var str: String = fullText
        var start = str.startIndex

        while let from = str.range(of: "(", range: start..<str.endIndex)?.lowerBound,
            let to = str.range(of: ")", range: from..<str.endIndex)?.upperBound,
            from != to {
                str.removeSubrange(from..<to)
                start = from
        }
        return str
    }
}

extension ViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            jrtiUrl = urls.first
            return
        }
        print("import result : \(myURL)")
        var textToRead: String = self.readFileContents(documentUrl: myURL)
        var textTrimmed: String = removePreamble(fullText: textToRead)
        textTrimmed = removeCitations(fullText: textTrimmed)
        self.textView.text = textTrimmed
        self.playPauseButton.isHidden = false
        self.startedSpeaking = false
    }

     func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

