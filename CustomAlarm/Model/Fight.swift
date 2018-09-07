//
//  Fight.swift
//  CustomAlarm
//
//  Created by Daniel Yo on 9/7/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit

struct Fight {
    
    let title: String?
    let when: String?
    let registeredDeviceIDs: Array<String>?

    
    init?(dictionary: [String: Any]) {
//        guard let name = dictionary["name"] as? String else { return nil }
//        self.name = name
        
        self.title = dictionary["title"] as? String
        self.when = dictionary["when"] as? String
        self.registeredDeviceIDs = dictionary["registeredDeviceIDs"] as? Array<String>
    }
    
}
