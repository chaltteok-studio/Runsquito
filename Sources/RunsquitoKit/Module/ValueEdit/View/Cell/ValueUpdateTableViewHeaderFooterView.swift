//
//  ValueUpdateTableViewHeaderFooterView.swift
//  Runsquito
//
//  Created by jsilver on 2021/09/26.
//

import UIKit
import Runsquito

protocol ValueUpdateTableViewHeaderFooterViewDelegate: AnyObject {
    func headerFooterViewTappedUpdate(_ view: ValueUpdateTableViewHeaderFooterView)
}

final class ValueUpdateTableViewHeaderFooterView: UITableViewHeaderFooterView {
    // MARK: - View
    private let updateButton: UIButton = {
        let view = UIButton(type: .system)
        view.layer.cornerRadius = 4
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.setTitleColor(.gray, for: .normal)
        
        return view
    }()
    
    // MARK: - Property
    weak var delegate: ValueUpdateTableViewHeaderFooterViewDelegate?
    
    // MARK: - Initializer
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Action
    @objc private func updateTap(_ sender: UIButton) {
        delegate?.headerFooterViewTappedUpdate(self)
    }
    
    // MARK: - Public
    func configure(key: String, exists: Bool) {
        updateButton.isEnabled = !key.isEmpty
        updateButton.setTitle(exists ? "update_title".localized : "add_title".localized, for: .normal)
    }
    
    // MARK: - Private
    private func commonInit() {
        setUpComponent()
        setUpAction()
        setUpLayout()
    }
    
    private func setUpComponent() {
        
    }
    
    private func setUpAction() {
        updateButton.addTarget(self, action: #selector(updateTap(_:)), for: .touchUpInside)
    }
    
    private func setUpLayout() {
        [updateButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        let topAnchor = updateButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32)
        topAnchor.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            topAnchor,
            updateButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            updateButton.widthAnchor.constraint(equalToConstant: 100),
            updateButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
