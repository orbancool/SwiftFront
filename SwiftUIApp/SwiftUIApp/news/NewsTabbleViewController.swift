import UIKit

class NewsTabbleViewController: UITableViewController {
    
    //var newsArray = ["News News News News News News News News News News News News News News News News Long News News News News News News News News News News News News News News News News News News News News News News News News News News News News News News News News ","Wats uuuup","News News News News News News News News News News News News News News News News Long News News News News News News News News News News News News News News News News News News News News News News News News News News News News News News News News ","boom","dance"]
    
    var newsArray: [News] = [
        News(avatarNews: "foto02", titleNews: "Moscow", timeNews: "19:00", messageNews: "short message"),
        News(avatarNews: "hou", titleNews: "Russia", timeNews: "11:00", messageNews: "long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long message"),
        News(avatarNews: "maya_logo", titleNews: "Moscow", timeNews: "19:00", messageNews: "short message"),
        News(avatarNews: "hou", titleNews: "Russia", timeNews: "11:00", messageNews: "long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long message"),
        News(avatarNews: "foto04", titleNews: "Moscow", timeNews: "19:00", messageNews: "short message"),
        News(avatarNews: "foto06", titleNews: "Russia", timeNews: "11:00", messageNews: "long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long message")
        ]
    
    func setNavigationBarProperty() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.topItem?.title = "News"
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    override func viewDidLoad() {

        setNavigationBarProperty()
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "newsIdentCell")
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsIdentCell", for: indexPath) as! NewsCell
        
        //cell.messageNews.text = newsArray[indexPath.row].messageNews
        cell.titleNews.text = newsArray[indexPath.row].titleNews
        cell.messageNews.text = newsArray[indexPath.row].messageNews
        cell.timeNews.text = newsArray[indexPath.row].timeNews
        cell.avatarNews.image = UIImage(named: newsArray[indexPath.row].avatarNews) 
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyBoard.instantiateViewController(withIdentifier: "newsIdent") as? NewsDetailViewController else { return }
        
        let news = newsArray[indexPath.row]
        viewController.name = news.titleNews
        //let newsTitle = cell.titleNews //newsArray[indexPath.row]

        //viewController.newsTitle.text = cell?.titleNews.text
        //print(viewController.newsTitle.text)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

