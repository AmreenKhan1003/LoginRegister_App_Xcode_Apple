//
//  ViewController.swift
//  UseCaseSprint
//
//  Created by Capgemini-DA322 on 8/18/22.
//

import UIKit
import CoreData
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    //var edata = [EmployeeData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        super.title = "Login"
        //deleteItem()
        //passcodeAuthentication()
        faceIDAuthentication()
    }
    
    //passcode aukthentication
    func passcodeAuthentication(){
        
        let context = LAContext()
        var authenticateError: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authenticateError){
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Authenticate to access", reply: {
                (success, error) in
                DispatchQueue.main.sync {
                    if success{
                        //self.showAlert
                        print("Successfull")
                    }
                    else{
                        if let error = error {
                            print("Failed \(error.localizedDescription)")
                        }
                    }
                }
            })
        }
        
    }
    
    //Face ID authentication
    
    func faceIDAuthentication(){
        
        let context = LAContext()
        var authenticateError: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authenticateError){
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authenticate to access") { success, error in
                DispatchQueue.main.sync {
                    if success{
                        print("success")
                    }
                    else{
                        if let error = error {
                            print("Failed \(error.localizedDescription)")
                        }
                    }
                }
            }
            
        }
    }
    
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        let email = emailTxtFld.text!
        let password = passwordTxtFld.text!
        //flag will be 1 if data is present or else remain 0
        var flag = 0
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        do{
            //fetch the data present in Coredata
            let edata = try context.fetch(EmployeeData.fetchRequest()) as! [EmployeeData]
            //print(edata)
            for data in edata{
                //Match each row of the CoreData with the provided data of user that is email and password
                let tomatchemail = data.emailData
                let tomatchpass = data.passwordData
                if(tomatchemail == email && tomatchpass == password){
                    flag = 1
                    break
                }
            }
        }
        catch{
            print("Error occured")
        }
        
        if(flag == 1 ){
            //flag will be 1 so Data of employee will be displayed
            let employeeVC = self.storyboard?.instantiateViewController(withIdentifier: "EmpVC") as! EmployeeTableViewController
            self.navigationController?.pushViewController(employeeVC, animated: true)
        }
        else{
            //flag remain 0 So alert will be displayed
            let cancelAction = UIAlertAction(title: "cancel",
                                 style: .cancel) { (action) in
             // Respond to user selection of the action.
            }
            
            // Create and configure the alert controller.
            let alert = UIAlertController(title: "Failed",
                  message: "please provide valid details.",
                  preferredStyle: .alert)
            alert.addAction(cancelAction)
            
                 
            self.present(alert, animated: true) {
               // The alert was presented
            }
        }
    }
    
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        let signVC = self.storyboard?.instantiateViewController(withIdentifier: "signVC") as! SignUpViewController
        self.navigationController?.pushViewController(signVC, animated: true)
    }
    
    @IBAction func forgotPasswordClicked(_ sender: Any) {
        let forgotpassvc = self.storyboard?.instantiateViewController(withIdentifier: "forgotpass") as! ForgotPassViewController
        forgotpassvc.eml = emailTxtFld.text
        self.navigationController?.pushViewController(forgotpassvc, animated: true)
    }
    
    /*
    func deleteItem() {
        // Delete the user-selected item from the context
        let store = (UIApplication.shared.delegate) as! AppDelegate
        let viewContext = store.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<EmployeeData> = EmployeeData.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "emailData == nil")

        if let result = try? viewContext.fetch(fetchRequest) {
            for object in result {
                viewContext.delete(object)
            }
        }

        do {
            try viewContext.save()
        } catch {
            //Handle error
            print("Error while deleting")
        }
        // Delete the user-selected item from the data source
        

        // Save changes to the Managed Object Context
        //store.saveContext()
    }
    
}*/
}

