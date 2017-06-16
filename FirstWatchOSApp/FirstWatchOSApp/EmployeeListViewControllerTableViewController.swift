//
//  EmployeeListViewControllerTableViewController.swift
//  FirstWatchOSApp
//
//  Created by avnish kumar on 14/06/17.
//  Copyright © 2017 avnish kumar. All rights reserved.
//

import UIKit
import WatchKit
import WatchConnectivity

class EmployeeListViewControllerTableViewController: UITableViewController {

    fileprivate var employeeArray = [Employee]()
    fileprivate let session = WCSession.default()
    override func viewDidLoad() {
        super.viewDidLoad()
        session.delegate = self
        session.activate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return employeeArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.employeeCustomCell, for: indexPath)
        if let employeeCell = cell as? CustomTableViewCell {
            
            employeeCell.employee = employeeArray[indexPath.row]
        }
        return cell
    }

    @IBAction func sendButtonAction(_ sender: UIBarButtonItem) {
        
        sendEmployeeDetails()
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationViewController = segue.destination as? EmployeeDetailViewController {
            
            destinationViewController.employeeDetailDelegate = self
        }
    }
    
    // MARK:- Check for a valid and paired session with watch.  If it will succeed then encode the employee array and send it to watch(session.sendMessage())
    
    private func sendEmployeeDetails() {
        
        if session.isReachable && session.isPaired {
            
            let jsonEncoder = JSONEncoder()
            var encodedEmployeeArray = Data()
            do {
                
                encodedEmployeeArray = try jsonEncoder.encode(employeeArray)
            }catch {
                print(error)
            }
            
            print(encodedEmployeeArray)
            session.sendMessage([Constant.employeeList:encodedEmployeeArray], replyHandler: { (replay) in
                
                print(replay)
            }, errorHandler: { (error) in
                print(error)
            })
            
        }
    }
}


extension EmployeeListViewControllerTableViewController: EmployeeDetailProtocol {
    
    //MARK:- Delegate method to update the array and reload the table
    func updateEmployeeData(employee:Employee) {
        
        employeeArray.append(employee)
        self.tableView.reloadData()
    }
}

extension EmployeeListViewControllerTableViewController:WCSessionDelegate {
    
    @available(iOS 9.3, *)
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    @available(iOS 9.3, *)
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
        
    }

}
