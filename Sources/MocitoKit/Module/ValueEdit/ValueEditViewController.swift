//
//  ValueEditViewController.swift
//  MocitoKit
//
//  Created by jsilver on 2021/08/30.
//

import UIKit
import Mocito

protocol ValueEditViewControllerDelegate: AnyObject {
    func edited()
}

final class ValueEditViewController: UIViewController {
    // MARK: - View
    private let root = ValueEditView()
    
    private var textView: UITextView { root.textView }
    private var saveButton: UIButton { root.saveButton }
    
    // MARK: - Property
    private let key: Key
    private let slot: AnySlot
    
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
        setUpLayout()
        setUpAction()
    }
    
    // MARK: - Action
    @objc private func saveTap(_ sender: UIButton) {
        guard let data = textView.text.data(using: .utf8) else { return }
        
        do {
            try slot.decode(data)
            
            delegate?.edited()
        } catch {
            showAlert(error: error)
        }
    }
    
    // MARK: - Public
    
    // MARK: - Private
    private func setUpComponent() {
        title = "\(key)"
        
        if let data = try? slot.encode() {
            textView.text = String(data: data, encoding: .utf8)
        }
    }
    
    private func setUpLayout() {
        
    }
    
    private func setUpAction() {
        saveButton.addTarget(self, action: #selector(saveTap(_:)), for: .touchUpInside)
    }
    
    private func showAlert(error: Error) {
        let viewController = UIAlertController(
            title: "Something went wrong!",
            message: "\(error.localizedDescription)",
            preferredStyle: .alert
        )
        
        viewController.addAction(
            .init(
                title: "Confirm",
                style: .default
            )
        )
        
        present(viewController, animated: true, completion: nil)
    }
}
