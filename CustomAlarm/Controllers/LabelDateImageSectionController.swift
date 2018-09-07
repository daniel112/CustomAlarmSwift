//
//  LabelDateImageSectionController.swift
//  CustomAlarm
//
//  Created by Daniel Yo on 9/7/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit
import IGListKit


protocol LabelDateImageSectionControllerDelegate {
    func didSelectItem(item:FightAlarm)
}

class LabelDateImageSectionController: ListSectionController {

    var delegate:LabelDateImageSectionControllerDelegate?
    var revealWidth:CGFloat?
    private var item:FightAlarm?
    
    //MARK: ListSectionController
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext!.containerSize.width, height: 55)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        let cell:LabelDateImageCollectionViewCell = self.collectionContext!.dequeueReusableCell(of: LabelDateImageCollectionViewCell.self, for: self, at: index) as! LabelDateImageCollectionViewCell
        
        cell.title = self.item!.title
        cell.when = self.item!.date
        cell.isSubscribed = item!.isSubscribed
        
        return cell
        
    }
    
    override func didUpdate(to object: Any) {
        self.item = object as? FightAlarm
    }
    
    override func didSelectItem(at index: Int) {
        
        //if delegate exists and conforms to method
        if let delegateVC = self.delegate {
            delegateVC.didSelectItem(item: self.item!)
        }
        
    }
}
