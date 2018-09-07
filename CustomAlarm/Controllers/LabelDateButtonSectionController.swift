//
//  LabelDateButtonSectionController.swift
//  CustomAlarm
//
//  Created by Daniel Yo on 9/7/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit

import IGListKit


protocol LabelDateButtonSectionControllerDelegate {
    func labelDateButtonSectionButtonPressed(button:UIButton)

}

class LabelDateButtonSectionController: ListSectionController {
    
    var delegate:LabelDateButtonSectionControllerDelegate?
    private var item:FightAlarm?
    
    //MARK: ListSectionController
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext!.containerSize.width, height: 55)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        let cell:LabelDateButtonCollectionViewCell = self.collectionContext!.dequeueReusableCell(of: LabelDateButtonCollectionViewCell.self, for: self, at: index) as! LabelDateButtonCollectionViewCell

        cell.title = self.item!.title
        cell.when = self.item!.date
        cell.delegate = self
        return cell
            
    }
    
    override func didUpdate(to object: Any) {
        self.item = object as? FightAlarm
    }
    
    override func didSelectItem(at index: Int) {
        
        
    }
}

extension LabelDateButtonSectionController:LabelDateButtonCollectionViewCellDelegate {
    func LabelDateButtonCollectionViewCellButtonPressed(button: UIButton) {
        if let delegateVC = self.delegate {
            delegateVC.labelDateButtonSectionButtonPressed(button: button)
        }
    }
    
    
}
