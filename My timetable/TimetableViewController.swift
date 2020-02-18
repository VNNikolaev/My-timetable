//
//  TimetableViewController.swift
//  My timetable
//
//  Created by Васлий Николаев on 17.02.2020.
//  Copyright © 2020 Васлий Николаев. All rights reserved.
//

import UIKit


class TimetableViewController: UITableViewController {
    
    let networkService = NetworkService()
    var pickerView = UIPickerView()
    
    var allTraining: [Weekdays: [Training]] = [:]
    var training: [Training] = []
    var selectedDay = Weekdays(rawValue: 1){
        didSet {
            self.updateTableView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://sample.fitnesskit-admin.ru/schedule/get_group_lessons_v2/1/"
        
        networkService.fetchData(urlString: urlString) { [weak self] (result) in
            switch result {
            case .success(let training):
                for day in Weekdays.allCases {
                    self?.allTraining[day] = training.filter{ $0.weekDay == day.rawValue }
                }
                self?.training = (self?.allTraining[Weekdays(rawValue: 1)!]!)!
                self?.tableView.tableFooterView = UIView()
                self?.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return training.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TrainingCell
        
        let singleTraining = training[indexPath.row]
        cell.configure(with: singleTraining)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        selectedDay?.getTitle()
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    @IBAction func changeDayButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Выберите день", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        
        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
        
        alert.view.addSubview(pickerFrame)
        pickerFrame.dataSource = self
        pickerFrame.delegate = self
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil ))
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateTableView() {
        training = allTraining[selectedDay!]!
        self.tableView.tableFooterView = UIView()
        self.tableView.reloadData()
    }
}

extension TimetableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - Picker View
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Weekdays.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Weekdays(rawValue: row + 1)?.getTitle()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedDay = Weekdays(rawValue: min(7, max(1, row + 1)))
    }
}
