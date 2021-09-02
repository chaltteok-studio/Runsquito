//
//  SlotDetailView.swift
//  RunsquitoKit
//
//  Created by jsilver on 2021/08/30.
//

import UIKit

final class SlotDetailView: UIView {
    // MARK: - View
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        
        // Header & Footer register
        view.register(SlotResetTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: String(describing: SlotResetTableViewHeaderFooterView.self))
        
        // Cell register
        view.register(SlotValueTableViewCell.self, forCellReuseIdentifier: String(describing: SlotValueTableViewCell.self))
        view.register(SlotDetailTableViewCell.self, forCellReuseIdentifier: String(describing: SlotDetailTableViewCell.self))
        
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
        [tableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
}
