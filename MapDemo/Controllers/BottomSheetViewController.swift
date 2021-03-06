
import UIKit

import LocalAuthentication
import CoreLocation

struct OrderDetailEntryModel {
    
    var title:String?
//    var subTitle:String?
    
    init(title: String) {
        self.title = title
        //self.subTitle = subTitle
    }
}


class BottomSheetViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var imgArrow: UIImageView!
    
    @IBOutlet weak var svCar: UIStackView!
    
    @IBOutlet weak var btnTaxi: UIButton!
    @IBOutlet weak var btnPooling: UIButton!
    @IBOutlet weak var btnAuto: UIButton!
    
    @IBOutlet weak var lblTaxi: UILabel!
    @IBOutlet weak var lblPool: UILabel!
    @IBOutlet weak var lblAuto: UILabel!
    
//    var objUpdate = [OrderDetailEntryModel]()
    var objUpdate = [PoiList]()
    var dataSourceVehicle = [PoiList]()
    @IBOutlet weak var tblVehicles: UITableView!
    
    var fromMainView = false
    var isBottomSheetOpen = false
    
    var fullView : CGFloat = 0.0
    
    var partialView: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
//        newArrayTaxi = dataSourceVehicle.filter({$0.fleetType == "TAXI"}).compactMap({$0})
//        newArrayPooling = dataSourceVehicle.filter({$0.fleetType == "POOLING"}).compactMap({$0})
//        print("NEW TAXI : ",newArrayTaxi.count, "NEW Pool : ", newArrayPooling.count)
        
