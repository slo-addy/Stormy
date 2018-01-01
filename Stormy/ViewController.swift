//
//  ViewController.swift
//  Stormy
//
//  Created by Addison Francisco on 12/26/17.
//  Copyright © 2017 Addison Francisco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    @IBOutlet weak var currentPrecipitationLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentSummaryLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let temperaturePlaceholder = "--º"
    let humidityPlaceholder = "--%"
    let precipitationProbabilityPlaceholder = "--%"
    let summaryPlaceholder = "--"
    let iconPlaceholder: UIImage = WeatherIcon(iconString: "default").image
    
    let client = DarkSkyAPIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentWeather()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TODO: Animate labels being set
    func displayWeather(using viewModel: CurrentWeatherViewModel) {
        currentTemperatureLabel.text = viewModel.temperature
        currentHumidityLabel.text = viewModel.humidity
        currentPrecipitationLabel.text = viewModel.precipitationProbability
        currentSummaryLabel.text = viewModel.summary
        currentWeatherIcon.image = viewModel.icon
    }
    
    // TODO: Animate labels being set
    func displayPlaceholderWeather() {
        currentTemperatureLabel.text = temperaturePlaceholder
        currentHumidityLabel.text = humidityPlaceholder
        currentPrecipitationLabel.text = precipitationProbabilityPlaceholder
        currentSummaryLabel.text = summaryPlaceholder
        currentWeatherIcon.image = iconPlaceholder
    }
    
    @IBAction func getCurrentWeather() {
        
        toggleRefreshAnimation(on: true)
        displayPlaceholderWeather()
        
        // San Luis Obispo, CA
        let coordinate = Coordinate(latitude: 35.2477, longitude: -120.6432)
        
        client.getCurrentWeather(at: coordinate) { [unowned self] currentWeather, error in
            // client is a stored property on self, so a capture list is declared here to prevent a reference cycle. [unowned self]
            // is used because this URLSession is not configured for background downloads, so we can guarantee (in theory) the closure
            // will be deallocated at the same time as self.
            if let currentWeather = currentWeather {
                let viewModel = CurrentWeatherViewModel(model: currentWeather)
                self.displayWeather(using: viewModel)
                self.toggleRefreshAnimation(on: false)
            } else {
                Alert.showBasic(title: "Oh Farts", message: "Looks like something went wrong while fetching the weather.\nPlease try again.", vc: self)
                self.toggleRefreshAnimation(on: false)
            }
        }
    }
    
    func toggleRefreshAnimation(on: Bool) {
        refreshButton.isHidden = on
        
        if on {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}

