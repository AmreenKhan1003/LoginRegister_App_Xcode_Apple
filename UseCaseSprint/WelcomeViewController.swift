//
//  WelcomeViewController.swift
//  UseCaseSprint
//
//  Created by Capgemini-DA322 on 8/30/22.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var greet: UILabel!
    @IBOutlet weak var name: UILabel!
    var dummyname:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        greet.text = "To, "
        name.text = dummyname
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
