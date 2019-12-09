import UIKit

struct Section<T> {
    var title: String
    var items: [T]
}

var friendsList: [User] = [User(name: "Denis", secondName: "Semenov", avatar: "msg"),
                           User(name: "Irina", secondName: "Semenova", avatar: "info"),
                           User(name: "Denis", secondName: "Semenov", avatar: "msg"),
                           User(name: "Irina", secondName: "Semenova", avatar: "info"),User(name: "Denis", secondName: "Semenov", avatar: "msg"),
                           User(name: "Irina", secondName: "Semenova", avatar: "info"),
                           User(name: "Puf", secondName: "Cat", avatar: "cat"),
                           User(name: "Aydrei", secondName: "Ivanov", avatar: "msg"),
                           User(name: "Sasha", secondName: "Petrov", avatar: "info"),
                           User(name: "Mary", secondName: "Sidorova", avatar: "cat")
]

class FriendsViewController: UITableViewController {
    
    var friendsSection = [Section<User>]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let friendsDictionary = Dictionary.init(grouping: friendsList) {
            $0.name.prefix(1)
        }
        
        friendsSection = friendsDictionary.map{Section(title: String($0.key), items: $0.value)}
        friendsSection.sort{ $0.title < $1.title }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return friendsSection.count
    }

    @IBAction func editAction(_ sender: UIBarButtonItem) {
        self.tableView.isEditing = !self.tableView.isEditing
        sender.title = (self.tableView.isEditing) ? "Done" : "Edit"
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsSection[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let tempObj = friendsList[sourceIndexPath.item]
        friendsList.remove(at: sourceIndexPath.item)
        friendsList.insert(tempObj, at: destinationIndexPath.item)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            friendsSection[indexPath.section].items.remove(at: indexPath.row)
            //friendsList.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsTemplate", for: indexPath) as! FriendsCell
        let user = friendsSection[indexPath.section].items[indexPath.row] as User
        cell.friendName.text = user.name
        cell.friendSecondName.text = user.secondName
        cell.avatarImage.image = UIImage(named: user.avatar)
        //cell.backgroundColor = .black
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "PhotoController") as! PhotoController
        
        let userName = friendsSection[indexPath.section].items[indexPath.row] as User
        viewController.user = userName.name
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return friendsSection[section].title
    }
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        return friendsSection.map { $0.title}
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(displayP3Red: 0.496, green: 0.591, blue: 0.799, alpha: 1)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        //tableView.backgroundColor = UIColor(displayP3Red: 0.496, green: 0.591, blue: 0.799, alpha: 1)
    }

}
