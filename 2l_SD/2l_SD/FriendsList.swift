//
//  FriendsList.swift
//  2l_SD
//
//  Created by Irina Semenova on 01/12/2019.
//  Copyright © 2019 Denis Semenov. All rights reserved.
//

import UIKit

var friendsList = ["Denis", "Irina"]

class FriendsList: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        //return 0
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 0
        return friendsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //return UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsTemplate", for: indexPath) as! FriendsCell
        cell.friendName.text = friendsList[indexPath.row]
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userName = friendsList[indexPath.row]
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "PhotoController") as! PhotoController
        viewController.user = userName
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}
