//
//  TableViewCell.swift
//  RebuildBreakingBad
//
//  Created by IACD-Air-2 on 2021/07/05.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var nameSurname: UILabel!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var dateOfBirth: UILabel!
    @IBOutlet weak var buttonNextView: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
