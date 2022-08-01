import UIKit
import Toast



class ViewController: UIViewController {
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
   
  
    // UserDefault 초기화
    let getIndexNumber = UserDefaultsKey.standard.index
    var levelCount = UserDefaultsKey.standard.level
    var riceCount = UserDefaultsKey.standard.rice
    var waterCount = UserDefaultsKey.standard.water
    
    
    // notification 알림
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배경색 지정
        view.backgroundColor = .tamagotchiBackgroundColor

        // 다마고치 이름 Label 스타일
        mainNameBackground.tamagotchiLabelBackground()
        mainName.tamagotchiLabel(15)
        
        // Custom Font
        storyLabel.font = UIFont(name: "Galmuri9-Regular", size: 15)
        storyLabel.textColor = UIColor(named: "NameColor")
        
        
        // Lv, 밥알, 믈방울 스타일
        mainLevel.mainLabels()
        mainRice.mainLabels()
        mainWater.mainLabels()
        storyLabel.numberOfLines = 0
      
        
        // 버튼 스타일
        riceButton.eatButton("drop.circle","밥먹기")
        waterButton.eatButton("leaf.circle","물먹기")
        
        // 텍스트 필드 스타일
        riceTextField.mainTextField("밥주세용")
        waterTextField.mainTextField("물주세용")
        
        // 텍스트필드 밑 구분선 색상
        riceSection.backgroundColor = .black
        waterSection.backgroundColor = .black
        
        
        // 밥알, 물방울 Label 값
        mainRice.text = "· 밥알 \(Int(riceCount))개"
        mainWater.text = "· 물방울 \(Int(waterCount))개"
        
        // 다마고치 이름
        mainName.text = SelectChangeInfo.select[getIndexNumber-1].name
        
