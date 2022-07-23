
import UIKit
import Toast


class SelectCollectionViewController: UICollectionViewController {
    
    static let selectIndentifier = "SelectCollectionViewController"

    @IBOutlet weak var selectPageBackground: UIView!
    
    let selectChange = SelectChangeInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 헤더 제목
        navigationItem.title = "다마고치 선택하기"
        
        // 스크롤 바 없애기
        collectionView.showsVerticalScrollIndicator = false
        
        // 배경 색
        selectPageBackground.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
        
        // cell 레이아웃
        let layout = UICollectionViewFlowLayout()
        let spacing:CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 5)
        layout.itemSize = CGSize(width: width / 3, height: width / 3 * 1.17)
        layout.sectionInset = UIEdgeInsets(top: spacing * 2 , left: spacing, bottom: spacing, right: spacing)
        
        collectionView.collectionViewLayout = layout
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectCollectionViewCell", for: indexPath) as? SelectCollectionViewCell else {
            return UICollectionViewCell()
        }

        // 선택 화면 객체 스타일
        cell.tamagotchiNameBackground.tamagotchiLabelBackground()
        cell.tamagotchiName.tamagotchiLabel(13)
        
        // cell에 적용할 Image와 Label 설정
        if indexPath.row < selectChange.select.count{
            cell.tamagotchiImage.image = UIImage(named: selectChange.select[indexPath.row].image)
            cell.tamagotchiName.text = selectChange.select[indexPath.row].name
        } else {
            cell.tamagotchiImage.image = UIImage(named: "noImage")
            cell.tamagotchiName.text = "준비중이에요"
        }
        
        
        return cell
    }
    
    // 선택 시 PopUp창으로 이동
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let popSB = UIStoryboard(name: "PopUp", bundle: nil)
        guard let popVC = popSB.instantiateViewController(withIdentifier: PopUpViewController.popIdentifier) as? PopUpViewController else {
            return
        }
        popVC.modalPresentationStyle = .overFullScreen
        if indexPath.row < selectChange.select.count{
            popVC.selectChangeData = selectChange.select[indexPath.row]
            popVC.pass = indexPath.row + 1
            present(popVC, animated: true)
        } else {
            // Toast 라이브러리를 이용한 나머지 cell들의 팝업창
            view.makeToast("아직 준비가 안됐어요 ㅠㅠ", duration: 2.0, position: .center, title: "(?) 다마고치", image: UIImage(named: "noImage"), style: ToastStyle(), completion: nil)
        }
        
    }
    
 
}
