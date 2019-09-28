//
//  RealTimeCameraSupportVC.swift
//  Customer App
//
//  Created by Pawan kumar on 19/09/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import Foundation
import UIKit
import SceneKit
import ARKit

class RealTimeCameraSupportVC: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    var displayLink: CADisplayLink?
    
    var imagerecivedforcompressed: Bool = false
    var imagecompressed: Bool = false
    var senndImageInSecondMax: Int = 2
    
    //Button Play / Pause
    @IBOutlet var playPauseButton: UIButton!
    
    //Button Clear Object
    @IBOutlet var clearObjectButton: UIButton!
    
    //Button Torch
    @IBOutlet var torchButton: UIButton!
    
    //Color
    let customerDrawingLineColor: UIColor = .red
    let supportDrawingLineColor: UIColor = .yellow
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation Back Button
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.done , target: self, action: #selector(self.backButtonTapped(_:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        self.configurationPlayPauseButton()
        
        //Connfiguration ARKit
        self.configurationARKit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    @objc func backButtonTapped(_ sender:UIButton)
    {
        //Close All Functionality
    
        //Stop Capture Screen
        self.stop()
        
        //Go Back
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - ARSCNViewDelegate
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

//MARK: Touch Delegate
extension RealTimeCameraSupportVC {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //Only One Touch recived at a time
    }
}

extension RealTimeCameraSupportVC {
    
    func configurationARKit() {
        
        setupScene()
        
        start()
    }
    
    
    @objc func displayLinkDidFire(timer: CADisplayLink) {
        // Our capturer polls the ARSCNView's snapshot for processed AR video content, and then copies the result into a CVPixelBuffer.
        // This process is not ideal, but it is the most straightforward way to capture the output of SceneKit.
        let myImage = self.sceneView.snapshot
    
    }
    
    func setupScene() {
        sceneView.delegate = self
        sceneView.session = sceneView.session
        sceneView.antialiasingMode = .multisampling4X
        sceneView.automaticallyUpdatesLighting = false
        
        sceneView.preferredFramesPerSecond = 5
        sceneView.contentScaleFactor = 1
        //sceneView.showsStatistics = true
        
        if let camera = sceneView.pointOfView?.camera {
            camera.wantsHDR = false
            camera.wantsExposureAdaptation = true
            camera.exposureOffset = -1
            camera.minimumExposure = -1
            
        }
    }
    
    
    func start() {
        // Starting capture is a two step process. We need to start the ARSession and schedule the CADisplayLinkTimer.
        //let configuration = ARWorldTrackingConfiguration()
        //sceneView.session.run(configuration)
        
        self.displayLink = CADisplayLink(target: self, selector: #selector(self.displayLinkDidFire))
        self.displayLink?.preferredFramesPerSecond = self.sceneView.preferredFramesPerSecond
        displayLink?.add(to: RunLoop.main, forMode: RunLoop.Mode.common)
        
    }
    
    func stop() {
        self.displayLink?.invalidate()
        self.sceneView.session.pause()
    }
    
}

//MARK: Play Pause Button Fuctionality
extension RealTimeCameraSupportVC {
    
    func configurationPlayPauseButton() {
        
        if self.playPauseButton == nil {return}
        
        //Play and Selected when Pressed Button
        self.playPauseButton.isSelected = true
    }
    
    @IBAction func playPauseButton(_ sender: UIButton) -> () {
        
        if sender.isSelected == false {
            //Play and Selected when Pressed Button
            sender.isSelected = true
            
            self.start()
            
        } else {
            //Paused when Pressed Button
            sender.isSelected = false
            
            self.stop()
            
        }
    }
}

//MARK: Clear Object Button Fuctionality
extension RealTimeCameraSupportVC {
    
    @IBAction func clearObjectButton(_ sender: UIButton) -> () {
        
        //Remove All Pointer on screen
        self.sceneView.scene.rootNode.enumerateChildNodes({ (node, _) in
            if node.name == "pointer" {
                node.removeFromParentNode()
            }
        })
        
    }
}


//MARK: Torch Enable or Disable Button Fuctionality
extension RealTimeCameraSupportVC {
    
    @IBAction func torchButton(_ sender: UIButton) -> () {
        
        sender.isSelected = !sender.isSelected
        toggleTorch(on: sender.isSelected)
    }
    
    func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                
                if on == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }
                
                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
}


