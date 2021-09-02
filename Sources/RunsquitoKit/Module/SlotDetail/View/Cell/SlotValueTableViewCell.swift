//
//  SlotValueTableViewCell.swift
//  RunsquitoKit
//
//  Created by jsilver on 2021/08/30.
//

import UIKit
import Runsquito

final class SlotValueTableViewCell: UITableViewCell {
    // MARK: - View
    private let valueTitleLabel: UILabel = {
        let view = UILabel()
        view.setContentHuggingPriority(.required, for: .horizontal)
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        view.textColor = .gray
        view.font = .systemFont(ofSize: 14)
        view.text = "Current Value"
        
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
        
        valueLabel.text = nil
    }
    
    // MARK: - Public
    func configure(value: Any?) {
        valueLabel.text = "\(value ?? "nil")"
    }
    
    // MARK: - Private
    private func commonInit() {
        setUpLayout()
    }
    
    private func setUpLayout() {
        [valueTitleLabel, valueLabel].forEach { valueStackView.addArrangedSubview($0) }
        
        [
            valueStackView
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
