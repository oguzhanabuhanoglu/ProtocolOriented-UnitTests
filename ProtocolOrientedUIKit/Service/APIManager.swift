//
//  APIManager.swift
//  ProtocolOrientedUIKit
//
//  Created by Oğuzhan Abuhanoğlu on 29.11.2023.
//

import Foundation

//bu protokol ve devamında ki işlemlerle aslında APIManager() soyut hale geldi
protocol UserService {
    func fetchUser(completion : @escaping(Result<User,Error>) -> Void)
}

class APIManager : UserService{
    
    /* KODU MVVM E CEVİRİRKEN SİNGLETON YAPISI YERİNE PROTOCOL YAPISI KULLANACAĞIZ
    static let shared = APIManager()
    private init (){}
    */
    
    func fetchUser(completion : @escaping(Result<User,Error>) -> Void) {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {return}
            
            DispatchQueue.main.async {
                if let user = try? JSONDecoder().decode([User].self, from: data).first {
                    completion(.success(user))
                }else{
                    completion(.failure(NSError()))
                }
            }
            
        }.resume()
    }
    
}
