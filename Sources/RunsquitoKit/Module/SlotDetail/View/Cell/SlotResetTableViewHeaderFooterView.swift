//
//  SlotResetTableViewHeaderFooterView.swift
//  RunsquitoKit
//
//  Created by jsilver on 2021/08/30.
//

import UIKit
import Runsquito

protocol SlotResetTableViewHeaderFooterViewDelegate: AnyObject {
    func reset()
}

final class SlotResetTableViewHeaderFooterView: UITableViewHeaderFooterView {
    // MARK: - View
    private let resetButton: UIButton = {
        let view = UIButton(type: .system)
        view.layer.cornerRadius = 4
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.setTitle("Reset", for: .normal)
        view.setTitleColor(.gray, for: .normal)
        
        return view
    }()
    
    // MARK: - Property
    weak var delegate: SlotResetTableViewHeaderFooterViewDelegate?
    
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
    
    // MARK: - Public
    
    // MARK: - Private
    private func commonInit() {
        setUpLayout()
        setUpAction()
    }
    
    private func setUpLayout() {
        [resetButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        let topAnchor = resetButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32)
        topAnchor.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            topAnchor,
            resetButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            resetButton.widthAnchor.constraint(equalToConstant: 100),
            resetButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    private func setUpAction() {
        resetButton.addTarget(self, action: #selector(resetTap(_:)), for: .touchUpInside)
    }
    
    @objc private func resetTap(_ sender: UIButton) {
        delegate?.reset()
    }
}
