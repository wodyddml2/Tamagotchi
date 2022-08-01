import Foundation

//enum UserDefaultsKey {
//    static let rice = "rice"
//    static let water = "water"
//    static let nickname = "nickname"
//    static let level = "level"
//    static let tamagotchi = "tamagotchi"
//    static let index = "index"
//}

class UserDefaultsKey {
    private init() {}
    
    enum Key: String {
        case rice, water, nickname, level, tamagotchi, index
    }
    
    static let standard = UserDefaultsKey()
    
    let userDefaults = UserDefaults.standard
    let optionalDefaults = "재용"
    
    var rice: Double {
        get {
            userDefaults.double(forKey: Key.rice.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.rice.rawValue)
        }
    }
    
    var water: Double {
        get {
            userDefaults.double(forKey: Key.water.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.water.rawValue)
        }
    }
    
    var nickname: String {
        get {
            userDefaults.string(forKey: Key.nickname.rawValue) ?? optionalDefaults
        }
        set {
            userDefaults.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    var level: Int {
        get {
            userDefaults.integer(forKey: Key.level.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.level.rawValue)
        }
    }
    
    var tamagotchi: Bool {
        get {
            userDefaults.bool(forKey: Key.tamagotchi.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.tamagotchi.rawValue)
        }
    }
    
    var index: Int {
        get {
            userDefaults.integer(forKey: Key.index.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.index.rawValue)
        }
    }
    
    
    
}