        // navigation 설정
        // titleTextAttributes: 글꼴또는 색상 등의 변경을 할 수 있는 기능
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "NameColor") ?? .black]
        navigationController?.navigationBar.tintColor = UIColor(named: "NameColor")
        navigationItem.backButtonTitle = " "
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(nextButton))
        //
        notificationAuthorization()
        
    }
    
    // notification 권한 요청
    func notificationAuthorization() {
        let authorizationOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        
        notificationCenter.requestAuthorization(options: authorizationOptions) { sucess, error in
            if sucess {
                self.sendNotification()
            }
        }
    }
    
    
    // 권한 허용한 사용자에게 알림 요청
    func sendNotification() {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "\(SelectChangeInfo.select[getIndexNumber-1].name)"
        notificationContent.body = "\(Story(nick: nickName).notificationBody)"
        notificationContent.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3600, repeats: true)
        
        let request = UNNotificationRequest(identifier: "j", content: notificationContent, trigger: trigger)
        
        notificationCenter.add(request)
    }
    
    
    
    // 메인화면 입장 시 문구
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // 뷰컨 생명주기를 이용하여 이름 변경 적용
        nickName = UserDefaultsKey.standard.nickname
        // 처음 입장 시 나오는 말풍선
        storyLabel.text = tamagtchiTalk.storyBasic
        navigationItem.title = "\(nickName)님의 다마고치"
        // 레벨마다의 말풍선과 등등...
        levelUp(nickName)
        // 키보드 올릴 시 화면 같이 올려주는 기능
        setKeyboardObserver()
        
        self.sendNotification()
    }
    
    // 옵저버 제거
    override func viewWillDisappear(_ animated: Bool) {
        // 부모 클래스 메서드를 먼저 호출 (생명주기의 제어를 세밀하게 해주기 위함.)
        super.viewWillDisappear(true)
        removeKeyboardObserver()
    }
    
    
    // action - setting으로 push
    @objc func nextButton() {
        let settingSB = UIStoryboard(name: "Setting", bundle: nil)
        
        guard let settingVC = settingSB.instantiateViewController(withIdentifier: SettingTableViewController.reusableIdentifier) as? SettingTableViewController else { return }
        
        self.navigationController?.pushViewController(settingVC, animated: true)
        // 키보드 올린 상태로 넘어갈 시 키보드 내려줌 (다시 넘어와서 키보드 내리면 화면 깨짐때문)
        view.endEditing(true)
    }
    
    // 바탕 터치 시 편집 중단
    @IBAction func keyboardReturn(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    /*
     inout: 함수의 파라미터는 상수이다. 그렇기 때문에 함수 내부에서 파라미터를 변경할 수 없기에 inout키워드가 필요하다.
     inout 파라미터는 변수만을 취급
     타입 옆에 inout 명시, 함수 인자 전달 시 &키워드 명시
     원리 : 함수 호출 시 매개변수 복사 -> 함수 내부에서 복사한 값을 수정 -> 반환 시 변환된 값을 원본에 재할당
     */
    func eatCalculation(_ textField: UITextField, _ count: inout Double, _ label: UILabel) {
        if Double(textField.text ?? "") == nil && !(textField.text?.isEmpty ?? true) {
            view.makeToast("숫자를 입력해주세요ㅠㅠ", duration: 0.5, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
        } else {
            
            if textField.text?.isEmpty ?? true {
                count += 1
            } else if (Double(textField.text ?? "") ?? 0) < 100 && (Double(textField.text ?? "") ?? 0) > 0{
                count += Double(textField.text ?? "") ?? 0
            } else {
                view.makeToast("이 이상은 못먹어요!!", duration: 0.5, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
            }
            label.text = "· 밥알 \(Int(count))개"
            levelUp(nickName)
        }
        textField.text = ""
        view.endEditing(true)
    }
    
    
    // 밥알 버튼
    @IBAction func riceButtonClicked(_ sender: UIButton) {
        
//        eatCalculation(riceTextField, &UserDefaultsKey.standard.rice, mainRice)
        if Double(riceTextField.text ?? "") == nil && !(riceTextField.text?.isEmpty ?? true) {
            view.makeToast("숫자를 입력해주세요ㅠㅠ", duration: 0.5, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
        } else {

            if riceTextField.text?.isEmpty ?? true {
                riceCount += 1
            } else if (Double(riceTextField.text ?? "") ?? 0) < 100 && (Double(riceTextField.text ?? "") ?? 0) > 0{
                riceCount += Double(riceTextField.text ?? "") ?? 0
            } else {
                view.makeToast("이 이상은 못먹어요!!", duration: 0.5, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
            }
            UserDefaultsKey.standard.rice = riceCount
            mainRice.text = "· 밥알 \(Int(riceCount))개"
            levelUp(nickName)
        }
        riceTextField.text = ""
        view.endEditing(true)
    }
    
    // 물방울 버튼
    @IBAction func waterButtonClicked(_ sender: UIButton) {
        
        if Double(waterTextField.text ?? "") == nil && !(waterTextField.text?.isEmpty ?? true) {
            view.makeToast("숫자를 입력해주세요ㅠㅠ", duration: 0.5, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
        } else {
            if waterTextField.text?.isEmpty ?? true {
                waterCount += 1
            } else if (Double(waterTextField.text ?? "") ?? 0) < 50 && (Double(waterTextField.text ?? "") ?? 0) > 0{
                waterCount += Double(waterTextField.text ?? "") ?? 0
            } else {
                view.makeToast("이 이상은 못마셔요!!", duration: 0.5, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
            }
            UserDefaultsKey.standard.water = waterCount
            mainWater.text = "· 물방울 \(Int(waterCount))개"
            levelUp(nickName)

        }
        waterTextField.text = ""
        view.endEditing(true)
    }

    // Lv과 Lv에 따른 이미지, Lv마다 이야기 Label을 경험치 양마다 설정
    func levelUp(_ nick: String) {
        let tamagtchiTalk = Story(nick: nick)
        let levelPoint = Int((UserDefaultsKey.standard.rice/5) + (waterCount/2)) / 10
        switch levelPoint {
        case 0...1:
            levelCount = 1
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.storyLv1_2
        case 2:
            levelCount = levelPoint
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.storyLv1_2
        case 3:
            levelCount = levelPoint
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.storyLv3_4
        case 4:
            levelCount = levelPoint
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.storyLv3_4
        case 5:
            levelCount = levelPoint
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.storyLv5_6
        case 6:
            levelCount = levelPoint
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.storyLv5_6
        case 7:
            levelCount = levelPoint
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.storyLv7_8_9
        case 8:
            levelCount = levelPoint
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.storyLv7_8_9
        case 9:
            levelCount = levelPoint
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.storyLv7_8_9
        default:
            levelCount = 10
            mainImage.image = UIImage(named: "\(getIndexNumber)-\(levelCount-1)")
            mainLevel.text = "Lv\(levelCount)"
            storyLabel.text = tamagtchiTalk.storyLv10
        }
        UserDefaultsKey.standard.level = levelCount
    }
}

