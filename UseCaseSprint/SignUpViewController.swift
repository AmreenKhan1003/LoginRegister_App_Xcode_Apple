//
//  SignUpViewController.swift
//  UseCaseSprint
//
//  Created by Capgemini-DA322 on 8/18/22.
//

import UIKit
import CoreData


class KeyChainManager{
    
    static func save(name: Data, email: String,  password: String) -> Bool{
    
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecValueData as String: name as AnyObject,
            kSecAttrService as String: email as AnyObject,
           //kSecAttrSerialNumber as String: mobile as AnyObject,
            kSecAttrAccount as String: password as AnyObject,
            
        ]
        if SecItemAdd(query as CFDictionary, nil) == noErr {
            print("User saved successfully in the keychain")
            return true
        } else {
            print("Something went wrong trying to save the user in the keychain")
            return false
        }
    }
    
}


class SignUpViewController: UIViewController {
    
    func callAlert(titles: String) -> Bool{
        if (titles == "Successful"){
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel) { (action) in
             // Respond to user selection of the action.
            }
            
            // Create and configure the alert controller.
            let alert = UIAlertController(title: titles,
                  message: "Your registration is completed",
                  preferredStyle: .alert)
            alert.addAction(cancelAction)
            
                 
            self.present(alert, animated: true) {
               // The alert was presented
            }
            return true
        }
        else{
        
           let cancelAction = UIAlertAction(title: "cancel",
                                style: .cancel) { (action) in
            // Respond to user selection of the action.
           }
           
           // Create and configure the alert controller.
           let alert = UIAlertController(title: titles,
                 message: "please provide valid details.",
                 preferredStyle: .alert)
           alert.addAction(cancelAction)
           
                
           self.present(alert, animated: true) {
              // The alert was presented
           }
            return true
        }
    }
    
    func isValidName(name: String) -> Bool {
        var result = true
        let nameRegEx = "^(?=.+[a-zA-Z]).{4,}$"
        do{
            let regex = try NSRegularExpression(pattern: nameRegEx)
            let nsString = name as NSString
            let results = regex.matches(in: name, range: NSRange(location: 0, length: nsString.length))
            if (results.count == 0){
                result = false
            }
            
        }
        catch (let error as NSError){
            result = false
            print(error.localizedDescription)
        }
        
        return result
    }
    
    //email id validation
    func isValidEmailID(email: String) -> Bool {
        var result = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        do{
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = email as NSString
            let results = regex.matches(in: email, range: NSRange(location: 0, length: nsString.length))
            if (results.count == 0){
                result = false
            }
            
        }
        catch (let error as NSError){
            result = false
            print(error.localizedDescription)
        }
        
        return result
    } //end of email id validation
    
    //Password validation
    func isvalidpassword(password: String) -> Bool{
        var result = true
        let passwordRegEx = "(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9]{6,}"
        do{
            let regex = try NSRegularExpression(pattern: passwordRegEx)
            let nsString = password as NSString
            let results = regex.matches(in: password, range: NSRange(location: 0, length: nsString.length))
            if (results.count == 0){
                result = false
            }
            
        }
        catch (let error as NSError){
            result = false
            print(error.localizedDescription)
        }
        return result
    }       //end of password validation
    
    @IBOutlet weak var nameTxtFld: UITextField!
    @IBOutlet weak var emailTextFld: UITextField!
    @IBOutlet weak var mobileTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var confirmPasswordTxtFld: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    
    func clearField(fieldName: String){
        switch (fieldName){
        case "name":
            nameTxtFld.text = ""
        case "email":
            emailTextFld.text = ""
        case "mobile":
            mobileTxtFld.text = ""
        case "password":
            passwordTxtFld.text = ""
            confirmPasswordTxtFld.text = ""
        case "all":
            nameTxtFld.text = ""
            emailTextFld.text = ""
            mobileTxtFld.text = ""
            passwordTxtFld.text = ""
            confirmPasswordTxtFld.text = ""
        default: break
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        super.title = "Sign Up"
    }
    

    

    @IBAction func signUpButtonClicked(_ sender: Any) {
        let name = nameTxtFld.text!
        let email = emailTextFld.text!
        let mobile = mobileTxtFld.text!
        let password = passwordTxtFld.text!
        let conpas = confirmPasswordTxtFld.text!
        
        //check if name is valid or not
        if(isValidName(name: name) == false){
            callAlert(titles: "Invalid Name")
            clearField(fieldName: "name")
            
            print("Name error")
        }
        else{
            //check if email is valid or not
            if(isValidEmailID(email: email) == false){
                callAlert(titles: "Invalid email")
                clearField(fieldName: "email")
                print("email error")
            }
            else{
                //check if mobile is valid or not
                if(mobile.count < 10){
                    callAlert(titles: "Invalid mobile")
                    clearField(fieldName: "mobile")
                    print("phone error")
                }
                else{
                    //check if password and confirm password is matching and is vaild contains uppercase + number + 6 or more long
                    if(conpas == password && isvalidpassword(password: password) != false){
                        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
                        let context = appDelegate.persistentContainer.viewContext
                        let EmpData = NSEntityDescription.insertNewObject(forEntityName: "EmployeeData", into: context) as! EmployeeData
                        
                        //check if provided email already exist in coreData
                        //flag = 1 if exist email flag = 0 if not exist
                        var flag = 0
                        do{
                            let edata = try context.fetch(EmployeeData.fetchRequest()) as! [EmployeeData]
                            //print(edata)
                            for data in edata{
                                let tomatchemail = data.emailData
                                
                                if(tomatchemail == email ){
                                    //email exist
                                    flag = 1
                                    //callAlert(titles: "Email Already Exist")
                                    break
                                    //print(tomatchemail)
                                }
                            }
                            //no same email present so enter data in coreData
                            if(flag == 0){
                                EmpData.nameData = name
                                EmpData.emailData = email
                                EmpData.mobileData = mobile
                                EmpData.passwordData = password
                                do{
                                    try context.save()
                                    print("Data has been stored")
                                }
                                catch {
                                    print("Cant load")
                                }
                                //if registration is completed
                                print("Done")
                                callAlert(titles: "Successful")
                                clearField(fieldName: "all")
                                
                                //enter data in keychain
                                
                                do{
                                    try KeyChainManager.save(name: Data(name.utf8), email: email, password: password)
                                }
                                catch{
                                    print("Key chain error\(error)")
                                }
                                 
                            }
                            else{
                                //flag is 1 than email exist
                                callAlert(titles: "Email exist")
                                clearField(fieldName: "email")
                            }
                        }
                        catch{
                            print("Error occured")
                        }
                        
                    }
                    else{
                        //if password is not as per standard
                        callAlert(titles: "check password")
                        clearField(fieldName: "password")
                        print("password error")
                    }
                    
                }
            }
        }
        
        
        
        
    }
}
