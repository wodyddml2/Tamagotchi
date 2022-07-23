
import UIKit

class SettingTableViewController: UITableViewController {

    static let settingIdentifier = "SettingTableViewController"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
        
        navigationItem.title = "설정"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "NameColor") ?? .black]
       
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
        cell.accessoryType = .disclosureIndicator
        if indexPath.row == 0 {
            cell.user.text = "\(ViewController.userName)"
        } else {
            cell.user.text = ""
        }
        return cell
    }
   

}
