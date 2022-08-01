import UIKit

protocol IdentifierProtocol {
    static var reusableIdentifier: String { get }
}

extension UIViewController: IdentifierProtocol {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: IdentifierProtocol {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: IdentifierProtocol {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}
