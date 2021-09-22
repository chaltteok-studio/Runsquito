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
    
    // MARK: - Property
    
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
        let _ = targetRect.intersection(keyboardRect)
        
        // TODO:
    }
    
    @objc private func keyboardHideShow(_ sender: NSNotification) {
        // TODO:
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
            backgroundColor = .groupTableViewBackground
        }
        
        textView.inputAccessoryView = keyboardAccessoryView
    }
    
    private func setUpLayout() {
        [textView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),
            textView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            textView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24)
        ])
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
