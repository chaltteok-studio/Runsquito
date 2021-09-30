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
        
        let doneButton = UIBarButtonItem(
            title: "done_title".localized,
            style: .done,
            target: self,
            action: #selector(doneButtonTap(_:))
        )
        
        view.items = [spacer, doneButton]

        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.setContentHuggingPriority(.required, for: .horizontal)
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        view.font = .systemFont(ofSize: 16)
        view.text = "value_edit_key_title".localized
        
        return view
    }()
    
    let textField: UITextField = {
        let view = UITextField()
        view.autocapitalizationType = .none
        view.autocorrectionType = .no
        view.backgroundColor = .clear
        view.font = .systemFont(ofSize: 16)
        view.textAlignment = .right
        view.placeholder = "value_edit_key_placeholder".localized
        
        return view
    }()
    
    private let contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 16
        
        return view
    }()
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height = max(size.height, 38)
        
        return size
    }
    
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
            contentStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24)
        ])
    }
}
