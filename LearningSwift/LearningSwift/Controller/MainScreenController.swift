//
//  MainScreenController.swift
//  LearningSwift
//
//  Created by Emre Kahraman on 26/03/2018.
//  Copyright © 2018 Emre Kahraman. All rights reserved.
//

import Foundation
import UIKit

class MainScreenController: UIViewController {
    @IBOutlet weak var bestAttempt: UILabel!
    
    var bestAttemptCount = 0 {
        didSet {
            bestAttempt.text = "Best Attempt: \(bestAttemptCount)"
        }
    }
}
