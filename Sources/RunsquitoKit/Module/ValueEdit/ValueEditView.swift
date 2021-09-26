//
//  ValueEditView.swift
//  RunsquitoKit
//
//  Created by jsilver on 2021/08/30.
//

import UIKit

final class ValueEditView: UIView {
    // MARK: - View
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        
        // Cell register
        view.register(ValueUpdateTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: ValueUpdateTableViewHeaderFooterView.name)
        
        view.register(ValueEditTableViewCell.self, forCellReuseIdentifier: ValueEditTableViewCell.name)
        view.register(ValueUpdateKeyTableViewCell.self, forCellReuseIdentifier: ValueUpdateKeyTableViewCell.name)
        
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
    @objc private func keyboardWillShow(_ sender: NSNotification) {
        let keyboardFrameKey = UIResponder.keyboardFrameEndUserInfoKey
        
        guard let userInfo = sender.userInfo,
              let keyboardRect = (userInfo[keyboardFrameKey] as? NSValue)?.cgRectValue else { return }
        
        let targetRect = convert(bounds, to: window)
        let rect = targetRect.intersection(keyboardRect)
        
        tableView.contentInset.bottom = rect.height
    }
    
    @objc private func keyboardHideShow(_ sender: NSNotification) {
        tableView.contentInset.bottom = .zero
    }
    
    // MARK: - Public
    
    // MARK: - Private
    private func commonInit() {
        setUpComponent()
        setUpAction()
        setUpLayout()
    }
    
    private func setUpComponent() {
        if #available(iOS 13.0, *) {
            backgroundColor = .systemGroupedBackground
        } else {
            backgroundColor = .groupTableViewBackground
        }
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
    
    private func setUpLayout() {
        [tableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        ])
    }
}
