//
//  TimetableViewController.swift
//  My timetable
//
//  Created by Васлий Николаев on 17.02.2020.
//  Copyright © 2020 Васлий Николаев. All rights reserved.
//

import UIKit
import RealmSwift

class TimetableViewController: UITableViewController {
    
    var dataFromDB: Results<Training>!
    var notificationToken: NotificationToken? = nil
    
    let networkService = NetworkService()
    var pickerView = UIPickerView()
    
    var allTraining: [Weekdays: [Training]] = [:]
    var training: [Training] = []
    var secondArray: [Training] = []
    
    var selectedDay = Weekdays(rawValue: 1){
        didSet {
            self.updateTableView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alamofireRequest()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return training.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TrainingCell
        
        let singleTraining = training[indexPath.row]
        cell.configure(with: singleTraining)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return selectedDay?.getTitle()
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
        guard let day = selectedDay else {return }
        guard let selectedDayTraining = allTraining[day] else { return }
        training = selectedDayTraining
        
        self.tableView.tableFooterView = UIView()
        self.tableView.reloadData()
    }
    
    func alamofireRequest() {
        let urlString = "https://sample.fitnesskit-admin.ru/schedule/get_group_lessons_v2/1/"
        
        networkService.fetchData(urlString: urlString) { [weak self] (result) in
            switch result {
            case .success(let training):
                self?.secondArray = training
                self?.fetchDataFromDB()
                
                if self?.secondArray == self?.training {
                    self?.addDataInDictionary(training: self!.training)
                    self?.setupDefaultData()
                }
                else {
                    StorageManager.shared.deleteAll()
                    self?.training = self!.secondArray
                    StorageManager.shared.saveObject(self!.training)
                    self?.addDataInDictionary(training: self!.training)
                    self?.setupDefaultData()
                }
                
            case .failure(let error):
                print(error)
                self?.fetchDataFromDB()
                self?.addDataInDictionary(training: self!.training)
                self?.setupDefaultData()
            }
        }
    }
    
    func addDataInDictionary(training: [Training]) {
        for day in Weekdays.allCases {
            allTraining[day] = training.filter{ $0.weekDay == day.rawValue }
        }
    }
    
    func setupDefaultData() {
        guard let mondayTrainings = allTraining[.monday] else { return }
        training = mondayTrainings
        
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }
    
    func fetchDataFromDB() {
        dataFromDB = realm.objects(Training.self)
        for item in dataFromDB {
            training.append(item)
        }
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
