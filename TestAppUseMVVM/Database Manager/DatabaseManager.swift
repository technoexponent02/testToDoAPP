
//
//  DatabaseManager.swift
//  TestApp
//
//  Created by Technoexponent on 10/09/19.
//  Copyright © 2019 Technoexponent. All rights reserved.
//

import Foundation
import CoreData

enum Result
{
    case success(Any)
    case failure(String)
}
typealias DBResult = (Result)->()
class DatabaseManager: NSObject {
    
    static let shared = DatabaseManager()
    let manageObjectContest : NSManagedObjectContext
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var userInfo = [Entity]()
    public override init()
    {
        manageObjectContest = appDelegate.persistentContainer.viewContext
    }
    
    
    //MARK: for saving/insert data into database::---->>
    
    func saveEventData(eventId : String , eventTitle : String , eventDescription : String , eventContactNo : String , completion : DBResult)
    {
        let entityInfo = Entity(context: manageObjectContest)
        entityInfo.id = eventId
        entityInfo.eventName = eventTitle
        entityInfo.eventDetails = eventDescription
        entityInfo.contactNo = eventContactNo
        do{
            try manageObjectContest.save()
            completion(.success("Saved Successfully"))
        }
        catch
        {
            completion(.failure("Data not saved properly!!"))
        }
        
    }
    
    //MARK: for fetch data into database::---->>
    
    func fetchData(completion: @escaping([EventModel]?) -> ())
    {
        let fetchRequest = Entity.fetchRequest() as NSFetchRequest
        do{
            try userInfo = manageObjectContest.fetch(fetchRequest) as [Entity]
            var arrEventData = [EventModel]()
            for event in userInfo{
                arrEventData.append(EventModel(eventId: event.id!, eventName:event.eventName!, eventDescription: event.eventDetails!, eventContactNo: event.contactNo!))
            }
            completion(arrEventData)
        }
        catch
        {
            
        }
    }
    
    //MARK: for Delete data into database::---->>
    
    func deleteData(id : String, completion : DBResult)
    {
        let fetchRequest = Entity.fetchRequest() as NSFetchRequest
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do
        {
            let result = try manageObjectContest.fetch(fetchRequest) as [Entity]
            for item in result
            {
                manageObjectContest.delete(item)
            }
            try manageObjectContest.save()
            if result.count > 0
            {
                completion(.success("Deleted Successfully!!"))
            }
            else
            {
                completion(.failure("Not Deleted"))
            }
        }
        catch
        {
            completion(.failure(error.localizedDescription))
        }
    }
    
    //MARK: for Update data into database::---->>
    
    func updateData(eventId : String , eventTitle : String , eventDescription : String , eventContactNo : String, completion : DBResult)
    {
        let fetchRequest = Entity.fetchRequest() as NSFetchRequest
        let predicate = NSPredicate(format: "id == %@", eventId)
        fetchRequest.predicate = predicate
        do
        {
            let result = try manageObjectContest.fetch(fetchRequest) as [Entity]
            if result.count > 0
            {
                for item in result
                {
                    item.eventName = eventTitle
                    item.eventDetails = eventDescription
                    item.contactNo = eventContactNo
                }
                
                try manageObjectContest.save()
                print("update Successfully")
                completion(.success("updated successfully"))
            }
            else
            {
                completion(.failure("Not upadted!!"))
            }
        }
        catch
        {
            completion(.failure("Not upadted!!"))
        }
    }
}
