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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let newPost = Post(userId: 1, id: 123, title: "Hello Word!", body: "This is my first post in swift!")
        do {
            let jsonBody = try JSONEncoder().encode(newPost)
            request.httpBody = jsonBody
        } catch {
            print("\n===================ERROR! \(error.localizedDescription) IN\(#function) ======================\n")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("\n===================ERROR! \(error.localizedDescription) IN\(#function) ======================\n")
            }
            if let response = response as? HTTPURLResponse{
                print("=================== Response Code : \(response.statusCode)======================")
            }
            guard let data = data else {return}
            do {
                let sentPost = try JSONDecoder().decode(Post.self, from: data)
                print("=================== sentPost : \(sentPost)======================")
            } catch {
                print("\n===================ERROR! \(error.localizedDescription) IN\(#function) ======================\n")
            }
        }
        task.resume()
    }
}

