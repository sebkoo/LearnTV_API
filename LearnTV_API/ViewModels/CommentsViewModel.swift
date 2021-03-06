//
//  CommentViewModel.swift
//  LearnTV_API
//
//  Created by Sebastian Koo on 2/10/21.
//

import Foundation

class CommentsViewModel {
    typealias completionBlock = ([Post]?, Error?) -> ()
    var apiHandler = APIhandler()
    var dataSource = [Post]()
    
    func getCommentsFromAPIhandler (commentsURL: String, completionBlock: @escaping completionBlock) {
        apiHandler.getCommentsFromAPI(withURL: commentsURL) { [weak self] (comments, err)  in
            self?.dataSource = comments!
            completionBlock(comments!, nil)
        }
    }
    
    func getNumberOfRowsInSection() -> Int {
        return dataSource.count
    }
    
    func getPostAtIndex (index: Int) -> Post {
        let post = dataSource[index]
        return post
    }
    
    func getPostCellData (index: Int) -> String {
        let post = self.getPostAtIndex(index: index)
        let postId = post.postId ?? 0
        let id = post.id ?? 0
        let name = post.name ?? ""
        let email = post.email ?? ""
        return "PostId- \(postId) ID- \(id) Name- \(name) Email- \(email)"
    }
    
    func getPostCellDetail (index: Int) -> String {
        let user = self.getPostAtIndex(index: index)
        let body = user.body ?? ""
        return "Body- \(body)"
    }
}
