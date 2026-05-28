//
//  VisibleViewController.swift
//  flutter_inappwebview
//
//  Created by Alexandru Terente on 02.08.2023.
//

import UIKit

extension UIApplication {
    
    /// Get the key window across all iOS versions
    var keyWindowCompat: UIWindow? {
        if #available(iOS 13.0, *) {
            let windowScene = connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .first(where: { $0.activationState == .foregroundActive })
            
            if #available(iOS 15.0, *) {
                if let keyWindow = windowScene?.keyWindow {
                    return keyWindow
                }
            }
            
            return windowScene?.windows.first(where: { $0.isKeyWindow })
                ?? windowScene?.windows.first
        } else {
            return windows.first(where: { $0.isKeyWindow })
                ?? windows.first
        }
    }

    var visibleViewController: UIViewController? {
        guard let rootViewController = keyWindowCompat?.rootViewController else {
            return nil
        }
        return getVisibleViewController(rootViewController)
    }

    private func getVisibleViewController(_ rootViewController: UIViewController) -> UIViewController? {
        if let presentedViewController = rootViewController.presentedViewController {
            return getVisibleViewController(presentedViewController)
        }
        if let navigationController = rootViewController as? UINavigationController {
            return navigationController.visibleViewController
        }
        if let tabBarController = rootViewController as? UITabBarController {
            return tabBarController.selectedViewController
        }
        return rootViewController
    }
}
