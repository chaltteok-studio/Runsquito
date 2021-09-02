//
//  RunsquitoViewController.swift
//  RunsquitoKit
//
//  Created by jsilver on 2021/08/30.
//

import UIKit
import Runsquito

public final class RunsquitoViewController: UINavigationController {
    // MARK: - View
    
    // MARK: - Property
    
    // MARK: - Initializer
    public init(runsquito: Runsquito = .default) {
        let viewController = SlotListViewController(runsquito: runsquito)
        
        super.init(rootViewController: viewController)
        
        viewController.delegate = self
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpComponent()
        setUpLayout()
    }
    
    // MARK: - Public
    
    // MARK: - Private
    private func setUpComponent() {
        
    }
    
    private func setUpLayout() {
        
    }
}

extension RunsquitoViewController: SlotListViewControllerDelegate {
    func close() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
