//
//  ViewController.swift
//  MovieTimeLineGame
//
//  Created by Ryan on 8/17/16.
//  Copyright © 2016 R. Johnson Consulting, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    // MARK: - Variables
    
    let movieCollection: MovieCollectionType

    
    
    // MARK: - INIT
    
    required init?(coder aDecoder: NSCoder) {
        
        // Checks for valid file, valid data, then creates a movie collection
        do {
            let dictionary = try PlistConverter.dictionaryFromFile("MovieCollection", ofType: "plist")
            let collection = try MovieCollectionUnarchiver.movieCollectionFromDictionary(dictionary)
            self.movieCollection = MovieCollection(collection: collection)
            
        } catch let error { // FIXME: Catch block
            fatalError("\(error)")
        }
        
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

