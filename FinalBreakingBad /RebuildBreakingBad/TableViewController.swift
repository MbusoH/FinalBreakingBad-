//
//  TableViewController.swift
//  RebuildBreakingBad
//
//  Created by IACD-Air-2 on 2021/07/05.
//

import UIKit
import Foundation

//Creating the api url link/ address/ calling charactors and charactor details
let url = URL(string: "https://www.breakingbadapi.com/api/characters")!
//Creating a URL session
let urlSession = URLSession.shared
//url request from the url
let request = URLRequest(url: url)

//THis struct creates the array with items inside and also determines the data type of the items in te array.
struct Character: Decodable, CustomStringConvertible {
    let name: String
    let nickname: String
    let birthday: String
    let img: String
    let occupation: [String]
    let portrayed: String
    let status: String
    let appearance : [Int]
    let id: Int
    
    var description: String {
        return  "\(id) - \(name) aka \(nickname) and img: \(img)"   // this is the output of the stuct Character
    }
    
    enum CodingKeys: String, CodingKey {
        case name, nickname, birthday, img, portrayed, status , occupation, appearance
        case id = "char_id"
    }
}

class TableViewController: UITableViewController {
    
    var dataToReturn = [Character]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        print("pass0")
        
        //Complition handler: confirms if succsefull or error occured.
        let task = urlSession.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            //Unwarpping the data and confriming if there is data and not nil
            guard let unwrappedData = data else {
                print("No data")
                return
            }
            //A JsconDecoder which occonverts the data from the jason  file with help from a struc "Character"!!!
            let jsonDecoder = JSONDecoder()
            do {
                guard let characterList = try? jsonDecoder.decode([Character].self, from: unwrappedData)
                else {
                    print("Could not decode")
                    return
                }
                print("pass1")
                DispatchQueue.main.async {
                    //give values to the dataToReturn dictionary
                    self.dataToReturn = characterList
                    self.tableView.reloadData() //Reload very IMPORTANT!!!!!!
                    print("\(self.dataToReturn[1].occupation)")
                }
            }
            return
        }
        
        //Activating the task and task1 (in  the ServersCalling.swift file) to start
        task.resume()
        print("pass2")
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("pass3")
        return  dataToReturn.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TableViewCell
        // Configure the cell...
        let currentCharactor = dataToReturn[indexPath.row]
        //print("this number confrim charactor id: \(dataToReturn[indexPath.row].id)")
        //print("mark pass 1: \(dataToReturn[(dataToReturn[indexPath.row].id) - 1].id)")

        //UImage(named: "")// getting the url for image in global thread then  displaying in main thread
        DispatchQueue.global().async {
            //let urlString = url.absoluteString // convert url to string
            let url = URL(string: "\(currentCharactor.img)") //convert string to url
            if let dataOnline = try? Data(contentsOf: url!){
                DispatchQueue.main.async {
                    cell.img.image = UIImage(data: dataOnline)
                }
            }
        }
        
        // function that convert the date format to a number in Syring format
        func age() -> String{
            let charactorAge = DateFormatter()
            charactorAge.dateFormat = "mm-dd-yyyy"
            guard let numberAge = charactorAge.date(from:currentCharactor.birthday )
            else{
                return "Age not specified"
            }
            
            let calandar = NSCalendar.current
            
            let ageConverted = calandar.dateComponents([.year], from: numberAge, to: Date())
            
            guard let ageToDisplay = ageConverted.year
            else{
                return "0"
            }
            
            return "\(ageToDisplay) years"
        }
  
        cell.nameSurname.text = "\(currentCharactor.name)"
        cell.nickName.text = "\(currentCharactor.nickname)"
        cell.dateOfBirth.text = age()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Breaking Bad"
    }
    
    // for some reason these these also passes the index of the particular charactor index!!!
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "seguePass", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //These were the segue function transferes data. This is linked to the performSegue function. I think!!
        print("----------------> performing segue")
        if let ViewController = segue.destination as? ViewController {
            ViewController.dataRecieved = dataToReturn[(tableView.indexPathForSelectedRow?.row)!]
        }
        print("pass5")
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

   
