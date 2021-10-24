//
//  SlotListView.swift
//  RunsquitoKit
//
//  Created by jsilver on 2021/08/29.
//

import UIKit

final class SlotListView: UIView {
    // MARK: - View
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.enablesReturnKeyAutomatically = false
        view.returnKeyType = .done
        view.autocapitalizationType = .none
        view.autocorrectionType = .no
        view.searchBarStyle = .minimal
        view.placeholder = "search_placeholder".localized
        
        return view
    }()
    
    private let headerContainerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 60))
        return view
    }()
    
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        
        // Cell register
        view.register(SlotListTableViewCell.self, forCellReuseIdentifier: SlotListTableViewCell.name)
        view.register(SlotAllResetTableViewCell.self, forCellReuseIdentifier: SlotAllResetTableViewCell.name)
        
        return view
    }()
    
    let closeButton: UIButton = {
        let view = UIButton(type: .system)
        view.layer.cornerRadius = 14
        view.backgroundColor = view.tintColor
        view.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        view.setTitle("close_title".localized, for: .normal)
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
    
    // MARK: - Action
    
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
        
        tableView.tableHeaderView = headerContainerView
    }
    
    private func setUpAction() {
        
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
