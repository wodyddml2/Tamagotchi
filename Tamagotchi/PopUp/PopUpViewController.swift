
import UIKit



class PopUpViewController: UIViewController {
    
    
    // 변경하기를 위한 변수
    static var popupChange = "시작하기"
    
    var selectChangeData: SelectChange?
    

    @IBOutlet weak var popupBackground: UIView!
    @IBOutlet weak var popupImage: UIImageView!
    @IBOutlet weak var popupNameBackground: UIView!
    @IBOutlet weak var popupName: UILabel!
    
    @IBOutlet weak var sectionLine: UIView!
    
    @IBOutlet weak var introBackground: UIView!
    @IBOutlet weak var intro: UILabel!
    
    @IBOutlet weak var buttonTopLine: UIView!
    @IBOutlet weak var cancleButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 뒷 배경 투명도
        // 개체를 복사해 복사본만 변경해 원본에 영향을 끼치지않는다.(하나의 개체를 수정해도 subView에 영향이 없다.)
        view.layer.backgroundColor = UIColor.black.cgColor.copy(alpha: 0.5)

        // select화면에서 데이터 가져오기
        popupImage.image = UIImage(named: "\(selectChangeData?.image ?? "1")-6")
        popupName.text = selectChangeData?.name
        intro.text = selectChangeData?.story
        
      
        // popup 배경 색 지정
        popupBackground.backgroundColor = .tamagotchiBackgroundColor
        
        // popup 배경 둥글게
        // masksToBounds를 true 설정하지 않아도 되는 이유는 레이어를 벗어날 객체가 없기 때문에 굳이 설정해주지 않아도 되는 듯
//        popupBackground.layer.masksToBounds = true
        popupBackground.layer.cornerRadius = 5
        
        // 이름 스타일
        popupNameBackground.tamagotchiLabelBackground()
        popupName.tamagotchiLabel(13)
        
        // 구분선 색상
        sectionLine.backgroundColor = UIColor(named: "LineColor")
        
        // 소개 글 바탕 색상
        introBackground.backgroundColor = .clear
        
        // 소개 글 스타일
        intro.numberOfLines = 0
        intro.tamagotchiLabel(13)
        
        // 버튼 위 구분선
        buttonTopLine.backgroundColor = UIColor(named: "LineColor")
        
        // cancle 버튼
        cancleButton.backgroundColor = UIColor(named: "CancleColor")
        cancleButton.popButton("취소")
        // ok 버튼
        okButton.popButton(PopUpViewController.popupChange)
       
        
        

    }
    
    
    
    @IBAction func cancleButtonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func okButtonClicked(_ sender: UIButton) {
        UserDefaultsKey.standard.tamagotchi = true
        let SB = UIStoryboard(name: "Main", bundle: nil)
        guard let VC = SB.instantiateViewController(withIdentifier: ViewController.reusableIdentifier) as? ViewController else {
            return
        }
        
        let Nav = UINavigationController(rootViewController: VC)
        
        Nav.modalPresentationStyle = .fullScreen
        
        present(Nav, animated: true)
    }
    

}
