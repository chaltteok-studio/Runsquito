//
//  ToastView.swift
//  RunsquitoKit
//
//  Created by jsilver on 2021/10/08.
//

import UIKit

class ToastView: UIView {
    // MARK: - View
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .systemFont(ofSize: 17, weight: .semibold)
        
        return view
    }()
    
    // MARK: - Property
    var title: String? {
        get {
            titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    // MARK: - Initializer
    init(title: String) {
        super.init(frame: .zero)
        
        commonInit(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available(iOS 12.0, *) {
            switch traitCollection.userInterfaceStyle {
            case .dark:
                titleLabel.textColor = .black
                
            default:
                titleLabel.textColor = .white
            }
        }
    }
    
    // MARK: - Public
    
    // MARK: - Private
    private func commonInit(title: String) {
        setUpComponent(title: title)
        setUpAction()
        setUpLayout()
    }
    
    private func setUpComponent(title: String) {
        backgroundColor = R.Color.gray
        layer.cornerRadius = 26
        
        layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        layer.shadowOffset = .init(width: 0, height: 2)
        
        self.title = title
    }
    
    private func setUpAction() {
        
    }
    
    private func setUpLayout() {
        [titleLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -52),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 52)
        ])
    }
}
