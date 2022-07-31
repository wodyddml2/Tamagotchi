
import UIKit

extension UIViewController {
    
    func setKeyboardObserver() {
        // Notification은 애플리케이션 내 정보를 전하는 역할을 가지고 있다.
        // NotificationCenter는 어디로 정보를 보내야할지 어디에서 정보를 가져올지 정하는 중간(방송국) 역할을 한다.
        // observer: 정보를 가져오는 역할
        // addObserver: 받고자 하는 정보를 가져온다.
        // .keyboardWillShowNotification: 키보드가 표시되기 직전에 게시되는 알림 - dictionary에서 키보드의 위치와 크기를 가져온다.
        // .keyboardWillHideNotification: 키보드가 사라지기 직전 게시되는 알림 - 위와 동일
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // NSValue: 데이터 타입을 포함하고 있으며 collection타입이나 Objective-C 객체가 필요한 기타 API에 이러한 데이터 타입을 사용해야 할 경우 사용
    // .keyboardFrameEndUserInfoKey: Notification.userInfo의 key를 이용하여 키보드의 높이를 가져온다. .keyboardFrameBeginUserInfoKey을 사용하지 않는 이유는 키보드가 등장하는 순간이기에 높이 값이 조금 줄어서 나온다고 한다.
    // .cgRectValue: 값의 CoreGraphics 사각형 구조 표현
    // CGAffineTransform: 2D 그래픽을 그리는 행렬로 view의 이동,크기,회전을 할 수 있다. - 뷰를 텍스트 필드를 가리지 않을 만큼 올려줌
    @objc func keyboardUp(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            UIView.animate(withDuration: 0.2, animations: {self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight + 120)}, completion: nil)
        }
    }
    // CGAffineTransform.identity: 변환 전 고유의 값으로 돌려준다.
    @objc func keyboardDown() {
        self.view.transform = .identity
    }
}

