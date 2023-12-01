//
//  UserViewModel.swift
//  ProtocolOrientedUIKit
//
//  Created by Oğuzhan Abuhanoğlu on 29.11.2023.
//

import Foundation

protocol UserViewModelOutput : AnyObject {
    func updateView(name : String, username : String, email : String)
}

class UserViewModel {
    
    private let userService : UserService
    
    //bunu weak var yapabilmek için protocolu any objecte comform etmek gerekiyor
    weak var output : UserViewModelOutput?
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func fetchUsers() {
        
        userService.fetchUser { [weak self] result in
            switch result {
            case .success(let user):
                self?.output?.updateView(name: user.name, username: user.username, email: user.email)
                
            case.failure(_):
                self?.output?.updateView(name: "No user found", username: "", email: "")
            }
        }
        
    }
}
