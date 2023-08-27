//
//  Utilities.swift
//  JRTI
//
//  Created by Kordel France on 8/27/23.
//

import Foundation


struct Utilities {
}

extension Double {
    func truncate(places : Int) -> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}
