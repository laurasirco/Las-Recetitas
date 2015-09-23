//
//  RecetaViewController.swift
//  Las Recetitas
//
//  Created by Laura Sirvent Collado on 27/8/15.
//  Copyright © 2015 Laura Sirvent Collado. All rights reserved.
//

import UIKit
import QuartzCore
import WatchConnectivity

class RecetaViewController: UIViewController, WCSessionDelegate {

    @IBOutlet weak var mandaButton: UIButton!
    @IBOutlet weak var image: UIImageView!    
    @IBOutlet var recipeTitle: UILabel!
    @IBOutlet var descriptionText: UITextView!
    
    var recipeID : NSNumber!
    var receta : NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mandaButton.layer.borderWidth = 2.0
        mandaButton.layer.borderColor = UIColor.blackColor().CGColor
        
        
        
        receta = NSDictionary()
        
        let descargador = DescargarYParsear()
        
        descargador.descargarRecetaPorID(recipeID.stringValue, completionHandler: { receta -> Void in
            self.receta = receta
            self.updateValues()
        })
        // Do any additional setup after loading the view.
    }
    
    func updateValues(){
        
        dispatch_async(dispatch_get_main_queue()){
            self.recipeTitle.text = self.receta.valueForKey("name") as? String
            self.descriptionText.text = self.receta.valueForKey("description") as? String
            
            let urlString = self.receta.valueForKey("mobileimg") as? String
            
            DescargarYParsear.descargarImagen(NSURL(string: urlString!)!, handler: {image, error in
                self.image.image = image
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mandarAlWatchAction(sender: AnyObject) {
        
        
        let pasos = self.receta.valueForKey("steps") as! NSArray
        
        
        
        if #available(iOS 9.0, *) {
            if (WCSession.isSupported()){
                let session = WCSession.defaultSession()
                session.delegate = self
                session.activateSession()
            
                let applicationData  = ["pasosArray":NSArray!(pasos)]
            
                session.sendMessage(applicationData, replyHandler: {(_: [String : AnyObject]) -> Void in
                    // handle reply from Watch app here
                    }, errorHandler: {(error ) -> Void in
                        // catch any errors here
                    })
                }
        } else {
            // Fallback on earlier versions
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
