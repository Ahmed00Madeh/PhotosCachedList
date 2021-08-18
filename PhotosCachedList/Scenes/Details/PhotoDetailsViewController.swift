//
//  PhotoDetailsViewController.swift
//  PhotosCachedList
//
//  Created by Ahmed Madeh on 14/08/2021.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var photoImageView: UIImageView!
    
    // MARK: - Variables
    let photoModel: PhotoModel
    
    // MARK: - Life Cycle
    init(photoModel: PhotoModel) {
        self.photoModel = photoModel
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    deinit {
        print(String(describing: type(of: self)) + "  Deinit")
    }

    // MARK: - Functions
    func setupView() {
        if let url = URL(string: photoModel.downloadUrl) {
            photoImageView.sd_setImage(with: url) {[weak self] (image, _, _, _) in
                guard let self = self else { return }
                self.view.backgroundColor = image?.averageColor ?? UIColor.white
            }
        }
    }
    
    // MARK: - Actions

}
