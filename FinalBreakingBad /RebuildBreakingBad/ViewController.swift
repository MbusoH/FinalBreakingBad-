//
//  ViewController.swift
//  RebuildBreakingBad
//
//  Created by IACD-Air-2 on 2021/07/05.
//

import UIKit
import Foundation


class ViewController: UIViewController {
    
    
    var dataRecieved: Character?
    var quoteReceived = [Quotes]()
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var occupation: UILabel!
    @IBOutlet weak var protrayed: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var quote: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Must unwrapp data this way to take away Optional("data") printed!!!
        if let dataRecieved = self.dataRecieved{
            self.name.text = "\(dataRecieved.name) "
            self.nickname.text = ("\(dataRecieved.nickname)")
            
            let occupationLabel: [String] = dataRecieved.occupation
            occupation.text = occupationLabel.joined(separator: ",")
            
            //self.occupation.text = ("\(dataRecieved.occupation)")
            self.protrayed.text = ("\(dataRecieved.portrayed)")
            self.status.text = ("\(dataRecieved.status)")
            
            if self.status.text == "Presumed dead" || self.status.text == "Deceased" {
                self.status.textColor = UIColor.red
            }
            
            /* self.quote.text = ""
            for i in 0 ..< quoteReceived.count {
                //To display to display all qouotes that are in the array
                self.quote.text?.append("\(quoteReceived[i].quote) \n\n")
            }  */
            //To display random qoutes in the array
            self.quote.text = quoteReceived.randomElement()?.quote
            if self.quote.text == nil {
                self.quote.text = "No quotes logged for this character!!!"
            }
        }
    }
}

