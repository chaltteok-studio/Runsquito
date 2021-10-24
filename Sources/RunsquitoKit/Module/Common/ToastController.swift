//
//  ToastController.swift
//  
//
//  Created by jsilver on 2021/10/24.
//

import JSToast

class ToastController {
    static let shared: ToastController = .init()
    
    private init() { }
    
    func showToast(title: String) {
        Toaster.shared.showToast(
            Toast(ToastView(title: title)),
            withDuration: 2,
            at: [.inside(of: .top), .center(of: .x)],
            show: .slideIn(duration: 0.3, direction: .down),
            hide: .fadeOut(duration: 0.3)
        )
    }
}
