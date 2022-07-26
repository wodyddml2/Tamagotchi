import UIKit

var nickName = UserDefaultsKey.standard.nickname

class NameChangeViewController: UIViewController {

    @IBOutlet var nameChangeBackground: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var sectionLine: UIView!


    override func viewDidLoad() {
        super.viewDidLoad()

        // navigation 스타일
        navigationItem.title = "\(nickName)님 이름 정하기"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveAction))
        
        // 배경 색상
        nameChangeBackground.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
        
        // 텍스트 필드 스타일
        nameTextField.borderStyle = .none
        nameTextField.placeholder = "이름을 작성하주세요!!"
        nameTextField.font = .boldSystemFont(ofSize: 17)
        nameTextField.textColor = UIColor(named: "NameColor")
        nameTextField.clearButtonMode = .whileEditing
        
        // 텍스트 필드 밑 선 색상
        sectionLine.backgroundColor = .black
    }
    // 저장 action
    @objc func saveAction() {
        UserDefaultsKey.standard.nickname = nameTextField.text ?? UserDefaultsKey.standard.optionalDefaults
        
        navigationController?.popViewController(animated: true)
    }

  
}
