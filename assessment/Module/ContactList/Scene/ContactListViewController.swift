//
//  ContactListViewController.swift
//  assessment
//
//  Created by Hexa-MingJie.Lai on 16/10/2021.
//

import UIKit

class ContactListViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var listView: UITableView!
    
    //MARK: - Variables
    private var contactListViewModel : ContactListViewModel!
    private var dataSource: ContactListTableViewDataSource<ContactListTableViewCell, Contact>!
    
    var activityView: UIActivityIndicatorView?
    
    let refreshControl = UIRefreshControl()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupView()
        callToViewModelForUIUpdate()
    }
    
    //MARK: - View Set up
    func setupNavigationBar() {
        self.title = "Contacts"

        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchAction))
        navigationItem.leftBarButtonItem = searchButton
        navigationItem.leftBarButtonItem?.tintColor = UIColor(rgb: 0xff8c00)
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.rightBarButtonItem?.tintColor = UIColor(rgb: 0xff8c00)
    }
    
    func setupView() {
        let nib = UINib(nibName: "ContactListTableViewCell", bundle: Bundle.main)
        listView.register(nib, forCellReuseIdentifier: "ContactListTableViewCell")
        listView.tableFooterView = UIView(frame: .zero)
        listView.rowHeight = 80
        listView.delegate = self
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)

        listView.addSubview(refreshControl)
    }

    //MARK: - View Model
    func callToViewModelForUIUpdate(){
        self.contactListViewModel = ContactListViewModel()
        
        //* Call APi
        self.showActivityIndicator()
        self.contactListViewModel.getContactListData()
        
        //* Display data
        DispatchQueue.main.async {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        self.dataSource = ContactListTableViewDataSource(cellIdentifier: "ContactListTableViewCell", items: self.contactListViewModel.contactListData, configureCell: { (cell, evm) in
            cell.contactNameLabel.text = "\(evm.firstName ?? "") \(evm.lastName ?? "")"
        })
        
        DispatchQueue.main.async {
            self.hideActivityIndicator()
            self.listView.dataSource = self.dataSource
            self.listView.reloadData()
        }
    }

    //MARK:- Actions 
    @objc func refresh(_ sender: AnyObject) {
        self.contactListViewModel.getContactListData()
        
        DispatchQueue.main.async {
            self.updateDataSource()
            self.refreshControl.endRefreshing()
        }
    }
    
    @objc func searchAction(sender: UIButton!) {
        
    }
    
    @objc func addAction(sender: UIButton!) {
        
    }
    
    //MARK: - Helper
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
    }

    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }
}

extension ContactListViewController: UpdateContactDelegate {
    func updateContact(contact: Contact) {
        if let index = self.contactListViewModel.contactListData.firstIndex(where: {$0.id == contact.id}) {
            self.contactListViewModel.contactListData.remove(at: index)
            self.contactListViewModel.contactListData.insert(contact, at: index)
        }
        self.updateDataSource()
    }
}

extension ContactListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contactDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContactDetailViewController") as! ContactDetailViewController
        contactDetailViewController.contactData = self.contactListViewModel.contactListData[indexPath.row]
        contactDetailViewController.delegate = self
        self.navigationController?.pushViewController(contactDetailViewController, animated: true)
    }
}
