//
//  SlotDetailTableViewCell.swift
//  RunsquitoKit
//
//  Created by jsilver on 2021/08/30.
//

import UIKit
import Runsquito

final class SlotDetailTableViewCell: UITableViewCell {
    // MARK: - View
    private let keyTitleLabel: UILabel = {
        let view = UILabel()
        view.setContentHuggingPriority(.required, for: .horizontal)
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        view.font = .systemFont(ofSize: 16)
        view.text = "slot_detail_key_title".localized
        
        return view
    }()
    
    private let keyLabel: UILabel = {
        let view = UILabel()
        view.lineBreakMode = .byTruncatingHead
        view.textAlignment = .right
        view.textColor = .gray
        view.font = .systemFont(ofSize: 16)
        
        return view
    }()
    
    private let keyStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 16
        
        return view
    }()
    
    private let valueTitleLabel: UILabel = {
        let view = UILabel()
        view.setContentHuggingPriority(.required, for: .horizontal)
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        view.font = .systemFont(ofSize: 16)
        view.text = "slot_detail_value_title".localized
        
        return view
    }()
    
    private let valueLabel: UILabel = {
        let view = UILabel()
        view.lineBreakMode = .byTruncatingHead
        view.textAlignment = .right
        view.textColor = .gray
        view.font = .systemFont(ofSize: 16)
        
        return view
    }()
    
    private let valueStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 16
        
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textColor = .gray
        view.font = .systemFont(ofSize: 16)
        
        return view
    }()
    
    private let contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 6
        
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
        descriptionLabel.text = nil
        
        descriptionLabel.isHidden = true
    }
    
    // MARK: - Public
    func configure(value: (key: String, item: AnyItem)) {
        keyLabel.text = value.key
        valueLabel.text = "\(value.item.value)"
        descriptionLabel.text = value.item.description
        
        descriptionLabel.isHidden = value.item.description == nil
    }
    
    // MARK: - Private
    private func commonInit() {
        setUpLayout()
    }
    
    private func setUpLayout() {
        [keyTitleLabel, keyLabel].forEach { keyStackView.addArrangedSubview($0) }
        
        [valueTitleLabel, valueLabel].forEach { valueStackView.addArrangedSubview($0) }
        
        [
            keyStackView,
            valueStackView,
            descriptionLabel
        ].forEach {
            contentStackView.addArrangedSubview($0)
        }
        
        [contentStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.5),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12.5),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24)
        ])
    }
}
