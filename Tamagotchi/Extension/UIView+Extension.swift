
import UIKit

extension UIView {
    func tamagotchiLabelBackground() {
        self.backgroundColor = UIColor(named: "LabelColor")
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "LineColor")?.cgColor
    }
    
   
}
