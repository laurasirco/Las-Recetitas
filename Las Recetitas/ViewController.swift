//
//  ViewController.swift
//  Las Recetitas
//
//  Created by Laura Sirvent Collado on 23/8/15.
//  Copyright © 2015 Laura Sirvent Collado. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var buscaButton: UIButton!
    @IBOutlet weak var buscaTextField: UITextField!
    var searchString : String!
    var arrayRecetas : NSArray!
    
    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        buscaButton.layer.borderColor = UIColor.blackColor().CGColor
        buscaButton.layer.borderWidth = 2.0
        //buscaButton.enabled = false
        
        buscaTextField.layer.borderWidth = 2.0
        let paddingView = UIView(frame: CGRectMake(0, 0, 5, 45))
        buscaTextField.leftView = paddingView
        buscaTextField.leftViewMode = UITextFieldViewMode.Always
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buscaAction(sender: AnyObject) {
        
        searchString = buscaTextField.text
        
        /*api.getData({data, error -> Void in
            if (data != nil) {
                self.items = NSMutableArray(array: data)
                self.tableView!.reloadData()
                self.view
            } else {
                println("api.getData failed")
                println(error)
            }
        })*/
        

    }

    
    func textFieldDidEndEditing(textField: UITextField) {
        resignFirstResponder();
        if(buscaTextField.text != ""){
            buscaButton.enabled = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "buscaSegue"){
            let TVController = segue.destinationViewController as? TableViewController
            TVController?.searchString = searchString
        }
    }
}

