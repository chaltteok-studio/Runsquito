//
//  ValueEditView.swift
//  RunsquitoKit
//
//  Created by jsilver on 2021/08/30.
//

import UIKit

final class ValueEditView: UIView {
    // MARK: - View
    private let keyboardAccessoryView: UIToolbar = {
        let view = UIToolbar()
        view.sizeToFit()
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTap(_:)))
        
        view.items = [spacer, doneButton]

        return view
    }()
    
    let textView: UITextView = {
        let view = UITextView()
        view.autocapitalizationType = .none
        view.autocorrectionType = .no
        view.backgroundColor = .clear
        view.font = .systemFont(ofSize: 14)
        
        return view
    }()
    
    let saveButton: UIButton = {
        let view = UIButton(type: .system)
        view.layer.cornerRadius = 4
        view.backgroundColor = view.tintColor
        view.titleLabel?.font = .systemFont(ofSize: 16)
        view.setTitle("Save", for: .normal)
        view.setTitleColor(.white, for: .normal)
        
        return view
    }()
    
    private let contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        
        return view
    }()
    
    // MARK: - Property
    private var contentStackViewBottomConstraint: NSLayoutConstraint?
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Lifecycle
    
    // MARK: - Action
    @objc private func doneButtonTap(_ sender: UIBarButtonItem) {
        textView.endEditing(true)
    }
    
    @objc private func keyboardWillShow(_ sender: NSNotification) {
        let keyboardFrameKey = UIResponder.keyboardFrameEndUserInfoKey
        
        guard let userInfo = sender.userInfo,
              let keyboardRect = (userInfo[keyboardFrameKey] as? NSValue)?.cgRectValue else { return }
        
        let targetRect = convert(bounds, to: window)
        let intersectRect = targetRect.intersection(keyboardRect)
        
        contentStackViewBottomConstraint?.constant = -(intersectRect.height - safeAreaInsets.bottom + 8)
        layoutIfNeeded()
    }
    
    @objc private func keyboardHideShow(_ sender: NSNotification) {
        contentStackViewBottomConstraint?.constant = -8
        layoutIfNeeded()
    }
    
    // MARK: - Public
    
    // MARK: - Private
    private func commonInit() {
        setUpComponent()
        setUpLayout()
        setUpAction()
    }
    
    private func setUpComponent() {
        if #available(iOS 13.0, *) {
            backgroundColor = .systemGroupedBackground
        } else {
            backgroundColor = .init(red: 0.95, green: 0.95, blue: 0.97, alpha: 1)
        }
        
        textView.inputAccessoryView = keyboardAccessoryView
    }
    
    private func setUpLayout() {
        [
            textView,
            saveButton
        ].forEach { contentStackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            saveButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        [contentStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        let contentStackViewBottomConstraint = contentStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            contentStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            contentStackViewBottomConstraint,
            contentStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
        
        self.contentStackViewBottomConstraint = contentStackViewBottomConstraint
    }
    
    private func setUpAction() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardHideShow(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        
    }
}
