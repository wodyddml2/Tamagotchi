
import UIKit

extension UIView {
    // 다마고치 이름 배경 스타일
    func tamagotchiLabelBackground() {
        self.backgroundColor = UIColor(named: "LabelColor")
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "LineColor")?.cgColor
    }
}
