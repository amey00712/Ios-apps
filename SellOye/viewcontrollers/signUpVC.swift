//
//  signUpVC.swift
//  SellOye
//
//  Created by Amey Kothavale on 24/02/18.
//  Copyright © 2018 Amey Kothavale. All rights reserved.
//

import UIKit
import TextFieldEffects
import Alamofire

class signUpVC: UIViewController {

    @IBOutlet weak var nameTextField: HoshiTextField!
    @IBOutlet weak var emailTextField: HoshiTextField!
    @IBOutlet weak var passwordTextField: HoshiTextField!
    @IBOutlet weak var mobileTextField: HoshiTextField!
    @IBOutlet weak var companyTextField: HoshiTextField!
    @IBOutlet weak var addressTextField: HoshiTextField!
    @IBOutlet weak var cityTextField: HoshiTextField!
    @IBOutlet weak var pincodeTextField: HoshiTextField!
    @IBOutlet weak var gstTextField: HoshiTextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
    
       
     
        
       
        
        
       
        if nameTextField.text!.count < 2 {
            let alert = UIAlertController(title:nil, message: "Please enter your full name", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
       else if !self .isValidEmail(testStr: emailTextField.text!) {
            
            let alert = UIAlertController(title: nil, message: "Please enter a valid email id", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
       else if passwordTextField.text?.count == 0 {
            let alert = UIAlertController(title: nil, message: "Password cannot be empty", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        else if mobileTextField.text!.count != 10 {
            let alert = UIAlertController(title: nil, message: "Mobile number should be of 10 digits", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        else if companyTextField.text!.count == 0 {
            let alert = UIAlertController(title: nil, message: "Please enter your company name", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        else if addressTextField.text!.count == 0 {
            let alert = UIAlertController(title: nil, message: "Please enter your address", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        else if cityTextField.text!.count == 0 {
            let alert = UIAlertController(title: nil, message: "Please enter your city", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        else if pincodeTextField.text!.count == 0 {
            let alert = UIAlertController(title: nil, message: "Please enter your area's pincode", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        else{
            
             let parameters: Parameters = ["full_name":nameTextField.text!,"email":emailTextField.text!,"phone":mobileTextField.text!,"city":cityTextField.text!,"pincode":pincodeTextField.text!,"address":addressTextField.text!,"company":companyTextField.text!,"gst_no":gstTextField.text!]
             
             let url = "http://selloye.com/api/Api/registeration"
             
             Alamofire.request(url, method:.post, parameters:parameters).responseJSON { response in
             switch response.result {
             case .success:
             
                let dic  = response.result.value as! [String : String]
                print(dic["status"]!)
                
                let alert = UIAlertController(title: nil, message: dic["status"]!, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
             case .failure(let error):
             print(error)
             }
             
             }
        }
        
        
    
    }
    
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
         nameTextField.frame = CGRect(x:20,y: 90 ,width: self.view.frame.size.width - 40 ,height:50)
        
        emailTextField.frame = CGRect(x:20,y:nameTextField.frame.origin.y + nameTextField.frame.size.height + 10 ,width: self.view.frame.size.width - 40 ,height:50)
        
        passwordTextField.frame = CGRect(x:20,y:emailTextField.frame.origin.y + emailTextField.frame.size.height + 10 ,width: self.view.frame.size.width - 40 ,height:50)
        
        mobileTextField.frame = CGRect(x:20,y:passwordTextField.frame.origin.y + passwordTextField.frame.size.height + 10 ,width: nameTextField.frame.size.width / 2 - 5 ,height:50)
        
        
        gstTextField.frame = CGRect(x:mobileTextField.frame.origin.x + mobileTextField.frame.size.width + 10,y:passwordTextField.frame.origin.y + passwordTextField.frame.size.height + 10 ,width: mobileTextField.frame.size.width,height:50)

        
        companyTextField.frame = CGRect(x:20,y:mobileTextField.frame.origin.y + mobileTextField.frame.size.height + 10 ,width: self.view.frame.size.width - 40 ,height:50)
        
        addressTextField.frame = CGRect(x:20,y:companyTextField.frame.origin.y + companyTextField.frame.size.height + 10 ,width: self.view.frame.size.width - 40 ,height:50)
        
        cityTextField.frame = CGRect(x:20,y:addressTextField.frame.origin.y + addressTextField.frame.size.height + 10 ,width: addressTextField.frame.size.width / 2 - 5,height:50)
        
        pincodeTextField.frame = CGRect(x:cityTextField.frame.origin.x + cityTextField.frame.size.width + 10,y:addressTextField.frame.origin.y + addressTextField.frame.size.height + 10 ,width: cityTextField.frame.size.width,height:50)
        
        signUpButton.frame = CGRect(x: 20,y:pincodeTextField.frame.origin.y + pincodeTextField.frame.size.height + 60 ,width:self.view.frame.size.width - 40,height:40)


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
