//
//  ViewController.swift
//  RebuildBreakingBad
//
//  Created by IACD-Air-2 on 2021/07/05.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    var dataRecieved: Character?
    
    
    
    @IBOutlet weak var name: UILabel!
    
    
    @IBOutlet weak var nickname: UILabel!
    
    
    @IBOutlet weak var occupation: UILabel!
    
    
    @IBOutlet weak var protrayed: UILabel!
    
    
    @IBOutlet weak var status: UILabel!
    
    
    
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
        }   
    }


}

