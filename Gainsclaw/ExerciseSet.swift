//
//  File.swift
//  Gainsclaw
//
//  Created by Roberto Pando on 7/12/16.
//  Copyright © 2016 Aestheticruz. All rights reserved.
//

import Foundation
import UIKit


struct ExerciseClaw {
    
    let exerciseName: String
    let suggestedPerformance: String
    let description: String
    let icon: String
    
}

extension ExerciseClaw: DictSetter {
    init?(dict: [String: AnyObject]) {
        guard let exerciseName = dict["exerciseName"] as? String,
            suggestedPerformance = dict["suggested"] as? String,
            description = dict["description"] as? String,
            icon = dict["icon"] as? String
            else {
            return nil
            }
        
        // TODO: Fix icon to display UIImageView
        
        self.exerciseName = exerciseName
        self.suggestedPerformance = suggestedPerformance
        self.description = description
        self.icon = icon
    
    }
    
}