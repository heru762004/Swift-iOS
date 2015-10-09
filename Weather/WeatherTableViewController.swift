//
//  WeatherTableViewController.swift
//  Weather
//
//  Created by Heru Prasetia on 10/2/15.
//  Copyright © 2015 Heru Prasetia. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController, WeatherRequestResponseCallback {
    // class Weather
    var weather:Weather = Weather()
    // class to handle weather data retrieval
    var weatherHandler = WeatherRequestResponse();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set refresh control property
        self.refreshControl?.backgroundColor = UIColor.purpleColor()
        self.refreshControl?.tintColor = UIColor.whiteColor()
        // set macro to call refresh method when user do pull 2 refresh
        self.refreshControl?.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        // set title on navigation bar with the city name that retrieved from server
        self.title = self.weather.cityName
        self.weatherHandler.delegate = self
    }
    
    // reload weather data from server
    func refresh() {
        self.weatherHandler.load_data(self.title!);
        
    }
    
    // return the table height
    override func tableView(tableView: UITableView,
        heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            if indexPath.row == 0 {
                return 80 // set row 0 with this height (image)
            }
            return 44
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        // Configure the cell...
        if indexPath.row == 0 {
            if let url = NSURL(string:weather.weatherIconUrl) {
                // load image data from url
                if let data = NSData(contentsOfURL: url){
                    cell.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
                    cell.imageView?.image = UIImage(data: data)
                }
            }
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "Temperature : \(self.weather.temp_C) C"
        } else if indexPath.row == 2 {
            cell.textLabel?.text = "Humidity : \(self.weather.humidity)"
        } else if indexPath.row == 3 {
            cell.textLabel?.text = "Weather Description : \(self.weather.weatherDesc)"
        } else if indexPath.row == 4 {
            cell.textLabel?.text = "Observation Time : \(self.weather.observation_time)"
        }
        return cell
    }
    
    // called when the app retrieved weather data successfully
    func onRequestFinished(data: Weather) {
        self.weather = data
        self.refreshControl?.endRefreshing()
        self.tableView.reloadData()
    }
    
    // called when there is an error during weather data retrieval
    func onRequestError(errorMessage: String) {
        self.refreshControl?.endRefreshing()
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}