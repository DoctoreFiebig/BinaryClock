import UIKit

@IBDesignable
class Clock: UIView {

    private var iHH: Int = 0
    private var iMM: Int = 0
    private var iSS: Int = 0
    
    private var circleColor: UIColor = UIColor.orangeColor().colorWithAlphaComponent(0.5)
    private var dottedColor: UIColor = UIColor.orangeColor()
    
    private var HH_centers: [CGPoint] = []
    private var MM_centers: [CGPoint] = []
    private var SS_centers: [CGPoint] = []
    
    private var radius: CGFloat!
    private var line: CGFloat!
    
    //Öffentliche Variable zum setzen des aktuellen NSDate's
    var time: NSDate = NSDate() {
        didSet {
            getTimeElements()
            setNeedsDisplay()
        }
    }
    private func getTimeElements(){
        let dF = NSDateFormatter()
        dF.dateFormat = "HH:mm:ss"
        let dateString = dF.stringFromDate(time)
        let iARR = dateString.componentsSeparatedByString(":").flatMap{Int($0)}
        if iARR.count == 3 {
            iHH = iARR[0]
            iMM = iARR[1]
            iSS = iARR[2]
        }
    }
    
    private func getCenters() {
        let h = bounds.size.height
        let b = bounds.size.width
        
        radius = (min(b, h) / 12) * 0.7
        line = 2.5
        
        //CenterPoints der Kreise gleichmäßig über das View verteilen
        HH_centers = [CGPoint(x: 9 * (b / 10), y: 1 * (h / 6)),
                      CGPoint(x: 7 * (b / 10), y: 1 * (h / 6)),
                      CGPoint(x: 5 * (b / 10), y: 1 * (h / 6)),
                      CGPoint(x: 3 * (b / 10), y: 1 * (h / 6)),
                      CGPoint(x: 1 * (b / 10), y: 1 * (h / 6))]
        
        MM_centers = [CGPoint(x: 11 * (b / 12), y: 3 * (h / 6)),
                      CGPoint(x: 9 * (b / 12), y: 3 * (h / 6)),
                      CGPoint(x: 7 * (b / 12), y: 3 * (h / 6)),
                      CGPoint(x: 5 * (b / 12), y: 3 * (h / 6)),
                      CGPoint(x: 3 * (b / 12), y: 3 * (h / 6)),
                      CGPoint(x: 1 * (b / 12), y: 3 * (h / 6))]
        
        SS_centers = [CGPoint(x: 11 * (b / 12), y: 5 * (h / 6)),
                      CGPoint(x: 9 * (b / 12), y: 5 * (h / 6)),
                      CGPoint(x: 7 * (b / 12), y: 5 * (h / 6)),
                      CGPoint(x: 5 * (b / 12), y: 5 * (h / 6)),
                      CGPoint(x: 3 * (b / 12), y: 5 * (h / 6)),
                      CGPoint(x: 1 * (b / 12), y: 5 * (h / 6))]
    }
    
    //Grundmethode um einen UIBezierpath an einem CenterPoint zu erhalten
    private func drawCircle(center c: CGPoint)->UIBezierPath {
        let path = UIBezierPath(arcCenter: c, radius: radius, startAngle: 0, endAngle: 2*CGFloat(M_PI), clockwise: true)
        path.lineWidth = line
        return path
    }
    
    //Die nicht-ausgefüllten Kreise zeichnen
    private func drawGefaultCircles() {
        circleColor.setStroke()
        
        for c in HH_centers {
            drawCircle(center: c).stroke()
        }
        for c in MM_centers {
            drawCircle(center: c).stroke()
        }
        for c in SS_centers {
            drawCircle(center: c).stroke()
        }
    }
    
    //Ausgefüllte Kreise zeichnen
    private func drawDottedCircles(center c: CGPoint){
        dottedColor.setFill()
        drawCircle(center: c).fill()
    }
    
    //Den Intwert der Stunden in eine binäre Bitfolge umwandeln
    //Wenn ein Bit den Wert "1" erhält, wird der entsprechende Kreis ausgefüllt
    private func setHours(){
        for i in 0...4 {
            if iHH % 2 == 0 {
                iHH = iHH / 2
            }
            else {
                iHH = iHH - 1
                iHH = iHH / 2
                
                drawDottedCircles(center: HH_centers[i])
            }
        }
    }
    
    private func setMinutes(){
        for i in 0...5 {
            if iMM % 2 == 0 {
                iMM = iMM / 2
            }
            else {
                iMM = iMM - 1
                iMM = iMM / 2
                
                drawDottedCircles(center: MM_centers[i])
            }
        }
    }

    private func setSeconds(){
        for i in 0...5 {
            if iSS % 2 == 0 {
                iSS = iSS / 2
            }
            else {
                iSS = iSS - 1
                iSS = iSS / 2
                
                drawDottedCircles(center: SS_centers[i])
            }
        }
    }

    
    
    //Eigentliches Drawing im View
    override func drawRect(rect: CGRect) {
        getCenters()
        drawGefaultCircles()
        setHours()
        setMinutes()
        setSeconds()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
