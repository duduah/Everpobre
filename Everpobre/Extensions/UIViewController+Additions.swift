//
//  UIViewController+Additions.swift
//  Everpobre
//
//  Created by Diego Gay Saez on 21/04/2018.
//  Copyright © 2018 Diego Gay Saez. All rights reserved.
//

import UIKit

extension UIViewController {
    func wrapViewInNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}
