//
//  EventDetailViewController.swift
//  WoopSicredi3
//
//  Created by Jobe Diego Dylbas dos Santos on 04/11/21.
//

import Foundation
import UIKit

final class EventDetailViewController: UIViewController, UITableViewDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Public Properties
    
    var viewModel: EventDetailViewModel?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        setupUI()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        tableView.register(UINib(nibName: "EventDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "EventDetailTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func showCheckInResultAlert(result: Result<Data, Error>) {
        let alertController: UIAlertController
        
        switch result {
        case .success( _):
            alertController = UIAlertController(title: Constants.CheckIn.title, message: Constants.CheckIn.successMessage, preferredStyle: .alert)
        case .failure( _):
            alertController = UIAlertController(title: Constants.CheckIn.title, message: Constants.CheckIn.errorMessage, preferredStyle: .alert)
        }
        
        let okAction = UIAlertAction(title: Constants.Alert.ok, style: .default, handler: nil)
        alertController.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

// MARK: - UITableViewDataSource

extension EventDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EventDetailTableViewCell") as? EventDetailTableViewCell {
            cell.viewModel = viewModel
            cell.delegate = self
            
            cell.setupUI()
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

// MARK: - EventDetailTableViewCellDelegate

extension EventDetailViewController: EventDetailTableViewCellDelegate {
    func showCheckInAlert(for eventID: String) {
        let alertController = UIAlertController(title: Constants.CheckIn.title, message: Constants.CheckIn.message, preferredStyle: .alert)
        alertController.addTextField { (textfield: UITextField!) -> Void in
            textfield.placeholder = Constants.CheckIn.name
        }
        
        alertController.addTextField { (textfield: UITextField!) -> Void in
            textfield.placeholder = Constants.CheckIn.email
        }
        
        let saveAction = UIAlertAction(title: Constants.Alert.ok, style: .default) { (alert) -> Void in
            let nameTextField = alertController.textFields![0] as UITextField
            let emailTextField = alertController.textFields![0] as UITextField
            
            if let name = nameTextField.text, let email = emailTextField.text {
                EventAPIManager.shared.makeCheckIn(eventId: eventID, name: name, email: email) { result in
                    self.showCheckInResultAlert(result: result)
                }
            } else {
                self.showCheckInResultAlert(result: .failure(NullError.foundNil))
            }
        }
        
        let cancelAction = UIAlertAction(title: Constants.Alert.cancel, style: .cancel, handler: nil)
    
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
