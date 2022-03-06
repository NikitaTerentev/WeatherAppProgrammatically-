//
//  TableViewCell.swift
//  WeatherAppProgrammatically
//
//  Created by Nikita on 21.02.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    
        var cityLabel = UILabel()
        var tempLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.font = UIFont.systemFont(ofSize: 12)
        tempLabel.font = UIFont.systemFont(ofSize: 12)
        
        contentView.addSubview(cityLabel)
        contentView.addSubview(tempLabel)
        
        NSLayoutConstraint.activate([
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            tempLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16)
        ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with tempCity: Weather?) {
        cityLabel.text = tempCity?.name
        if let temp = tempCity?.main.temp {
            tempLabel.text = String(format: "%.0f", temp.kelvinToCelsius) + "˚C"
        } else {
            tempLabel.text = nil 
        }
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
