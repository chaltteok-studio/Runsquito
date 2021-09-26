//
//  SlotListTableViewCell.swift
//  RunsquitoKit
//
//  Created by jsilver on 2021/08/30.
//

import UIKit
import Runsquito

final class SlotListTableViewCell: UITableViewCell {
    // MARK: - View
    private let keyTitleLabel: UILabel = {
        let view = UILabel()
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.font = .systemFont(ofSize: 14)
        view.text = "key_title".localized
        
        return view
    }()
    
    private let keyLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .right
        view.textColor = .gray
        view.font = .systemFont(ofSize: 14)
        
        return view
    }()
    
    private let keyStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        
        return view
    }()
    
    private let valueTitleLabel: UILabel = {
        let view = UILabel()
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.font = .systemFont(ofSize: 14)
        view.text = "value_title".localized
        
        return view
    }()
    
    private let valueLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .right
        view.textColor = .gray
        view.font = .systemFont(ofSize: 14)
        
        return view
    }()
    
    private let valueStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        
        return view
    }()
    
    private let storageTitleLabel: UILabel = {
        let view = UILabel()
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.font = .systemFont(ofSize: 14)
        view.text = "storage_title".localized
        
        return view
    }()
    
    private let storageLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .right
        view.textColor = .gray
        view.font = .systemFont(ofSize: 14)
        
        return view
    }()
    
    private let storageStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textColor = .gray
        view.font = .systemFont(ofSize: 14)
        
        return view
    }()
    
    private let contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 4
        
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
        
        keyLabel.text = nil
        valueLabel.text = nil
        storageLabel.text = nil
        descriptionLabel.text = nil
        
        descriptionLabel.isHidden = true
    }
    
    // MARK: - Public
    func configure(
        id: String,
        slot: AnySlot
    ) {
        keyLabel.text = id
        valueLabel.text = "\(slot.value ?? "nil") (\(String(describing: slot.type)))"
        storageLabel.text = "\(slot.storage.count)"
        descriptionLabel.text = slot.description
        
        descriptionLabel.isHidden = slot.description == nil
    }
    
    // MARK: - Private
    private func commonInit() {
        setUpLayout()
    }
    
    private func setUpLayout() {
        [keyTitleLabel, keyLabel].forEach { keyStackView.addArrangedSubview($0) }
        
        [valueTitleLabel, valueLabel].forEach { valueStackView.addArrangedSubview($0) }
        
        [storageTitleLabel, storageLabel].forEach { storageStackView.addArrangedSubview($0) }
        
        [
            keyStackView,
            valueStackView,
            storageStackView,
            descriptionLabel
        ].forEach {
            contentStackView.addArrangedSubview($0)
        }
        
        [contentStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24)
        ])
    }
}
