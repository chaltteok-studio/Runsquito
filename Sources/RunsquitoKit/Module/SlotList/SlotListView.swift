//
//  SlotListView.swift
//  RunsquitoKit
//
//  Created by jsilver on 2021/08/29.
//

import UIKit

final class SlotListView: UIView {
    // MARK: - Constsnt
    static let headerHeight: CGFloat = 91
    
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
    
    private let filterLabel: UILabel = {
        let view = UILabel()
        view.textColor = .gray
        view.font = .systemFont(ofSize: 16)
        view.text = "slot_list_filter_title".localized
        
        return view
    }()
    
    let filterSwitch: UISwitch = {
        let view = UISwitch()
        return view
    }()
    
    private let filterStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = 8
        
        return view
    }()
    
    private let headerBottomDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = R.Color.separator
        
        return view
    }()
    
    let headerView: UIView = {
        let view = UIView(
            frame: .init(
                x: 0,
                y: 0,
                width: 0,
                height: SlotListView.headerHeight
            )
        )
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemGroupedBackground
        } else {
            view.backgroundColor = .groupTableViewBackground
        }
        
        return view
    }()
    
    let tableView: UITableView = {
        // Set table view's initial height(over content inset's top) for initial inset rendering.
        // Code generate view with frame `.zero` conflict autolayout constraints when initial load.
        // If you set a value above 37 as the height, inset work normally. but i don't know what the number 37 mean.
        let view = UITableView(
            frame: .init(
                origin: .zero,
                size: .init(
                    width: 0,
                    height: SlotListView.headerHeight * 2
                )
            ),
            style: .grouped
        )
        view.tableHeaderView = UIView(frame: .init(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
        view.contentInset.top = SlotListView.headerHeight
        view.scrollIndicatorInsets.top = SlotListView.headerHeight
        
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
    
    var headerTopConstraint: NSLayoutConstraint?
    
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
    }
    
    private func setUpAction() {
        
    }
    
    private func setUpLayout() {
        [
            filterLabel,
            filterSwitch
        ]
            .forEach { filterStackView.addArrangedSubview($0) }
        
        [
            searchBar,
            filterStackView,
            headerBottomDividerView
        ]
            .forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
                headerView.addSubview($0)
            }
        
        let searchBarTrailingConstraint = searchBar.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16)
        searchBarTrailingConstraint.priority = .init(999)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            searchBarTrailingConstraint,
            searchBar.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            searchBar.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        let filterStackViewTrailingConstraint = filterStackView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -24)
        filterStackViewTrailingConstraint.priority = .init(999)
        
        NSLayoutConstraint.activate([
            filterStackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            filterStackViewTrailingConstraint,
            filterStackView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8),
            filterStackView.leadingAnchor.constraint(greaterThanOrEqualTo: headerView.leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            headerBottomDividerView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            headerBottomDividerView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            headerBottomDividerView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            headerBottomDividerView.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale)
        ])
        
        [
            tableView,
            headerView,
            closeButton
        ]
            .forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
                addSubview($0)
            }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        ])
        
        let headerTopConstraint = headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        self.headerTopConstraint = headerTopConstraint
        
        NSLayoutConstraint.activate([
            headerTopConstraint,
            headerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            headerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
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
