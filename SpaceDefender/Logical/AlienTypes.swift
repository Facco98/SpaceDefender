//
//  AlienGenerator.swift
//  SpaceDefender
//
//  Created by Claudio Facchinetti on 26/07/18.
//  Copyright © 2018 Claudio Facchinetti. All rights reserved.
//

import Foundation

enum AlienTypes: Int{
    
    public static let probabilties: [CountableClosedRange<Int>: [String: Double]] = [
        0...20: ["type1": 100, "type2": 0, "type3": 0],
        21...40: ["type1": 70, "type2": 20, "type3": 10],
        41...70: ["type1": 40, "type2": 40, "type3": 20 ]
    ]
    
    case type1 = 0
    case type2 = 1
    case type3 = 2
    

}

extension CountableClosedRange: Hashable{
    
    public var hashValue: Int {
        return "\(self.upperBound)_\(self.lowerBound)".hashValue
    }
    
    
    
    
}
