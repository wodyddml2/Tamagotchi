
import UIKit
// 열거형과 switch문을 이용한 cell 구성
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
        // 배경 색상 지정
        view.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
        
        // navigation 스타일
        navigationItem.title = "설정"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "NameColor") ?? .black]
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // 이름 변경 재정의
        nickName = UserDefaults.standard.string(forKey: "nickname") ?? "재용"
        tableView.reloadData()
    }
    
   // 데이터 초기화 경고창
    func resetAlert() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let selectSB = UIStoryboard(name: "Select", bundle: nil)
        guard let selectVC = selectSB.instantiateViewController(withIdentifier: SelectCollectionViewController.selectIndentifier) as? SelectCollectionViewController else {
            return
        }
        
        let selectNav = UINavigationController(rootViewController: selectVC)
        
        let alert = UIAlertController(title: "데이터 초기화", message: "정말 다시 처음부터 키우실 건가요?!", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "네^^", style: .default, handler:  { action in
            sceneDelegate?.window?.rootViewController = selectNav
            sceneDelegate?.window?.makeKeyAndVisible()
            // 타입 프로퍼티 변경
            SelectCollectionViewController.selectChange = "선택하기"
            PopUpViewController.popupChange = "시작하기"
            // 저장된 UserDefauts 초기화
            UserDefaults.standard.removeObject(forKey: "level")
            UserDefaults.standard.removeObject(forKey: "nickname")
            UserDefaults.standard.removeObject(forKey: "rice")
            UserDefaults.standard.removeObject(forKey: "water")
            UserDefaults.standard.removeObject(forKey: "tamagotchi")
        })
        
        let cancle = UIAlertAction(title: "장난이에요ㅎㅎ", style: .cancel, handler: nil)
        
        ok.setValue(UIColor(named: "AlertOkColor"), forKey: "titleTextColor")
        cancle.setValue(UIColor(named: "AlertCancleColor"), forKey: "titleTextColor")
        
        alert.addAction(ok)
        alert.addAction(cancle)
        
        present(alert, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingCell.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        // cell의 배경 색상
        cell.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
        // 오른쪽 꺽쇠 악세사리 지정
        cell.accessoryType = .disclosureIndicator
        // 왼쪽 구분선 채움
        cell.separatorInset.left = 0
        
        // 열거형을 이용한 cell setting
        cell.settingImage.image = UIImage(systemName: SettingCell.allCases[indexPath.row].cellInfo[0])
        cell.settingTitle.text = SettingCell.allCases[indexPath.row].cellInfo[1]
        cell.user.text = SettingCell.allCases[indexPath.row].cellInfo[2]
        
        // systemSymbols 색상
        cell.settingImage.tintColor = UIColor(named: "NameColor")
        // 설정창 sub제목들 스타일
        cell.settingTitle.textColor = .black
        cell.settingTitle.font = .boldSystemFont(ofSize: 15)
        // 이름 변경 cell 이름 스타일
        cell.user.textColor = UIColor(named: "LineColor")
        cell.user.font = .boldSystemFont(ofSize: 13)

        return cell
    }
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    // cell 선택 시
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // cell 클릭 시 회색 하이라이트 없애기
        tableView.deselectRow(at: indexPath, animated: true)
        
        let nameSB = UIStoryboard(name: "Setting", bundle: nil)
        guard let nameVC = nameSB.instantiateViewController(withIdentifier: "NameChangeViewController") as? NameChangeViewController else {
            return
        }
        
     
        let selectSB = UIStoryboard(name: "Select", bundle: nil)
        guard let selectVC = selectSB.instantiateViewController(withIdentifier: SelectCollectionViewController.selectIndentifier) as? SelectCollectionViewController else {
            return
        }
        
        
        switch indexPath.row {
            
        case SettingCell.nameSet.rawValue:
            self.navigationController?.pushViewController(nameVC, animated: true)
            
        case SettingCell.tamagotchiChange.rawValue:
            SelectCollectionViewController.selectChange = "변경하기"
            PopUpViewController.popupChange = "변경하기"
            self.navigationController?.pushViewController(selectVC, animated: true)
            
        case SettingCell.dataReset.rawValue:
            resetAlert()
            
        default:
            return
        }
    }
}
