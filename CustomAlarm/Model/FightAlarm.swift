//
//  FightAlarm.swift
//  CustomAlarm
//
//  Created by Daniel Yo on 9/7/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit

import IGListKit

class FightAlarm: NSObject {
    var title:String?
    var date:String?
    var isSubscribed:Bool = false
    
    init(withName name:String, date:String) {
        self.title = name
        self.date = date
    }
}

extension FightAlarm: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return self.title! as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? FightAlarm else {
            return false
        }
        return self.title == object.title
    }
}
