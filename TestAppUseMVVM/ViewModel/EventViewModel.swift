//
//  EventViewModel.swift
//  TestAppUseMVVM
//
//  Created by Technoexponent on 20/09/19.
//  Copyright © 2019 Technoexponent. All rights reserved.
//

import UIKit

class EventViewModel: NSObject {
    
    var eventId: String?
    var eventName: String?
    var eventDescription: String?
    var eventContactNo: String?
    
    init(fromModel:EventModel){
        
        self.eventId = fromModel.eventId
        self.eventName = fromModel.eventName
        self.eventDescription = fromModel.eventDescription
        self.eventContactNo = fromModel.eventContactNo
    }
    
}
