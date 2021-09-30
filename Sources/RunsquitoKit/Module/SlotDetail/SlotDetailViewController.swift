//
//  SlotDetailViewController.swift
//  RunsquitoKit
//
//  Created by jsilver on 2021/08/30.
//

import UIKit
import Runsquito

protocol SlotDetailViewControllerDelegate: AnyObject {
    func viewControllerDidChange(_ viewController: SlotDetailViewController)
}

final class SlotDetailViewController: UIViewController {
    typealias SlotDetailSectionModel = SectionModel<SectionType, CellType>
    
    enum SectionType {
        case value
        case item
        case action
        
        var title: String? {
            switch self {
            case .value:
                return "slot_detail_current_value_title".localized
                
            case .item:
                return "slot_detail_storage_title".localized
                
            case .action:
                return nil
            }
        }
    }
    
    enum CellType {
        case value
        case item((Key, AnyItem))
        case reset
    }
    
    // MARK: - View
    private let root = SlotDetailView()
    
    private var searchBar: UISearchBar { root.searchBar }
    private var tableView: UITableView { root.tableView }
    
    // MARK: - Property
    private let key: Key
    private let slot: AnySlot
    
    private var query: String = ""
    private var items: [SlotDetailSectionModel] {
        [
            SlotDetailSectionModel(
                section: .value,
                items: [.value]
            ),
            SlotDetailSectionModel(
                section: .item,
                items: slot.storage
                    .filter { key, _ in
                        let query = query.trimmingCharacters(in: .whitespaces)
                        guard !query.isEmpty else { return true }
                        
                        return key.contains(query)
                    }
                    .sorted(by: \.key)
                    .map { .item($0) }
            ),
            SlotDetailSectionModel(
                section: .action,
                items: [.reset]
            )
        ]
            .filter { !$0.items.isEmpty }
    }
    
    weak var delegate: SlotDetailViewControllerDelegate?
    
    // MARK: - Initializer
    init(key: Key, slot: AnySlot) {
        self.key = key
        self.slot = slot
        
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
    }
    
    // MARK: - Public
    
    // MARK: - Private
    private func setUpComponent() {
        title = key
        
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setUpLayout() {
        
    }
}

extension SlotDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section].items[indexPath.item]
        
        switch item {
        case .value:
            let identifier = SlotValueTableViewCell.name
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? SlotValueTableViewCell else {
                fatalError("Fail to dequeue cell for identifier: \(identifier)")
            }
            
            cell.configure(value: slot.value, isEditable: slot.isEditable)
            
            return cell
            
        case let .item(value):
            let identifier = SlotDetailTableViewCell.name
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? SlotDetailTableViewCell else {
                fatalError("Fail to dequeue cell for identifier: \(identifier)")
            }
            
            cell.configure(value: value)
            
            return cell
            
        case .reset:
            let identifier = SlotResetTableViewCell.name
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? SlotResetTableViewCell else {
                fatalError("Fail to dequeue cell for identifier: \(identifier)")
            }
            
            return cell
        }
    }
}

extension SlotDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        items[section].section.title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = items[indexPath.section].items[indexPath.item]
        
        switch item {
        case .value:
            view.endEditing(true)
            
            let viewController = ValueEditViewController(key: key, slot: slot)
            viewController.delegate = self
            
            navigationController?.pushViewController(viewController, animated: true)
            
        case let .item(value):
            let (_, item) = value
            try? slot.setValue(item.value)
            tableView.reloadData()
            
            delegate?.viewControllerDidChange(self)
            
        case .reset:
            try? slot.setValue(nil)
            
            tableView.reloadData()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

extension SlotDetailViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        query = searchText
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

extension SlotDetailViewController: ValueEditViewControllerDelegate {
    func viewControllerDidChange(_ viewController: ValueEditViewController) {
        tableView.reloadData()
        
        delegate?.viewControllerDidChange(self)
        navigationController?.popViewController(animated: true)
    }
}
