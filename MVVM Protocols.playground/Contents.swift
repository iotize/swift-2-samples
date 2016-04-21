import UIKit

// See: https://realm.io/news/doios-natasha-murashev-protocol-oriented-mvvm/

protocol TextPresentable {
    var text: String { get }
    var textColor: UIColor { get }
    var font: UIFont { get }
}

protocol ImagePresentable {
    var image: UIImage { get }
}

protocol SwitchPresentable {
    var switchColor: UIColor { get }
    
    func onSwitchToggle(on: Bool)
}

// Set up some text defaults

extension TextPresentable {
    var textColor: UIColor {
        return UIColor.blackColor()
    }
    
    var font: UIFont {
        return UIFont.systemFontOfSize(UIFont.systemFontSize())
    }
}

// Set up some switch defaults

extension SwitchPresentable {
    var switchColor: UIColor {
        return UIColor.blackColor()
    }
}

class ImageWithSwitchCell : UITableViewCell <T where T: TextPresentable, T: ImagePresentable, T: SwitchPresentable> {
    private var delegate: T
    
    var imageView: UIImageView!
    var textLabel: UILabel!
    var cellSwitch: UISwitch!
    
    func configure(delegate: T) {
        imageView.image = delegate.image
        textLabel.text = delegate.text
        cellSwitch.onTintColor = delegate.switchColor
        
        self.delegate = delegate
    }
    
    // TODO: respond to switch toggle, forward to delegate
}

struct Person {
    var photo: UIImage
    var name: String
    var age: String
}

struct PersonViewModel : TextPresentable, ImagePresentable, SwitchPresentable {
    // Use of protocols enforces conformance
    
    let person: Person
    
    init(person: Person) {
        self.person = person
    }
    
    var text: String {
        return "\(self.person.name) is \(self.person.age) years old."
    }
    
    var image: UIImage {
        return self.person.photo
    }
    
    func onSwitchToggle(on: Bool) {
        // Change some property on Person
    }
}
