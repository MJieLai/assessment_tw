//
//  ContactDetailViewController.swift
//  assessment
//
//  Created by Hexa-MingJie.Lai on 16/10/2021.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    //MARK: - Variable
    private var contactDetailViewModel : ContactDetailViewModel!
        
    // MARK: - Outlets
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var mainInfoLabel: UILabel!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var firstNameTextfield: UITextField!
    
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var lastNameTextfield: UITextField!
    
    @IBOutlet weak var subInfoLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneTextfield: UITextField!
    
    //MARK: Variable
    public var contactData: ContactList = ContactList(id: "", firstName: "", lastName: "", email: "", phone: "")
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupUI()
        setupContactData()
    }
    
    
    
    //MARK: - View set up
    func setupContactData() {
        firstNameTextfield.text = contactData.firstName
        lastNameTextfield.text = contactData.lastName
        emailTextfield.text = contactData.email
        phoneTextfield.text = contactData.phone
    }
    
    func setupNavigationBar() {
        self.navigationItem.hidesBackButton = true
        
        self.title = ""

        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAction))
        self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationItem.leftBarButtonItem = cancelBtn
        
        let saveBtn = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveAction))
        self.navigationItem.rightBarButtonItem = saveBtn
    }
    
    func setupUI() {
        headerImageView.layer.cornerRadius = 50
        headerImageView.layer.masksToBounds = true
        
        mainInfoLabel.font = UIFont.boldSystemFont(ofSize: 16)
        mainInfoLabel.text = "Main Information"
        
        firstNameLabel.font = UIFont.systemFont(ofSize: 14)
        firstNameLabel.text = "First Name"
        
        lastNameLabel.font = UIFont.systemFont(ofSize: 14)
        lastNameLabel.text = "Last Name"
        
        subInfoLabel.font = UIFont.boldSystemFont(ofSize: 16)
        subInfoLabel.text = "Sub Information"
        
        emailLabel.font = UIFont.systemFont(ofSize: 14)
        emailLabel.text = "Email"
        
        phoneLabel.font = UIFont.systemFont(ofSize: 14)
        phoneLabel.text = "Phone"
    }
    
    //MARK:- Button Method
    @objc func cancelAction(sender: UIButton!) {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func saveAction(sender: UIButton!) {
        
    }
}

