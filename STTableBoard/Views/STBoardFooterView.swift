//
//  STBoardFooterView.swift
//  STTableBoard
//
//  Created by DangGu on 15/12/17.
//  Copyright © 2015年 StormXX. All rights reserved.
//

import UIKit

public class STBoardFooterView: UIView {
    
    public weak var boardView: STBoardView?

    public lazy var titleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.titleLabel?.font = TableBoardCommonConstant.labelFont
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(red: 8/255, green: 220/255, blue: 136/255, alpha: 1)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.clear.cgColor
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.contentHorizontalAlignment = .center
        button.contentEdgeInsets = UIEdgeInsetsMake(6, 46, 6, 46);
        button.addTarget(self, action: #selector(STBoardFooterView.addButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var textComposeView: TextComposeView = {
        let view = TextComposeView(frame: CGRect(x: 0, y: 0, width: self.width, height: self.height), textFieldHeight: newCellComposeViewTextFieldHeight, cornerRadius: 0.0)
        view.delegate = self
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProperty()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func setupProperty() {
        
        addSubview(titleButton)
        titleButton.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["titleButton": titleButton]
        let titleButtonHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[titleButton]-8-|", options: [], metrics: nil, views: views)
        let titleButtonVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[titleButton]-8-|", options: [], metrics: nil, views: views)
        let xConstraint = NSLayoutConstraint(item: titleButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        
        let yConstraint = NSLayoutConstraint(item: titleButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([xConstraint, yConstraint])
    }
    
    @objc func addButtonTapped(_ sender: UIButton?) {
        if let boardView = boardView, let customAction = boardView.delegate?.customAddRowAction(for: boardView) {
            customAction()
            return
        }
//        boardView?.footerViewHeightConstant = newCellComposeViewHeight
//        textComposeView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: self.width, height: newCellComposeViewHeight))
//        showTextComposeView()
//        if boardView?.tableBoard.isAddBoardTextComposeViewVisible ?? false {
//            boardView?.tableBoard.hiddenTextComposeView()
//            boardView?.tableBoard.isAddBoardTextComposeViewVisible = false
//        } else if let boardViewForVisibleTextComposeView = boardView?.tableBoard.boardViewForVisibleTextComposeView {
//            if boardViewForVisibleTextComposeView != boardView {
//                boardViewForVisibleTextComposeView.hideTextComposeView()
//            }
//        }
//        
//        boardView?.tableBoard.boardViewForVisibleTextComposeView = boardView
//        let tableView = boardView.tableView
//        let indexPath = NSIndexPath(forRow: tableView.numberOfRowsInSection(0) - 1, inSection: 0)
//        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
    }
    
    func showTextComposeView() {
        titleButton.isHidden = true
        addSubview(textComposeView)
        textComposeView.frame.size.height = newCellComposeViewHeight
        textComposeView.layoutIfNeeded()
        textComposeView.textField.becomeFirstResponder()
    }
    
    func hideTextComposeView() {
        titleButton.isHidden = false
        textComposeView.textField.resignFirstResponder()
        textComposeView.removeFromSuperview()
        textComposeView.textField.text = nil
        let shouldEnableAddRow = boardView?.shouldEnableAddRow ?? true
        boardView?.footerViewHeightConstant = shouldEnableAddRow ? footerViewNormalHeight : footerViewDisabledHeight
    }
}

extension STBoardFooterView: TextComposeViewDelegate {
    func textComposeView(textComposeView view: TextComposeView, didClickDoneButton button: UIButton, withText text: String) {
        textComposeView.textField.text = nil
        
        if let boardView = boardView {
            boardView.delegate?.boardView(boardView, didClickDoneButtonForAddNewRow: button, withRowTitle: text)
        }
    }
    
    func textComposeView(textComposeView view: TextComposeView, didClickCancelButton button: UIButton) {
        hideTextComposeView()
        if let boardView = boardView {
            boardView.delegate?.boardViewDidClickCancelButtonForAddNewRow(boardView)
        }
    }
    
    func textComposeViewDidBeginEditing(textComposeView view: TextComposeView) {
        boardView?.footerViewBeginEditing()
    }
}

