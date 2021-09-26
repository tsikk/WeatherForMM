//
//  DailyWeatherTableViewCell.swift
//  WeatherForMM
//
//  Created by Ilia Tsikelashvili on 26.09.21.
//

import UIKit

class DailyWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
