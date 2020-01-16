import UIKit

var groups: [Group] = [Group(name: "Houdini", avatar: "hou"),
                       Group(name: "Maya", avatar: "maya_logo"),
                       Group(name: "Vfx", avatar: "foto01"),
                       Group(name: "Mantra", avatar: "foto02"),
                       Group(name: "Cg", avatar: "foto03")
]

class GroupViewController: UITableViewController {
    @IBOutlet weak var groupSearchBar: UISearchBar!
    
    var groupSection = [Section<Group>]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeSortedSection()
        groupSearchBar.placeholder = "Search group..."
        groupSearchBar.delegate = self
    }
    
    func makeSortedSection() {
        let groupDictionary = Dictionary.init(grouping: groups) {
            $0.name.prefix(1)
        }
        
        groupSection = groupDictionary.map{Section(title: String($0.key), items: $0.value)}
        groupSection.sort{ $0.title < $1.title }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return groupSection.count
    }
    
    @IBAction func editAction(_ sender: UIBarButtonItem) {
        self.tableView.isEditing = !self.tableView.isEditing
        sender.title = (self.tableView.isEditing) ? "Done" : "Edit"
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupSection[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let tempObj = groups[sourceIndexPath.item]
        groups.remove(at: sourceIndexPath.item)
        groups.insert(tempObj, at: destinationIndexPath.item)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            groupSection[indexPath.section].items.remove(at: indexPath.row)
            //friendsList.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTemplate", for: indexPath) as! GroupCell
        let user = groupSection[indexPath.section].items[indexPath.row] as Group

        cell.groupName.text = user.name
        cell.groupImage.image = UIImage(named: user.avatar)
        
        //cell.backgroundColor = .black
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "GroupController") as! GroupCollectioViewController
        
        let user = groupSection[indexPath.section].items[indexPath.row] as Group
        viewController.user = user.name

        let titleView = UIView(frame: .init(x: 0, y: 0, width: 200, height: 40))
        let userInfo = UILabel(frame: .init(x: 0, y: 0, width: 200, height: 40))
        userInfo.text = user.name
        userInfo.textAlignment = .center
        userInfo.textColor = .white
        titleView.addSubview(userInfo)
        viewController.navigationItem.titleView = titleView
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension GroupViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let groupDictionary = Dictionary.init(grouping: groups.filter{ (user) -> Bool in
            searchText.isEmpty || user.name.lowercased().contains(searchText.lowercased())
        }) {
            $0.name.prefix(1)
        }
        
        groupSection = groupDictionary.map{Section(title: String($0.key), items: $0.value)}
        groupSection.sort{ $0.title < $1.title }
        tableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}

