import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var userName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let owner = User(name: "Denis", secondName: "Semenov", avatar: "msg")
        userName.text = owner.name
    }
}
