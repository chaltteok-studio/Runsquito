//
//  SlotDetailView.swift
//  RunsquitoKit
//
//  Created by jsilver on 2021/08/30.
//

import UIKit

final class SlotDetailView: UIView {
    // MARK: - View
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.enablesReturnKeyAutomatically = false
        view.returnKeyType = .done
        view.autocapitalizationType = .none
        view.autocorrectionType = .no
        view.searchBarStyle = .minimal
        
        return view
    }()
    
    private let headerContainerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 36))
        return view
    }()
    
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
        if #available(iOS 13.0, *) {
            backgroundColor = .systemGroupedBackground
        } else {
            backgroundColor = .groupTableViewBackground
        }
        
        tableView.tableHeaderView = headerContainerView
    }
    
    private func setUpLayout() {
        [searchBar].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            headerContainerView.addSubview($0)
        }
        
        let searchBarTrailingConstraint = searchBar.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor, constant: -16)
        searchBarTrailingConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: headerContainerView.topAnchor, constant: 8),
            searchBarTrailingConstraint,
            searchBar.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor, constant: 16),
            searchBar.heightAnchor.constraint(equalToConstant: 36)
        ])
        
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
