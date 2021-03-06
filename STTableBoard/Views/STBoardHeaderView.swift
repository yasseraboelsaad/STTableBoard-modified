//
//  STBoardHeaderView.swift
//  STTableBoard
//
//  Created by DangGu on 15/12/16.
//  Copyright © 2015年 StormXX. All rights reserved.
//

import UIKit

public class STBoardHeaderView: UIView {
    
    public weak var boardView: STBoardView?
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    var number: Int = 0 {
        didSet {
            numberLabel.text = " \(number)"
        }
    }

    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Medium", size: 14)!
        label.textColor = UIColor.black
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()

    public lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = TableBoardCommonConstant.labelFont
        label.textColor = UIColor.darkGrayTextColor
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    public lazy var actionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "boardHeaderMoreButton", in: currentBundle, compatibleWith: nil), for: .normal)
        button.addTarget(self, action: #selector(self.actionButtonBeClicked(_:)), for: .touchUpInside)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -10)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProperty()
    }
    
    func setupProperty() {
        addSubview(titleLabel)
        addSubview(numberLabel)
        addSubview(actionButton)
        
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        actionButton.isHidden = true
        
        let leading: CGFloat = BoardHeaderViewConstant.labelLeading
        let spacing: CGFloat = 0.0
        let trailing: CGFloat = 0.0
//        let horizontalConstraits = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[numberLabel]-spacing-[actionButton]-trailing-|", options: [], metrics: ["leading":leading, "trailing":trailing, "spacing":spacing], views: ["numberLabel":numberLabel, "actionButton":actionButton])
       
        let titleLabelVerticalConstrait = NSLayoutConstraint(item: titleLabel,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0)
        
        let titleLabelHorizontalConstrait = NSLayoutConstraint(item: titleLabel,
                                                             attribute: .leading,
                                                             relatedBy: .equal,
                                                             toItem: self,
                                                             attribute: .leading,
                                                             multiplier: 1.0,
                                                             constant: 20)
        
        let titleLabelHorizontalConstrait2 = NSLayoutConstraint(item: actionButton,
                                                               attribute: .leading,
                                                               relatedBy: .greaterThanOrEqual,
                                                               toItem: titleLabel,
                                                               attribute: .trailing,
                                                               multiplier: 1.0,
                                                               constant: 4)
        
        let horizontalConstraits = NSLayoutConstraint(item: actionButton,
                                                                attribute: .trailing,
                                                                relatedBy: .equal,
                                                                toItem: self,
                                                                attribute: .trailing,
                                                                multiplier: 1.0,
                                                                constant: -16)
        
        let numberLabelConstraits = NSLayoutConstraint(item: numberLabel,
                                                       attribute: .centerY,
                                                       relatedBy: .equal,
                                                       toItem: titleLabel,
                                                       attribute: .centerY,
                                                       multiplier: 1.0,
                                                       constant: 0)
        
        let buttonWidth = NSLayoutConstraint(item: actionButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 49.0)
//        let buttonCenterY = NSLayoutConstraint(item: actionButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
        let buttonVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[actionButton]|", options: [], metrics: nil, views: ["actionButton":actionButton])
        
        NSLayoutConstraint.activate(buttonVerticalConstraints + [titleLabelVerticalConstrait, numberLabelConstraits, buttonWidth, titleLabelHorizontalConstrait, titleLabelHorizontalConstrait2, horizontalConstraits])
        
    }
    
    @objc func actionButtonBeClicked(_ sender: UIButton) {
        if let boardView = boardView {
            boardView.delegate?.boardView(boardView, didClickBoardMenuButton: sender)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
