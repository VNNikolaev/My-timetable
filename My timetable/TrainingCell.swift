//
//  TrainingCell.swift
//  My timetable
//
//  Created by Васлий Николаев on 17.02.2020.
//  Copyright © 2020 Васлий Николаев. All rights reserved.
//

import UIKit

class TrainingCell: UITableViewCell {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var teacherNameLabel: UILabel!
    @IBOutlet weak var trainingNameLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var payIndicatorView: UIImageView!
    
    func configure(with singleTrainig: Training){
        locationLabel.text = singleTrainig.place
        teacherNameLabel.text = singleTrainig.teacher_v2.short_name
        trainingNameLabel.text = "\(singleTrainig.name)" + " \(singleTrainig.weekDay)"
        startTimeLabel.text = singleTrainig.startTime
        endTimeLabel.text = singleTrainig.endTime
        
        if !singleTrainig.pay {
            payIndicatorView.isHidden = true
        }
        
        let gradientLayer = CAGradientLayer()
        colorView.layer.insertSublayer(gradientLayer, at: 0)
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.colors = [UIColor(ciColor: CIColor(string: singleTrainig.color)).cgColor, UIColor.white.cgColor]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.colorView.bounds.size.width, height: self.colorView.bounds.size.height)
        gradientLayer.locations = [0.5, 1]
        
        colorView.backgroundColor = UIColor(ciColor: CIColor(string: singleTrainig.color))
    }
}
