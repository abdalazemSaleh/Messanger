//
//  DateFormatter.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-09.
//

import UIKit

extension UIViewController {
    public static let dateFormatter: DateFormatter = {
        let formattre = DateFormatter()
        formattre.dateStyle = .medium
        formattre.timeStyle = .long
        formattre.locale = .current
        return formattre
    }()
}
