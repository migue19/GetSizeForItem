//
//  ViewController.swift
//  GetSizeforItem
//
//  Created by Miguel Mexicano Herrera on 29/12/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var message = "Hola, soy Enrique, te doy la bienvenida a la primera súperapp hecha por y para mexicanos! 🇲🇽 A partir de ahora, haz pagos por chat, abre tu tienda en línea, escucha tu música favorita, ve TV en vivo y mucho más en un solo lugar 🙌🏽  Estaré a tus órdenes para ayudarte en el momento que lo necesites 😉"
        //message = "Hola como estas migue un saludo porfa por que"
        //message = "Hola como estas migue saludo porfavor sd"
        //message = "Hola como estas migue saludos de tu mejor amigo"
        //message = "Hola como estas migue saludos del"
        //message = "i"
        textView.text = message
        //createTextView()
        getSize()
    }
    private func getSize() {
        if let font = textView.font {
            let size = getSizeForText(textView.text, font: font, marginTop: 8, marginBottom: 8)
            widthConstraint.constant = size.width
            heightConstraint.constant = size.height
            contentView.layoutIfNeeded()
        }
    }
    private func getSizeForText(_ text: String, font: UIFont, marginTop: Double, marginBottom: Double) -> SizeView {
        let width = widthForItem(text: text, font: font, marginLeft: 8, marginRight: 8)
        var height = text.height(withConstrainedWidth: width, font: font)
        height = marginTop + height + marginBottom
        return SizeView(width: width, height: height)
    }
    private func getWidthForText(_ text: String, font: UIFont) -> Double {
        return text.size(withAttributes: [NSAttributedString.Key.font: font]).width
    }
    private func widthForItem(text: String, font: UIFont, marginLeft: Double, marginRight: Double) -> Double {
        let maxWidth = self.view.bounds.width * 0.8
        let width = getWidthForText(text, font: font)
        if width > maxWidth {
            return maxWidth
        } else {
            return marginLeft + width + marginRight
        }
    }
}
struct SizeView {
    var width: Double
    var height: Double
}
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}
