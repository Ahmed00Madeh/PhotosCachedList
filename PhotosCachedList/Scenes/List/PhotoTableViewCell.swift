//
//  PhotoTableViewCell.swift
//  PhotosCachedList
//
//  Created by Ahmed Madeh on 14/08/2021.
//

import UIKit
import SDWebImage

class PhotoTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    
    // MARK: - Variables
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func populate(_ photoModel: PhotoModel) {
        if let url = URL(string: photoModel.downloadUrl) {
            photoImageView.sd_setImage(with: url, completed: nil)
        }
        authorLabel.text = photoModel.author
    }
    
}
