//
//  ValueEditViewController.swift
//  RunsquitoKit
//
//  Created by jsilver on 2021/08/30.
//

import UIKit
import Runsquito
import JSToast

protocol ValueEditViewControllerDelegate: AnyObject {
    func viewController(_ viewController: ValueEditViewController, valueDidChange value: Any)
    func viewController(_ viewController: ValueEditViewController, itemDidUpdate item: AnyItem)
}

final class ValueEditViewController: UIViewController {
    typealias ValueEditSectionModel = SectionModel<SectionType, CellType>
    
    enum SectionType: Int {
        case edit
        case update
        
        var title: String {
            switch self {
            case .edit:
                return "value_edit_edit_title".localized
                
            case .update:
                return "value_edit_update_title".localized
            }
        }
    }
    
    enum CellType {
        case edit(String)
        case key(String)
        case update
    }
    
    // MARK: - View
    private let root = ValueEditView()
    
    private var tableView: UITableView { root.tableView }
    
    // MARK: - Property
    private let key: Key
    private let slot: AnySlot
    
    private var dataSource: [ValueEditSectionModel] {
        [
            .init(section: .edit, items: [.edit(text)]),
            .init(
                section: .update,
                items: [
                    .key(updateKey),
                    .update
                ]
            )
        ]
    }
    
    private var text: String = ""
    private var updateKey: String = ""
    
    weak var delegate: ValueEditViewControllerDelegate?
    
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
        setUpAction()
        setUpLayout()
        
        if let data = try? slot.encode() {
            // Set initial value
            text = String(data: data, encoding: .utf8) ?? ""
        }
    }
    
    // MARK: - Action
    @objc private func saveTap(_ sender: UIButton) {
        guard let value = decode() else { return }
        
        try? slot.setValue(value)
        delegate?.viewController(self, valueDidChange: value)
    }
    
    // MARK: - Public
    
    // MARK: - Private
    private func setUpComponent() {
        title = "\(key)"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTap(_:)))
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setUpAction() {
        
    }
    
    private func setUpLayout() {
        
    }
    
    private func decode() -> Any? {
        let text = text.replacingOccurrences(of: "[“”]", with: "\"", options: [.regularExpression], range: nil)
        guard let data = text.data(using: .utf8) else { return nil }

        do {
            return try slot.decode(from: data)
        } catch {
            showAlert(error: error)
            return nil
        }
    }
    
    private func showAlert(error: Error) {
        let viewController = UIAlertController(
            title: "error_title".localized,
            message: "\(error.localizedDescription)",
            preferredStyle: .alert
        )
        
        viewController.addAction(
            .init(
                title: "alert_confirm_title".localized,
                style: .default
            )
        )
        
        present(viewController, animated: true, completion: nil)
    }
    
    private func showToast(title: String) {
        ToastController.shared.showToast(title: title)
    }
}

extension ValueEditViewController: ValueEditTableViewCellDelegate {
    func cellDidChange(_ cell: ValueEditTableViewCell) {
        text = cell.text
    }
}

extension ValueEditViewController: ValueUpdateKeyTableViewCellDelegate {
    func cellDidChange(_ cell: ValueUpdateKeyTableViewCell) {
        updateKey = cell.text ?? ""
        
        // Update action
        tableView.reloadRows(
            at: tableView.indexPathsForVisibleRows?
                .filter {
                    let item = dataSource[$0.section].items[$0.item]
                    guard case .update = item else { return false }
                    return true
                } ?? [],
            with: .none
        )
    }
}

extension ValueEditViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataSource[indexPath.section].items[indexPath.item]
        
        switch item {
        case let .edit(text):
            let identifier = ValueEditTableViewCell.name
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ValueEditTableViewCell else {
                fatalError("Fail to dequeue header for identifier: \(identifier)")
            }
            
            cell.delegate = self
            cell.text = text
            
            return cell
            
        case let .key(key):
            let identifier = ValueUpdateKeyTableViewCell.name
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ValueUpdateKeyTableViewCell else {
                fatalError("Fail to dequeue header for identifier: \(identifier)")
            }
            
            cell.delegate = self
            cell.text = key
            
            return cell
            
        case .update:
            let identifier = ValueUpdateTableViewCell.name
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ValueUpdateTableViewCell else {
                fatalError("Fail to dequeue header for identifier: \(identifier)")
            }
            
            cell.configure(
                key: updateKey,
                exists: !slot.storage
                    .filter { key, _ in key == updateKey }
                    .isEmpty
            )
            
            return cell
        }
    }
}

extension ValueEditViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        dataSource[section].section.title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard case .update = dataSource[indexPath.section].items[indexPath.item] else { return }
        
        guard let value = decode() else { return }
        
        let exists = !slot.storage
            .filter { key, _ in key == updateKey }
            .isEmpty
        
        let item = AnyItem(ValueItem<Any>(value))
        
        try? slot.updateItem(item, forKey: updateKey)
        
        tableView.reloadData()
        
        let title = exists
        ? "value_edit_update_item_toast_title".localized
        : "value_edit_add_item_toast_title".localized
        
        ToastController.shared.showToast(title: title)
        
        delegate?.viewController(self, itemDidUpdate: item)
    }
}
