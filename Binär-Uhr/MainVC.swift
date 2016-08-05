import UIKit

class MainVC: UIViewController {

    
    @IBOutlet weak var clock: Clock!
    
    //Verstecken der Statusbar für den View
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //Laden des Views
    override func viewDidLoad() {
        super.viewDidLoad()
        //Ein-Sekunden-Timer um in der Klasse Clock den Wert "Time" zu aktualisieren
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(MainVC.timerTick(_:)), userInfo: nil, repeats: true)
    }
    func timerTick(sender: NSTimer){
        clock.time = NSDate()
    }
    
    
    
    
    
    
    
}
