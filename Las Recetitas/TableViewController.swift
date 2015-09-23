//
//  TableViewController.swift
//  Las Recetitas
//
//  Created by Laura Sirvent Collado on 27/8/15.
//  Copyright © 2015 Laura Sirvent Collado. All rights reserved.
//

import UIKit
import QuartzCore

class TableViewController: UITableViewController {

    var arrayRecetas : NSArray!
    var searchString : String!
    var selectedRow : NSIndexPath!
    //var cachedImages : NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        arrayRecetas = NSArray()
        //cachedImages = NSMutableArray()
        
        let descargador = DescargarYParsear()
        descargador.descargarListaRecetasPorKeywords(searchString, completionHandler: {arrayRecetas -> Void in
            self.arrayRecetas = arrayRecetas
            //print(arrayRecetas)
            
            self.tableView.reloadData()
        })
        //print(arrayRecetas)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayRecetas.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("recetaCell", forIndexPath: indexPath) as! TableViewCell

        let receta : NSDictionary = arrayRecetas[indexPath.row] as! NSDictionary
        cell.title.text = receta.objectForKey("name") as? String
        cell.recipeDesc.text = receta.objectForKey("description") as? String
        
        /*let urlString = receta.objectForKey("recipelink") as! String
        print(urlString)

        print(cachedImages.count)
        print(indexPath.row)
        if cachedImages.count > indexPath.row{
           let cachedImage = cachedImages.objectAtIndex(indexPath.row) as? UIImage
            cell.background.image = cachedImage
        }
        else{
            DescargarYParsear.descargarImagen(NSURL(string: urlString)!, handler: {image, error in
                cell.background.image = image
                self.cachedImages.insertObject(image, atIndex: indexPath.row)
            })
        }*/
        
        return cell
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedRow = indexPath
        //print(self.selectedRow)
        
        self.performSegueWithIdentifier("verReceta", sender: indexPath)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let originCell = sender as! NSIndexPath
        let RecetaVC = segue.destinationViewController as? RecetaViewController
        
        let receta : NSDictionary = arrayRecetas[originCell.row] as! NSDictionary
        let recipe_id = receta.objectForKey("recipe_id") as! NSNumber
        RecetaVC?.recipeID = recipe_id
        
    }
    

}
