//
//  ViewController.swift
//  openweather.org.Vwasweissichwieviel
//
//  Created by Nicolai Kaschta on 24.06.16.
//  Copyright © 2016 Nicolai Kaschta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        connect()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // Zu übergebende Variablen
    var data = NSMutableData()
    var windir1 = Double()
    var wind1 = Double()
    var windspeed1 = Double()
    var tempCelsius1 = Double()
    var humid1 = Double()
    
   
    
    
    //Interfacegedöns
    @IBOutlet weak var temperatur: UILabel!
    @IBOutlet weak var ort: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var tempmin: UILabel!
    @IBOutlet weak var tempmax: UILabel!
    @IBOutlet weak var windspd: UILabel!
    @IBOutlet weak var wdir: UILabel!
    @IBOutlet weak var press: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var clouds: UILabel!
    
    

    

    //API Abruf
    func connect(){
        
        let url: String = "http://api.openweathermap.org/data/2.5/weather?q=Hockenheim,de&appid=8fac47973bfc7e3f73b113e9b0171517&lang=de"
        let nsUrl: NSURL = NSURL(string: url)!
        let request: NSURLRequest = NSURLRequest(URL: nsUrl)
        let nsURLConnection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)!  // hier bekomm ich ein ausrufezeichen aber weiß nicht was es mir sagt
        nsURLConnection.start()
    }
    
    
    
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        self.data.appendData(data)
    }
    
   
    
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        
        let jsonData: NSDictionary
        do {
            jsonData = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            
            
            
            // Hier werden alle werte ausgelesen und den feldern und zu übergebenden Variablen zugeordnet
            
            let main: NSDictionary = jsonData["main"] as! NSDictionary
            let tempKelvin = main["temp"] as! Double
            let tempCelsius = tempKelvin - 273.15
            tempCelsius1 = tempCelsius
            temperatur.text = (NSString(format: "%.2f", tempCelsius) as String)+" °C" as String
            let tempMinKelvin = main["temp_min"] as! Double
            let tempMinCelsius = tempMinKelvin - 273.15
            tempmin.text = (NSString(format: "%.2f", tempMinCelsius) as String)+" °C" as String
            let tempMaxKelvin = main["temp_max"] as! Double
            let tempMaxCelsius = tempMaxKelvin - 273.15
            tempmax.text = (NSString(format: "%.2f", tempMaxCelsius) as String)+" °C" as String
            let druck = main["pressure"] as! Double
            press.text = (NSString(format: "%.0f", druck) as String)+" hPa" as String
            let weather: NSArray = (jsonData["weather"] as? NSArray)!
            let weatherData: NSDictionary = weather[0] as! NSDictionary
            let description = String(weatherData["description"] as! NSString)
            self.condition.text = description
            let wind: NSDictionary = jsonData["wind"] as! NSDictionary
            let wspeed = wind["speed"] as! Double
            windspeed1 = wspeed
            windspd.text = (NSString(format: "%.1f", wspeed) as String)+" m/s" as String
            let windir = wind["deg"] as! Double
            windir1 = windir
            wdir.text = (NSString(format: "%.1f", windir) as String)+"°" as String
            let name: NSString = jsonData["name"] as! NSString
            ort.text = name as String
            let humid = main["humidity"] as! Double
            humid1 = humid
            humidity.text = (NSString(format: "%.0f", humid) as String)+"%" as String
            let cloud: NSDictionary = jsonData["clouds"] as! NSDictionary
            let overcast = cloud["all"] as! Double
            clouds.text = "Überdeckung "+(NSString(format: "%.0f", overcast) as String)+"%" as String
            
            // Irgendwann anders wird auch die anzeige von bildern umgesetzt aber da ist die zeit nun etwas knapp.
            //
            //let icon = String(weatherData["icon"] as! NSString)
            //let image1 = UIImage(named: icon)
            //self.weatherImage.image = image1
            
        }
        catch {
            print("Fehler aufgetreten!") // Spricht an wenn ich zurück auf den ersten View wechsle. erschließt sich mir auch noch nicht so recht
        }
    }
   
    
    
    
    @IBAction func unwindToVC(segue: UIStoryboardSegue) {
        
    }
    
    
    
    // Vorbereiten zur übergabe
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let DestViewController : SecondviewController = segue.destinationViewController as! SecondviewController
        
        DestViewController.windr = windir1
        DestViewController.winds = windspeed1
        DestViewController.temp = tempCelsius1
        DestViewController.feucht = humid1
        
    }
}