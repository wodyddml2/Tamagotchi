
import Foundation

class Story {
    var nick:String?
    
    init(nick: String) {
        self.nick = nick
    }

    // 인스턴트 연산 프로퍼티로 재사용
    var storyBasic: String {
        ["\(nick ?? "")님 안녕하세요!!!!", "왠지 오랜만에 뵙는 것 같은데요?", "보고싶었어요~~", "얼른 물부터 주세요!"].randomElement()!
    }
    
    var storyLv1_2: String {
        ["물이 시원하네요~", "오늘은 날씨가 좋아요!" ,"고마워요!!", "반가워요 \(nick ?? "")님!!"].randomElement()!
    }
    
    var storyLv3_4: String {
        ["오늘도 감사합니다!!", "밥 내놔..." ," 빨리 성장하고 싶네요^^", "\(nick ?? "")님 배고파요..."].randomElement()!
    }
    
    var storyLv5_6: String {
        [ "오늘도 열심히 공부중이신가요??", "목말라유 :(" ,"전 이제 자야겠어요ㅎㅎㅎ", "\(nick ?? "")님 힘내세요!!"].randomElement()!
    }
    
    var storyLv7_8_9: String {
        ["입 좀 행구고 싶네요~", "조금만 더 먹으면 완벽할 것 같아요!!" ,"항상 감사합니다!", "\(nick ?? "")님 오늘 좋은 하루 되세요 :)"].randomElement()!
    }
    
    var storyLv10: String {
        ["이제 그만줘요ㅠㅠ", "배불러 죽겠어요!!" ,"토할 것 같아요...", "\(nick ?? "")님 전 이제 다 컸습니다!"].randomElement()!
    }
    
    var notificationBody: String {
        ["\(nick ?? "")님 보고싶어요!", "\(nick ?? "")님 배고파요...", "\(nick ?? "")님 오늘 하루도 화이팅하세요 :)"].randomElement()!
    }
}

