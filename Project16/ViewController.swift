//
//  ViewController.swift
//  Project16
//
//  Created by Ceboolion on 20/05/2020.
//  Copyright © 2020 Ceboolion. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        capitals()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map Style", style: .plain, target: self, action: #selector(changeMapStyle))
    }
    
    @objc func changeMapStyle(){
        let ac = UIAlertController(title: "Choose map style", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: { action in
            self.mapView.mapType = MKMapType.satellite
        }))
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: { action in
            self.mapView.mapType = MKMapType.hybrid
        }))
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: { action in
            self.mapView.mapType = MKMapType.standard
        }))
        present(ac, animated: true)
    }
    
    func capitals(){
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 summer olimpics.", wikiUrl: "https://en.wikipedia.org/wiki/London")
        let oslo  = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.74), info: "It was founded 1000 years ago.", wikiUrl: "https://en.wikipedia.org/wiki/Oslo")
        let paris  = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Ofen called the city of light", wikiUrl: "https://en.wikipedia.org/wiki/Paris")
        let rome  = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a hole country inside it", wikiUrl: "https://en.wikipedia.org/wiki/Rome")
        let washington  = Capital(title: "Washington", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself", wikiUrl: "https://en.wikipedia.org/wiki/Washington")
        
        mapView.addAnnotations([london,oslo,paris,rome,washington])
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else {return nil}
        let identifier = " Capital"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.pinTintColor = .orange
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        let placeName = capital.title
        let placeInfo = capital.info
        let wikiDetails = capital.wikiUrl
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "See more", style: .default, handler: { action in
            let detailVC = DetailViewController()
            detailVC.url = wikiDetails
            self.navigationController?.pushViewController(detailVC, animated: true)
        }))
        present(ac, animated: true)
        
    }
}
