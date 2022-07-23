

import UIKit

extension UITextField {
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
