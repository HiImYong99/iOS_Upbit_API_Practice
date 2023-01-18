//
//  LoginController.swift
//  upbit_API
//
//  Created by 김용태 on 2023/01/18.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class LoginController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var pwdText: UITextField!
    
    @IBOutlet weak var logInFail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func logInPressed(_ sender: UIButton) {
        if let email = emailText.text, let password = pwdText.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                if let e = error {
                    print(error?.localizedDescription)
                    self!.logInFail.text = "아이디 혹은 비밀번호를 다시 확인하세요."
                } else {
                    self!.performSegue(withIdentifier: Identy.LtoT, sender: self)
                }
            }
        }
    }
    

}
