//
//  CalendarViewController.swift
//  Tgic-Demo
//
//  Created by Umair Afzal on 09/10/2020.
//  Copyright © 2020 Tgic Co. All rights reserved.
//

import UIKit

protocol CalendarViewControllerDeleagte {
    func didSelectDate(selectedDates: CalendarDates)
}

class CalendarDates {
    var startDate: String?
    var endDate: String?
    var startDateIndex: IndexPath?
    var endDateIndexPath: IndexPath?
}

class CalendarViewController: UIViewController {

    // MARK: - Variables & Constants

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var topMonthButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backgroundView: UIView!

    var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    var numOfDaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    var currentMonthIndex: Int = 0
    var currentYear: Int = 0
    var presentMonthIndex = 0
    var presentYear = 0
    var todaysDate = 0
    var firstWeekDayOfMonth = 0 //(Sunday-Saturday 1-7)

    var delegate: CalendarViewControllerDeleagte?
    var selectedDates = CalendarDates()

    // MARK: - UIViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllerUI()
        setupCalendar()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
        backgroundView.applyGradient(colors: [#colorLiteral(red: 0.5568390489, green: 0.4392440617, blue: 0.5254263282, alpha: 1).cgColor, #colorLiteral(red: 0.2862224579, green: 0.3647295833, blue: 0.4234738946, alpha: 1).cgColor], locations: [0.0, 1.0], direction: .leftToRight, isFullFrame: true, isCircular: true)
    }

    // MARK: - UIViewController Helper Methods

    func setupCalendar() {
        currentMonthIndex = Calendar.current.component(.month, from: Date())
        currentMonthIndex -= 1 // because apple calendar returns months starting from 1

        currentYear = Calendar.current.component(.year, from: Date())
        todaysDate = Calendar.current.component(.day, from: Date())
        firstWeekDayOfMonth = getFirstWeekDay()

        //for leap years, make february month of 29 days
        if currentMonthIndex == 1 && currentYear % 4 == 0 {
            numOfDaysInMonth[currentMonthIndex] = 29
        }
        //end
        presentMonthIndex = currentMonthIndex
        presentYear = currentYear

        // display current month name in title
        topMonthButton.setTitle("\(months[currentMonthIndex]) \(currentYear)", for: .normal)
        leftButton.isEnabled = !(currentMonthIndex == presentMonthIndex && currentYear == presentYear) // Disable left button if user is on current month
    }

    func setupViewControllerUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    // MARK: - IBActions

    @IBAction func doneButtonTapped(_ sender: Any) {
        self.delegate?.didSelectDate(selectedDates: selectedDates)
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func leftButtonTapped(_ sender: Any) {
        currentMonthIndex -= 1

        if currentMonthIndex < 0 {
            currentMonthIndex = 11
            currentYear -= 1
        }

        topMonthButton.setTitle("\(months[currentMonthIndex]) \(currentYear)", for: .normal)

        //for leap year, make february month of 29 days
        if currentMonthIndex == 1 {

            if currentYear % 4 == 0 {
                numOfDaysInMonth[currentMonthIndex] = 29

            } else {
                numOfDaysInMonth[currentMonthIndex] = 28
            }
        }
        //end

        leftButton.isEnabled = !(currentMonthIndex == presentMonthIndex && currentYear == presentYear)// Disable left button if user is on current month
        firstWeekDayOfMonth = getFirstWeekDay()
        resetSelectedDates()
        collectionView.reloadData()
    }

    @IBAction func rightButtonTapped(_ sender: Any) {
        currentMonthIndex += 1

        if currentMonthIndex > 11 {
            currentMonthIndex = 0
            currentYear += 1
        }

        topMonthButton.setTitle("\(months[currentMonthIndex]) \(currentYear)", for: .normal)

        //for leap year, make february month of 29 days
        if currentMonthIndex == 1 {

            if currentYear % 4 == 0 {
                numOfDaysInMonth[currentMonthIndex] = 29

            } else {
                numOfDaysInMonth[currentMonthIndex] = 28
            }
        }
        //end
        leftButton.isEnabled = !(currentMonthIndex == presentMonthIndex && currentYear == presentYear)// Disable left button if user is on current month
        firstWeekDayOfMonth = getFirstWeekDay()
        resetSelectedDates()
        collectionView.reloadData()
    }

    // Private Methods

    private func getFirstWeekDay() -> Int {
        if let day = ("\(currentYear)-\(currentMonthIndex+1)-01".date?.firstDayOfTheMonth.weekday) {
            return day
        }

        return 1
    }

    private func resetSelectedDates() {
        selectedDates.endDate =  nil
        selectedDates.startDateIndex = nil
        selectedDates.endDateIndexPath = nil
        selectedDates.startDate = nil
    }
}

extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfDaysInMonth[currentMonthIndex] + firstWeekDayOfMonth - 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = DateCollectionViewCell.cellForCollectionView(collectionView: collectionView, indexPath: indexPath)

        if indexPath.item <= firstWeekDayOfMonth - 2 {
            cell.isHidden = true
            cell.isUserInteractionEnabled = false
            return cell
        }

        cell.configureCell(selectedDates: selectedDates, firstWeekDayOfMonth: firstWeekDayOfMonth, indexPath: indexPath)
        return cell
    }

    // MARK: - UICollectionView Delegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? DateCollectionViewCell
        cell?.backgroundImageView.image = #imageLiteral(resourceName: "bg_date_light")
        cell?.dateLabel.textColor = .black

        // user is trying to select first date again
        if selectedDates.endDate != nil {
            resetSelectedDates()
            collectionView.reloadData()
            doneButton.isEnabled = false
            return
        }

        guard let day = cell?.dateLabel.text else { return }

        let dateString = "\(day)-\(months[currentMonthIndex])-\(currentYear)"

        if selectedDates.startDate == nil {
            selectedDates.startDate = dateString
            selectedDates.startDateIndex = indexPath
            collectionView.reloadItems(at: [indexPath])
            return
        } else if selectedDates.endDate == nil {
            selectedDates.endDate = dateString
            selectedDates.endDateIndexPath = indexPath
            doneButton.isEnabled = true
        }

        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? DateCollectionViewCell
        cell?.backgroundImageView.image = nil
        cell?.dateLabel.textColor = .white
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/7 , height: collectionView.frame.width/7 )
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
