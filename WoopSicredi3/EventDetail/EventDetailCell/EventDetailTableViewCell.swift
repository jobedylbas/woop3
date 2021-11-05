//
//  EventDetailTableViewCell.swift
//  WoopSicredi3
//
//  Created by Jobe Diego Dylbas dos Santos on 04/11/21.
//

import Foundation
import UIKit

protocol EventDetailTableViewCellDelegate: AnyObject {
    func showCheckInAlert(for eventID: String)
}

final class EventDetailTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var eventImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var checkInButton: UIButton!
    
    // MARK: - Public Properties
    
    var viewModel: EventDetailViewModel?
    var delegate: EventDetailTableViewCellDelegate?
    
    // MARK: - Public Methods
    
    func setupUI() {
        self.selectionStyle = .none
        
        eventImageView?.layer.cornerRadius = 20
        eventImageView?.layer.masksToBounds = true
        
        checkInButton.layer.cornerRadius = 10
        checkInButton.layer.masksToBounds = true
        
        guard let _viewModel = viewModel else { return }
        
        titleLabel.text = _viewModel.event.title
        descriptionLabel.text = _viewModel.event.description
        dateLabel.text = _viewModel.getDate()
        priceLabel.text = _viewModel.getPrice()
        
        let _ = checkInButton.rx.tap.bind { [self] event in
            guard let _viewModel = self.viewModel else { return }
            self.delegate?.showCheckInAlert(for: _viewModel.event.id)
        }
        
        guard let image = _viewModel.image else { return }
        
        eventImageView?.image = UIImage(data: image)?.resized(to: CGSize(width: UIScreen.main.bounds.width-32, height: 204.0))
    }
    
}
