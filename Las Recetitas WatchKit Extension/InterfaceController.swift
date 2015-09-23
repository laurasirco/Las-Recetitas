//
//  InterfaceController.swift
//  Las Recetitas WatchKit Extension
//
//  Created by Laura Sirvent Collado on 23/8/15.
//  Copyright © 2015 Laura Sirvent Collado. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    @IBOutlet var pasoLabel: WKInterfaceLabel!
    @IBOutlet var descripcionPaso: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        
        super.awakeWithContext(context)
        
        let paso = context as! NSDictionary
        
        let descPaso = paso.objectForKey("TipText") as! String
        let numPaso = paso.objectForKey("TipNumber") as! NSNumber
        descripcionPaso.setText(descPaso)
        pasoLabel.setText("Paso \(numPaso)")
        
        self.setTitle("Cerrar")
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    


}
