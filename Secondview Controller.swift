//
//  Secondview Controller.swift
//  openweather.org.Vwasweissichwieviel
//
//  Created by Nicolai Kaschta on 25.06.16.
//  Copyright © 2016 Nicolai Kaschta. All rights reserved.
//

import Foundation
import UIKit

class SecondviewController: UIViewController {
    
    
    // Interfacesachen
    @IBOutlet weak var tempCels: UILabel!
    @IBOutlet weak var lufeucht: UILabel!
    @IBOutlet weak var winspd: UILabel!
    @IBOutlet weak var windir: UILabel!
    @IBOutlet weak var taup: UILabel!
    @IBOutlet weak var startrichtung: UITextField!
    @IBOutlet weak var windrichtung: UILabel!
    
    
    // Variablen welche dann von ViewController angesprochen werden
    var windr = Double()
    var winds = Double()
    var feucht = Double()
    var temp = Double()
    
    //override func viewWillAppear(animated: Bool) {
        //super.viewWillAppear(animated)
        //connect()

    //}
    
    override func viewDidLoad() {
        //super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        windir.text = String(windr)+"°"
        winspd.text = String(winds)+"m/s"
        tempCels.text = String(temp)+"°C"
        lufeucht.text = String(feucht)+"%"
        


    }
    

    
    // Berechnen der Gegenwindkomponente. Aus irgendwelchen gründen ungenau. Schätze M_PI macht hier ein paar Probleme.

    @IBAction func Berechnen(sender: AnyObject) {
        // benötigte Variablen
        var hwind = 0.0
        var startricht = 0.0
        let startinput = NSString(string: startrichtung.text!)
        startricht = startinput.doubleValue

        // eigentliche berechnung nach der Formel cos(a)*windgeschwindigkeit = Gegenwind
        hwind = -cos((windr-startricht)*M_PI/180)*winds
        
        // Anzeige im Label
        self.windrichtung.text = (NSString(format:"%.f",hwind) as String)+"m/s" as String
        
    }
    // Berechnung des Taupunktes
    @IBAction func berechneDenTaupunkt(sender: AnyObject) {
        
        
        // Variablen
        var tau = 0.0
        var phi = 0.0
        let feuchtImRichtigenFormat = feucht/100
        
        // Berechnung mit zwischenschritt für phi (wenn das ding überhaupt so heißt)
        // womöglich gibt es was besseres für einen exponenten
        //Zugrundeliegende Formel ist: Taupunkt= ReativeLuftfeuchtigkeit^(1/8,02) * (109,8+t) - 109,8
        phi = pow(feuchtImRichtigenFormat, 1/8.02)
        tau = phi*(109.8 + temp)-109.8
        
        
         // Anzeige im Label
        self.taup.text = (NSString(format:"%.2f",tau) as String)+"°C" as String
        
        
        
    }
    


}