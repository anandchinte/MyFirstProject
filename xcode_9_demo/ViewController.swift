//
//  ViewController.swift
//  xcode_9_demo
//
//  Created by chinte, anand on 8/1/17.
//  Copyright © 2017 chinte, anand. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource {

    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var textfield: UITextField!
    var fetchdata: [Testing]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        //self.navigationController?.navigationBar
        // Do any additional setup after loading the view, typically from a nib.
        TableView.dataSource = self
        let apiCall = Apicalls.init()
        apiCall.GetNoAuthAccount() { isSuccess, fetchdata  in
            if isSuccess {
                print("Success")
                self.fetchdata = fetchdata
                self.TableView.reloadData()
            } else {
                print("Call failed")
            }
            
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let fetchdata = fetchdata else {
            return 0
        }
        return fetchdata.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableView.dequeueReusableCell(withIdentifier: "cell")
        guard let fetchdata = fetchdata else {
            return cell!
        }
        cell?.textLabel?.text = fetchdata[indexPath.row].plasticnumber
        cell?.detailTextLabel?.text = fetchdata[indexPath.row].numberofauth
        return cell!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func button(_ sender: Any) {
        
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! ViewControllerB
        
        destVC.nametodisplay = textfield.text!
    }
    
    @IBAction func showAlert(){
        
    }
    
}

