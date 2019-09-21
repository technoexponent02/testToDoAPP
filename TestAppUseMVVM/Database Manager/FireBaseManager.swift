//
//  FireBaseManager.swift
//  TestApp
//
//  Created by Technoexponent on 19/09/19.
//  Copyright © 2019 Technoexponent. All rights reserved.
//

import UIKit
import Firebase

class FireBaseManager: NSObject {
    
    static let shared = FireBaseManager()
    var refUser: DatabaseReference!

    /**
     For update event :-
     */
    
    func updateToFireBase(id:String,title:String, description : String, contactno : String){
        //creating artist with the new given values
        let user = ["id":id,
                    "eventName": title,
                    "eventDetails": description,
                    "contactNo": contactno
        ]
        
        refUser.child(id).setValue(user)
        debugPrint("user Updated")
    }
    
    /**
     For add event :-
     */
    
    func addDataIntoFirebase(userInfoDict:[String: Any],dataBaseKey : String){
        refUser.child(dataBaseKey).setValue(userInfoDict)
    }
    
    /**
     For delete event :-
     */
    
    func deleteDataIntoFirebase(dataBaseKey : String){
        refUser.child(dataBaseKey).setValue(nil)
    }
    
    func firebaseDataChangeListener(completion: @escaping([EventModel]?, Error?) -> ()){
        refUser = Database.database().reference().child("EventList")
        refUser.observe(DataEventType.value, with: { (snapshot) in
            
            if snapshot.childrenCount > 0 {
                
                var arrEventData = [EventModel]()
                
                for item in snapshot.children.allObjects as! [DataSnapshot] {
                    
                    let itemObject = item.value as? [String: AnyObject]
                    arrEventData.append(EventModel(eventId: itemObject!["id"] as! String, eventName: itemObject!["eventName"] as! String, eventDescription: itemObject!["eventDetails"] as! String, eventContactNo: itemObject!["contactNo"] as! String))

                }
                completion(arrEventData, nil)
            }
        })

    }
}
