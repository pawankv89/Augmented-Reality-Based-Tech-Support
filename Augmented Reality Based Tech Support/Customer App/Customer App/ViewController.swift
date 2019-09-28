//
//  ViewController.swift
//  Customer App
//
//  Created by Pawan kumar on 13/09/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Button Video
    @IBOutlet var videoSupportButton: UIButton!
    
    //Button Lve
    @IBOutlet var liveSupportButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    
    @IBAction func videoSupportButtonTap(_ sender: UIButton) -> () {
        print("videoSupportButtonTap")
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let selfVideoSupportVC = storyboard.instantiateViewController(withIdentifier: "SelfVideoSupportVC") as! SelfVideoSupportVC
        self.navigationController!.pushViewController(selfVideoSupportVC, animated: true)
    }
    
    @IBAction func liveSupportButtonTap(_ sender: UIButton) -> () {
        print("liveSupportButtonTap")
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let realTimeCameraSupportVC = storyboard.instantiateViewController(withIdentifier: "RealTimeCameraSupportVC") as! RealTimeCameraSupportVC
        self.navigationController!.pushViewController(realTimeCameraSupportVC, animated: true)
    }
}
