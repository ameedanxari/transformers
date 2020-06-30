//
//  UIApplication+Extension.swift
//  transformers
//
//  Created by macintosh on 2020-06-30.
//  Copyright © 2020 aequilibrium. All rights reserved.
//

import UIKit

extension UIApplication {
    class func getTopViewController(_ base: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopViewController(presented)
        }
        return base
    }
}
