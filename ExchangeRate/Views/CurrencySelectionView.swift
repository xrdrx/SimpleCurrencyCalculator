//
//  SearchTableView.swift
//  ExchangeRate
//
//  Created by Aleksandr Svetilov on 10.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import Foundation
import UIKit

class CurrencySelectionView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textField)
        addSubview(tableView)
        
        textField.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: tableView.topAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        tableView.anchor(top: textField.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let textField: UITextField = {
        let field = UITextField()
        field.font = UIFont.systemFont(ofSize: 20)
        field.autocapitalizationType = .allCharacters
        field.textAlignment = .left
        field.borderStyle = .none
        field.placeholder = "Filter..."
        field.backgroundColor = .white
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: field.frame.height))
        field.leftViewMode = UITextField.ViewMode.always
        return field
    }()
    
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        return table
    }()
    
}
