

import UIKit

extension UITextField {
    // 메인 화면 테스트필드 스타일
    func mainTextField(_ text:String) {
        self.borderStyle = .none
        self.placeholder = text
        self.textAlignment = .center
        self.textColor = UIColor(named: "NameColor")
        self.font = UIFont.boldSystemFont(ofSize: 17)
        self.clearButtonMode = .whileEditing
        self.keyboardType = .numberPad
    }
}
