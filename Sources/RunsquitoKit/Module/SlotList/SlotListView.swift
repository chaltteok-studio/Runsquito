//
//  SlotListView.swift
//  RunsquitoKit
//
//  Created by jsilver on 2021/08/29.
//

import UIKit

final class SlotListView: UIView {
    // MARK: - View
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        
        view.contentInset.bottom = 64
        
        // Cell register
        view.register(SlotListTableViewCell.self, forCellReuseIdentifier: String(describing: SlotListTableViewCell.self))
        
        return view
    }()
    
    let closeButton: UIButton = {
        let view = UIButton(type: .system)
        view.layer.cornerRadius = 4
        view.backgroundColor = view.tintColor
        view.titleLabel?.font = .systemFont(ofSize: 16)
        view.setTitle("Close", for: .normal)
        view.setTitleColor(.white, for: .normal)
        
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
    
    // MARK: - Public
    
    // MARK: - Private
    private func commonInit() {
        setUpComponent()
        setUpLayout()
    }
    
    private func setUpComponent() {
        backgroundColor = .white
    }
    
    private func setUpLayout() {
        [tableView, closeButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            closeButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            closeButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            closeButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
