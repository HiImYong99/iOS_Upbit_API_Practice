//
//  RegisterController.swift
//  upbit_API
//
//  Created by 김용태 on 2023/01/18.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class RegisterController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var pwdText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailText.text, let password = pwdText.text {
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                if let e = error {
                    print(error!.localizedDescription)
                } else {
                    self!.performSegue(withIdentifier: Identy.RtoT, sender: self)
                }
            }
        }
    }
    
}
