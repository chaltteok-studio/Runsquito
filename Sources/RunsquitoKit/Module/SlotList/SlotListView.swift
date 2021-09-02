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
        
        // Cell register
        view.register(SlotListTableViewCell.self, forCellReuseIdentifier: String(describing: SlotListTableViewCell.self))
        
        return view
    }()
    
    let closeButton: UIButton = {
        let view = UIButton(type: .system)
        view.layer.cornerRadius = 14
        view.backgroundColor = view.tintColor
        view.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
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
        if #available(iOS 13.0, *) {
            backgroundColor = .systemGroupedBackground
        } else {
            backgroundColor = .groupTableViewBackground
        }
    }
    
    private func setUpLayout() {
        [
            tableView,
            closeButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),
            closeButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            closeButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            closeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
