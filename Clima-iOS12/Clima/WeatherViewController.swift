//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

// 设置应用遵从LocationManagerDelegate协议
class WeatherViewController: UIViewController, CLLocationManagerDelegate{
    
    //Constants
    let WEATHER_URL = Const.Weather_URL
    let APP_ID = Const.API_KEY
    
    
    //TODO: Declare instance variables here
    let locationManager = CLLocationManager()
    
    let weatherDataModel = WeatherDataModel()
    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //TODO:Set up the location manager here.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        // 仅当使用的时候获取位置信息
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    

    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
   
    
    //Write the updateWeatherData method here:
    

    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            // 获取到有效的地理位置信息
            locationManager.stopUpdatingLocation()
            let lat = String(location.coordinate.latitude)
            let lon = String(location.coordinate.longitude)
            
            let params : [String : String] = [
                "lat": lat,
                "lon" : lon,
                "appid": Const.API_KEY,
            ]
            getWeatherData(url: Const.Weather_URL, params: params)
        }
    }
    
    private func updateUIWithWeatherData(){
        cityLabel.text = weatherDataModel.city
        temperatureLabel.text = "\(weatherDataModel.temperature)"
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    
    private func updateWeatherData(_ data: JSON){
        if let tempResult = data["main"]["temp"].double{
            weatherDataModel.temperature = Int(tempResult - 273.15)
            weatherDataModel.city = data["name"].stringValue
            weatherDataModel.condition = data["weather"][0]["id"].intValue
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            updateUIWithWeatherData()
        }else{
            cityLabel.text = "Weather Unavailable"
        }
    }
    
    private func getWeatherData(url: String, params: [String: String]){
        Alamofire.request(url, method: .get, parameters: params).responseJSON{ response in
            if response.result.isSuccess{
                print("get weather data")
                let weatherJSON: JSON = JSON(response.result.value!)
                self.updateWeatherData(weatherJSON)
                
            }else{
                print("error for \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection Issue"
            }
        }
    }
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavailable"
    }
    
    
    
    

    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    

    
    //Write the PrepareForSegue Method here
    
    
    
    
    
}


