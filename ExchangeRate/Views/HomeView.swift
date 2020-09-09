//
//  HomeView.swift
//  ExchangeRate
//
//  Created by Aleksandr Svetilov on 09.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import Foundation
import UIKit

class HomeView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        stackView.addArrangedSubview(amount)
        stackView.addArrangedSubview(underline)
        stackView.addArrangedSubview(fromButton)
        stackView.addArrangedSubview(toButton)
        stackView.addArrangedSubview(result)
        fromButton.addSubview(convertFromLabel)
        fromButton.addSubview(playImageFrom)
        toButton.addSubview(convertToLabel)
        toButton.addSubview(playImageTo)
        addSubview(stackView)
        
        stackView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        amount.anchor(top: nil, leading: stackView.leadingAnchor, bottom: nil, trailing: stackView.trailingAnchor, paddingTop: 0, paddingLeft: standardPadding, paddingBottom: 0, paddingRight: standardPadding, width: 0, height: 50)
        
        underline.anchor(top: nil, leading: stackView.leadingAnchor, bottom: nil, trailing: stackView.trailingAnchor, paddingTop: 0, paddingLeft: standardPadding, paddingBottom: 0, paddingRight: standardPadding, width: 0, height: 2)
        
        fromButton.anchor(top: nil, leading: stackView.leadingAnchor, bottom: nil, trailing: stackView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 70)
        
        toButton.anchor(top: nil, leading: stackView.leadingAnchor, bottom: nil, trailing: stackView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 70)
        
        convertFromLabel.anchor(top: fromButton.topAnchor, leading: fromButton.leadingAnchor, bottom: fromButton.bottomAnchor, trailing: playImageFrom.leadingAnchor, paddingTop: 0, paddingLeft: standardPadding, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        convertFromLabel.setContentCompressionResistancePriority(higherPriority, for: .horizontal)
        
        convertToLabel.anchor(top: toButton.topAnchor, leading: toButton.leadingAnchor, bottom: toButton.bottomAnchor, trailing: playImageTo.leadingAnchor, paddingTop: 0, paddingLeft: standardPadding, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        convertToLabel.setContentCompressionResistancePriority(higherPriority, for: .horizontal)
        
        playImageFrom.anchor(top: fromButton.topAnchor, leading: convertFromLabel.trailingAnchor, bottom: fromButton.bottomAnchor, trailing: fromButton.trailingAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 20, paddingRight: standardPadding, width: 0, height: 0)
        playImageFrom.setContentHuggingPriority(higherPriority, for: .horizontal)
        NSLayoutConstraint(item: playImageFrom, attribute: .height, relatedBy: .equal, toItem: playImageFrom, attribute: .width, multiplier: 1, constant: 0).isActive = true
        
        playImageTo.anchor(top: toButton.topAnchor, leading: convertToLabel.trailingAnchor, bottom: toButton.bottomAnchor, trailing: toButton.trailingAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 20, paddingRight: standardPadding, width: 0, height: 0)
        playImageTo.setContentHuggingPriority(higherPriority, for: .horizontal)
        NSLayoutConstraint(item: playImageTo, attribute: .height, relatedBy: .equal, toItem: playImageTo, attribute: .width, multiplier: 1, constant: 0).isActive = true
        
        result.anchor(top: nil, leading: stackView.leadingAnchor, bottom: nil, trailing: stackView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let standardPadding: CGFloat = 20
    let higherPriority: UILayoutPriority = UILayoutPriority(251)
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .center
        sv.spacing = 7
        return sv
    }()
    
    let amount: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 50)
        tf.placeholder = "1250"
        tf.contentHorizontalAlignment = .left
        tf.minimumFontSize = 17
        tf.textColor = .blue
        return tf
    }()
    
    let underline: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBlue
        view.tintColor = UIColor.systemBlue
        return view
    }()
    
    let fromButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let toButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let convertFromLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 50, weight: .semibold)
        label.textColor = .blue
        label.text = "Label"
        return label
    }()
    
    let convertToLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 50, weight: .semibold)
        label.textColor = .blue
        label.text = "Label"
        return label
    }()
    
    let playImageFrom: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "play.fill")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let playImageTo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "play.fill")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let result: UILabel = {
        let result = UILabel()
        result.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        result.textColor = .blue
        result.textAlignment = .center
        result.numberOfLines = 0
        result.text = "Label"
        return result
    }()
    
    
    
}

