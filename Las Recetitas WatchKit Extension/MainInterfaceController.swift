//
//  MainInterfaceController.swift
//  Las Recetitas
//
//  Created by Laura Sirvent Collado on 31/8/15.
//  Copyright © 2015 Laura Sirvent Collado. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class MainInterfaceController: WKInterfaceController, WCSessionDelegate {

    var session : WCSession!
    var pasos : NSArray = []
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        pasos = NSArray()
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        pasos = NSArray()
        
        if(WCSession.isSupported()){
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        pasos = message["pasosArray"] as! NSArray
        print("Watch: ")
        print(pasos)
        
        //let paso = pasos[0] as! NSDictionary
        //let numPaso = paso.objectForKey("TipNumber") as! NSNumber
        //let descPaso = paso.objectForKey("TipText") as! String
        
        //pasoLabel.setText("Paso \(numPaso)")
        //descripcionPaso.setText(descPaso)
        
        //let objects  = ["1", "2", "3", "4", "5"]
        let controllers = Array(count: pasos.count, repeatedValue: "Page")
        presentControllerWithNames(controllers, contexts: pasos as [AnyObject])
        /*let hashtagString = message["hashtagString"] as? String
        titulo.setText(hashtagString)*/
    }
}
