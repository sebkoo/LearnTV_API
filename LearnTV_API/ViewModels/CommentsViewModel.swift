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
    
    func getDataFromAPIhandler (commentsURL: String, completionBlock: @escaping completionBlock) {
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
    
    func getCellData (index: Int) -> String {
        let post = self.getPostAtIndex(index: index)
        let postId = post.postId ?? 0
        let id = post.id ?? 0
        let name = post.name ?? ""
        let email = post.email ?? ""
        let rep = "PostId- \(postId)" + "ID- \(id)" + "Name- \(name) " + "Email- \(email)"
        return rep
    }
    
    func getDetailCellData (index: Int) -> String {
        let user = self.getPostAtIndex(index: index)
        let body = user.body ?? ""
        let detail = "Body- \(body)"
        return detail
    }
}
