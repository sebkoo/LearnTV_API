//
//  APIhandler.swift
//  LearnTV_API
//
//  Created by Sebastian Koo on 2/10/21.
//

import Foundation

class APIhandler {
    typealias completePosts = ([User]?, Error?) -> ()
    typealias completeComments = ([Post]?, Error?) -> ()
    
    func getPostsFromAPI (withURL postsURL: String, completePosts: @escaping completePosts) {
        if let safePostsURL = URL (string: postsURL) {
            // a web browser for making HTTP GET / POST / PUT / DELETE request and getting HTTP:
            // Save the data retrieved from response into Memory in Data form
            URLSession.shared.dataTask(with: safePostsURL, completionHandler: { (data, rep, err) in
                if data != nil {
                    let decoded = JSONDecoder()
                    let users = try? decoded.decode([User].self, from: data!)
                    
                    if users != nil {
                        completePosts(users!, nil)
                    } else {
                        let output = [User]()
                        completePosts(output, nil)
                    }
                } else {
                    let user = [User]()
                    completePosts(user, nil)
                }
            }).resume()
        }
    }
    
    func getCommentsFromAPI (withURL commentsURL: String, completeComments: @escaping completeComments) {
        if let safeCommentsURL = URL (string: commentsURL) {
            // a web browser for making HTTP GET / POST / PUT / DELETE request and getting HTTP:
            // Save the data retrieved from response into Memory in Data form
            URLSession.shared.dataTask(with: safeCommentsURL, completionHandler: { (data, rep, err) in
                if data != nil {
                    let decoded = JSONDecoder()
                    let posts = try? decoded.decode([Post].self, from: data!)
                    
                    if posts != nil {
                        completeComments(posts!, nil)
                    } else {
                        let output = [Post]()
                        completeComments(output, nil)
                    }
                } else {
                    let post = [Post]()
                    completeComments(post, nil)
                }
            }).resume()
        }
    }
}
