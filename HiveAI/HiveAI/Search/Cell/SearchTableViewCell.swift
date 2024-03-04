//
//  SearchTableViewCell.swift
//  HiveAI
//
//  Created by Sannica.Gupta on 02/03/24.
//

import UIKit

final class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var resultImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var resultImageViewHeightConstraint: NSLayoutConstraint!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.resultImageView.image = nil
        self.resetImageViewConstraint(height: 0, width: 0)
    }
    
    func configureCell(data: ResultData){
            self.titleLabel.text = data.title
            self.descriptionLabel.text = data.description
            if let resultImageData = data.imageData, let resultImage = resultImageData.source {
                let sizeHeight = resultImageData.height ?? 80
                let sizeWidth = resultImageData.width ?? 80
                self.resetImageViewConstraint(height: CGFloat(sizeHeight),
                                              width: CGFloat(sizeWidth))
                self.resultImageView.downloaded(from: resultImage,
                                                 contentMode: .scaleToFill)
            } else {
                self.resetImageViewConstraint(height: 0, width: 0)
            }
    }
    
    func resetImageViewConstraint(height: CGFloat, width: CGFloat){
        UIView.animate(withDuration: 0.001) {
            self.resultImageViewWidthConstraint.constant = width
            self.resultImageViewHeightConstraint.constant = height
        }
    }
}
