//
//  GoogleMapVC.swift
//  TataMapDemo
//
//  Created by Kayaan on 03/06/21.
//  Copyright © 2021 Abhilash Mathur. All rights reserved.
//

import UIKit
import GoogleMaps

class GoogleMapVC: UIViewController {
    
    let bottomSheetVC : BottomSheetViewController =  BottomSheetViewController()
    @IBOutlet var pinImage: UIImageView!
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var mapView: GMSMapView!
    private var mapsViewModel : MapsViewModel!
    private var dataSource : MapViewDataSource<MapModelData>!
    var bounds = GMSCoordinateBounds()
    var moveRequired = false
    
    private let locationManager = CLLocationManager()
    var geoCoder :CLGeocoder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        callToViewModelForUIUpdate()
        addBottomSheetView()
        geoCoder = CLGeocoder()
//        self.mapView.bringSubviewToFront(pinImage)
        styleGoogleMap()
        
       // self.mapView.mapType = .normal
       
        
        //        let mapID = GMSMapID(identifier: GOOGLE_MAP_STYLE_ID)
        //        mapView = GMSMapView(frame: .zero, mapID: mapID, camera: mapView.camera)
        
//        let marker = GMSMarker()
//        marker.isDraggable = true
//        marker.icon = #imageLiteral(resourceName: "PinMarker")
        
        
    }
    
    func addBottomSheetView() {
       
//        bottomSheetVC.didSelectItem = { [weak self](item) in
//            if self != nil  {
//                self!.searchFinderVC?.filterAnnotations(finderObj: item)
//                self!.listViewVC?.filterAnnotations(finderObj: item)
//                self!.bottomSheetVC.close()
//
//           }
//        }
        bottomSheetVC.fromMainView = true
        bottomSheetVC.view.makeCorner(withRadius: 20.0)
        self.addChild(bottomSheetVC)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParent: self)
   
        let height = view.frame.height
        let width  = view.frame.width
        bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
    }
    
    private func styleGoogleMap(){
        do {
                // Set the map style by passing the URL of the local file.
                if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                    mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)

                } else {
                    NSLog("Unable to find style.json")
                }
            } catch {
                NSLog("One or more of the map styles failed to load. \(error)")
            }
    }
    
    func callToViewModelForUIUpdate(){
       
       
        self.mapsViewModel =  MapsViewModel()
        self.mapsViewModel.bindMapsViewModelToController = {
//            self.updateDataSource()
            DispatchQueue.main.async {
                self.showCurrentLocationOnMap(poiList: self.mapsViewModel.mapsData.poiList ?? [])
            }
            
        }
    }
    
    func updateDataSource(){
        
        
        self.dataSource = MapViewDataSource(items: self.mapsViewModel.mapsData, configureMap: { (mapObj) in
            print(mapObj)

        })
    }
    
    func showCurrentLocationOnMap(poiList:[PoiList]){

        mapView.clear() // clear the map
        
        for data in poiList{
            
            let location = CLLocationCoordinate2D(latitude: Double(data.coordinate?.latitude ?? 0.0).rounded(toPlaces: 5), longitude: Double(data.coordinate?.longitude ?? 0.0).rounded(toPlaces: 5))
            print("location: \(location)")
            
            let marker = GMSMarker()
            
            marker.position = location
            if(data.fleetType == "TAXI"){
                marker.icon = #imageLiteral(resourceName: "cabNew")
            }else if(data.fleetType == "POOLING"){
                marker.icon = #imageLiteral(resourceName: "carPool")
            }
            marker.snippet = data.fleetType
            marker.map = mapView
            bounds = bounds.includingCoordinate(marker.position)

        }
        if(moveRequired == false){
            let update = GMSCameraUpdate.fit(bounds, withPadding: 20)
            self.mapView.animate(with: update)
        }
        

    }
//    func DisplayMarker(latitude : CLLocationDegrees,logitude : CLLocationDegrees,locationStr : String){
//    //        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: logitude, zoom: 10.0)
    //        let mapViews = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
    //
    //        self.mapDisplay.camera = camera
