//
//  APICalls.swift
//  xcode_9_demo
//
//  Created by chinte, anand on 9/18/17.
//  Copyright © 2017 chinte, anand. All rights reserved.
//

import Foundation

class Apicalls: NSObject,URLSessionTaskDelegate{

    func updateAuthTxnCountToDB(name:String){
        
        var request = NSMutableURLRequest()
        var session = URLSession()
        let url: String = "http://ec2-54-208-249-57.compute-1.amazonaws.com/AddintoDB.php"
        (request, session) = requestHeadersforReports(API_EndPoint: url)
        //Creating Json Body
        let reqbody:NSMutableDictionary = [:]
        let screenshotarray:NSMutableArray = []
        let screensdict : NSMutableDictionary = [:]
        reqbody.setObject(screenshotarray, forKey: "Data" as NSCopying)
        screensdict.setValue(name, forKey: "Name")
        screenshotarray.add(screensdict)
        print(reqbody)
        do {
            let jsonpost = try JSONSerialization.data(withJSONObject: reqbody, options: [])
            request.httpBody = jsonpost
        } catch {
            print("error creating json")
        }
        var shouldkeeprunning = true
        
        let loopobj = RunLoop.current
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data,response,error in
            
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                print("Account Adding into DB Post call Status : \(statusCode)")
            }
            
            if error != nil {
                print("Account Adding into DB Post call Failed - Error: \(String(describing: error))")
            }
            shouldkeeprunning = false
        })
        task.resume()
        while shouldkeeprunning && loopobj.run(mode: RunLoopMode.defaultRunLoopMode, before: NSDate.distantFuture) {
            
        }
        
    }


    func requestHeadersforReports(API_EndPoint: String) -> (NSMutableURLRequest,URLSession) {
        
        
        let configuration = URLSessionConfiguration.default
        configuration.connectionProxyDictionary = [:]
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
        let request : NSMutableURLRequest = NSMutableURLRequest()
        print("API_EndPoint \(API_EndPoint)")
        request.url = NSURL(string: API_EndPoint) as URL?
        request.httpMethod = "POST"
        request.timeoutInterval = 100
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return (request, session)
    }
    
    //-------------------------GET CALL----------------------------
    func GetNoAuthAccount(completion:@escaping (_ isSuccessfull: Bool, _ fetchedData: [Testing]?) -> ()) {
        var fetchdata = [Testing]()
        var dataDictionary = NSDictionary()
        var request = NSMutableURLRequest()
        var session = URLSession()
        var plasticnumber:String = ""
        var noofauth:String = ""
        let url: String = "http://ec2-54-208-249-57.compute-1.amazonaws.com/SamplePage.php"
        (request, session) = requestHeadersforReports(API_EndPoint: url)
        request.httpMethod = "GET"
        var shouldkeeprunning = true
        let loopobj = RunLoop.current
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data,response,error in
            
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                print("StatusCode for GET Call \(statusCode)")
            }
            
            if error != nil {
                print("Error: \(String(describing: error))")
            }else{
                
                do{
                    dataDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    let rootArray : NSMutableArray = dataDictionary.object(forKey: "root") as! NSMutableArray
                    if (rootArray.count>0){
                        
                        
                        for eachrootArray in rootArray {
                            let data: NSDictionary = eachrootArray as! NSDictionary
                            if (data.object(forKey: "id") != nil){
                                plasticnumber = data.object(forKey: "id") as! String
                            }
                            if (data.object(forKey: "name") != nil){
                                noofauth = data.object(forKey: "name") as! String
                            }
                            
                            fetchdata.append(Testing(plasticnumber: plasticnumber, numberofauth: noofauth))
                            print("fetchdata: \(noofauth)")
                        }
                        
                    }
                    
                    
                    //print("jsonResultsOutput: \(plasticnumber)")
                } catch let error as NSError {
                    print(error)
                    completion(false, nil)
                }
                shouldkeeprunning = false
                
            }
           
        })
        task.resume()
        while shouldkeeprunning && loopobj.run(mode: RunLoopMode.defaultRunLoopMode, before: NSDate.distantFuture) {
            
        }
        completion(true, fetchdata)
    }
}


class Testing {
    var plasticnumber:String
    var numberofauth:String
    init(plasticnumber : String, numberofauth : String){
        self.plasticnumber = plasticnumber
        self.numberofauth = numberofauth
        
    }
}

