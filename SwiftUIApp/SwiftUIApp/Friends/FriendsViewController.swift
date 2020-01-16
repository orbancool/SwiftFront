import UIKit


var friendsList: [User] = [User(name: "Denis", secondName: "Semenov", avatar: "foto08"),
                           User(name: "Irina", secondName: "Semenova", avatar: "foto07"),
                           User(name: "Denis", secondName: "Semenov", avatar: "foto06"),
                           User(name: "Irina", secondName: "Semenova", avatar: "foto05"),User(name: "Denis", secondName: "Semenov", avatar: "foto08"),
                           User(name: "Irina", secondName: "Semenova", avatar: "foto04"),
                           User(name: "Puf", secondName: "Cat", avatar: "cat"),
                           User(name: "Aydrei", secondName: "Ivanov", avatar: "foto03"),
                           User(name: "Sasha", secondName: "Petrov", avatar: "foto02"),
                           User(name: "Mary", secondName: "Sidorova", avatar: "foto01")
]

class FriendsViewController: UITableViewController {
    @IBOutlet weak var friendsSearchBar: UISearchBar!
    
    var customRefreshControl = UIRefreshControl()
    var friendsSection = [Section<User>]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRefreshControl()
        let color = UIColor(displayP3Red: 0.496, green: 0.591, blue: 0.799, alpha: 1)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search friends..."
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.backgroundColor = .white
        searchController.searchBar.tintColor = color

        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = false

        navigationItem.searchController = searchController
        definesPresentationContext = true
        
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
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action, index) in
            //print("\(action), \(index)")
            self.friendsSection[indexPath.section].items.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.reloadData()
        }
        deleteAction.backgroundColor = UIColor(red: 0.4, green: 0.3, blue: 0.4, alpha: 1)
        
        
        let forfardAction = UITableViewRowAction(style: .default, title: "Frwrd") { (action, index) in
            //print("\(action), \(index)")
        }
        forfardAction.backgroundColor = UIColor(red: 0.4, green: 0.4, blue: 0.6, alpha: 1)
        
        let editAction = UITableViewRowAction(style: .default, title: "Edit") { (action, index) in
            //print("\(action), \(index)")
        }
        editAction.backgroundColor = UIColor(red: 0.4, green: 0.5, blue: 0.8, alpha: 1)
        
        return[deleteAction, forfardAction, editAction]
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
    
    func filterContentForSearchText(_ searchText: String) {
        let friendsDictionary = Dictionary.init(grouping: friendsList.filter{ (user) -> Bool in
            searchText.isEmpty || user.name.lowercased().contains(searchText.lowercased())
        }) {
            $0.name.prefix(1)
        }
        
        friendsSection = friendsDictionary.map{Section(title: String($0.key), items: $0.value)}
        friendsSection.sort{ $0.title < $1.title }
        tableView.reloadData()
        
    }
    
}


extension FriendsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}

extension FriendsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print("scope")
    }
}