//
//            DispatchQueue.main.async
//                {
//                    let position = CLLocationCoordinate2DMake(latitude,logitude)
//                    let marker = GMSMarker(position: position)
//                    marker.title = locationStr
//                    marker.map = self.mapView
//            }
//        }

}

extension GoogleMapVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        guard status == .authorizedWhenInUse else {
            return
        }
        
        locationManager.startUpdatingLocation()
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
//        guard let location = locations.first else {
//            return
//        }
        //self.showCurrentLocationOnMap(poiList: self.mapsViewModel.mapsData.poiList ?? [])
       // mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        
        locationManager.stopUpdatingLocation()
        
    }
    
}
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
// MARK: - GMSMapViewDelegate
extension GoogleMapVC: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
      //  reverseGeocodeCoordinate(position.target)
        
        
        
        let lat = position.target.latitude
        let lng = position.target.longitude
        
        // Create Location
        let location = CLLocation(latitude: lat, longitude: lng)
        
        // Geocode Location
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let placemarks = placemarks{
                
            
                let pm = placemarks as [CLPlacemark]

                if pm.count > 0 {
                    let pm = placemarks[0]
                    print(pm.country ?? "")
                    print(pm.locality ?? "")
                    print(pm.subLocality ?? "")
                    print(pm.thoroughfare ?? "")
                    print(pm.postalCode ?? "")
                    print(pm.subThoroughfare ?? "")
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    print(addressString)
                    self.commonInforMessage(successTitle: "Location :", body: addressString)
              }
            }
        }
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
       // addressLabel.lock()
        
        if (gesture) {
            self.pinImage.isHidden = false
       //     mapCenterPinImage.fadeIn(0.25)
            mapView.selectedMarker = nil
            moveRequired = true
            self.callToViewModelForUIUpdate()
        }
    }
    

    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        self.pinImage.isHidden = true
        self.mapView?.camera = GMSCameraPosition.camera(withTarget: marker.position, zoom: 14.0)
        
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        print("Drag started!")

    }
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        print("ON Drag marker!")

    }
    
    func mapView (_ mapView: GMSMapView, didEndDragging didEndDraggingMarker: GMSMarker) {

        print("Drag ended!")
        print("Update Marker data if stored somewhere.")

    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
       // mapCenterPinImage.fadeIn(0.25)
        
        
        let camera = GMSCameraPosition.camera(withLatitude: Double(self.mapsViewModel.mapsData.poiList?[0].coordinate?.latitude ?? 0.0).rounded(toPlaces: 5), longitude: Double(self.mapsViewModel.mapsData.poiList?[0].coordinate?.longitude ?? 0.0).rounded(toPlaces: 5), zoom: 8.0)
        mapView.animate(toLocation: CLLocationCoordinate2DMake(Double(self.mapsViewModel.mapsData.poiList?[0].coordinate?.latitude ?? 0.0).rounded(toPlaces: 5), Double(self.mapsViewModel.mapsData.poiList?[0].coordinate?.longitude ?? 0.0).rounded(toPlaces: 5)))
        mapView.camera = camera
        mapView.selectedMarker = nil
        
        return false
    }
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        
        
        
//        for i in 0..<objList.count{
//            let place = objList[i].address
//            if place == marker.title{
//                switch UserDefaults.standard.object(forKey: Key.Role) as! String {
//                    case RoleType.tradesman.description, RoleType.subUser.description:
//                        self.callWebServicePropertyDetail(propertyObject: objList[i], serviceID: .tradesManProperties)
//                        break
//                    case RoleType.propertyManager.description:
//                        self.callWebServicePropertyDetail(propertyObject: objList[i], serviceID: .propertyManagerProperties)
//                        break
//                    case RoleType.landlord.description:
//                        break
//                    default:
//                        break
//                }
//                break
//            }
//        }
//        self.performSegue(withIdentifier: "GoToPropertiesDetails", sender: nil)
    }
}
