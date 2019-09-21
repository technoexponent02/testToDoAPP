
//
//  AllEventLisViewController.swift
//  TestAppUseMVVM
//
//  Created by Technoexponent on 20/09/19.
//  Copyright © 2019 Technoexponent. All rights reserved.
//

import UIKit
import  Firebase

class AllEventLisViewController: UIViewController {
    
    //MARK:- outlets declarations
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- variable declarations
    var arrEventVM = [EventViewModel]()
    
    
    //MARK:- view life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if NetworkReachabilityManager.shared.isInternetAvailable(){
            FireBaseManager.shared.firebaseDataChangeListener { (events, error) in
                if(error==nil){
                    self.arrEventVM = events?.map({return EventViewModel(fromModel: $0)}) ?? []
                    DispatchQueue.main.async {
                        debugPrint(self.arrEventVM)
                        self.tableView.reloadData()
                    }
                }
            }
        }else{
            DatabaseManager.shared.fetchData { (events) in
                self.arrEventVM = events?.map({return EventViewModel(fromModel: $0)}) ?? []
                DispatchQueue.main.async {
                    debugPrint(self.arrEventVM)
                    self.tableView.reloadData()
                }
            }
        }

        
    }
    
    //MARK:- button actions
    @IBAction func addEventButtonClick(_ sender: Any) {
        
        let AddEventViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddEventViewController") as! AddEventViewController
        AddEventViewController.checking = false
        self.navigationController?.pushViewController(AddEventViewController, animated: true)
        
    }
    
    /**
     delete selected event from firebase and core data 
     */
    func deleteDataFromFirebase(id:String){
        FireBaseManager.shared.deleteDataIntoFirebase(dataBaseKey: id)
    }
    func deleteDataFromDataBase(id: String,completion:DBResult){
        DatabaseManager.shared.deleteData(id: id) { (result) in
            switch result
            {
            case .success ( let data ):
                completion(result)
            case .failure(_):
                break
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK:- UITableViewDelegate and UITableViewDataSource methods
extension AllEventLisViewController : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrEventVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! eventCell
        
        let MVM = arrEventVM[indexPath.row]
        
        cell.titleLabel.text = MVM.eventName ?? ""
        cell.descriptionLabel.text = MVM.eventDescription ?? ""
        cell.mobileNoLabel.text = MVM.eventContactNo ?? ""
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteDataFromFirebase(id: arrEventVM[indexPath.row].eventId!)
            deleteDataFromDataBase(id: arrEventVM[indexPath.row].eventId!) { (result) in
                self.arrEventVM.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let MVM = self.arrEventVM[indexPath.row]
        let AddEventViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddEventViewController") as! AddEventViewController
        AddEventViewController.id = MVM.eventId ?? ""
        AddEventViewController.eventTitle = MVM.eventName ?? ""
        AddEventViewController.eventDetails = MVM.eventDescription ?? ""
        AddEventViewController.contactNo = MVM.eventContactNo ?? ""
        AddEventViewController.checking = true
        self.navigationController?.pushViewController(AddEventViewController, animated: true)
    }
}

