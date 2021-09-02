//
//  SlotListViewController.swift
//  MocitoKit
//
//  Created by jsilver on 2021/08/29.
//

import UIKit
import Mocito

final class SlotListViewController: UIViewController {
    // MARK: - View
    private let root = SlotListView()
    
    private var tableView: UITableView { root.tableView }
    
    // MARK: - Property
    private let mocito: Mocito
    
    private var items: [(Key, AnySlot)] {
        Mocito.default.slots
            .map { ($0, $1) }
    }
    
    // MARK: - Initializer
    init(mocito: Mocito) {
        self.mocito = mocito
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
        title = "Mocito"
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setUpLayout() {
        
    }
}

extension SlotListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: SlotListTableViewCell.self)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? SlotListTableViewCell else {
            fatalError("Fail to dequeue cell for identifier: \(identifier)")
        }
        
        let (key, slot) = items[indexPath.item]
        
        cell.configure(id: key, slot: slot)
        
        return cell
    }
}

extension SlotListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let (key, slot) = items[indexPath.item]
        
        let viewController = SlotDetailViewController(key: key, slot: slot)
        viewController.delegate = self
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension SlotListViewController: SlotDetailViewControllerDelegate {
    func valueChanged() {
        tableView.reloadData()
    }
}
