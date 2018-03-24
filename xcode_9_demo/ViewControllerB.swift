//
//  ViewControllerB.swift
//  xcode_9_demo
//
//  Created by chinte, anand on 8/1/17.
//  Copyright © 2017 chinte, anand. All rights reserved.
//

import UIKit

class ViewControllerB: UIViewController {

    @IBOutlet weak var namelabel: UILabel!
    
    var nametodisplay = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let apiCall = Apicalls.init()
        apiCall.updateAuthTxnCountToDB(name: nametodisplay)
        namelabel.text = nametodisplay
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
