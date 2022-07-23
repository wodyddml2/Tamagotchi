

import UIKit

extension UILabel {
    func tamagotchiLabel(_ num: CGFloat) {
        self.textAlignment = .center
        self.font = .boldSystemFont(ofSize: num)
        self.textColor = UIColor(named: "NameColor")
    }
    
    func mainLabels() {
        self.font = .boldSystemFont(ofSize: 15)
        self.textColor = UIColor(named: "NameColor")
    }
}
