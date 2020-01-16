

import UIKit

class NewsDetailViewController: UIViewController {

    @IBOutlet weak var newsTitle: UILabel!
    var name: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTitle.text = name
    }

}
