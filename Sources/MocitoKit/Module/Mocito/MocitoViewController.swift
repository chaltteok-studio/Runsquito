//
//  MocitoViewController.swift
//  MocitoKit
//
//  Created by jsilver on 2021/08/30.
//

import UIKit
import Mocito

public final class MocitoViewController: UINavigationController {
    // MARK: - View
    
    // MARK: - Property
    
    // MARK: - Initializer
    public init(mocito: Mocito = .default) {
        let viewController = SlotListViewController(mocito: mocito)
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
