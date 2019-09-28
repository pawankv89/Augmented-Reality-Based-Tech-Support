//
//  ViewController.swift
//  Tech Support App
//
//  Created by Pawan kumar on 13/09/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//


import Foundation
import UIKit

class ViewController: UIViewController {
    
    //@IBOutlet weak var draw: UIButton!
    @IBOutlet weak var screenImageView: UIImageView!
    
    //Button Refresh Screen
    @IBOutlet var refreshScreenButton: UIButton!
    
    //Button Clear Object
    @IBOutlet var clearObjectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.screenImageView.isUserInteractionEnabled = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    
    }
    
   
}

extension ViewController {
    
    
}



//MARK: Refresh Reload Scrreen Button Fuctionality
extension ViewController {
    
    @IBAction func refreshScreenButton(_ sender: UIButton) -> () {
        
    }
}


//MARK: Clear Object Button Fuctionality
extension ViewController {
    
    @IBAction func clearObjectButton(_ sender: UIButton) -> () {
        
        
    }
}