//        objUpdate.append(OrderDetailEntryModel(title : "Sector 36, Kharghar, Navi Mumbai 410210"))
//        objUpdate.append(OrderDetailEntryModel(title : "Sector 36, Kharghar, Navi Mumbai 410210"))
//        objUpdate.append(OrderDetailEntryModel(title : "Sector 36, Kharghar, Navi Mumbai 410210"))
//        objUpdate.append(OrderDetailEntryModel(title : "Sector 36, Kharghar, Navi Mumbai 410210"))
//        objUpdate.append(OrderDetailEntryModel(title : "Sector 36, Kharghar, Navi Mumbai 410210"))
//        objUpdate.append(OrderDetailEntryModel(title : "Sector 36, Kharghar, Navi Mumbai 410210"))
//        objUpdate.append(OrderDetailEntryModel(title : "Sector 36, Kharghar, Navi Mumbai 410210"))
//        objUpdate.append(OrderDetailEntryModel(title : "Sector 36, Kharghar, Navi Mumbai 410210"))

        self.tblVehicles.register(UINib(nibName: "ListOfVehicleCell", bundle: nil), forCellReuseIdentifier: "ListOfVehicleCell")
        self.tblVehicles.rowHeight = UITableView.automaticDimension
        self.tblVehicles.estimatedRowHeight = 100
        self.tblVehicles.dataSource = self
        
        svCar.addBottomBorderWithColor(color: #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1), width: 0.8)
        
        let imageView = UIImageView(image:#imageLiteral(resourceName: "cabNew"))
        imageView.setImageColor(color: UIColor.lightGray)
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageArrowTapped))

        self.imgArrow.isUserInteractionEnabled = true
        self.imgArrow.addGestureRecognizer(tapGestureRecognizer)
        
        
        
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(BottomSheetViewController.panGesture))
        view.addGestureRecognizer(gesture)
        
        
        objUpdate.removeAll()
        objUpdate = dataSourceVehicle.filter({$0.fleetType == "TAXI"}).compactMap({$0})
        print(objUpdate.count)
        self.tblVehicles.reloadData()
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.initialSetup()
    }
    
    @IBAction func btnTaxiPressed() {
        objUpdate.removeAll()
        objUpdate = dataSourceVehicle.filter({$0.fleetType == "TAXI"}).map({$0})
        print(objUpdate.count)
        self.btnTaxi.isSelected = true
        self.btnPooling.isSelected = false
        self.btnAuto.isSelected = false
        self.lblTaxi.textColor = .black
        self.lblPool.textColor = .lightGray
        self.lblAuto.textColor = .lightGray
        self.tblVehicles.reloadData()
    }
    
    @IBAction func btnPoolPressed() {
        objUpdate.removeAll()
        objUpdate = dataSourceVehicle.filter({$0.fleetType == "POOLING"}).map({$0})
        print(objUpdate.count)
        self.btnTaxi.isSelected = false
        self.btnPooling.isSelected = true
        self.btnAuto.isSelected = false
        self.lblTaxi.textColor = .lightGray
        self.lblPool.textColor = .black
        self.lblAuto.textColor = .lightGray
        self.tblVehicles.reloadData()
    }
    @IBAction func btnAutoPressed() {
        objUpdate.removeAll()
        self.btnTaxi.isSelected = false
        self.btnPooling.isSelected = false
        self.btnAuto.isSelected = true
        self.lblTaxi.textColor = .lightGray
        self.lblPool.textColor = .lightGray
        self.lblAuto.textColor = .black
        self.tblVehicles.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         
          return UITableView.automaticDimension
      }
    
      
       func numberOfSections(in tableView: UITableView) -> Int {
          return 1
      }

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if objUpdate.count == 0 {
              self.tblVehicles.setEmptyMessage("No vehicles are available this time..!")
          } else {
              self.tblVehicles.restore()
          }

        
             return objUpdate.count
      }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
          let cell = tableView.dequeueReusableCell(withIdentifier: "ListOfVehicleCell", for: indexPath) as! ListOfVehicleCell
        
        let animation = AnimationFactory.makeFadeAnimation(duration: 0.5, delayFactor: 0.05)
        let animator = AnimatorTVC(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
        
        if("\(self.objUpdate[indexPath.row].fleetType ?? "")" == "TAXI"){
            cell.imgVehicle?.image = #imageLiteral(resourceName: "cabNew")
        }else if ("\(self.objUpdate[indexPath.row].fleetType ?? "")" == "POOLING"){
            cell.imgVehicle?.image = #imageLiteral(resourceName: "carPool")
        }else{
            cell.imgVehicle?.image = #imageLiteral(resourceName: "rickshaw")
        }
        
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(self.objUpdate[indexPath.row].coordinate?.latitude ?? 0.0)")!
        
        let lon: Double = Double("\(self.objUpdate[indexPath.row].coordinate?.longitude ?? 0.0)")!
        
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon

        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)

            var addressString = String()
        ceo.reverseGeocodeLocation(loc, completionHandler:{   (placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
            if placemarks  != nil {
                let pm = placemarks! as [CLPlacemark]

                    if pm.count > 0 {
                        let pm = placemarks![0]
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
                        //print(addressString)
                        cell.lblPlace.text = "\(addressString)"
                  }
            }
                
        })
      
            
          cell.innerView.setCardView()
          
          return cell
      }
    
    
    @objc func imageArrowTapped(){
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            
            let frame = self?.view.frame
             if (self?.isBottomSheetOpen == false){
                self?.isBottomSheetOpen = true
                let yComponent = self?.fullView
                self?.view.frame = CGRect(x: 0, y: yComponent!, width: frame!.width, height: frame!.height)
                self?.imgArrow.transform = CGAffineTransform(rotationAngle: CGFloat(CGFloat(Double.pi)))
                
            }else{
                self?.isBottomSheetOpen = false
                let yComponent = self?.partialView
               self?.view.frame = CGRect(x: 0, y: yComponent!, width: frame!.width, height: frame!.height)
                self!.imgArrow.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi) - 3.14159)
            }
        })
        
    }
    
    
    
    func initialSetup()
    {
        fullView = 320
        partialView = self.view.frame.size.height * 0.80
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
         let frame = self?.view.frame
         let yComponent = self?.partialView
         self?.view.frame = CGRect(x: 0, y: yComponent!, width: frame!.width, height: frame!.height)
        })
    }
    
    
    fileprivate func resize(textView: UITextView) {
        var newFrame = textView.frame
        let width = newFrame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: width,
                                                   height: CGFloat.greatestFiniteMagnitude))
        newFrame.size = CGSize(width: width, height: newSize.height)
        textView.frame = newFrame
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
   
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func adjustBottomSheetAccordingToScreenSize(){                   adjustBottomSheetAccordingSelection(contentYPosition: 360)
    }
    
    func adjustBottomSheetAccordingSelection(contentYPosition : CGFloat){
        UIView.animate(withDuration: 0.3, animations: {
            let frame = self.view.frame
            self.fullView = contentYPosition
            self.view.frame = CGRect(x: 0, y: self.fullView, width: frame.width, height: frame.height)
        })
    }
    
    
    
