//
//  ViewController.swift
//  SellOye
//
//  Created by Amey Kothavale on 24/02/18.
//  Copyright © 2018 Amey Kothavale. All rights reserved.
//

import UIKit
import TextFieldEffects
import Alamofire
import SlideMenuControllerSwift


class ViewController: UIViewController {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var usernameTextField: HoshiTextField!
    @IBOutlet weak var passwordTextField: HoshiTextField!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
   
    
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        
 
        let story = UIStoryboard(name : "Main" , bundle : nil)
        let VC = story.instantiateViewController(withIdentifier:"signUpVC")  as! signUpVC
        self.navigationController?.pushViewController(VC, animated: true)

    }
    
    override func viewDidAppear(_ animated: Bool) {
       // self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        iconImageView.frame = CGRect(x:self.view.frame.size.width / 2 - 50,y:70, width:100,height : 100)
        
        usernameTextField.frame = CGRect(x:20,y:iconImageView.frame.origin.y + iconImageView.frame.size.height + 30 ,width: self.view.frame.size.width - 40 ,height:50)
        
        passwordTextField.frame = CGRect(x:20,y:usernameTextField.frame.origin.y + usernameTextField.frame.size.height + 30 ,width: self.view.frame.size.width - 40 ,height:50)
        
        signinButton.frame = CGRect(x: 20,y:passwordTextField.frame.origin.y + passwordTextField.frame.size.height + 60 ,width:self.view.frame.size.width - 40,height:40)
        
        signupButton.frame = CGRect(x: signinButton.frame.size.width / 2 - 25,y:signinButton.frame.origin.y + signinButton.frame.size.height + 30 ,width:100,height:signupButton.bounds.size.height)
    }

    @IBAction func signInButtonPressed(_ sender: Any) {
        
        if !self .isValidEmail(testStr: usernameTextField.text!) {
            
            let alert = UIAlertController(title: nil, message: "Please enter a valid email id", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        else if passwordTextField.text!.count == 0 {
            
            let alert = UIAlertController(title: nil, message: "Please enter password", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        else{
            
            let url = "http://selloye.com/api/Api/login"
            
            let parameters: Parameters = ["username" : usernameTextField.text! , "password" : passwordTextField.text!]
            
            Alamofire.request(url, method:.post, parameters:parameters).responseJSON { response in
                switch response.result {
                case .success:
                    
                    let dic  = response.result.value as! [String : String]
                    UserDefaults.standard.setValue(dic, forKey: "allDetails")
                   
                    
                     let story = UIStoryboard(name : "Main" , bundle : nil)
                     let left = story.instantiateViewController(withIdentifier:"leftDrawer")  as! leftDrawer
                     let middle = story.instantiateViewController(withIdentifier:"dashboardVC")  as! dashboardVC
                     
                     SlideMenuOptions.leftViewWidth = 300
                     
                     let slideMenuController = SlideMenuController(mainViewController: middle, leftMenuViewController: left)
                     let appDel = UIApplication.shared.delegate as! AppDelegate
                     appDel.window?.rootViewController = slideMenuController
                     appDel.window?.makeKeyAndVisible()
                    
                case .failure(let error):
                    print(error)
                }
                
            } 
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func leftButtonPressed(_ sender: Any) {
        self.slideMenuController()?.openLeft()

    }
    
}

