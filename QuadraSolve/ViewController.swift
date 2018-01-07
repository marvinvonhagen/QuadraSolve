//  ViewController.swift
//  QuadraSolve
//  Created by M. von Hagen on 04.11.16.
//  Copyright © 2016 Marvincent. All rights reserved.

import UIKit
import Darwin

class ViewController: UIViewController{
    //Wird bei Erscheinen des Views ausgeführt
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIAccessibilityIsVoiceOverRunning() {
            quadEquation.becomeFirstResponder()
        } else {
            a_value.becomeFirstResponder()

        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //      Outlets - Verbindung zwischen UI und Code
    @IBOutlet var quadEquation: UILabel!
    @IBOutlet var a_value: UITextField!
    @IBOutlet var p_value: UITextField!
    @IBOutlet var q_value: UITextField!
    @IBOutlet var a_sign: UIButton!
    @IBOutlet var p_sign: UIButton!
    @IBOutlet var q_sign: UIButton!
    @IBOutlet var out: UILabel!
    @IBOutlet var calc: UIButton!
    @IBOutlet var setOfNumbers: UIButton!
    
    
    //      Vorzeichen
    @IBAction func a_sign(_ sender: Any) {
        if a_sign.title(for: .normal)=="+"{
            a_sign.setTitle("-", for: .normal)
        }
        else {
            a_sign.setTitle("+", for: .normal)
        }
    }
    
    @IBAction func p_sign(_ sender: Any) {
        if p_sign.title(for: .normal)=="+"{
            p_sign.setTitle("-", for: .normal)
        }
        else {
            p_sign.setTitle("+", for: .normal)
        }
    }
    
    @IBAction func q_sign(_ sender: Any) {
        if q_sign.title(for: .normal)=="+"{
            q_sign.setTitle("-", for: .normal)
        }
        else {
            q_sign.setTitle("+", for: .normal)
        }
    }
    
    @IBAction func setOfNumbers(_ sender: Any) {
        if setOfNumbers.title(for: .normal)=="ℝ"{
            setOfNumbers.setTitle("ℂ", for: .normal)
        }
        else {
            setOfNumbers.setTitle("ℝ", for: .normal)
        }
    }
    // Ausgabe
    @IBAction func calc_button(_ sender: AnyObject) {
        
        //      Fehlt etwas?
        if (a_value.text?.isEmpty)! || (p_value.text?.isEmpty)! || (q_value.text?.isEmpty)!   {
            
            if (p_value.text?.isEmpty)! && (q_value.text?.isEmpty)! && (a_value.text?.isEmpty)! {
                self.out.text = "a=?; p=?; q=?"
                return
            }
            
            if (a_value.text?.isEmpty)! && (p_value.text?.isEmpty)! {
                self.out.text = "a=?; p=?"
                return
            }
            
            if (a_value.text?.isEmpty)! && (q_value.text?.isEmpty)! {
                self.out.text = "a=?; q=?"
                return
            }
            
            if (p_value.text?.isEmpty)! && (q_value.text?.isEmpty)! {
                self.out.text = "p=?; q=?"
                return
            }
            
            
            if (a_value.text?.isEmpty)!  {
                self.out.text = "a=?"
                return
            }
            
            if (p_value.text?.isEmpty)!  {
                self.out.text = "p=?"
                return
            }
            
            if (q_value.text?.isEmpty)!  {
                self.out.text = "q=?"
                return
            }
            
            
        }
        
        //      Auslesen der Textfelder
        var a: Double
        var p: Double
        var q: Double
        
        var aStr = a_value.text!
        let aP = String(aStr.characters.map {$0 == "," ? "." : $0})
        if a_sign.title(for: .normal)=="+"{
            a = Double(aP)!
        }
        else {
            a = -1*Double(aP)!
        }
        
        var pStr = p_value.text!
        let pP = String(pStr.characters.map {$0 == "," ? "." : $0})
        if p_sign.title(for: .normal)=="+"{
            p = Double(pP)!/a
        }
        else {
            p = (-1*Double(pP)!)/a
        }
        
        var qStr = q_value.text!
        let qP = String(qStr.characters.map {$0 == "," ? "." : $0})
        if q_sign.title(for: .normal)=="+"{
            q = Double(qP)!/a
        }
        else {
            q = (-1*Double(qP)!)/a
        }
        
        //      Ausgabe
        if a==0 {
            out.text = "a≠0"}
        else {
            let dis = pow(p, 2) - 4*q
            let uSqrt = pow(p/2, 2) - q
            var r1 = String(round((-p/2 + sqrt(uSqrt))*1000)/1000)
            var r2 = String(round((-p/2 - sqrt(uSqrt))*1000)/1000)
            
            let lan = calc.title(for: .normal)
            var comma = false
            if lan == "Berechne" || lan == "Calculer" || lan == "Calcolare" || lan=="Calcular" || lan == "подсчитывать" || lan == "Izračunati" || lan == "Beräkna" || lan == "Hesaplamak" || lan == "Obliczać" {
                comma = true
            }
            if comma==true {
                r1 = String(r1.characters.map {$0 == "." ? "," : $0})
                r2 = String(r2.characters.map {$0 == "." ? "," : $0})
                
            }
            
            if dis > 0 {
                out.text = "x₁=\(r1) v x₂=\(r2)"
            }
            else if dis == 0{
                out.text = "x= \(r1)"
            }
            else if setOfNumbers.title(for: .normal)=="ℂ"{
                var u = String(round(-p/2*1000)/1000)
                var b = String(round(sqrt(-1*uSqrt)*1000)/1000)
                
                if comma==true {
                    u = String(u.characters.map {$0 == "." ? "," : $0})
                    b = String(b.characters.map {$0 == "." ? "," : $0})
                }
                
                if p != 0{
                    out.text = "x= \(u) ± \(b)i"
                }
                else {
                    out.text = "x= ± \(b)i"
                }
            }
            else if setOfNumbers.title(for: .normal)=="ℝ"{
                out.text = "\(a_value.text!)x²\(String(describing: q_sign.title(for: .normal)!))\(p_value.text!)x\(String(describing: q_sign.title(for: .normal)!))\(q_value.text!)≠0"
            }
        }
    }
}
