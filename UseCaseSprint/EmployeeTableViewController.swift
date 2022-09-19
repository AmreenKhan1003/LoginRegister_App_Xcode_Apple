//
//  EmployeeViewTableViewController.swift
//  UseCaseSprint
//
//  Created by Capgemini-DA322 on 8/18/22.
//

import UIKit
import CoreData
class EmployeeTableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var result:[EmployeeData] = []
    var dataTopass: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        navigationItem.hidesBackButton = true
        self.title = "Employees"
        fetch()
        /*
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        do{
            let edata = try context.fetch(EmployeeData.fetchRequest()) as! [EmployeeData]
            //print(edata)
            for data in edata{
                let tomatch: Optional<String> = data.emailData
                print(tomatch ?? "none")
            }
        }
        catch{
            print("Error occured")
        }
         */
    }
    
    
    func fetch () {
        let request = NSFetchRequest<EmployeeData>(entityName: "EmployeeData")
        do{
            result = try context.fetch(request)
        }
        catch{
            print("Fetch error")
        }
        
    }
       // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
*/
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return result.count
    }

    //lets add each data in each cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell", for: indexPath) as! EmployeeTableViewCell
        
        let rslt = result[indexPath.row]
        cell.nameLabel.text = rslt.nameData
        cell.emailLabel.text = rslt.emailData
        cell.mobileLabel.text = rslt.mobileData
        //dataTopass = rslt.nameData!
        

        // Configure the cell...

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rslt = result[indexPath.row]
        print(rslt.nameData!)
        dataTopass = rslt.nameData!
        print("did select row")
        let welcomevc = self.storyboard?.instantiateViewController(withIdentifier: "welcome") as! WelcomeViewController
        welcomevc.dummyname = dataTopass
        self.navigationController?.pushViewController(welcomevc, animated: true)
        
    }
   /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "welcome"{
            let displayvc = segue.destination as! WelcomeViewController
            print("prepare: \(dataTopass)")
            displayvc.dummyname = dataTopass
        }
    }
*/
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
