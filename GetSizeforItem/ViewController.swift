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
    @IBOutlet weak var heightContraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var message = "Hola, soy Enrique, te doy la bienvenida a la primera súperapp hecha por y para mexicanos! 🇲🇽 A partir de ahora, haz pagos por chat, abre tu tienda en línea, escucha tu música favorita, ve TV en vivo y mucho más en un solo lugar 🙌🏽  Estaré a tus órdenes para ayudarte en el momento que lo necesites 😉"
        //message = "Hola como estas migue un saludo porfa por que"
        //message = "Hola como estas migue saludo porfavor sd"
        //message = "Hola como estas migue saludos de tu mejor amigo"
        //message = "Hola como estas migue saludos delta"
        message = "i"
        textView.text = message
        //createTextView()
        getWith()
    }
    
    private func getWith() {
        let font = textView.font ?? UIFont.systemFont(ofSize: 12)
        let pointSize = textView.font?.pointSize ?? 0.0
        let size = getSizeText(text: textView.text, pointSize: pointSize, font: font)
        widthConstraint.constant = size.width
        heightContraint.constant = size.height
        contentView.layoutIfNeeded()
    }
    
    private func returnHeightPoint(point: CGFloat) -> Double {
        switch point {
        case 12:
            return 9.8
        case 13:
            return 10.2
        case 14:
            return 11.2
        case 16:
            return 13
        default:
            return point - 2.6
        }
    }
    private func returnWidthPoint(point: CGFloat) -> Double {
        switch point {
        case 12:
            return 9.8
        case 13:
            return 10.2
        case 14:
            return 11.2
        case 16:
            return 10.9
        default:
            return point - 2.6
        }
    }
    
    private func returnForCharacter(text: String, sizeDefault: Double) -> Double {
        var tam = 0.0
        for t in text {
            switch t {
            case "i", "l":
                tam += sizeDefault * 0.9
            case " ":
                tam += sizeDefault * 1
            case "H", "m", "o", "a", "c":
                tam += sizeDefault
            default:
                tam += sizeDefault
            }
        }
        return tam
    }
    
    
    private func widthforItem(tamCharacter: Double, text: String) -> Double {
        let maxWidth = self.view.bounds.width * 0.8
        let width = returnForCharacter(text: text, sizeDefault: tamCharacter)
        
        if width > maxWidth {
            return maxWidth
        } else {
            return width
        }
    }
    
    private func getSizeText(text: String, pointSize: CGFloat, font: UIFont) -> SizeView {
        let heightPoint = returnHeightPoint(point: font.pointSize)
        let widthPoint = returnWidthPoint(point: font.pointSize)
        var maxWidth = widthforItem(tamCharacter: widthPoint, text: text)
        maxWidth = 8 + maxWidth + 8
        var numberOfRow = returnForCharacter(text: text, sizeDefault: widthPoint) / maxWidth
        let decimalPart = numberOfRow.truncatingRemainder(dividingBy: 1)
        if decimalPart > 0.35 {
            numberOfRow.round(.awayFromZero)
        } else {
            numberOfRow.round()
        }
        let topMargin = heightPoint
        let bottomMargin = heightPoint
        var heigthforRow = heightPoint * numberOfRow
        heigthforRow = topMargin + heigthforRow + bottomMargin
        return SizeView(width: maxWidth, height: heigthforRow)
    }
}
struct SizeView {
    var width: Double
    var height: Double
}
