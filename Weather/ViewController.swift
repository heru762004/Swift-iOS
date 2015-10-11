//
//  ViewController.swift
//  Weather
//
//  Created by Heru Prasetia on 10/2/15.
//  Copyright © 2015 Heru Prasetia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WeatherRequestResponseCallback, UITableViewDelegate, UITableViewDataSource {

    // loading indicator
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    // city name text field
    @IBOutlet weak var txtCityName: UITextField!
    
    // "auto complete" table object
    var autoCompleteTableView:UITableView!
    
    // object to handle request response
    var weatherHandler = WeatherRequestResponse();
    // object weather
    var weather = Weather()
    // object to handle city name data storage
    var storageData = CityNameStorageHandler();
    
    // array to store city names data that retrieved from persistent storage
    var cityName:[String] = [String]()
    
    override func viewDidLoad() {
        self.weatherHandler.delegate = self
        
        // register macro to called showSuggestion method when user click city textfield
        self.txtCityName.addTarget(self, action: "showSuggestion:", forControlEvents: UIControlEvents.EditingDidBegin)
        
        // construct "auto complete" table to suggest city name
        self.autoCompleteTableView = UITableView(frame: CGRectMake(txtCityName.frame.origin.x, txtCityName.frame.origin.y + txtCityName.frame.size.height, txtCityName.frame.size.width, 120.0), style: UITableViewStyle.Plain)
        self.autoCompleteTableView.delegate = self
        self.autoCompleteTableView.dataSource = self
        self.autoCompleteTableView.scrollEnabled = true
        self.autoCompleteTableView.hidden = true
        self.autoCompleteTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.autoCompleteTableView);
        
        loadingIndicator.hidden = true
        
        // register notification center to perform refresh when application active from background
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "viewDidActive", name:UIApplicationDidBecomeActiveNotification, object: nil)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func viewDidActive() {
        self.storageData.refreshDataFromStorage()
        self.cityName = self.storageData.getAllCitiesName()
        self.autoCompleteTableView.reloadData()
    }
    
    // before change screen, pass weather object to next screen
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showWeather" {
            let nextScene =  segue.destinationViewController as! WeatherTableViewController
            nextScene.weather = self.weather
        }
    }
    
    // WeatherRequestResponseCallback
    
    // called when the app retrieved weather data successfully
    func onRequestFinished(data: Weather) {
        self.weather = data
        
        // store cityname to persistent storage
        self.storageData.addCityName(self.txtCityName.text!)
        
        self.loadingIndicator.hidden = true
        self.loadingIndicator.stopAnimating()
        performSegueWithIdentifier("showWeather", sender:self)
    }
    
    
    // called when there is an error during weather data retrieval
    func onRequestError(errorMessage: String) {
        self.loadingIndicator.hidden = true
        self.loadingIndicator.stopAnimating()
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // called when user click "Search" button
    @IBAction func doShowWeather(sender: AnyObject) {
        if txtCityName.text?.characters.count == 0 {
            onRequestError("Please fill the city name")
            return
        }
        // hide the keyboard
        self.txtCityName.resignFirstResponder()
        // start show loading indicator
        self.loadingIndicator.hidden = false
        self.loadingIndicator.startAnimating()
        // retrieve weather data
        self.weatherHandler.load_data(txtCityName.text!);
    }

    // called when user touch city textfield
    @IBAction func showSuggestion(sender: AnyObject) {
        // check whether there is a suggestion city already store in the persistent storage
        if(self.storageData.isCityNameDataAvailable()) {
            // get the city names from the persistent storage
            self.cityName = self.storageData.getAllCitiesName()
            // reload the "auto complete" table
            self.autoCompleteTableView.reloadData()
            // set "auto complete" table scroll to the top
            self.autoCompleteTableView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: false)
            // unhide the "auto complete" table
            self.autoCompleteTableView.hidden = false
        }
    }
    
    // tableview delegate & data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return self.cityName.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = self.cityName[self.cityName.count - indexPath.row - 1]
        return cell
    }
    
    // called when user select the city on "auto complete" table
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // hide the keyboard
        self.txtCityName.resignFirstResponder()
        // hide the "auto complete" table
        self.autoCompleteTableView.hidden = true
        // set the city text filed to the selected city from "auto complete" table
        self.txtCityName.text = self.cityName[self.cityName.count - indexPath.row - 1]
        // start show loading indicator
        self.loadingIndicator.hidden = false
        self.loadingIndicator.startAnimating()
        // load weather data
        self.weatherHandler.load_data(self.cityName[self.cityName.count - indexPath.row - 1]);
    }
    
    // called when "Done" button pressed
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // hide the keyboard
        textField.resignFirstResponder()
        // hide the "auto complete" table
        self.autoCompleteTableView.hidden = true
        return true
    }
}

