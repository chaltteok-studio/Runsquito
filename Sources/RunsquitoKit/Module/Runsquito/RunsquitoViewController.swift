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
        super.init(nibName: nil, bundle: nil)
        
        let viewController = SlotListViewController(runsquito: runsquito)
        viewController.delegate = self
        
        viewControllers = [viewController]
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
    func viewControllerCloseButtonClicked(_ viewController: SlotListViewController) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
