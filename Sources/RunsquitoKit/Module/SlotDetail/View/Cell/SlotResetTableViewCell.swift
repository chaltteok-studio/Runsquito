//
//  SlotResetTableViewCell.swift
//  RunsquitoKit
//
//  Created by jsilver on 2021/08/30.
//

import UIKit
import Runsquito

final class SlotResetTableViewCell: UITableViewCell {
    // MARK: - View
    private let resetLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16)
        view.text = "slot_detail_reset_title".localized
        view.textColor = view.tintColor
        
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
    }
    
    // MARK: - Public
    
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
        [resetLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            resetLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            resetLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            resetLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            resetLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24)
        ])
    }
}
