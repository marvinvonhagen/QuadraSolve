//
//  InfoViewController.swift
//  QuadraSolve
//
//  Created by Cem-Marvin von Hagen on 22.08.17.
//  Copyright © 2017 M.vonHagen. All rights reserved.
//

import UIKit
import MessageUI
import StoreKit


class InfoViewController: UIViewController, MFMailComposeViewControllerDelegate {
    var ratingTimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startRatingTimer()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    @IBOutlet var mailOutlet: UIButton!
    @IBOutlet var Twitter: UIBarButtonItem!
    @IBOutlet var doneButton: UIBarButtonItem!
    
    
    @objc func rR(_ timer: Timer) {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        }
    }
    
    func startRatingTimer() {
        if #available(iOS 10.3, *) {
            ratingTimer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(rR(_:)), userInfo: nil, repeats: false)
        }
    }
    
    
    @IBAction func sendMail(_ sender: Any) {
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        composeVC.setToRecipients(["COD3LTA@vHagen.me"])
        composeVC.setSubject("QuadraSolve Support")
        ratingTimer.invalidate()
        self.present(composeVC, animated: true, completion: nil)
    }
    
    @IBAction func twitterCD(_ sender: Any) {
        if let url = URL(string: "twitter://user?screen_name=COD3LTA") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @IBAction func rSwipe(_ sender: Any) {
        ratingTimer.invalidate()
        performSegue(withIdentifier: "rSSegue", sender: self)
    }
    
    @IBAction func doneAction(_ sender: Any) {
        ratingTimer.invalidate()
        performSegue(withIdentifier: "rSSegue", sender: self)
    }
    
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
}
