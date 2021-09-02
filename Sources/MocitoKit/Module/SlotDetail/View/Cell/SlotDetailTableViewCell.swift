//
//  SlotDetailTableViewCell.swift
//  MocitoKit
//
//  Created by jsilver on 2021/08/30.
//

import UIKit
import Mocito

final class SlotDetailTableViewCell: UITableViewCell {
    // MARK: - View
    private let idTitleLabel: UILabel = {
        let view = UILabel()
        view.setContentHuggingPriority(.required, for: .horizontal)
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        view.textColor = .gray
        view.font = .systemFont(ofSize: 14)
        view.text = "ID"
        
        return view
    }()
    
    private let idLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .right
        view.font = .systemFont(ofSize: 14)
        
        return view
    }()
    
    private let idStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        
        return view
    }()
    
    private let valueTitleLabel: UILabel = {
        let view = UILabel()
        view.setContentHuggingPriority(.required, for: .horizontal)
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        view.textColor = .gray
        view.font = .systemFont(ofSize: 14)
        view.text = "Value"
        
        return view
    }()
    
    private let valueLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .right
        view.font = .systemFont(ofSize: 14)
        
        return view
    }()
    
    private let valueStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
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
        
        idLabel.text = nil
        valueLabel.text = nil
        descriptionLabel.text = nil
    }
    
    // MARK: - Public
    func configure(
        id: String,
        item: AnyItem
    ) {
        idLabel.text = id
        valueLabel.text = "\(item.value)"
        descriptionLabel.text = item.description
    }
    
    // MARK: - Private
    private func commonInit() {
        setUpLayout()
    }
    
    private func setUpLayout() {
        [idTitleLabel, idLabel].forEach { idStackView.addArrangedSubview($0) }
        
        [valueTitleLabel, valueLabel].forEach { valueStackView.addArrangedSubview($0) }
        
        [
            idStackView,
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
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24)
        ])
    }
}
