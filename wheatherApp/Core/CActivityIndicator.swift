
import UIKit

public class CActivityIndicator{
    let ActivityIndicator = UIActivityIndicatorView(style: .white)
    var view : UIView?
    var overlayView = UIView()
    public init(){
        self.view = UIApplication.shared.keyWindow
        self.addOverLay()
        self.addActivityIndicator()
    }
    private func addActivityIndicator(){
        if self.view != nil{
        ActivityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        ActivityIndicator.center = view!.center
        self.view!.addSubview(ActivityIndicator)
        }
    }
    private func addOverLay(){
        if self.view != nil{
            overlayView.frame = CGRect(x: 0, y: 0, width: (view?.frame.width)!, height: (view?.frame.height)!)
            overlayView.center = (view?.center)!
            overlayView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
            overlayView.isHidden = true
            self.view?.addSubview(overlayView)
        }
    }
    private func showOverLay(){
        self.overlayView.isHidden = false
    }
    private func HideOverLay(){
        self.overlayView.isHidden = true
    }
    public func start(){
        ActivityIndicator.startAnimating()
        self.showOverLay()
    }
    public func stop(){
        ActivityIndicator.stopAnimating()
        self.HideOverLay()
    }
}
