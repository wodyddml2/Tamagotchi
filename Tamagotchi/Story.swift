

import Foundation

class Story {
    // viewWillappear에서 보일 문구
    var storyBasic: [String] = [
        "\(nickName)님 안녕하세요!!!!", "왠지 오랜만에 뵙는 것 같은데요?", "보고싶었어요~~", "얼른 물부터 주세요!"
    ]
    // 레벨마다 나오는 문구
    var story1_2: [String] = [
        "물이 시원하네요~", "오늘은 날씨가 좋아요!" ,"고마워요!!", "반가워요 \(nickName)님!!"
    ]
    var story3_4: [String] = [
        "오늘도 감사합니다!!", "밥 내놔..." ," 빨리 성장하고 싶네요^^", "\(nickName)님 배고파요..."
    ]
    var story5_6: [String] = [
        "오늘도 열심히 공부중이신가요??", "목말라유 :(" ,"전 이제 자야겠어요ㅎㅎㅎ", "\(nickName)님 힘내세요!!"
    ]
    var story7_8_9: [String] = [
        "입 좀 행구고 싶네요~", "조금만 더 먹으면 완벽할 것 같아요!!" ,"항상 감사합니다!", "\(nickName)님 오늘 좋은 하루 되세요 :)"
    ]
    var story10: [String] = [
        "이제 그만줘요ㅠㅠ", "배불러 죽겠어요!!" ,"토할 것 같아요...", "\(nickName)님 전 이제 다 컸습니다!"
    ]
  
}
