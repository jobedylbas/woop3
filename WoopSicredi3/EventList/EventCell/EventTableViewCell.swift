//
//  EventCellView.swift
//  WoopSicredi3
//
//  Created by Jobe Diego Dylbas dos Santos on 01/11/21.
//

import Foundation
import UIKit
import RxSwift

final class EventTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var eventImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    // MARK: - Public Properties
    
    var viewModel: EventTableViewCellViewModel? {
        didSet {
            guard let _viewModel = viewModel else { return }
            titleLabel.text = _viewModel.event.title
            descriptionLabel.text = _viewModel.event.description
            dateLabel.text = viewModel?.getDate()
            priceLabel.text = viewModel?.getPrice()
        }
    }
    
    // MARK: - Public Methods
    
    func setupUI() {
        guard let image = viewModel?.image else { return }
        
        imageView?.image = UIImage(data: image)?.resized(to: CGSize(width: 160, height: 160))
        imageView?.layer.cornerRadius = 20
        imageView?.layer.masksToBounds = true
        
        self.layoutSubviews()
        
    }
}
