//
//  String+Localizable.swift
//  RunsquitoKit
//
//  Created by jsilver on 2021/09/26.
//

import Foundation

extension String {
    var localized: String { NSLocalizedString(self, bundle: .module, value: self, comment: "") }
}
