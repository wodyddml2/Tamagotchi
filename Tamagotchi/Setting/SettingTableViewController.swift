
import UIKit
enum SettingCell: Int ,CaseIterable {
    
    case nameSet
    case tamagotchiChange
    case dataReset

    var cellInfo: [String] {
        switch self {
        case .nameSet:
            return ["pencil", "내 이름 설정하기", "\(nickName)"]
        case .tamagotchiChange:
            return ["moon.fill", "다마고치 변경하기", ""]
        case .dataReset:
            return ["goforward", "데이터 초기화", ""]
            
        }
    }

}

class SettingTableViewController: UITableViewController {

    
    static let settingIdentifier = "SettingTableViewController"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
        
        navigationItem.title = "설정"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "NameColor") ?? .black]
        print(#function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        nickName = UserDefaults.standard.string(forKey: "nickname") ?? "재용"
        tableView.reloadData()
        print(#function)
    }
   
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingCell.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
        cell.accessoryType = .disclosureIndicator
        cell.separatorInset.left = 0
        
        cell.settingImage.image = UIImage(systemName: SettingCell.allCases[indexPath.row].cellInfo[0])
        cell.settingTitle.text = SettingCell.allCases[indexPath.row].cellInfo[1]
        cell.user.text = SettingCell.allCases[indexPath.row].cellInfo[2]
        
        cell.settingImage.tintColor = UIColor(named: "NameColor")
        
        cell.settingTitle.textColor = .black
        cell.settingTitle.font = .boldSystemFont(ofSize: 15)
        
        cell.user.textColor = UIColor(named: "LineColor")
        cell.user.font = .boldSystemFont(ofSize: 13)

        return cell
    }
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nameSB = UIStoryboard(name: "Setting", bundle: nil)
        guard let nameVC = nameSB.instantiateViewController(withIdentifier: "NameChangeViewController") as? NameChangeViewController else {
            return
        }
        
        
        switch indexPath.row {
        case SettingCell.nameSet.rawValue:
            self.navigationController?.pushViewController(nameVC, animated: true)
        case SettingCell.tamagotchiChange.rawValue:
            print("")
        case SettingCell.dataReset.rawValue:
            print("")
        default:
            print("")
        }
    }
}
