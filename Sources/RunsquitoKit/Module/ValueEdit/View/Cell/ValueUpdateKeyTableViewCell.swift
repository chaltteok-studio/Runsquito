//
//  ValueUpdateKeyTableViewCell.swift
//  RunsquitoKit
//
//  Created by jsilver on 2021/09/26.
//

import UIKit
import Runsquito

protocol ValueUpdateKeyTableViewCellDelegate: AnyObject {
    func cellDidChange(_ cell: ValueUpdateKeyTableViewCell)
}

final class ValueUpdateKeyTableViewCell: UITableViewCell {
    // MARK: - View
    private let keyboardAccessoryView: UIToolbar = {
        let view = UIToolbar()
        view.sizeToFit()
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTap(_:)))
        
        view.items = [spacer, doneButton]

        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.setContentHuggingPriority(.required, for: .horizontal)
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        view.font = .systemFont(ofSize: 14)
        view.text = "ID"
        
        return view
    }()
    
    private let textField: UITextField = {
        let view = UITextField()
        view.autocapitalizationType = .none
        view.autocorrectionType = .no
        view.backgroundColor = .clear
        view.font = .systemFont(ofSize: 14)
        view.textAlignment = .right
        view.placeholder = "key_placeholder".localized
        
        return view
    }()
    
    private let contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        
        return view
    }()
    
    // MARK: - Property
    var text: String? {
        get {
            textField.text
        }
        set {
            textField.text = newValue
        }
    }
    
    weak var delegate: ValueUpdateKeyTableViewCellDelegate?
    
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
        
        textField.text = nil
    }
    
    // MARK: - Action
    @objc private func textFieldDidChange(_ sender: UITextField) {
        delegate?.cellDidChange(self)
    }
    
    @objc private func doneButtonTap(_ sender: UIBarButtonItem) {
        textField.endEditing(true)
    }
    
    // MARK: - Public
    
    // MARK: - Private
    private func commonInit() {
        setUpComponent()
        setUpAction()
        setUpLayout()
    }
    
    private func setUpComponent() {
        selectionStyle = .none
        
        textField.inputAccessoryView = keyboardAccessoryView
    }
    
    private func setUpAction() {
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func setUpLayout() {
        [titleLabel, textField].forEach { contentStackView.addArrangedSubview($0) }
        
        
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
