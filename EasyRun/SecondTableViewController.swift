//
//  TableViewController.swift
//  EasyRun
//
//  Created by sgcs on 2018. 5. 7..
//  Copyright © 2018년 sgcs. All rights reserved.
//

import UIKit
import FirebaseDatabase

//var urlschemelist = ["kakaotalk://","fb://","megabox://","Meloniphone://","http://maps.apple.com/?q"]
var installedapplist : [String] = []
var urls : [String] = []


class SecondTableViewController: UITableViewController {
    
    var ref:DatabaseReference!
    var refHandle:DatabaseHandle!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the firebase reference
        ref = Database.database().reference()
        
        //Retrieve the urls and listen for changes
        refHandle = ref.child("URLs").observe(.childAdded, with: {(snapshot) in
                let urlscheme = snapshot.value as? String
                //print(urlscheme)
            
                if let realscheme = urlscheme{

                    //print(realscheme)

                    urls.append(realscheme)
                   // self.tableView.reloadData()
                    
                  //  print(urls)
                }
            
            
            if urls.count == 5 {
                if installedapplist.count == 0 {
                    //for index in urlschemelist{
                    for index in urls{
                        //print(index)
                        if UIApplication.shared.canOpenURL(NSURL(string: index)! as URL){
                            installedapplist.append(index)
                        }
                    }
                    print(installedapplist)
                    self.tableView.reloadData()

                }
            }
        })
            
 
        
        /*
        if installedapplist.count == 0 {
            //for index in urlschemelist{
            for index in urls{
                //print(index)
                if UIApplication.shared.canOpenURL(NSURL(string: index)! as URL){
                    installedapplist.append(index)
                }
            }
        }
        */
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
    
        return installedapplist.count
        //return urls.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell2", for: indexPath)
        
        // Configure the cell...
        
        cell.textLabel?.text = installedapplist[(indexPath as NSIndexPath).row]
        //cell.textLabel?.text = itemsImageFile[(indexPath as NSIndexPath).row]
        
        return cell
    }
    
    
    
    
}