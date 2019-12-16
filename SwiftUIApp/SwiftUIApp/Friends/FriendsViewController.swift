import UIKit

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
    @IBOutlet weak var friendsSearchBar: UISearchBar!
    
    var customRefreshControl = UIRefreshControl()
    var friendsSection = [Section<User>]()

    override func viewDidLoad() {
        super.viewDidLoad()
        addRefreshControl()
        friendsSearchBar.placeholder = "Search friends..."
        friendsSearchBar.delegate = self
        makeSortedSection()
        
    }
    
    func addRefreshControl() {
        customRefreshControl.attributedTitle = NSAttributedString(string: "Refreshing...")
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        let attributedTitle = NSAttributedString(string: "Refreshing...", attributes: attributes)
        customRefreshControl.tintColor = .lightGray
        customRefreshControl.attributedTitle = attributedTitle
        customRefreshControl.addTarget(self, action: #selector(refreshFriends), for: .valueChanged)
        tableView.addSubview(customRefreshControl)
    }
    
    @objc func refreshFriends() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.customRefreshControl.endRefreshing()
        }
    }
    
    func makeSortedSection() {
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
    
    // new delete
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let shareAction = UITableViewRowAction(style: .default, title: "Share") { (action, index) in
            print("\(action), \(index)")
        }
        shareAction.backgroundColor = UIColor(red: 0.4, green: 0.3, blue: 0.4, alpha: 1)
        
        let forfardAction = UITableViewRowAction(style: .default, title: "Frwrd") { (action, index) in
            print("\(action), \(index)")
        }
        forfardAction.backgroundColor = UIColor(red: 0.4, green: 0.4, blue: 0.6, alpha: 1)
        
        let editAction = UITableViewRowAction(style: .default, title: "Edit") { (action, index) in
            print("\(action), \(index)")
        }
        editAction.backgroundColor = UIColor(red: 0.4, green: 0.5, blue: 0.8, alpha: 1)
        
        return[shareAction, forfardAction, editAction]
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
        //viewController.navigationItem.title = userName.name + " " + userName.secondName
        let titleView = UIView(frame: .init(x: 0, y: 0, width: 200, height: 40))
        let userInfo = UILabel(frame: .init(x: 0, y: 0, width: 200, height: 40))
        userInfo.text = userName.name + " " + userName.secondName
        userInfo.textAlignment = .center
        userInfo.textColor = .white
        titleView.addSubview(userInfo)
        //titleView.backgroundColor  = .gray
        viewController.navigationItem.titleView = titleView
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

extension FriendsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let friendsDictionary = Dictionary.init(grouping: friendsList.filter{ (user) -> Bool in
            searchText.isEmpty || user.name.lowercased().contains(searchText.lowercased())
        }) {
            $0.name.prefix(1)
        }
        
        friendsSection = friendsDictionary.map{Section(title: String($0.key), items: $0.value)}
        friendsSection.sort{ $0.title < $1.title }
        tableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
