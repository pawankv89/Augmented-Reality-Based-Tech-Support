//
//  SelfVideoSupportVC.swift
//  Customer App
//
//  Created by Pawan kumar on 18/09/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import Foundation
import UIKit
import SceneKit
import ARKit
import AVKit

class SelfVideoSupportVC: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    @IBOutlet var videoView: UIView!
    
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var playButton:UIButton?
    var closeButton:UIButton?
    var displayNameLabel:UILabel?
    var playButtonEnabled: Bool = false
    var videoViewEnabled: Bool = false
    
    
    //Video Helpful View
    var helpfulView: UIView?
    var helpfulLabel: UILabel?
    var helpfulYesButton: UIButton?
    var helpfulNoButton: UIButton?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //Navigation Back Button
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.done , target: self, action: #selector(self.backButtonTapped(_:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        // Set the view's background color
        self.videoView.backgroundColor = .black
        self.videoView.isHidden = !videoViewEnabled
        
        // Set the view's delegate
        sceneView.delegate = self
        
        //Play Video
        //self.playClearPaperJamVideo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        //let configuration = ARImageTrackingConfiguration()
        
        let configuration = ARWorldTrackingConfiguration()
        
        // first see if there is a folder called "ARImages" Resource Group in our Assets Folder
        if let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: Bundle.main) {
            
            // if there is, set the images to track
            configuration.detectionImages = trackedImages
            //configuration.trackingImages = trackedImages
            // at any point in time, only 1 image will be tracked
            //configuration.maximumNumberOfTrackedImages = 1
        }
        
        let options: ARSession.RunOptions = [.resetTracking, .removeExistingAnchors]
        sceneView.session.run(configuration, options: options)
        
        // Run the view's session
        //sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    
     // Override to create and configure nodes for anchors update to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        //Contious calling
        
        if videoViewEnabled == true {return}
        
        // if the anchor is not of type ARImageAnchor (which means image is not detected), just return
        guard let imageAnchor = anchor as? ARImageAnchor else {return}
        let imageName: String = imageAnchor.referenceImage.name!
        if  imageName == "paperjam_3" || imageName == "paperjam_4" || imageName == "paperjam_5" || imageName == "paperjam_7" || imageName == "paperjam_8" || imageName == "paperjam_9" {
            
            //imageName == "paperjam" || imageName == "paperjam_1" || imageName == "paperjam_2" ||
            
            guard let fileUrlString = Bundle.main.path(forResource: "clear_paper_jam", ofType: "m4v") else {return}
            
            print("image Found:- \(imageName)")
            
            //Display Video View When
            
            videoViewEnabled = true
            
            DispatchQueue.main.async {
                self.videoView.isHidden = !self.videoViewEnabled
                //Play Video
                self.playClearPaperJamVideo(fileUrlString: fileUrlString, nameString: "Clear Paper Jam")
            }
            
        } else if  imageName == "ink_1" || imageName == "ink_2" || imageName == "ink_3" || imageName == "ink_4" || imageName == "ink_5" || imageName == "ink_6" {
            
            
            //imageName == "ink" ||
            
            guard let fileUrlString = Bundle.main.path(forResource: "ink", ofType: "mp4") else {return}
            
            print("image Found:- \(imageName)")
            
            //Display Video View When
            
            videoViewEnabled = true
            
            DispatchQueue.main.async {
                self.videoView.isHidden = !self.videoViewEnabled
                //Play Video
                self.playClearPaperJamVideo(fileUrlString: fileUrlString, nameString: "Replace Ink Cartridge")
            }
        } else if imageName == "printer_1" || imageName == "printer_2" || imageName == "printer_3" || imageName == "printer_4" || imageName == "printer_5" || imageName == "printer_6" || imageName == "printer_7"  || imageName == "printer_8" || imageName == "printer_9" {
            
            //imageName == "printer" || imageName == "printer_1" || imageName == "printer_2" || || imageName == "printer_4" 
            
            guard let fileUrlString = Bundle.main.path(forResource: "print", ofType: "mp4") else {return}
            
            print("image Found:- \(imageName)")
            
            //Display Video View When
            
            videoViewEnabled = true
            
            DispatchQueue.main.async {
                self.videoView.isHidden = !self.videoViewEnabled
                //Play Video
                self.playClearPaperJamVideo(fileUrlString: fileUrlString, nameString: "Printing Trackable Labels")
            }
        } else if imageName == "feeding_envelopes_1" || imageName == "feeding_envelopes_2" || imageName == "feeding_envelopes_3" || imageName == "feeding_envelopes_4" || imageName == "feeding_envelopes_5" || imageName == "feeding_envelopes_6" {
            
            guard let fileUrlString = Bundle.main.path(forResource: "feeding_envelopes", ofType: "mp4") else {return}
            
            print("image Found:- \(imageName)")
            
            //Display Video View When
            
            videoViewEnabled = true
            
            DispatchQueue.main.async {
                self.videoView.isHidden = !self.videoViewEnabled
                //Play Video
                self.playClearPaperJamVideo(fileUrlString: fileUrlString, nameString: "Feeding Envelopes")
            }
        } else if imageName == "refillingpostage_1"  {
            
            guard let fileUrlString = Bundle.main.path(forResource: "fixing_incorrect_postage", ofType: "mp4") else {return}
            
            print("image Found:- \(imageName)")
            
            //Display Video View When
            
            videoViewEnabled = true
            
            DispatchQueue.main.async {
                self.videoView.isHidden = !self.videoViewEnabled
                //Play Video
                self.playClearPaperJamVideo(fileUrlString: fileUrlString, nameString: "Envelope Printing") //Fixing Incorrect Postage
            }
        }
    }
    
    // Override to create and configure nodes for anchors added to the view's session.
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        //One Tme calling
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    func playClearPaperJamVideo(fileUrlString: String, nameString: String) -> () {
        
        //Remove all SubViews
        for view in self.videoView.subviews {
            view.removeFromSuperview()
        }
        for view in self.videoView.subviews {
            view.layer.removeFromSuperlayer()
        }
        
        let url = URL(fileURLWithPath: fileUrlString)
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        
        let playerLayer = AVPlayerLayer(player: player!)
        playerLayer.frame = self.videoView.bounds
        self.videoView.layer.addSublayer(playerLayer)
        

        //Continue Play Video
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem, queue: nil) { (notification) in
            self.player?.seek(to: CMTime.zero)
            //self.player?.play() //Looping Video
    
            self.playButton!.setImage(UIImage(named: "play"), for: UIControl.State.normal)
            self.playButtonEnabled = false // Not Play
            
            print("Looping Video")
            print("Looping Video notification:- \(notification)")
        
            //Visible When Video Finished
            if self.helpfulView != nil {
                self.helpfulView?.isHidden = false
            }
        }
       
        //Play Button Left
        playButton = UIButton(type: UIButton.ButtonType.system) as UIButton
        let xPostion: CGFloat = self.videoView.bounds.width - 60
        let yPostion: CGFloat = 20
        let buttonWidth: CGFloat = 40
        let buttonHeight: CGFloat = 40
        
        playButton!.frame = CGRect(x: xPostion, y: yPostion, width: buttonWidth, height: buttonHeight)
        playButton!.backgroundColor = UIColor.clear
        playButton!.setImage(UIImage(named: "play"), for: UIControl.State.normal)
        playButtonEnabled = false // Not Play
        playButton!.tintColor = UIColor.white
        playButton!.addTarget(self, action: #selector(self.playButtonTapped(_:)), for: .touchUpInside)
        
        self.videoView.addSubview(playButton!)
        
        //Close Button
        closeButton = UIButton(type: UIButton.ButtonType.system) as UIButton
        let pxPostion: CGFloat = 20
        let pyPostion: CGFloat =  20
        let pbuttonWidth: CGFloat = 40
        let pbuttonHeight: CGFloat = 40
        
        closeButton!.frame = CGRect(x: pxPostion, y: pyPostion, width: pbuttonWidth, height: pbuttonHeight)
        closeButton!.backgroundColor = UIColor.clear
        closeButton!.setImage(UIImage(named: "close"), for: UIControl.State.normal)
        closeButton!.tintColor = UIColor.white
        closeButton!.addTarget(self, action: #selector(self.closeButtonTapped(_:)), for: .touchUpInside)
        
        self.videoView.addSubview(closeButton!)
        
        
        //Diisplay Name Label  //80 20; 235 40
        let lxPostion: CGFloat = 60
        let lyPostion: CGFloat = 20
        let lWidth: CGFloat = self.videoView.bounds.width - 60 - 60
        let lHeight: CGFloat = 40
        displayNameLabel = UILabel(frame: CGRect(x: lxPostion, y: lyPostion, width: lWidth, height: lHeight))
        displayNameLabel?.backgroundColor = .clear
        displayNameLabel?.textColor = .white
        displayNameLabel?.text = nameString
        displayNameLabel?.numberOfLines = 1
        displayNameLabel?.textAlignment = .center
        
        self.videoView.addSubview(displayNameLabel!)
        
        
        
        //---------------------- HelpFul View ------------------
        
        
        //Create Bottom HelpFul View
        let hxPostion: CGFloat = 0
        let hyPostion: CGFloat = self.videoView.bounds.height - 60
        let hWidth: CGFloat = self.videoView.bounds.width
        let hHeight: CGFloat = 60
        helpfulView  = UIView(frame: CGRect(x: hxPostion, y: hyPostion, width: hWidth, height: hHeight))
        helpfulView?.backgroundColor = .black
        self.videoView.addSubview(helpfulView!)
        
        let hlxPostion: CGFloat = 10
        let hlyPostion: CGFloat = 10
        let hlWidth: CGFloat = self.helpfulView!.bounds.width - 120
        let hlHeight: CGFloat = self.helpfulView!.bounds.height - 20
        helpfulLabel = UILabel(frame: CGRect(x: hlxPostion, y: hlyPostion, width: hlWidth, height: hlHeight))
        helpfulLabel?.backgroundColor = .clear
        helpfulLabel?.textColor = .white
        helpfulLabel?.text = "This video is helpful ?"
        helpfulLabel?.numberOfLines = 1
        helpfulLabel?.textAlignment = .left
        
        helpfulView!.addSubview(helpfulLabel!)
        
        //Yes Button
        helpfulYesButton = UIButton(type: UIButton.ButtonType.system) as UIButton
        let yxPostion: CGFloat = self.helpfulView!.bounds.width - 150
        let yyPostion: CGFloat =  10
        let ybuttonWidth: CGFloat = 60
        let ybuttonHeight: CGFloat = self.helpfulView!.bounds.height - 20
        
        helpfulYesButton!.frame = CGRect(x: yxPostion, y: yyPostion, width: ybuttonWidth, height: ybuttonHeight)
        helpfulYesButton!.backgroundColor = UIColor.clear
        helpfulYesButton!.setTitle("YES", for: UIControl.State.normal) //
        helpfulYesButton!.setTitleColor(.white, for: UIControl.State.normal)
        helpfulYesButton!.addTarget(self, action: #selector(self.helpfulYesButtonTapped(_:)), for: .touchUpInside)
        
        helpfulView!.addSubview(helpfulYesButton!)
        
        
        //No Button
        helpfulNoButton = UIButton(type: UIButton.ButtonType.system) as UIButton
        let nxPostion: CGFloat = self.helpfulView!.bounds.width - 70
        let nyPostion: CGFloat =  10
        let nbuttonWidth: CGFloat = 60
        let nbuttonHeight: CGFloat = self.helpfulView!.bounds.height - 20
        
        helpfulNoButton!.frame = CGRect(x: nxPostion, y: nyPostion, width: nbuttonWidth, height: nbuttonHeight)
        helpfulNoButton!.backgroundColor = UIColor.clear
        helpfulNoButton!.setTitle("NO", for: UIControl.State.normal) //
        helpfulNoButton!.setTitleColor(.white, for: UIControl.State.normal)
        helpfulNoButton!.addTarget(self, action: #selector(self.helpfulNoButtonTapped(_:)), for: .touchUpInside)
        
        helpfulView!.addSubview(helpfulNoButton!)
        
        self.updateButton(sender: helpfulYesButton!)
        self.updateButton(sender: helpfulNoButton!)
 
        
        //Not Visible When Video Play / Pause
        if self.helpfulView != nil {
            self.helpfulView?.isHidden = true
        }
        
        //Play When Video Found
        playButtonEnabled = true // Play
        player!.play()
        playButton!.setImage(UIImage(named: "pause"), for: UIControl.State.normal)
    }
    

    @objc func playButtonTapped(_ sender:UIButton)
    {
        if playButtonEnabled == false {
            playButtonEnabled = true // Play
            player!.play()
            playButton!.setImage(UIImage(named: "pause"), for: UIControl.State.normal)
            //playButton!.setTitle("Pause", for: UIControl.State.normal)
        } else {
            playButtonEnabled = false // Not Play
            player!.pause()
            playButton!.setImage(UIImage(named: "play"), for: UIControl.State.normal)
            //playButton!.setTitle("Play", for: UIControl.State.normal)
        }
    }
    
    @objc func closeButtonTapped(_ sender: UIButton?)
    {
        if player != nil {
            player!.pause()
        }
        playButtonEnabled = false // Not Play
        //Display Video View When
        videoViewEnabled = false
        self.videoView.isHidden = !videoViewEnabled
    }
    
    @objc func backButtonTapped(_ sender: UIButton)
    {
        //Close All Functionality
        self.closeButtonTapped(sender)
        
        //Go Back
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func helpfulYesButtonTapped(_ sender: UIButton)
    {
        print("helpfulYesButtonTapped")
        
        let alert = UIAlertController(title: "Thanks for watching this video.", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Ok"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            
            //Close All Functionality
            self.closeButtonTapped(nil)
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    @objc func helpfulNoButtonTapped(_ sender:UIButton)
    {
        print("helpfulNoButtonTapped")
        
        let alert = UIAlertController(title: "Thanks for trying this video, Please connect our Tech Support Team for further Help", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Connect", comment: "Connect"), style: .default, handler: { _ in
            NSLog("The \"Connect\" alert occured.")
            
            //Close All Functionality
            self.closeButtonTapped(nil)
            
            let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            let realTimeCameraSupportVC = storyboard.instantiateViewController(withIdentifier: "RealTimeCameraSupportVC") as! RealTimeCameraSupportVC
            self.navigationController!.pushViewController(realTimeCameraSupportVC, animated: true)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    
    }
    
    func updateButton(sender: UIButton) -> () {
        
        sender.layer.borderWidth = 4
        sender.layer.borderColor = UIColor.black.cgColor
        sender.layer.masksToBounds = true
        sender.setTitleColor(.black, for: UIControl.State.normal)
        sender.backgroundColor = UIColor.white
        
    }
}
