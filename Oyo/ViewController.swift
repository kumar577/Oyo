//
//  ViewController.swift
//  Oyo
//
//  Created by VEENA on 02/01/22.
//

import UIKit

protocol ObserverProtocol {
  var Id: Int {get set}
  func onTrafficLightColorChange(_color: String)
}

class ViewController: UIViewController {
  
  struct TrafficColor {
    static let red = "red"
    static let green = "green"
    static let yellow = "yellow"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let trafficLightSubject = TrafficLightSubject()
    let vehicleObserver = VehicleObserver(_Id: 1)
    let vendorObserver = VendorObserver(_Id: 2)
    
    trafficLightSubject.addObserver(_observer: vehicleObserver)
    trafficLightSubject.addObserver(_observer: vendorObserver)
    trafficLightSubject.addObserver(_observer: vendorObserver)
    trafficLightSubject.trafficLightColor = TrafficColor.red
    trafficLightSubject.removeObserver(_observer: vendorObserver)
    trafficLightSubject.trafficLightColor = TrafficColor.green
  }
  
 
  
  class VehicleObserver: ObserverProtocol {
    var Id: Int
    
    init(_Id: Int) {
      Id = _Id
    }
    
    func onTrafficLightColorChange(_color: String) {
      if (_color == TrafficColor.red) {
        debugPrint("stop my vehicle")
      }
      if (_color == TrafficColor.green) {
        debugPrint("start my vehicle")
      }
      if (_color == TrafficColor.yellow) {
        debugPrint("slow down the speed of the vehicle")
      }
    }
    
  }
  
  class VendorObserver: ObserverProtocol {
    var Id: Int
    
    init(_Id: Int) {
      Id = _Id
    }
    
    func onTrafficLightColorChange(_color: String) {
      if (_color == TrafficColor.red) {
        debugPrint("Vendor: Start selling products")
      }
      if (_color == TrafficColor.green) {
        debugPrint("Vendor: Move aside the traffic")
      }
      
    }
    
  }
  
  class TrafficLightSubject {
    private var _color = String()
    var trafficLightColor: String
    {
      get
      {
        return _color
      }
      set {
        _color = newValue
        notifyObserver()
      }
    }
    
    private var trafficObserver = [ObserverProtocol]()
    
    func addObserver(_observer: ObserverProtocol)
    {
      guard trafficObserver.contains(where: {$0.Id == _observer.Id}) == false else {
        return
      }
      
      trafficObserver.append(_observer)
      
    }
    
    func removeObserver(_observer: ObserverProtocol) {
      trafficObserver = trafficObserver.filter({$0.Id != _observer.Id})
    }
    
    private func notifyObserver() {
      trafficObserver.forEach({$0.onTrafficLightColorChange(_color: _color)})
    }
    
    deinit {
      trafficObserver.removeAll()
    }
    
  }
  
  
  
}