//    func callMapDataService(isFromGetDetailButtonClick : Bool){
//        if !Connectivity.isConnectedToInternet() {
//             // show Alert
//             let customAlert = commonAlert()
//                 customAlert.showAlertWithCallback(title: LanguageKey.APPNAME_SBIQUICK, message: LanguageKey.INTERNET_CONNECTIVITY_FAIL , onClick: {
//                     Log.i("Button retry tap")
//                 })
//
//         }else{
//
//            if strFormatteAddress.count > 0 {
//                if (self.btnAtm.isSelected){
//                        strFinderTypes = Constants.FinderTypes.atm.description
//                        self.btnWorkingStatus.isSelected = false
//                        self.btnWillWorkStatus.isSelected = false
//                        self.btnUnavailable.isSelected = false
//                        self.btnStatusAwaited.isSelected = false
//                    }else if (self.btnCashDeposit.isSelected){
//                        strFinderTypes = Constants.FinderTypes.cashdeposit.description
//                    }else if (self.btnBranch.isSelected){
//                        strFinderTypes = Constants.FinderTypes.branch.description
//                    }else if (self.btnCashCSP.isSelected){
//                        strFinderTypes = Constants.FinderTypes.cashcsp.description
//                    }
//
//                    let strKms = String(Int(sliderKm.value))
//                    var dictObj = [String: Any]()
//                    dictObj = ["kilometres": strKms ,"finderTypes": strFinderTypes ,"latitude" : strLatitude.prefix(8) , "longitude" : strLongitude.prefix(8)]
//
//                               Log.i(dictObj)
//                    if strLatitude.count > 0 && strLongitude.count > 0 {
//                        self.getAllDataFromBottomSheetInMapbaseListVC(finderData: dictObj, isFromGetDetailButtonClick: isFromGetDetailButtonClick)
//                    }
//            }else{
//                let customAlert = commonAlert()
//                customAlert.showAlertWithCallback(title: LanguageKey.APPNAME_SBIFINDER, message: LanguageKey.GETDETAILWHENLOCATIONNOTSELECTED , onClick: {
//
//                })
//            }
//
//        }
//    }

    
    @IBAction func close() {
        
        DispatchQueue.main.async {
        let frame = self.view.frame
       UIView.animate(withDuration: 0.6, animations: { [weak self] in
            self?.isBottomSheetOpen = false
            let yComponent = self?.partialView
        
            self?.view.frame = CGRect(x: 0, y: yComponent!, width: frame.width, height: frame.height)
            self?.imgArrow.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi) - 3.14159)
        })
        }
    }
    
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        let velocity = recognizer.velocity(in: self.view)
        let y = self.view.frame.minY
        if ( y + translation.y >= fullView) && (y + translation.y <= partialView ) {
            self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        
        if recognizer.state == .ended {
            var duration =  velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )
            
            duration = duration > 1.3 ? 1 : duration
            
            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                if  velocity.y >= 0 {
                    self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
                    
                    self.imgArrow.transform = CGAffineTransform(rotationAngle: CGFloat( CGFloat(Double.pi) - 3.14159));
                   // self.imgArrow.image = #imageLiteral(resourceName: "pullArrowUp")
                  
                } else {
                    self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: self.view.frame.height)
                    self.imgArrow.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
                    //self.imgArrow.image = #imageLiteral(resourceName: "pullArrowDown")
                }
                
                }, completion: nil)
        }
    }
    
    
    
}
