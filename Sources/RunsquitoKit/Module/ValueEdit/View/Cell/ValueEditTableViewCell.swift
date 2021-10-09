//
//  ValueEditTableViewCell.swift
//  RunsquitoKit
//
//  Created by jsilver on 2021/09/26.
//

import UIKit
import Runsquito

protocol ValueEditTableViewCellDelegate: AnyObject {
    func cellDidChange(_ cell: ValueEditTableViewCell)
}

final class ValueEditTableViewCell: UITableViewCell {
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
    
    private let textView: UITextView = {
        let view = UITextView()
        view.autocapitalizationType = .none
        view.autocorrectionType = .no
        view.backgroundColor = .clear
        view.font = .systemFont(ofSize: 16)
        
        return view
    }()
    
    // MARK: - Property
    var text: String {
        get {
            textView.text
        }
        set {
            textView.text = newValue
        }
    }
    
    weak var delegate: ValueEditTableViewCellDelegate?
    
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
        
        textView.text = nil
    }
    
    // MARK: - Action
    @objc private func doneButtonTap(_ sender: UIBarButtonItem) {
        textView.endEditing(true)
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
        
        textView.inputAccessoryView = keyboardAccessoryView
        textView.delegate = self
    }
    
    private func setUpAction() {
        
    }
    
    private func setUpLayout() {
        [textView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        let textViewHeightConstraint = textView.heightAnchor.constraint(equalToConstant: 300)
        textViewHeightConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.5),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12.5),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            textViewHeightConstraint
        ])
    }
}

extension ValueEditTableViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        delegate?.cellDidChange(self)
    }
}
