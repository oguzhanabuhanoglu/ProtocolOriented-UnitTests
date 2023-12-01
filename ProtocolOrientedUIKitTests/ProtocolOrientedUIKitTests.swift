//
//  ProtocolOrientedUIKitTests.swift
//  ProtocolOrientedUIKitTests
//
//  Created by Oğuzhan Abuhanoğlu on 29.11.2023.
//

import XCTest
@testable import ProtocolOrientedUIKit

final class ProtocolOrientedUIKitTests: XCTestCase {
    
    private var userViewModel : UserViewModel!
    private var userService : MockUserService!
    
    private var output :MockUserViewModelOutput!
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        userService = MockUserService()
        userViewModel = UserViewModel(userService: userService)
        output = MockUserViewModelOutput()
        // userviewmodel da ki apiden gelen outputu buradaki mock outputa eşitledik.
        userViewModel.output = output
        
    }

    
    func testUpdateView_WhenAPISucces_showsNameUsernameEmail() throws {
        
        let mockUser = User(id: 1, name: "oguz", username: "abushanoglu", email: "oguzhanabuhanoglu@gmail.com", address: Address(street: "", suite: "", city: "", zipcode: "", geo: Geo(lat: "", lng: "")), phone: "", website: "", company: Company(name: "", catchPhrase: "", bs: ""))
        
        userService.fetchUserMockResult = .success(mockUser)
        
        userViewModel.fetchUsers()
        
        XCTAssertEqual(output.updateViewAttay.first?.username, "abushanoglu")
    }
    

}


class MockUserService : UserService {
    var fetchUserMockResult : Result<ProtocolOrientedUIKit.User, Error>?
    func fetchUser(completion: @escaping (Result<ProtocolOrientedUIKit.User, Error>) -> Void) {
        if let result = fetchUserMockResult{
            completion(result)
        }
    }
}

class MockUserViewModelOutput : UserViewModelOutput{
    var updateViewAttay : [(name : String, username : String, email : String)]=[]
    func updateView(name: String, username: String, email: String) {
        updateViewAttay.append((name,username,email))
    }
    
    
}
