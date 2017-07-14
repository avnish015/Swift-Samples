//
//  ViewController.swift
//  TableViewSample
//
//  Created by avnish kumar on 28/06/17.
//  Copyright © 2017 avnish kumar. All rights reserved.
//

import UIKit

protocol StudentDataUpdate:class {
    
    func updateStudentDataInTable(student:Student)
}

class ViewController: UIViewController {

    var arrayOfStudentObject = [Student]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? AddStudentViewController {
            
            destination.addStudentDelegate = self
        }
    }

    @IBAction func switchAction(_ sender: UISwitch) {
        
        print(sender.isOn)
    }
    @IBAction func segmentControllerSelected(_ sender: UISegmentedControl) {
        
        print(sender.selectedSegmentIndex)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayOfStudentObject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as? CustomTableViewCell {
            
            cell.label.text = arrayOfStudentObject[indexPath.row].name
            cell.imageView?.image = arrayOfStudentObject[indexPath.row].photo
            return cell
        }
        return UITableViewCell()
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
}
extension ViewController:StudentDataUpdate {
    
    func updateStudentDataInTable(student: Student) {
        
        arrayOfStudentObject.append(student)
        tableView.reloadData()
    }
}

