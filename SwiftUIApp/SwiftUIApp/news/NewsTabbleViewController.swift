import UIKit

class NewsTabbleViewController: UITableViewController {
    
    var newsArray = ["News News News News News News News News News News News News News News News News Long News News News News News News News News News News News News News News News News News News News News News News News News News News News News News News News News ","Wats uuuup","News News News News News News News News News News News News News News News News Long News News News News News News News News News News News News News News News News News News News News News News News News News News News News News News News News ","boom","dance"]
    
    override func viewDidLoad() {
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "newsIdentCell")
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsIdentCell", for: indexPath) as! NewsCell
        
        cell.messageNews.text = newsArray[indexPath.row]
        return cell
    }
    
}

