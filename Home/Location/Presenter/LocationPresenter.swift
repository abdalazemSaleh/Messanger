//
//  LocationPresenter.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-09-04.
//

import Foundation
import CoreLocation


protocol LocationView: AnyObject {
    
}


class LocationPresenter {
    private weak var view: LocationPicker?
    init(view: LocationPicker) {
        self.view = view
    }
    // MARK: - Varibles
    var coordinates: CLLocationCoordinate2D?
    
    
}
