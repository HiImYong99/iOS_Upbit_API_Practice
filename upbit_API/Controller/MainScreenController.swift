//
//  MainScreenController.swift
//  upbit_API
//
//  Created by 김용태 on 2023/01/18.
//

import UIKit

class MainScreenController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func registerPressed(_ sender: UIButton) {
        performSegue(withIdentifier: Identy.mToR, sender: self)
    }
    
    @IBAction func logInPressed(_ sender: Any) {
        performSegue(withIdentifier: Identy.mToL, sender: self)
        
    }
    
}
