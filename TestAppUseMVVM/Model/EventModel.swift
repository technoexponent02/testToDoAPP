//
//  EventModel.swift
//  TestAppUseMVVM
//
//  Created by Technoexponent on 20/09/19.
//  Copyright © 2019 Technoexponent. All rights reserved.
//

import UIKit

class EventModel: NSObject {
    var eventId: String?
    var eventName : String?
    var eventDescription : String?
    var eventContactNo : String?
    
    init(eventId:String, eventName:String,eventDescription:String,eventContactNo:String ){
        self.eventId = eventId
        self.eventName = eventName
        self.eventDescription = eventDescription
        self.eventContactNo = eventContactNo
    }
}
