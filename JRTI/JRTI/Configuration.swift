//
//  Configuration.swift
//  JRTI
//
//  Created by Kordel France on 8/27/23.
//

import Foundation
import UIKit

struct Configuration {
    
    static var appVersion: String = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!
    static var databaseConfig: Int = 1  //0 experimental server (seekar), 1 Theta cloud (Theta)
    static var highConfig: Int = 1
    
    static var enterprise: Bool = false
    static var deviceIsIpad: Bool = false
    static var devConfig: Bool = false
    static var shouldUpdate: Bool = false
    static var accentFont = "AvenirNext-Bold"
    static var primaryFont = "AvenirNext-Regular"
    static var scaleFactor: CGFloat = 1.0
    static var primaryColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    static var accentColor = UIColor(red: 20/255.0, green: 20/255.0, blue: 20/255.0, alpha: 1.0)
    static var trimColor = UIColor(red: 27 / 255, green: 241 / 255, blue: 203 / 255, alpha: 1.0)
    static var therapyColor = UIColor.init(displayP3Red: 0.0 / 255.0, green: 255.0 / 255.0, blue: 150 / 255.0, alpha: 1.0)
    static var hudColor = UIColor(red: 255 / 255, green: 64 / 255, blue: 0 / 255, alpha: 1.0)
    static var navigationBarBackgroundColor = UIColor.clear
    
    //textfields
    static var textFieldBottomLineColor = UIColor(red: 193.0/255.0, green: 255.0/255.0, blue: 1.0/255.0, alpha: 1.0).cgColor
    static var textFieldPlaceholderColor = UIColor.darkGray
    static var textFieldBackgroundColor = UIColor.clear
    
    //notificationController
    static var notificationBackgroundColor = UIColor(red: 193.0/255.0, green: 255.0/255.0, blue: 1.0/255.0, alpha: 1.0)
    static var notificationTintColor = UIColor(red: 193.0/255.0, green: 255.0/255.0, blue: 1.0/255.0, alpha: 1.0)
    static var notificationFontColor = UIColor.black
    
    //view controllers
    static var viewController = ViewController()
    static var settingsViewController = SettingsViewController()
    
    //voice
    static var speakerPitch: Float = 0.8
    static var speakerRate: Float = 0.45
    static var speakerVolume: Float = 1.0
}
