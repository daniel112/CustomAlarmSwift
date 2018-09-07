//
//  LabelDateImageCollectionViewCell.swift
//  CustomAlarm
//
//  Created by Daniel Yo on 9/7/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit

class LabelDateImageCollectionViewCell: UICollectionViewCell {
    
    public var title:String? {
        get { return self.labelTitle.text }
        set { self.labelTitle.text = newValue }
    }
    
    public var when:String? {
        get { return self.labelDate.text }
        set { self.labelDate.text = newValue }
    }
    public var isSubscribed:Bool {
        get { return self.imageView.isHidden }
        set {
            if (newValue) {
                self.imageView.isHidden = false
            } else {
                self.imageView.isHidden = true
            }
        }
    }
    
    lazy private var labelTitle:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy private var labelDate:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        return label
    }()
    
    fileprivate var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "check")
        return imageView
    }()
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private API
    override var isHighlighted: Bool {
        didSet {
            self.contentView.backgroundColor = isHighlighted ? UIColor.gray : nil
        }
    }
    
    private func setup() {
        
        // title
        self.contentView.addSubview(self.labelTitle)
        self.labelTitle.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
        })
        
        // date
        self.contentView.addSubview(self.labelDate)
        self.labelDate.snp.makeConstraints({ (make) in
            make.top.equalTo(self.labelTitle.snp.bottom)
            make.left.equalToSuperview().offset(10)
        })
        
        // image
        self.contentView.addSubview(self.imageView)
        self.imageView.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(36)
            make.width.equalTo(36)
        })
    }
    
}
