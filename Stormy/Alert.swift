//
//  Alert.swift
//  Stormy
//
//  Created by Addison Francisco on 12/31/17.
//  Copyright © 2017 Addison Francisco. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    
    static func showBasic(title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true)
    }
}
