

import UIKit
import TextFieldEffects

class ViewController: UIViewController {
    static let mainIdentifier = "ViewController"
    
    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var mainNameBackground: UIView!
    @IBOutlet weak var mainName: UILabel!
    
    @IBOutlet weak var mainLevel: UILabel!
    @IBOutlet weak var mainRice: UILabel!
    @IBOutlet weak var mainWater: UILabel!
    
    @IBOutlet weak var riceTextField: TextFieldEffects!
    @IBOutlet weak var waterTextField: TextFieldEffects!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // navigation 설정
        // \()로 나중에 바꿔주자
        navigationItem.title = "재용님의 다마고치"
        // titleTextAttributes: 글꼴또는 색상 등의 변경을 할 수 있는 기능
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "NameColor") ?? .black]
        navigationController?.navigationBar.tintColor = UIColor(named: "NameColor")
        navigationItem.backButtonTitle = " "
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(nextButton))
        
        
        
        
    }
    
    // action - setting으로 push
    @objc func nextButton() {
        let settingSB = UIStoryboard(name: "Setting", bundle: nil)
        guard let settingVC = settingSB.instantiateViewController(withIdentifier: SettingTableViewController.settingIdentifier) as? SettingTableViewController else {
            return
        }
        
        self.navigationController?.pushViewController(settingVC, animated: true)
    }

}

