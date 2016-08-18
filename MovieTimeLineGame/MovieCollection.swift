//
//  MovieCollection.swift
//  MovieTimeLineGame
//
//  Created by Ryan on 8/17/16.
//  Copyright © 2016 R. Johnson Consulting, LLC. All rights reserved.
//

import Foundation



// MARK: - Protocols

protocol MovieType {
    
    var title: String { get }
    var year: Int { get }
    var url: String { get }
}

protocol MovieCollectionType {
    
    var collection: [MovieType] { get set } // Array containing collection of all the movies
    
    init(collection: [MovieType])
}



// MARK: - Error Types

enum CollectionError: ErrorType {
    case InvalidResource
    case ConversionError
    case InvalidKey
}



// MARK: - Concrete Types

struct Movie: MovieType {
    let title: String
    let year: Int
    let url: String
}

struct MovieCollection: MovieCollectionType {
    
    var collection: [MovieType] = []
    
    init(collection: [MovieType]) {
        self.collection = collection
    }
    
}


// MARK: - Helper Classes

// Converts .plist file into dictionary
class PlistConverter {
    class func dictionaryFromFile(resource: String, ofType type: String) throws -> [String : AnyObject] {
        
        // Check for valid resource path
        guard let path = NSBundle.mainBundle().pathForResource(resource, ofType: type) else {
            throw CollectionError.InvalidResource
        }
        
        // Check for valid dictionary conversion
        guard let dictionary = NSDictionary(contentsOfFile: path),
        let castDictionary = dictionary as? [String : AnyObject] else {
            throw CollectionError.ConversionError
        }
        
        return castDictionary
    }
}

// Converts dictionary to array of MovieTypes
class MovieCollectionUnarchiver {
    class func movieCollectionFromDictionary(dictionary: [String : AnyObject]) throws -> [MovieType] {
        
        var collection: [MovieType] = []
        
        for (_, value) in dictionary {
            if let movieDict = value as? [String : AnyObject] {
                // Unwrap variables from dictionary
                guard let title = movieDict["title"] as? String, let year = movieDict["year"] as? Int, let url = movieDict["url"] as? String else {
                    throw CollectionError.InvalidKey
                }
                
                collection.append(Movie(title: title, year: year, url: url))
            }
        }
        
        return collection
    }
}




