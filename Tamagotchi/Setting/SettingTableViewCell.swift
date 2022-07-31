
import UIKit

class SettingTableViewCell: UITableViewCell {
    @IBOutlet weak var settingImage: UIImageView!
    @IBOutlet weak var settingTitle: UILabel!
    @IBOutlet weak var user: UILabel!
    
    
    func cellStyles() {
        // cell의 배경 색상
        self.backgroundColor = .tamagotchiBackgroundColor
        // 오른쪽 꺽쇠 악세사리 지정
        self.accessoryType = .disclosureIndicator
        // 왼쪽 구분선 채움
        self.separatorInset.left = 0
        
        // systemSymbols 색상
        self.settingImage.tintColor = UIColor(named: "NameColor")
        // 설정창 sub제목들 스타일
        self.settingTitle.textColor = .black
        self.settingTitle.font = .boldSystemFont(ofSize: 15)
        // 이름 변경 cell 이름 스타일
        self.user.textColor = UIColor(named: "LineColor")
        self.user.font = .boldSystemFont(ofSize: 13)
    }
    
}
