

import UIKit

extension UIButton {
    func popButton(_ title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor(named: "NameColor"), for: .normal)
        self.setTitleColor(UIColor(named: "LineColor") , for: .highlighted)
    }
}
