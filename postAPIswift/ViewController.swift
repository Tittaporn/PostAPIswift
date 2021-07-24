//
//  ViewController.swift
//  postAPIswift
//
//  Created by Lee on 7/22/21.
//

import UIKit

class ViewController: UIViewController {
    
    struct Post: Codable {
        let userId: Int
        let id: Int
        let title: String
        let body: String
    }
    
    struct TestPost: Codable {
        var userId: Int = 0
        var id: Int = 0
        var title: String = ""
        var body: String = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let newPost = Post(userId: 1, id: 123, title: "Hello Word!", body: "This is my first post in swift!")
        do {
            let jsonBody = try JSONEncoder().encode(newPost)
            print("\n===================TEST! jsonBody :  \(jsonBody) IN \(#function) ======================\n")
            request.httpBody = jsonBody
        } catch {
            print("\n===================TEST! \(error.localizedDescription) IN\(#function) ======================\n")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("\n===================ERROR! \(error.localizedDescription) IN\(#function) ======================\n")
            }
            if let response = response as? HTTPURLResponse{
                print("=================== Response Code : \(response.statusCode)======================\(#function)")
            }
            guard let data = data else {return}
            do {
                let sentPost = try JSONDecoder().decode(Post.self, from: data)
                print("=================== TEST sentPost From Decode : \(sentPost)======================\(#function)")
            } catch {
                print("\n===================ERROR! \(error.localizedDescription) IN\(#function) ======================\n")
            }
        }
        task.resume()
    }
    
    // MARK: - TEST POST DEBUGGING
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        var testPost: ViewController.TestPost?
        if  testPost != nil {
            testPost?.userId = 2
            testPost?.id = 3
            testPost?.body = "test post"
            testPost?.title = "test title"
        } else {
            testPost = ViewController.TestPost()
            testPost?.userId = 2
            testPost?.id = 3
            testPost?.body = "else test post"
        }
        
        print("\n===================TEST! testPost Before Encode : \(testPost) IN \(#function) ======================\n")
        do {
            let jsonBody = try JSONEncoder().encode(testPost)
            print("\n===================TEST! testPost jsonBody : \(testPost) IN \(#function) ======================\n")
            request.httpBody = jsonBody
        } catch {
            print("\n=================== TEST! \(error.localizedDescription) IN \(#function) ======================\n")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("\n=================== ERROR if let error = error ! \(error.localizedDescription) IN \(#function) ======================\n")
            }
            if let response = response as? HTTPURLResponse{
                print("=================== Response Code : \(response.statusCode)======================\(#function)")
            }
            guard let data = data else {return}
            do {
                let sentPost = try JSONDecoder().decode(TestPost.self, from: data)
                print("=================== TEST testPost From Decode: \(sentPost)======================\(#function)")
            } catch {
                print("\n===================ERROR! After guard let data = data else {return} \(error.localizedDescription) IN \(#function) ======================\n")
            }
        }
        task.resume()
    }
}

