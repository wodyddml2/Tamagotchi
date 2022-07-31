
import UIKit

class SettingTableViewCell: UITableViewCell {
    @IBOutlet weak var settingImage: UIImageView!
    @IBOutlet weak var settingTitle: UILabel!
    @IBOutlet weak var user: UILabel!
    
    // cell의 배경 색상
    self.backgroundColor = .tamagotchiBackgroundColor
    // 오른쪽 꺽쇠 악세사리 지정
    self.accessoryType = .disclosureIndicator
    // 왼쪽 구분선 채움
    self.separatorInset.left = 0
}
