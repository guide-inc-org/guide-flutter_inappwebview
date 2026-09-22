//
//  SecCertificate.swift
//  flutter_inappwebview
//
//  Created by Lorenzo Pichilli on 19/02/21.
//

import UIKit
import Flutter
import Foundation

extension SecCertificate {
    var data: Data {
        let serverCertificateCFData = SecCertificateCopyData(self)
        return serverCertificateCFData as Data
    }
}
