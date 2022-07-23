

import UIKit

extension UIButton {
    func popButton(_ title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor(named: "NameColor"), for: .normal)
        self.setTitleColor(UIColor(named: "LineColor") , for: .highlighted)
    }
    
    func eatButton(_ icon: String,_ eat: String) {
        self.tintColor = UIColor(named: "NameColor")
        self.setImage(UIImage(systemName: "\(icon)"), for: .normal)
        self.setTitle(" \(eat)", for: .normal)
        self.setTitleColor(UIColor(named: "NameColor"), for: .normal)
        self.setTitleColor(UIColor(named: "LineColor") , for: .highlighted)
        
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1.3
        self.layer.borderColor = UIColor(named: "NameColor")?.cgColor
    }
    
   
}
