

import UIKit
import Toast


class ViewController: UIViewController, UITextFieldDelegate {
    static let mainIdentifier = "ViewController"
    
    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var mainNameBackground: UIView!
    @IBOutlet weak var mainName: UILabel!
    
    @IBOutlet weak var mainLevel: UILabel!
    @IBOutlet weak var mainRice: UILabel!
    @IBOutlet weak var mainWater: UILabel!
    
    @IBOutlet weak var riceTextField: UITextField!
    @IBOutlet weak var waterTextField: UITextField!
    
    @IBOutlet weak var riceSection: UIView!
    @IBOutlet weak var waterSection: UIView!
    
    
    @IBOutlet weak var riceButton: UIButton!
    @IBOutlet weak var waterButton: UIButton!
    
    
  
    static var userName:String = "재용"
    var tamagtchiTalk = Story()
    
    var levelCount = 0
    var riceCount:Double = 0
    var waterCount: Double  = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        riceTextField.delegate = self
        waterTextField.delegate = self
        
        // 배경색 지정
        view.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
        
        // 다마고치 이름 Label 스타일
        mainNameBackground.tamagotchiLabelBackground()
        mainName.tamagotchiLabel(15)
        
        // Lv, 밥알, 믈방울 Label 스타일
        mainLevel.mainLabels()
        mainRice.mainLabels()
        mainWater.mainLabels()
        
        // navigation 설정
        // \()로 나중에 바꿔주자
        navigationItem.title = "\(ViewController.userName)님의 다마고치"
        // titleTextAttributes: 글꼴또는 색상 등의 변경을 할 수 있는 기능
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "NameColor") ?? .black]
        navigationController?.navigationBar.tintColor = UIColor(named: "NameColor")
        navigationItem.backButtonTitle = " "
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(nextButton))
    
        // 버튼 스타일
        riceButton.eatButton("drop.circle","밥먹기")
        waterButton.eatButton("leaf.circle","물먹기")
        
        // 텍스트 필드 스타일
        riceTextField.mainTextField("밥주세용")
        waterTextField.mainTextField("물주세용")
        
        // 텍스트필드 밑 구분선 색상
        riceSection.backgroundColor = .black
        waterSection.backgroundColor = .black
        
    }
    
    
    // action - setting으로 push
    @objc func nextButton() {
        let settingSB = UIStoryboard(name: "Setting", bundle: nil)
        guard let settingVC = settingSB.instantiateViewController(withIdentifier: SettingTableViewController.settingIdentifier) as? SettingTableViewController else {
            return
        }
        
        self.navigationController?.pushViewController(settingVC, animated: true)
        
    }
    
    // return작용
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        riceTextField.resignFirstResponder()
        waterTextField.resignFirstResponder()
        
        return true
    }
    
    // 바탕 터치 시 편집중단
    @IBAction func keyboardReturn(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // 밥알 버튼
    @IBAction func riceButtonClicked(_ sender: UIButton) {
        if Double(riceTextField.text ?? "") == nil && !(riceTextField.text?.isEmpty ?? true) {
            view.makeToast("숫자를 입력해주세요!!")
        } else {
            
            if riceTextField.text?.isEmpty ?? true {
                riceCount += 1
            } else if (Double(riceTextField.text ?? "") ?? 0) < 100{
                riceCount += Double(riceTextField.text ?? "") ?? 0
            } else {
                view.makeToast("이 이상은 못먹어요!!!")
            }
            mainRice.text = "· 밥알 \(Int(riceCount))개"
        }
        riceTextField.text = ""
        print( (riceCount/5) + (waterCount/2))
    }
    
    // 물방울 버튼
    @IBAction func waterButtonClicked(_ sender: UIButton) {
        let water = UserDefaults.standard.double(forKey: <#T##String#>)
        UserDefaults.standard.set(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
        if Double(waterTextField.text ?? "") == nil && !(waterTextField.text?.isEmpty ?? true) {
            view.makeToast("숫자를 입력해주세요!!")
        } else {
            if waterTextField.text?.isEmpty ?? true {
                waterCount += 1
               
            } else if (Double(waterTextField.text ?? "") ?? 0) < 50{
                waterCount += Double(waterTextField.text ?? "") ?? 0
            } else {
                view.makeToast("이 이상은 못마셔요!!!")
            }
            mainWater.text = "· 밥알 \(Int(waterCount))개"
        }
        waterTextField.text = ""
        
    }
    if water == 0 {
        UserDefaults.standard.set(waterCount, forKey: "water")
    }
}

