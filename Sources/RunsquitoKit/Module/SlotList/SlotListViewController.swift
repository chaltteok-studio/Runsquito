//
//  SlotListViewController.swift
//  RunsquitoKit
//
//  Created by jsilver on 2021/08/29.
//

import UIKit
import Runsquito

protocol SlotListViewControllerDelegate: AnyObject {
    func close()
}

final class SlotListViewController: UIViewController {
    // MARK: - View
    private let root = SlotListView()
    
    private var searchBar: UISearchBar { root.searchBar }
    private var tableView: UITableView { root.tableView }
    private var closeButton: UIButton { root.closeButton }
    
    // MARK: - Property
    private let runsquito: Runsquito
    
    weak var delegate: SlotListViewControllerDelegate?
    
    private var query: String = ""
    private var items: [(Key, AnySlot)] {
        Runsquito.default.slots
            .filter { key, _ in
                let query = query.trimmingCharacters(in: .whitespaces)
                guard !query.isEmpty else { return true }
                
                return key.contains(query)
            }
            .sorted(by: \.key)
            .map { ($0, $1) }
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
    @objc private func closeTap(_ sender: UIButton) {
        delegate?.close()
    }
    
    // MARK: - Public
    
    // MARK: - Private
    private func setUpComponent() {
        title = "Runsquito"
        
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setUpLayout() {
        
    }
    
    private func setUpAction() {
        closeButton.addTarget(self, action: #selector(closeTap(_:)), for: .touchUpInside)
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
        view.endEditing(true)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let (key, slot) = items[indexPath.item]
        
        let viewController = SlotDetailViewController(key: key, slot: slot)
        viewController.delegate = self
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

extension SlotListViewController: SlotDetailViewControllerDelegate {
    func valueChanged() {
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
