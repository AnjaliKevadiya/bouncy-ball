//
//  StartAgainVC.swift
//  BouncyBall
//
//  Created by Anjali Kevadiya on 2/15/19.
//  Copyright © 2019 Anjali Kevadiya. All rights reserved.
//

import UIKit

class StartAgainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startAgainButtonClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
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
