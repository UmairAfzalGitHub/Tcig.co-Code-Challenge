//
//  SearchPageViewController.swift
//  Tgic-Demo
//
//  Created by Umair Afzal on 09/10/2020.
//  Copyright © 2020 Tgic Co. All rights reserved.
//

import UIKit

class SearchPageViewController: BaseViewController {

    // MARK: - IBOutlets and Variables
    
    @IBOutlet weak var topRoundedView: UIView!

    @IBOutlet weak var packageView: UIView!
    @IBOutlet weak var hotelView: UIView!
    @IBOutlet weak var destinationsView: UIView!
    @IBOutlet weak var packageLabel: UILabel!
    @IBOutlet weak var hotelLabel: UILabel!
    @IBOutlet weak var destinationsLabel: UILabel!
    @IBOutlet weak var packageImageView: UIImageView!
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var destinationImageView: UIImageView!
    
    @IBOutlet weak var fromDropDownTextField: DropDownTextField!
    @IBOutlet weak var toDropDownTextField: DropDownTextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var classTextField: UITextField!
    
    let classPickerView = UIPickerView()

    var viewModel = SearchPageViewModel()

    // MARK: - UIViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.getAirports()
        configureControls()
        setupGestures()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        view.applyGradient(colors: [#colorLiteral(red: 0.5568390489, green: 0.4392440617, blue: 0.5254263282, alpha: 1).cgColor, #colorLiteral(red: 0.2862224579, green: 0.3647295833, blue: 0.4234738946, alpha: 1).cgColor], locations: [0.0, 1.0], direction: .leftToRight)
        topRoundedView.roundedCorners(corners:  [.topLeft , .topRight] )
    }

    private func setupGestures() {
        let packageTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPackageView))
        let hotelTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapHotelView))
        let destinationsTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapDestinationsView))

        packageView.addGestureRecognizer(packageTapGesture)
        hotelView.addGestureRecognizer(hotelTapGesture)
        destinationsView.addGestureRecognizer(destinationsTapGesture)
    }

    private func configureControls() {
        // The list of array to display. Can be changed dynamically
        fromDropDownTextField.optionArray = viewModel.airports
        toDropDownTextField.optionArray = viewModel.airports

        // The the Closure returns Selected Index and String
        fromDropDownTextField.didSelect{(selectedValue , index) in
            self.fromDropDownTextField.text = "\(selectedValue.name) (\(selectedValue.code))"
        }

        toDropDownTextField.didSelect{(selectedValue , index) in
            self.toDropDownTextField.text = "\(selectedValue.name) (\(selectedValue.code))"
        }

        // setup class pickerView
        classPickerView.delegate = self
        classTextField.inputView = classPickerView

        dateTextField.delegate = self
        dateTextField.inputView = nil
    }

    private func setSelectedView(view: UIView, label: UILabel, select: Bool, imageView: UIImageView) {
        if select {
            view.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.3529411765, blue: 0.4078431373, alpha: 1)
            label.textColor = .white
            imageView.tintColor = .white
        } else {
            view.backgroundColor = .white
            label.textColor = #colorLiteral(red: 0.2431372549, green: 0.3529411765, blue: 0.4078431373, alpha: 1)
            imageView.tintColor = #colorLiteral(red: 0.2431372549, green: 0.3529411765, blue: 0.4078431373, alpha: 1)
        }
    }

    // MARK: Selectors

    @objc func didTapPackageView() {
        setSelectedView(view: packageView, label: packageLabel, select: true, imageView: packageImageView)
        setSelectedView(view: hotelView, label: hotelLabel, select: false, imageView: hotelImageView)
        setSelectedView(view: destinationsView, label: destinationsLabel, select: false, imageView: destinationImageView)
    }

    @objc func didTapHotelView() {
        setSelectedView(view: packageView, label: packageLabel, select: false, imageView: packageImageView)
        setSelectedView(view: hotelView, label: hotelLabel, select: true, imageView: hotelImageView)
        setSelectedView(view: destinationsView, label: destinationsLabel, select: false, imageView: destinationImageView)
    }

    @objc func didTapDestinationsView() {
        setSelectedView(view: packageView, label: packageLabel, select: false, imageView: packageImageView)
        setSelectedView(view: hotelView, label: hotelLabel, select: false, imageView: hotelImageView)
        setSelectedView(view: destinationsView, label: destinationsLabel, select: true, imageView: destinationImageView)
    }
}

extension SearchPageViewController: UIPickerViewDelegate, UIPickerViewDataSource {

     func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
     }

     func pickerView( _ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.travelClasses.count
     }

     func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.travelClasses[row]
     }

     func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        classTextField.text = viewModel.travelClasses[row]
     }
}

extension SearchPageViewController: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == dateTextField {
            let calendarViewController = CalendarViewController()
            calendarViewController.delegate = self
            self.present(calendarViewController, animated: true, completion: nil)
            return false
        }

        return true
    }
}

extension SearchPageViewController: CalendarViewControllerDeleagte {

    func didSelectDate(selectedDates: CalendarDates) {
        if let startDate = selectedDates.startDate, let endDate = selectedDates.endDate {
            dateTextField.text = "\(startDate) - \(endDate)"
        }
    }
}
