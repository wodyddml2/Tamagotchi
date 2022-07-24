

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
    
    
    
    let getIndexNumber = UserDefaults.standard.integer(forKey: "index")
    var selectChangeData = SelectChangeInfo()
  
    
    var tamagtchiTalk = Story()
  
    var levelCount = UserDefaults.standard.integer(forKey: "level")
    var riceCount:Double = UserDefaults.standard.double(forKey: "rice")
    var waterCount: Double  = UserDefaults.standard.double(forKey: "water")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        riceTextField.delegate = self
        waterTextField.delegate = self
    
        setKeyboardObserver()
        // 세 가지 Label 값
        mainRice.text = "· 밥알 \(Int(riceCount))개"
        mainWater.text = "· 물방울 \(Int(waterCount))개"
        
        
        
        // 배경색 지정
        view.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
        
        // 다마고치 이름 Label 스타일
        mainNameBackground.tamagotchiLabelBackground()
        mainName.tamagotchiLabel(15)
        
        mainName.text = selectChangeData.select[getIndexNumber-1].name
        
        // Lv, 밥알, 믈방울, story Label 스타일
        mainLevel.mainLabels()
        mainRice.mainLabels()
        mainWater.mainLabels()
        storyLabel.mainLabels()
        
        // navigation 설정
        // \()로 나중에 바꿔주자
        
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
    // 메인화면 입장 시 문구
    override func viewWillAppear(_ animated: Bool) {

        storyLabel.text = tamagtchiTalk.storyBasic.randomElement()!
        nickName = UserDefaults.standard.string(forKey: "nickname") ?? "재용"
        navigationItem.title = "\(nickName)님의 다마고치"
        levelUp()

    }
    // 옵저버를 제거해줌으로써 키보드 올린채 화면 넘어갔다 다시 올 때 화면 깨짐 방지
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardObserver()
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
            UserDefaults.standard.set(riceCount, forKey: "rice")
            mainRice.text = "· 밥알 \(Int(riceCount))개"
            levelUp()
        }
        riceTextField.text = ""
    }
    
    // 물방울 버튼
    @IBAction func waterButtonClicked(_ sender: UIButton) {
        
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
            UserDefaults.standard.set(waterCount, forKey: "water")
            mainWater.text = "· 물방울 \(Int(waterCount))개"
            levelUp()
        }
        waterTextField.text = ""
    }

    // Lv과 Lv에 따른 이미지, Lv마다 이야기 Label을 경험치 양마다 설정
    func levelUp() {
        let levelPoint = (riceCount/5) + (waterCount/2)
        switch levelPoint {
        case 0..<20:
            levelCount = 1
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.story1_2.randomElement()!
        case 20..<30:
            levelCount = 2
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.story1_2.randomElement()!
        case 30..<40:
            levelCount = 3
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.story3_4.randomElement()!
        case 40..<50:
            levelCount = 4
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.story3_4.randomElement()!
        case 50..<60:
            levelCount = 5
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.story5_6.randomElement()!
        case 60..<70:
            levelCount = 6
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.story5_6.randomElement()!
        case 70..<80:
            levelCount = 7
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.story7_8_9.randomElement()!
        case 80..<90:
            levelCount = 8
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.story7_8_9.randomElement()!
        case 90..<100:
            levelCount = 9
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.story7_8_9.randomElement()!
        default:
            levelCount = 10
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount-1)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.story10.randomElement()!
        }
        UserDefaults.standard.set(levelCount, forKey: "level")
    }
}

