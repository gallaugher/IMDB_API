//
//  Movie.swift
//  IMDB_API
//
//  Created by John Gallaugher on 4/20/20.
//  Copyright © 2020 John Gallaugher. All rights reserved.
//

import Foundation

class Movie: Codable {
    struct Cast: Codable {
        var actor = ""
        var character = ""
    }
    
    var title = ""
    var year = ""
    var length = ""
    var cast: [Cast] = []

    
    func getData(title: String, completed: @escaping ()->()) {
        let searchableTitle = title.replacingOccurrences(of: " ", with: "%20")
        
        let url = URL(string: "https://imdb-internet-movie-database-unofficial.p.rapidapi.com/film/")
        
        guard url != nil else {
            print("ERROR Creating URL object")
            return
        }
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://imdb-internet-movie-database-unofficial.p.rapidapi.com/film/\(searchableTitle)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        
        let headers = ["x-rapidapi-host": "imdb-internet-movie-database-unofficial.p.rapidapi.com",
                       "x-rapidapi-key": "\(APIKeys.imdbKey)"]
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if let error = error {
                print("😡 ERROR: \(error.localizedDescription)")
            }
            
            // note: there are some additional things that could go wrong when using URL session, but we shouldn't experience them, so we'll ignore testing for these for now...
            
            // deal with the data
            do {
                let result = try JSONDecoder().decode(Movie.self, from: data!)
                self.title = result.title
                self.length = result.length
                self.year = result.year
                self.cast = result.cast
            } catch {
                print("😡 JSON ERROR: \(error.localizedDescription)")
            }
            completed()
        }

        dataTask.resume()
    }
}
