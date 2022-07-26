
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 배경 색상 지정
        view.backgroundColor = .tamagotchiBackgroundColor
        
        // navigation 스타일
        navigationItem.title = "설정"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "NameColor") ?? .black]
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // 이름 변경 재정의
        nickName = UserDefaultsKey.standard.nickname
        tableView.reloadData()
    }
    
   // 데이터 초기화 경고창
    func resetAlert() {
        
        
        let alert = UIAlertController(title: "데이터 초기화", message: "정말 다시 처음부터 키우실 건가요?!", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "네^^", style: .default, handler:  { action in
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            
            let selectSB = UIStoryboard(name: "Select", bundle: nil)
            guard let selectVC = selectSB.instantiateViewController(withIdentifier: SelectCollectionViewController.reusableIdentifier) as? SelectCollectionViewController else { return }
            
            let selectNav = UINavigationController(rootViewController: selectVC)
            
            sceneDelegate?.window?.rootViewController = selectNav
            sceneDelegate?.window?.makeKeyAndVisible()
            // 타입 프로퍼티 변경
            SelectCollectionViewController.selectTitle = "선택하기"
            PopUpViewController.popupChange = "시작하기"
            
            // 저장된 UserDefauts 초기화

            // .bundleIdentifier: bundle의 전체 식별자 - key를 다 가져옴
            // .removePersistentDomain(forName: ): 영구 도메인을 제거 - 저장된 key를 제거
            if let bundleID = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: bundleID)
            }
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.reusableIdentifier, for: indexPath) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        // cell 스타일
        cell.cellStyles()
        
        // 열거형을 이용한 cell setting
        cell.settingImage.image = UIImage(systemName: SettingCell.allCases[indexPath.row].cellInfo[0])
        cell.settingTitle.text = SettingCell.allCases[indexPath.row].cellInfo[1]
        cell.user.text = SettingCell.allCases[indexPath.row].cellInfo[2]
        
        return cell
    }
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    // cell 선택 시
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // cell 클릭 시 회색 하이라이트 없애기
//        tableView.deselectRow(at: indexPath, animated: true)
        
        // 위의 방식으로 효과를 없애기보다 셀을 갱신하여 클릭 효과 방식
        tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .fade)
        
        switch indexPath.row {
            
        case SettingCell.nameSet.rawValue:
            let nameSB = UIStoryboard(name: "Setting", bundle: nil)
            guard let nameVC = nameSB.instantiateViewController(withIdentifier: NameChangeViewController.reusableIdentifier) as? NameChangeViewController else { return }
            
            self.navigationController?.pushViewController(nameVC, animated: true)
            
        case SettingCell.tamagotchiChange.rawValue:
            SelectCollectionViewController.selectTitle = "변경하기"
            PopUpViewController.popupChange = "변경하기"
            
            let selectSB = UIStoryboard(name: "Select", bundle: nil)
            guard let selectVC = selectSB.instantiateViewController(withIdentifier: SelectCollectionViewController.reusableIdentifier) as? SelectCollectionViewController else { return }
            
            self.navigationController?.pushViewController(selectVC, animated: true)
            
        case SettingCell.dataReset.rawValue:
            resetAlert()
            
            // default 없이 할 수 있는 방법 찾자
        default:
            return
        }
    }
}
