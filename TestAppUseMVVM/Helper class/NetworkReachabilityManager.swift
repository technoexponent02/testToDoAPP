//
//  NetworkReachabilityManager.swift
//  OperrDriverV3
//
//  Created by Joy Mondal on 09/03/19.
//  Copyright © 2019 Techno-MAC. All rights reserved.
//

import Foundation
import Reachability

class NetworkReachabilityManager: NSObject {
    static let shared = NetworkReachabilityManager();
    
    private let reachability = Reachability();
    private var syncingInProgress:Bool = false;
    
    override init() {
        super.init();
    }
    //Check Internet Connection:-
    
    func isInternetAvailable() -> Bool{
        if let reachability = reachability{
            switch reachability.connection {
            case .none:
                return false;
            default:
                return true;
            }
        } else {
            return false;
        }
    }
    
    func stopNetworkListeners(){
        if let reachability = reachability{
            reachability.stopNotifier();
        }
    }
    

}
