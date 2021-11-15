//
//  SlotListViewController.swift
//  RunsquitoKit
//
//  Created by jsilver on 2021/08/29.
//

import UIKit
import Runsquito

protocol SlotListViewControllerDelegate: AnyObject {
    func viewControllerCloseButtonClicked(_ viewController: SlotListViewController)
}

final class SlotListViewController: UIViewController {
    typealias SlotListSectionModel = SectionModel<SectionType, CellType>
    
    enum SectionType {
        case slot
        case action
    }
    
    enum CellType {
        case slot((Key, AnySlot))
        case reset
    }
    
    // MARK: - View
    private let root = SlotListView()
    
    private var headerView: UIView { root.headerView }
    private var searchBar: UISearchBar { root.searchBar }
    private var filterSwitch: UISwitch { root.filterSwitch }
    
    private var tableView: UITableView { root.tableView }
    
    private var closeButton: UIButton { root.closeButton }
    
    private var headerTopConstraint: NSLayoutConstraint? { root.headerTopConstraint }
    
    // MARK: - Property
    private let runsquito: Runsquito
    
    weak var delegate: SlotListViewControllerDelegate?
    
    private var query: String = ""
    private var isFiltered: Bool = false
    private var dataSource: [SlotListSectionModel] {
        [
            SlotListSectionModel(
                section: .slot,
                items: runsquito.slots
                    .filter { _, value in
                        guard isFiltered else { return true }
                        return value.value != nil
                    }
                    .filter { key, _ in
                        let query = query.trimmingCharacters(in: .whitespaces)
                        guard !query.isEmpty else { return true }
                        
                        return key.contains(query)
                    }
                    .sorted(by: \.key)
                    .map { .slot(($0, $1)) }
            ),
            SlotListSectionModel(section: .action, items: [.reset])
        ]
    }
    
    // MARK: - Initializer
    init(runsquito: Runsquito) {
        self.runsquito = runsquito
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        view = root
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpComponent()
        setUpLayout()
        setUpAction()
    }
    
    // MARK: - Action
    @objc private func filterChange(_ sender: UISwitch) {
        isFiltered = sender.isOn
        tableView.reloadData()
    }
    
    @objc private func closeTap(_ sender: UIButton) {
        delegate?.viewControllerCloseButtonClicked(self)
    }
    
    // MARK: - Public
    
    // MARK: - Private
    private func setUpComponent() {
        title = "title".localized
        
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setUpLayout() {
        
    }
    
    private func setUpAction() {
        filterSwitch.addTarget(self, action: #selector(filterChange(_:)), for: .valueChanged)
        closeButton.addTarget(self, action: #selector(closeTap(_:)), for: .touchUpInside)
    }
}

extension SlotListViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource[section].items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataSource[indexPath.section].items[indexPath.item]
        
        switch item {
        case let .slot((key, slot)):
            let identifier = SlotListTableViewCell.name
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? SlotListTableViewCell else {
                fatalError("Fail to dequeue cell for identifier: \(identifier)")
            }
            
            cell.configure(key: key, slot: slot)
            
            return cell
            
        case .reset:
            let identifier = SlotAllResetTableViewCell.name
            
            return tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }
}

extension SlotListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = dataSource[indexPath.section].items[indexPath.item]
        
        switch item {
        case let .slot((key, slot)):
            let viewController = SlotDetailViewController(key: key, slot: slot)
            viewController.delegate = self
            
            navigationController?.pushViewController(viewController, animated: true)
            
        case .reset:
            runsquito.slots.values
                .forEach { try? $0.setValue(nil) }
            
            tableView.reloadData()
            
            ToastController.shared.showToast(title: "slot_list_reset_all_toast_title".localized)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
        
        headerTopConstraint?.constant = max(-44, -(scrollView.contentInset.top + scrollView.contentOffset.y))
        
        view.layoutIfNeeded()
    }
}

extension SlotListViewController: SlotDetailViewControllerDelegate {
    func viewControllerDidChange(_ viewController: SlotDetailViewController) {
        tableView.reloadData()
    }
}

extension SlotListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        query = searchText
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
