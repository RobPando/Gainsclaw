//
//  File.swift
//  Gainsclaw
//
//  Created by Roberto Pando on 7/12/16.
//  Copyright © 2016 Aestheticruz. All rights reserved.
//

import Foundation
import UIKit


enum GymChoices: String {
    case Chest = "Chest"
    case Back = "Back"
    case Shoulder = "Shoulder"
    case Biceps = "Biceps"
    case Abs = "Abs"
    case Triceps = "Triceps"
    case Legs = "Legs"
    case Glutes = "Glutes"
    case Calves = "Calves"
    
}


struct ExerciseClaw {
    
    let exerciseName: String
    let reps: String
    let sets: String
    let description: String
    
}

extension ExerciseClaw: DictSetter {
    init?(dict: [String: AnyObject]) {
        guard let exerciseName = dict["exerciseName"] as? String,
            reps = dict["reps"] as? String,
            sets = dict["sets"] as? String,
            description = dict["description"] as? String
            else {
            return nil
            }
        
        // TODO: Fix icon to display UIImageView
        
        self.exerciseName = exerciseName
        self.reps = reps
        self.sets = sets
        self.description = description
    
    }
    
}

class RoutineClaw {
    var routine = [:]
    
    func randomExcerciseGrabber(choice: GymChoices, numberOf: Int) -> Void {
        
        if let excercises = NSBundle.mainBundle().pathForResource("Gym", ofType: "plist"),
        let excerciseDict = NSDictionary(contentsOfFile: excercises),
            let gymDict = excerciseDict[choice.rawValue] as? [[String : String]] {
                var tracker: [Int] = []
                for var i = 0; i < numberOf; {
                    let shuffleIt = Int(arc4random_uniform(UInt32(gymDict.count)))
                    while !tracker.contains(shuffleIt) {
                        tracker.append(shuffleIt)
                        var key:[String: String] = gymDict[shuffleIt]
                        routine.setValue(key["exerciseName"], forKey: "")
                        i++
                    }

                }
        }
        
    }
    
}




















