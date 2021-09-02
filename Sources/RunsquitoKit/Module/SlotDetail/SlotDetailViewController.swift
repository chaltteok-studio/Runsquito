//
//  SlotDetailViewController.swift
//  RunsquitoKit
//
//  Created by jsilver on 2021/08/30.
//

import UIKit
import Runsquito

protocol SlotDetailViewControllerDelegate: AnyObject {
    func valueChanged()
}

final class SlotDetailViewController: UIViewController {
    enum CellModel {
        case value
        case item(Key, AnyItem)
    }
    
    // MARK: - View
    private let root = SlotDetailView()
    
    private var tableView: UITableView { root.tableView }
    
    // MARK: - Property
    private let key: Key
    private let slot: AnySlot
    
    private var items: [CellModel] {
        [.value] + slot.storage.map { .item($0, $1) }
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
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setUpLayout() {
        
    }
}

extension SlotDetailViewController: SlotResetTableViewHeaderFooterViewDelegate {
    func reset() {
        try? slot.set(nil)
        
        tableView.reloadData()
    }
}

extension SlotDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.item]
        
        switch item {
        case .value:
            let identifier = String(describing: SlotValueTableViewCell.self)
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? SlotValueTableViewCell else {
                fatalError("Fail to dequeue cell for identifier: \(identifier)")
            }
            
            cell.configure(value: slot.value)
            
            return cell
            
        case let .item(key, item):
            let identifier = String(describing: SlotDetailTableViewCell.self)
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? SlotDetailTableViewCell else {
                fatalError("Fail to dequeue cell for identifier: \(identifier)")
            }
            
            cell.configure(id: key, item: item)
            
            return cell
        }
    }
}

extension SlotDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let identifier = String(describing: SlotResetTableViewHeaderFooterView.self)
        
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? SlotResetTableViewHeaderFooterView else {
            fatalError("Fail to dequeue header for identifier: \(identifier)")
        }
        
        view.delegate = self
        
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = items[indexPath.item]
        
        switch item {
        case .value:
            let viewController = ValueEditViewController(key: key, slot: slot)
            viewController.delegate = self
            
            navigationController?.pushViewController(viewController, animated: true)
            
        case let .item(_, item):
            try? slot.set(item.value)
            tableView.reloadData()
            
            delegate?.valueChanged()
        }
    }
}

extension SlotDetailViewController: ValueEditViewControllerDelegate {
    func edited() {
        tableView.reloadData()
        
        delegate?.valueChanged()
        navigationController?.popViewController(animated: true)
    }
}
