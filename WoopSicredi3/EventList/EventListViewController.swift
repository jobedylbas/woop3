//
//  EventListViewController.swift
//  WoopSicredi3
//
//  Created by Jobe Diego Dylbas dos Santos on 01/11/21.
//

import UIKit
import RxSwift
import RxCocoa

final class EventListViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Public Properties
    
    var viewModel = EventListViewModel()
    var detailViewModel: EventDetailViewModel? = nil
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    // MARK: Private Methods
    
    private func setupUI() {
        tableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventTableViewCell")
        
        viewModel.events.bind(to: tableView.rx.items(cellIdentifier: "EventTableViewCell", cellType: EventTableViewCell.self)) { (row, event, cell) in
            let cellViewModel = EventTableViewCellViewModel(event: event)
            
            cellViewModel.fetchImage() {
                DispatchQueue.main.async {
                    cell.viewModel = cellViewModel
                    cell.setupUI()
                }
            }
            
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Event.self)
            .asObservable()
            .bind{ [weak self] model in
                guard let self = self else { return }
                let detailViewModel = EventDetailViewModel(event: model)
                let eventViewModel = EventTableViewCellViewModel(event: model)
                
                eventViewModel.fetchImage {
                    detailViewModel.image = eventViewModel.image
                }

                self.detailViewModel = detailViewModel
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "goToEventDetail", sender: self)
                }
                
            }.disposed(by: disposeBag)
        
        viewModel.fetchEvents()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! EventDetailViewController
        viewController.viewModel = self.detailViewModel
    }
}

