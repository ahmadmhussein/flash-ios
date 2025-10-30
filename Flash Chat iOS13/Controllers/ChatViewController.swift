//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
let db = Firestore.firestore()
class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    var messages : [messege] = [
        messege(sender: "1@2.com", body: "welcom"),
        messege(sender: "2@3.com", body: "hello"),
        messege(sender: "1@2.com", body: "how are you?") 
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        title = "Chat"
        navigationItem.hidesBackButton = true
        tableView.register(UINib(nibName: K.cellNibName , bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
       if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email{
           db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField: messageSender, K.FStore.bodyField: messageBody]) { (error) in
               if let error = error{
                   print("Error adding document: \(error)")
               }
               else {
                   print( "Document added ")
    
               }
           }
        }
        
    }
    
    

    @IBAction func logOutPresed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
            }
        }
    
extension ChatViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell" , for: indexPath) as! MessageCell
        cell.lable.text=messages[indexPath.row].body
        return cell
    }
    
    
    
    }

