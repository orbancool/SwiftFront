//
//  FriendsList.swift
//  2l_SD
//
//  Created by Irina Semenova on 01/12/2019.
//  Copyright © 2019 Denis Semenov. All rights reserved.
//

import UIKit

//var friendsList = ["Denis", "Irina"]

var friendsList: [User] = [User(name: "Denis", secondName: "Semenov", avatar: UIImage(named: "msg")!),
                           User(name: "Irina", secondName: "Semenova", avatar: UIImage(named: "info")!),
                           User(name: "Puf", secondName: "Cat", avatar: UIImage(named: "cat")!)
]



class FriendsList: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        //return 0
        return 1
    }

    @IBAction func editAction(_ sender: UIBarButtonItem) {
        self.tableView.isEditing = !self.tableView.isEditing
        sender.title = (self.tableView.isEditing) ? "Done" : "Edit"
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 0
        return friendsList.count
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let tempObj = friendsList[sourceIndexPath.item]
        friendsList.remove(at: sourceIndexPath.item)
        friendsList.insert(tempObj, at: destinationIndexPath.item)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            friendsList.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //return UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsTemplate", for: indexPath) as! FriendsCell
        let user = friendsList[indexPath.row] as User
        cell.friendName.text = user.name
        cell.friendSecondName.text = user.secondName
        //cell.avatarImage = user.avatar
        //cell.imageView = user.avatar
        //cell.imageView?.image = user.avatar
        cell.avatarImage.image = user.avatar
        return cell
    }
    /*
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete
        {
            friendsList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
 */
    
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let userName = friendsList[indexPath.row]
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "PhotoController") as! PhotoController
        
        let userName = friendsList[indexPath.row] as User
        viewController.user = userName.name
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}
