//
//  LabelDateButtonCollectionViewCell.swift
//  CustomAlarm
//
//  Created by Daniel Yo on 9/7/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit

protocol LabelDateButtonCollectionViewCellDelegate: class {
    func LabelDateButtonCollectionViewCellButtonPressed(button:UIButton)
}

class LabelDateButtonCollectionViewCell: UICollectionViewCell {
    
    public var delegate:LabelDateButtonCollectionViewCellDelegate?
    public var title:String? {
        get { return self.labelTitle.text }
        set { self.labelTitle.text = newValue }
    }
    
    public var when:String? {
        get { return self.labelDate.text }
        set { self.labelDate.text = newValue }
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
    
    lazy var buttonAlarm:UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Send Alarm", for: UIControlState())
        button.setTitleColor(.blue, for: UIControlState())
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(LabelDateButtonCollectionViewCell.buttonAlarm_touchUpInside(_:)), for: .touchUpInside)
        return button
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
//    override var isHighlighted: Bool {
//        didSet {
//            self.contentView.backgroundColor = isHighlighted ? UIColor.gray : nil
//        }
//    }
    
    // MARK: UIResponder
    @objc func buttonAlarm_touchUpInside(_ button:UIButton!) {
        delegate?.LabelDateButtonCollectionViewCellButtonPressed(button:button)
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
        
        // button
        self.contentView.addSubview(self.buttonAlarm)
        self.buttonAlarm.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(30)
            make.width.equalTo(100)
        })
    }
    
    
    
}
