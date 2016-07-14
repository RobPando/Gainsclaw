//
//  FoursquareJSON.swift
//  Gainsclaw
//
//  Created by Roberto Pando on 7/12/16.
//  Copyright © 2016 Aestheticruz. All rights reserved.
//

import Foundation





final class FoursquareGym: APIGetter {
    var configuration: NSURLSessionConfiguration

    lazy var session: NSURLSession = {
        NSURLSession(configuration: self.configuration)
    }()
    
    var clientID: String
    var clientSecret: String
    
    init(config: NSURLSessionConfiguration, clientID: String, clientSecret: String){
        self.configuration = config
        self.clientID = clientID
        self.clientSecret = clientSecret
    }
    convenience init(clientID: String, clientSecret: String) {
        self.init(config: .defaultSessionConfiguration(), clientID: clientID, clientSecret: clientSecret)
    }
    
}