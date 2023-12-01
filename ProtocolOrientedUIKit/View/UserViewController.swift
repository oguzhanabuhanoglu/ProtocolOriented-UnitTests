//
//  ViewController.swift
//  ProtocolOrientedUIKit
//
//  Created by Oğuzhan Abuhanoğlu on 29.11.2023.
//

import UIKit

class UserViewController: UIViewController, UserViewModelOutput {
    
    func updateView(name: String, username: String, email: String) {
        self.nameLabel.text = name
        self.usernameLabel.text = username
        self.emailLabel.text = email
    }
    
    
    private let viewModel : UserViewModel
    
    init(viewModel: UserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.output = self
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let usernameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let emailLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViews()
        viewModel.fetchUsers()
        
    }
    
    private func setupViews() {
        
        view.backgroundColor = .yellow
        
        view.addSubview(nameLabel)
        view.addSubview(usernameLabel)
        view.addSubview(emailLabel)
        
        //kodla constrait vermek (.frame = cgrect()) ile de yapılabilir.bu sadece farklı bir yontem
        
        NSLayoutConstraint.activate([
    
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 200),
            nameLabel.heightAnchor.constraint(equalToConstant: 60),
            
            
            usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameLabel.widthAnchor.constraint(equalToConstant: 200),
            usernameLabel.heightAnchor.constraint(equalToConstant: 60),
            
            
            emailLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10),
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailLabel.widthAnchor.constraint(equalToConstant: 200),
            emailLabel.heightAnchor.constraint(equalToConstant: 60)
            

        
        ])
       
    }
    
    /* BU MVC GİBİ YAZDIĞIMIZ TARAF.SERVİCEDEN DİREK BURAYA GELDİĞİMİZ AMA BUNU MVVM E CEVİRECEĞİZ.VİEWCONTROLLERDA SADECE GÖRÜNÜM İŞLEMLERİ YAPABİLMEK İÇİN.
    func fetchUsers() {
        
        APIManager.shared.fetchUser { result in
        
            switch result {
            case .success(let user):
                self.nameLabel.text = user.name
                self.usernameLabel.text = user.username
                self.emailLabel.text = user.email
                
            case .failure:
                self.nameLabel.text = "No user found"
            }
        }
    }*/


}

