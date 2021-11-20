//
//  Resource.swift
//  RunsquitoKit
//
//  Created by jsilver on 2021/10/09.
//

import UIKit

typealias R = Resource

enum Resource {
    enum Color {
        static var gray: UIColor { UIColor(named: "gray", in: .module, compatibleWith: nil)! }
        static var separator: UIColor { UIColor(named: "separator", in: .module, compatibleWith: nil)! }
    }
    
    enum Icon {
        static var arrowRight: UIImage { UIImage(named: "arrowRight", in: .module, compatibleWith: nil)! }
    }
}
