//
//  UIExtensions.swift
//  wheatherApp
//
//  Created by sara salem on 06/05/2022.
//

import UIKit
extension UIViewController{
    func showAlert(error: Error) {
        let controller = UIAlertController(title: "Something went wrong", message: error.localizedDescription, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))

        present(controller, animated: true, completion: nil)
    }
    func showAlert(error: String) {
        let controller = UIAlertController(title: "Something went wrong", message: error, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        present(controller, animated: true, completion: nil)
    }
}

extension UIView{
  
    func roundCorners(cornerRadius: Double , corners:UIRectCorner) {
           let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
           let maskLayer = CAShapeLayer()
          // maskLayer.frame = self.bounds
           maskLayer.path = path.cgPath
           self.layer.mask = maskLayer
       }
}
extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

