import UIKit

var groups: [Group] = [Group(name: "Houdini", avatar: "loveRed"),
                       Group(name: "Maya", avatar: "love"),
                       Group(name: "Vfx", avatar: "love"),
                       Group(name: "Mantra", avatar: "loveRed"),
                       Group(name: "Cg", avatar: "loveRed")
]

class GroupViewController: UITableViewController {
    @IBOutlet weak var groupSearchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupSearchBar.placeholder = "Search group..."
        groupSearchBar.delegate = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func editAction(_ sender: UIBarButtonItem) {
        self.tableView.isEditing = !self.tableView.isEditing
        sender.title = (self.tableView.isEditing) ? "Done" : "Edit"
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let tempObj = groups[sourceIndexPath.item]
        groups.remove(at: sourceIndexPath.item)
        groups.insert(tempObj, at: destinationIndexPath.item)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            groups.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTemplate", for: indexPath) as! GroupCell
        let user = groups[indexPath.row] as Group
        cell.groupName.text = user.name
        cell.groupImage.image = UIImage(named: user.avatar)
        
        //cell.backgroundColor = .black
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "GroupController") as! GroupCollectioViewController
        
        let userName = groups[indexPath.row] as Group
        viewController.user = userName.name

        let titleView = UIView(frame: .init(x: 0, y: 0, width: 200, height: 40))
        let userInfo = UILabel(frame: .init(x: 0, y: 0, width: 200, height: 40))
        userInfo.text = userName.name
        userInfo.textAlignment = .center
        userInfo.textColor = .white
        titleView.addSubview(userInfo)
        viewController.navigationItem.titleView = titleView
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(displayP3Red: 0.496, green: 0.591, blue: 0.799, alpha: 1)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        //tableView.backgroundColor = UIColor(displayP3Red: 0.496, green: 0.591, blue: 0.799, alpha: 1)
    }
    
}

extension GroupViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //var oldGroups = groups
        let filteredGroups = groups.filter { (group) -> Bool in
            group.name.isEmpty || group.name.lowercased().contains(searchText.lowercased())
        }

        groups = filteredGroups
        tableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}

