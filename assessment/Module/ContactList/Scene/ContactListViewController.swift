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
    private var dataSource: ContactListTableViewDataSource<ContactListTableViewCell, ContactList>!
    
    public var searchText: String = ""
    
    var activityView: UIActivityIndicatorView?

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Contacts"
        callToViewModelForUIUpdate()
        
        let nib = UINib(nibName: "ContactListTableViewCell", bundle: Bundle.main)
        listView.register(nib, forCellReuseIdentifier: "ContactListTableViewCell")
        listView.tableFooterView = UIView(frame: .zero)
        listView.rowHeight = 80
        listView.delegate = self
    }
    
    //MARK: - View Model
    func callToViewModelForUIUpdate(){
        self.contactListViewModel = ContactListViewModel()
        
        //* Call APi
        self.showActivityIndicator()
        self.contactListViewModel.callFuncToGetData()
        
        //* Display data
//        self.contactListViewModel.bindContactListViewModelToController = {
//            if self.contactListViewModel.contactListData.count > 0 {
        DispatchQueue.main.async {
                self.updateDataSource()
        }
//            }
//            else {
//                self.displayNoDataAlert()
//            }
            
//        }
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
    
    func displayNoDataAlert() {
        DispatchQueue.main.async {
            self.hideActivityIndicator()
            let alert = UIAlertController(title: "Error", message: self.contactListViewModel.apiError, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
            
            self.navigationController?.popViewController(animated: true)
        }
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

extension ContactListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contactDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContactDetailViewController") as! ContactDetailViewController
        contactDetailViewController.contactData = self.contactListViewModel.contactListData[indexPath.row]
        self.navigationController?.pushViewController(contactDetailViewController, animated: true)
    }
}
