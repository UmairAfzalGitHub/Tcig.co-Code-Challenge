//
//  DateCollectionViewCell.swift
//  Tgic-Demo
//
//  Created by Umair Afzal on 09/10/2020.
//  Copyright © 2020 Tgic Co. All rights reserved.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateCircularView: UIView!
    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundImageView.clipsToBounds = true
    }

    func configureCell(selectedDates: CalendarDates, firstWeekDayOfMonth: Int, indexPath: IndexPath) {
        backgroundColor = .clear
        isUserInteractionEnabled = true
        let calculatedDate = indexPath.row-firstWeekDayOfMonth+2
        isHidden = false
        dateLabel.textColor = .white
        dateLabel.text="\(calculatedDate)"
        backgroundImageView.image = nil

        // user has only selected first date
        if indexPath == selectedDates.startDateIndex && selectedDates.endDateIndexPath == nil {
            backgroundImageView.image = #imageLiteral(resourceName: "bg_date_light")
            dateLabel.textColor = .black

        } else if indexPath.row >= selectedDates.startDateIndex?.row ?? -1 && indexPath.row <= selectedDates.endDateIndexPath?.row ?? -1 {
            backgroundColor = .white
            dateLabel.textColor = #colorLiteral(red: 0.2431372549, green: 0.3529411765, blue: 0.4078431373, alpha: 1)
        }
    }
    
    class func cellForCollectionView(collectionView: UICollectionView, indexPath: IndexPath) -> DateCollectionViewCell {
        let kDateCollectionViewCellIdentifier = "kDateCollectionViewCellIdentifier"
        collectionView.register(UINib(nibName: "DateCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: kDateCollectionViewCellIdentifier)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kDateCollectionViewCellIdentifier, for: indexPath) as! DateCollectionViewCell
        return cell
    }
}
