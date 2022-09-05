//
//  LocationPicker.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-09-04.
//

import UIKit
import MapKit
import CoreLocation

#warning("Refactor")

protocol returnCoordinates {
    func returnCoordinates(coordinates: CLLocationCoordinate2D)
}


class LocationPicker: UIViewController {

    // MARK: - Variables
    var presenter: LocationPresenter!
    var coordinates: CLLocationCoordinate2D?
    var isPickable = true
    var delegate: returnCoordinates?
    
    // MARK: - View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Picke Location"
        presenter = LocationPresenter(view: self)
        cehclk()
    }
    // MARK: - Init
    init(coordinates: CLLocationCoordinate2D?) {
        self.coordinates = coordinates
        self.isPickable = coordinates == nil
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - IBOutlet
    @IBOutlet var map: MKMapView!
    
    // MARK: - Check
    
    func cehclk() {
        if isPickable {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send",
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(sendButtonTapped))
            map.isUserInteractionEnabled = true
            let gesture = UITapGestureRecognizer(target: self,
                                                 action: #selector(didTapMap(_:)))
            gesture.numberOfTouchesRequired = 1
            gesture.numberOfTapsRequired = 1
            map.addGestureRecognizer(gesture)
        }
        else {
            // just showing location
            guard let coordinates = self.coordinates else {
                return
            }
            
            // drop a pin on that location
            let pin = MKPointAnnotation()
            pin.coordinate = coordinates
            map.addAnnotation(pin)
        }
    }
    
    @objc func sendButtonTapped() {
        guard let coordinates = coordinates else {
            return
        }
        navigationController?.popViewController(animated: true)
        // Return to chat view controller with coordinates
        delegate?.returnCoordinates(coordinates: coordinates)
    }

    @objc func didTapMap(_ gesture: UITapGestureRecognizer) {
        let locationInView = gesture.location(in: map)
        let coordinates = map.convert(locationInView, toCoordinateFrom: map)
        self.coordinates = coordinates

        for annotation in map.annotations {
            map.removeAnnotation(annotation)
        }

        // drop a pin on that location
        let pin = MKPointAnnotation()
        pin.coordinate = coordinates
        map.addAnnotation(pin)
    }
    
}
