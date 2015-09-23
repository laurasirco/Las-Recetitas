//
//  DescargarYParsear.swift
//  Las Recetitas
//
//  Created by Laura Sirvent Collado on 28/8/15.
//  Copyright © 2015 Laura Sirvent Collado. All rights reserved.
//

import Foundation
import UIKit

class DescargarYParsear: NSObject {
    
    let app_id = "178e427e"
    let app_key = "f42850f63ffda23a176b10e18a0fc532"
    let busca_base_url = "http://api.campbellskitchen.com/brandservice.svc/api/search?"
    let get_base_url = "http://api.campbellskitchen.com/brandservice.svc/api/recipe/"
    
    
    //keywords=chocolate&format=json&app_id=178e427e&app_key=f42850f63ffda23a176b10e18a0fc532"
    override init() {
        
    }
    
    func descargarListaRecetasPorKeywords(keywords: String, completionHandler: ((NSArray!) -> Void)!) -> Void {
        
        var arrayRecetas : NSArray! = NSArray()

        
        var urlString = "\(busca_base_url)keywords=\(keywords)&format=json&app_id=\(app_id)&app_key=\(app_key)"
        urlString = urlString.stringByReplacingOccurrencesOfString(" ", withString: "")
        
        let url = NSURL(string: urlString)
        //let url = NSURL(string: "http://api.campbellskitchen.com/brandservice.svc/api/search?keywords=tomato&format=json&app_id=178e427e&app_key=f42850f63ffda23a176b10e18a0fc532")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            
            (data, response, error) -> Void in
            //print(data)
            if let urlContent = data {
                do {
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    
                    //print(jsonResult)
                    
                    let allObject = jsonResult as? NSDictionary
                    
                    arrayRecetas = allObject!.valueForKey("recipes") as? NSArray
                    
                    return completionHandler(arrayRecetas)
                    
                } catch {
                    print("Error JSON")
                }
            }
        }
        
        task.resume()
        

    }
    
    
    class func descargarImagen(url: NSURL, handler: ((image: UIImage, NSError!) -> Void))
    {
        let imageRequest: NSURLRequest = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(imageRequest,
            queue: NSOperationQueue.mainQueue(),
            completionHandler:{response, data, error in
                handler(image: UIImage(data: data!)!, error)
        })
    }
    
    
    func descargarRecetaPorID(ID: String, completionHandler: ((NSDictionary!) -> Void)!) -> Void {
        
        var urlString = "\(get_base_url)\(ID)?format=json&app_id=\(app_id)&app_key=\(app_key)"
        urlString = urlString.stringByReplacingOccurrencesOfString(" ", withString: "")
        
        let url = NSURL(string: urlString)
        //let url = NSURL(string: "http://api.campbellskitchen.com/brandservice.svc/api/search?keywords=tomato&format=json&app_id=178e427e&app_key=f42850f63ffda23a176b10e18a0fc532")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            
            (data, response, error) -> Void in
            //print(data)
            if let urlContent = data {
                do {
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    
                    //print(jsonResult)
                    
                    let allObject = jsonResult as? NSDictionary
                    let receta = allObject!.valueForKey("results") as? NSDictionary
                    
                    //arrayRecetas = allObject!.valueForKey("recipes") as? NSArray
                    
                    return completionHandler(receta)
                    
                } catch {
                    print("Error JSON")
                }
            }
        }
        
        task.resume()
        
    }
    
    
}