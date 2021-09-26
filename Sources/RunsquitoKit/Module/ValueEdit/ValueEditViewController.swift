//
//  ValueEditViewController.swift
//  RunsquitoKit
//
//  Created by jsilver on 2021/08/30.
//

import UIKit
import Runsquito

protocol ValueEditViewControllerDelegate: AnyObject {
    func viewControllerDidChange(_ viewController: ValueEditViewController)
}

final class ValueEditViewController: UIViewController {
    typealias ValueEditSectionModel = SectionModel<SectionType, CellType>
    
    enum SectionType: Int {
        case edit = 0
        case update
        
        var title: String {
            switch self {
            case .edit:
                return "edit_title".localized
                
            case .update:
                return "update_title".localized
            }
        }
    }
    
    enum CellType {
        case edit(String)
        case key(String)
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
            .init(section: .update, items: [.key(updateKey)])
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
        delegate?.viewControllerDidChange(self)
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
}

extension ValueEditViewController: ValueEditTableViewCellDelegate {
    func cellDidChange(_ cell: ValueEditTableViewCell) {
        text = cell.text
    }
}

extension ValueEditViewController: ValueUpdateKeyTableViewCellDelegate {
    func cellDidChange(_ cell: ValueUpdateKeyTableViewCell) {
        updateKey = cell.text ?? ""
        
        // Update footer view
        guard let view = tableView.footerView(forSection: SectionType.update.rawValue) as? ValueUpdateTableViewHeaderFooterView else { return }
        
        view.configure(
            key: updateKey,
            exists: !slot.storage
                .filter { key, _ in key == updateKey }
                .isEmpty
        )
    }
}

extension ValueEditViewController: ValueUpdateTableViewHeaderFooterViewDelegate {
    func headerFooterViewTappedUpdate(_ view: ValueUpdateTableViewHeaderFooterView) {
        guard let value = decode() else { return }
        
        try? slot.updateItem(ValueItem<Any>(value), forKey: updateKey)
        delegate?.viewControllerDidChange(self)
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
            
        case let .key(id):
            let identifier = ValueUpdateKeyTableViewCell.name
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ValueUpdateKeyTableViewCell else {
                fatalError("Fail to dequeue header for identifier: \(identifier)")
            }
            
            cell.delegate = self
            cell.text = id
            
            return cell
        }
    }
}

extension ValueEditViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        dataSource[section].section.title
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard SectionType(rawValue: section) == .update else { return nil }
        
        let identifier = ValueUpdateTableViewHeaderFooterView.name
        
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? ValueUpdateTableViewHeaderFooterView else {
            fatalError("Fail to dequeue header for identifier: \(identifier)")
        }
        
        view.configure(
            key: updateKey,
            exists: !slot.storage
                .filter { key, _ in key == updateKey }
                .isEmpty
        )
        view.delegate = self
        
        return view
    }
}
