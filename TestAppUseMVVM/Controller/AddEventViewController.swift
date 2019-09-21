//
//  AddEventViewController.swift
//  TestApp
//
//  Created by Technoexponent on 10/09/19.
//  Copyright © 2019 Technoexponent. All rights reserved.
//

import UIKit
import Firebase

class AddEventViewController: UIViewController {
    
    //MARK:- outlets declarations
    @IBOutlet weak var eventTitleTextField: UITextField!
    @IBOutlet weak var eventDescriptionTextField: UITextField!
    @IBOutlet weak var eventContactNoTextField: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    //MARK:- variable declarations
    var checking : Bool?
    var id : String?
    var eventTitle : String?
    var eventDetails : String?
    var contactNo : String?
    
    static let shared = AddEventViewController()
    
    //MARK:- view life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Event"
        FireBaseManager.shared.refUser = Database.database().reference().child("EventList")
        
        if checking == true
        {
            self.submitBtn.setTitle("Update", for: .normal)
            self.eventTitleTextField.text = eventTitle
            self.eventDescriptionTextField.text = eventDetails
            self.eventContactNoTextField.text = contactNo
        }
        else
        {
            self.submitBtn.setTitle("Submit", for: .normal)
            
        }
        // Do any additional setup after loading the view.
    }
    
    //MARK:- button action
    @IBAction func submitAction(_ sender: Any) {
        if checking == false
        {
            if eventTitleTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) != "" || eventDescriptionTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) != "" || eventContactNoTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) != ""
            {
                addEvent()
                self.navigationController?.popViewController(animated: true)
                
                
            }else{
                showAlert(title: "Alert", msg: "all fields are mandatory")
            }
        }
        else
        {
            if eventTitleTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) != "" || eventDescriptionTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) != "" || eventContactNoTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) != ""
            {
                FireBaseManager.shared.updateToFireBase(id: id!, title: eventTitleTextField.text!, description: eventDescriptionTextField.text!, contactno: eventContactNoTextField.text!)
                DatabaseManager.shared.updateData(eventId: id!, eventTitle: eventTitleTextField.text!, eventDescription: eventDescriptionTextField.text!, eventContactNo: eventTitleTextField.text!) { (result) in
                    switch result{
                    case .success(_):
                        break
                    case .failure(_):
                        break
                    }
                }
                
                
                self.navigationController?.popViewController(animated: true)
            }else{
                showAlert(title: "Alert", msg: "all fields are mandatory")
            }
        }
        
        
    }
    
    /**
     add event function 
 */
    func addEvent(){
       
        let key = FireBaseManager.shared.refUser.childByAutoId().key
        
        let userinfo:[String : Any] = ["id":key!,
                                       "eventName": eventTitleTextField.text!,
                                       "eventDetails": eventDescriptionTextField.text!,
                                       "contactNo": eventContactNoTextField.text!
        ]
        
        FireBaseManager.shared.addDataIntoFirebase(userInfoDict: userinfo, dataBaseKey: key!)
        DatabaseManager.shared.saveEventData(eventId: key!, eventTitle: eventTitleTextField.text!, eventDescription: eventDescriptionTextField.text!, eventContactNo: eventContactNoTextField.text!) { (result) in
            switch result{
            case .success(_):
                break
            case .failure(_):
                break
            }
        }
    }
    
    func showAlert(title:String,msg:String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
