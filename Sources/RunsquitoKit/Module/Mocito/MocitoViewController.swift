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
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpComponent()
    }
    
    // MARK: - Public
    
    // MARK: - Private
    func setUpComponent() {
        
    }
}
