//
//  SettingsViewController.swift
//  JRTI
//
//  Created by Kordel France on 8/27/23.
//

import UIKit


class SettingsViewController: UIViewController {
    
    var rateLabel: UILabel!
    var pitchLabel: UILabel!
    var voiceLabel: UILabel!
    var rateSlider: UISlider!
    var pitchSlider: UISlider!
    var voiceSegControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
        
        rateLabel = UILabel(frame: CGRect(x:50, y: 100, width: self.view.bounds.size.width - 100, height: 40))
        rateLabel.textColor = UIColor.white
        rateLabel.font = UIFont(name: Configuration.primaryFont, size: 21)
        rateLabel.textAlignment = .left
        rateLabel.numberOfLines = 1
        rateLabel.contentMode = .center
        rateLabel.lineBreakMode = .byWordWrapping
        rateLabel.text = "\tRate: \(Configuration.speakerRate)"
        rateLabel.clipsToBounds = true
        self.view.addSubview(rateLabel)
        
        rateSlider = UISlider(frame: CGRect(x: 20, y: self.rateLabel.frame.maxY + 20, width: self.view.frame.width - 40, height: 50))
        rateSlider.maximumValue = 0.0
        rateSlider.maximumValue = 1.0
        rateSlider.thumbTintColor = Configuration.trimColor
        rateSlider.tintColor = Configuration.accentColor
        rateSlider.addTarget(self, action: #selector(selectRate(sender:)), for: .touchUpInside)
        self.view.addSubview(self.rateSlider)
        
        pitchLabel = UILabel(frame: CGRect(x:50, y: self.rateSlider.frame.maxY + 50, width: self.view.bounds.size.width - 100, height: 40))
        pitchLabel.textColor = UIColor.white
        pitchLabel.font = UIFont(name: Configuration.primaryFont, size: 21)
        pitchLabel.textAlignment = .center
        pitchLabel.numberOfLines = 1
        pitchLabel.contentMode = .center
        pitchLabel.lineBreakMode = .byWordWrapping
        pitchLabel.text = "\tPitch: \(Configuration.speakerPitch)"
        pitchLabel.clipsToBounds = true
        self.view.addSubview(pitchLabel)
        
        pitchSlider = UISlider(frame: CGRect(x: 20, y: self.pitchLabel.frame.maxY + 20, width: self.view.frame.width - 40, height: 50))
        pitchSlider.maximumValue = 0.0
        pitchSlider.maximumValue = 1.0
        pitchSlider.thumbTintColor = Configuration.trimColor
        pitchSlider.tintColor = Configuration.accentColor
        pitchSlider.addTarget(self, action: #selector(selectPitch(sender:)), for: .touchUpInside)
        self.view.addSubview(self.pitchSlider)
        
        voiceLabel = UILabel(frame: CGRect(x:50, y: self.pitchSlider.frame.maxY + 50, width: self.view.bounds.size.width - 100, height: 40))
        voiceLabel.textColor = UIColor.white
        voiceLabel.font = UIFont(name: Configuration.primaryFont, size: 21)
        voiceLabel.textAlignment = .center
        voiceLabel.numberOfLines = 1
        voiceLabel.contentMode = .left
        voiceLabel.lineBreakMode = .byWordWrapping
        voiceLabel.text = "\tVoice"
        voiceLabel.clipsToBounds = true
        self.view.addSubview(voiceLabel)
        
        voiceSegControl = UISegmentedControl(frame: CGRect(x:50, y: self.voiceLabel.frame.maxY + 20, width: self.view.bounds.size.width - 100, height: 60))
        voiceSegControl.insertSegment(withTitle: "en-US", at: 0, animated: true)
        voiceSegControl.insertSegment(withTitle: "en-GB", at: 1, animated: true)
        voiceSegControl.insertSegment(withTitle: "en-AU", at: 2, animated: true)
        voiceSegControl.backgroundColor = UIColor.black
        voiceSegControl.selectedSegmentTintColor = Configuration.trimColor
        voiceSegControl.tintColor = Configuration.accentColor
        voiceSegControl.layer.borderColor = Configuration.trimColor.cgColor
        voiceSegControl.layer.borderWidth = 3
        voiceSegControl.addTarget(self, action: #selector(selectVoice(sender:)), for: .touchUpInside)
        self.view.addSubview(voiceSegControl)
    }
    
    
    @objc func selectRate(sender: UISlider!) {
        self.rateLabel.text = "\tRate: \(Double(sender.value).truncate(places:2))"
        Configuration.speakerRate = sender.value
    }
    
    
    @objc func selectPitch(sender: UISlider!) {
        self.pitchLabel.text = "\tPitch: \(Double(sender.value).truncate(places:2))"
        Configuration.speakerPitch = sender.value
    }
    
    
    @objc func selectVoice(sender: UISegmentedControl!) {
        
    }
}
