//
//  ViewController.swift
//  RebuildBreakingBad
//
//  Created by IACD-Air-2 on 2021/07/05.
//

import UIKit
import Foundation

//Creating onther seperate api url link calling all qoutes.
let url1 = URL(string: "https://www.breakingbadapi.com/api/quotes")!
let urlSession1 = URLSession.shared
let request1 = URLRequest(url: url1)

struct Qoutes: Decodable {
    let quote_id : Int
    let quote: String
    let author: String
    let series: String
    
   enum QouteKeys: String, CodingKey {
        case quote_id
        case quote, author, eries
    }
}

class ViewController: UIViewController {
    
    var qoutesToReturn = [Qoutes]()
    var dataRecieved: Character?
    var count: Int = 0
    var indexToPass:[Int] = []
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var occupation: UILabel!
    @IBOutlet weak var protrayed: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var qoute: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let task1 = urlSession1.dataTask(with: request1) { data1, response1, error2 in
            if let error1 = error2 {
                print("Error: \(error1.localizedDescription)")
                return
            }
            //Unwarpping the data and confriming if there is data and not nil
            guard let unwrappedData1 = data1 else {
                print("No data")
                return
            }
            //A JsconDecoder which occonverts the data from the jason  file with help from a struc "Character"!!!
            let jsonDecoder1 = JSONDecoder()
            do {
                guard let qoutes = try? jsonDecoder1.decode([Qoutes].self, from: unwrappedData1)
                else {
                    print("Could not decode qoutes")
                    return
                }
                print("pass1")
                DispatchQueue.main.async {
                    //give values to the dataToReturn dictionary
                    self.qoutesToReturn  = qoutes
                    //self.tableView.reloadData() //Reload very IMPORTANT!!!!!!
                    print("*********************>>>\(self.qoutesToReturn[1].author)")
                }
            }
            return
        }
        
        task1.resume()
        
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

            
            //qoutesToReturn.contains(where: dataRecieved.name = qoutesToReturn[Qoutes].author)
            //print("eeeeeeeeeeeeeeeee\(self.indexToPass)")
            
            DispatchQueue.global().async {
                for _ in self.qoutesToReturn{
                    if self.qoutesToReturn[self.count].author == dataRecieved.name {
                        self.indexToPass.append(self.count)
                        print("eeeeeeeeeeeeeeeee\(self.indexToPass)")
                    }
                    self.count+=1
                }
                DispatchQueue.main.async {
                    self.view.reloadInputViews()
                   if let numberPicked = self.indexToPass.randomElement(){
                    self.qoute.text = self.qoutesToReturn[numberPicked].quote
                   }
                }
            }
        }
    }
}

