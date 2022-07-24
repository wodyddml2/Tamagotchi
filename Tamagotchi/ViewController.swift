
import UIKit
import Toast


class ViewController: UIViewController {
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
    
    // 다마고치 말풍선 class 초기화
    var tamagtchiTalk = Story(nick: nickName)
   
    //  다마고치 이름을 가져오기 위해 struct 초기화
    var selectChangeData = SelectChangeInfo()
  
    // UserDefault 초기화
    let getIndexNumber = UserDefaults.standard.integer(forKey: "index")
    var levelCount = UserDefaults.standard.integer(forKey: "level")
    var riceCount:Double = UserDefaults.standard.double(forKey: "rice")
    var waterCount: Double  = UserDefaults.standard.double(forKey: "water")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배경색 지정
        view.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)

        // 다마고치 이름 Label 스타일
        mainNameBackground.tamagotchiLabelBackground()
        mainName.tamagotchiLabel(15)
        
        // Lv, 밥알, 믈방울, story Label 스타일
        mainLevel.mainLabels()
        mainRice.mainLabels()
        mainWater.mainLabels()
        storyLabel.mainLabels()
        
        // 버튼 스타일
        riceButton.eatButton("drop.circle","밥먹기")
        waterButton.eatButton("leaf.circle","물먹기")
        
        // 텍스트 필드 스타일
        riceTextField.mainTextField("밥주세용")
        waterTextField.mainTextField("물주세용")
        
        // 텍스트필드 밑 구분선 색상
        riceSection.backgroundColor = .black
        waterSection.backgroundColor = .black
        
        // 키보드 올릴 시 화면 같이 올려주는 기능
        setKeyboardObserver()
        
        // 밥알, 물방울 Label 값
        mainRice.text = "· 밥알 \(Int(riceCount))개"
        mainWater.text = "· 물방울 \(Int(waterCount))개"
        
        // 다마고치 이름
        mainName.text = selectChangeData.select[getIndexNumber-1].name
        
        // navigation 설정
        // titleTextAttributes: 글꼴또는 색상 등의 변경을 할 수 있는 기능
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "NameColor") ?? .black]
        navigationController?.navigationBar.tintColor = UIColor(named: "NameColor")
        navigationItem.backButtonTitle = " "
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(nextButton))

    }
    
    // 메인화면 입장 시 문구
    override func viewWillAppear(_ animated: Bool) {
        // 뷰컨 생명주기를 이용하여 이름 변경 적용
        nickName = UserDefaults.standard.string(forKey: "nickname") ?? "재용"
        // 처음 입장 시 나오는 말풍선
        storyLabel.text = tamagtchiTalk.storyFirst()
        navigationItem.title = "\(nickName)님의 다마고치"
        // 레벨마다의 말풍선과 등등...
        levelUp(nickName)
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
    
    // 바탕 터치 시 편집 중단
    @IBAction func keyboardReturn(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // 밥알 버튼
    @IBAction func riceButtonClicked(_ sender: UIButton) {
        if Double(riceTextField.text ?? "") == nil && !(riceTextField.text?.isEmpty ?? true) {
            view.makeToast("숫자를 입력해주세요ㅠㅠ", duration: 0.5, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
        } else {
            
            if riceTextField.text?.isEmpty ?? true {
                riceCount += 1
            } else if (Double(riceTextField.text ?? "") ?? 0) < 100{
                riceCount += Double(riceTextField.text ?? "") ?? 0
            } else {
                view.makeToast("이 이상은 못먹어요!!", duration: 0.5, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
            }
            UserDefaults.standard.set(riceCount, forKey: "rice")
            mainRice.text = "· 밥알 \(Int(riceCount))개"
            levelUp(nickName)
        }
        riceTextField.text = ""
    }
    
    // 물방울 버튼
    @IBAction func waterButtonClicked(_ sender: UIButton) {
        
        if Double(waterTextField.text ?? "") == nil && !(waterTextField.text?.isEmpty ?? true) {
            view.makeToast("숫자를 입력해주세요ㅠㅠ", duration: 0.5, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
        } else {
            if waterTextField.text?.isEmpty ?? true {
                waterCount += 1
            } else if (Double(waterTextField.text ?? "") ?? 0) < 50{
                waterCount += Double(waterTextField.text ?? "") ?? 0
            } else {
                view.makeToast("이 이상은 못마셔요!!", duration: 0.5, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
            }
            UserDefaults.standard.set(waterCount, forKey: "water")
            mainWater.text = "· 물방울 \(Int(waterCount))개"
            levelUp(nickName)
        }
        waterTextField.text = ""
    }

    // Lv과 Lv에 따른 이미지, Lv마다 이야기 Label을 경험치 양마다 설정
    func levelUp(_ a: String) {
        var tamagtchiTalk = Story(nick: a)
        let levelPoint = (riceCount/5) + (waterCount/2)
        switch levelPoint {
        case 0..<20:
            levelCount = 1
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.storyLv1_2()
        case 20..<30:
            levelCount = 2
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.storyLv1_2()
        case 30..<40:
            levelCount = 3
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.storyLv3_4()
        case 40..<50:
            levelCount = 4
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.storyLv3_4()
        case 50..<60:
            levelCount = 5
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.storyLv5_6()
        case 60..<70:
            levelCount = 6
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.storyLv5_6()
        case 70..<80:
            levelCount = 7
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.storyLv7_8_9()
        case 80..<90:
            levelCount = 8
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.storyLv7_8_9()
        case 90..<100:
            levelCount = 9
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.storyLv7_8_9()
        default:
            levelCount = 10
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount-1)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.storyLv10()
        }
        UserDefaults.standard.set(levelCount, forKey: "level")
    }
}

