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
    private let valueLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16)
        view.numberOfLines = 3
        
        return view
    }()
    
    private let arrowButton: UIButton = {
        let view = UIButton()
        view.setContentHuggingPriority(.required, for: .horizontal)
        view.setImage(R.Icon.arrowRight, for: .normal)
        
        return view
    }()
    
    private let valueStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        
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
    func configure(value: Any?, isEditable: Bool) {
        valueLabel.text = "\(value ?? "nil")"

        isUserInteractionEnabled = isEditable
        arrowButton.isHidden = !isEditable
    }
    
    // MARK: - Private
    private func commonInit() {
        setUpLayout()
    }
    
    private func setUpLayout() {
        [
            valueLabel,
            arrowButton
        ].forEach {
            valueStackView.addArrangedSubview($0)
        }
        
        [valueStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            valueStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.5),
            valueStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            valueStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12.5),
            valueStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24)
        ])
    }
}
