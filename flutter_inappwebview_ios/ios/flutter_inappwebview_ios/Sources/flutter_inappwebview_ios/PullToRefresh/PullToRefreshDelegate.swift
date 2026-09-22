//
//  PullToRefreshDelegate.swift
//  flutter_inappwebview
//
//  Created by Lorenzo Pichilli on 04/03/21.
//

import UIKit
import Flutter
import Foundation

public protocol PullToRefreshDelegate {
    func enablePullToRefresh()
    func disablePullToRefresh()
    func isPullToRefreshEnabled() -> Bool
}
