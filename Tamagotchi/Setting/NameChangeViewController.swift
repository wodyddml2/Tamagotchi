

import UIKit
var nickName: String = UserDefaults.standard.string(forKey: "nickname") ?? "재용"
class NameChangeViewController: UIViewController {

    @IBOutlet var nameChangeBackground: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var sectionLine: UIView!


    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "\(nickName)님 이름 정하기"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveAction))
        
        nameChangeBackground.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
        
        nameTextField.borderStyle = .none
        nameTextField.placeholder = "이름을 작성하주세요!!"
        nameTextField.font = .boldSystemFont(ofSize: 17)
        nameTextField.textColor = UIColor(named: "NameColor")
        nameTextField.clearButtonMode = .whileEditing
        
        sectionLine.backgroundColor = .black
        print(#function)
    }

    @objc func saveAction() {
        UserDefaults.standard.set(nameTextField.text, forKey: "nickname")
        
        
        
        navigationController?.popViewController(animated: true)
       
        
    }

  
}
