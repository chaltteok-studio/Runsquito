//
//  ValueUpdate.swift
//  
//
//  Created by jsilver on 2021/09/30.
//

import UIKit
import Runsquito

final class ValueUpdateTableViewCell: UITableViewCell {
    // MARK: - View
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16)
        
        return view
    }()
    
    // MARK: - Property
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = ""
    }
    
    // MARK: - Action
    
    // MARK: - Public
    func configure(key: Key, exists: Bool) {
        isUserInteractionEnabled = !key.isEmpty
        titleLabel.textColor = key.isEmpty ? .gray : titleLabel.tintColor
        titleLabel.text = exists ? "value_edit_update_item_title".localized : "value_edit_add_item_title".localized
    }
    
    // MARK: - Private
    private func commonInit() {
        setUpComponent()
        setUpAction()
        setUpLayout()
    }
    
    private func setUpComponent() {
        
    }
    
    private func setUpAction() {
        
    }
    
    private func setUpLayout() {
        [titleLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24)
        ])
    }
}
