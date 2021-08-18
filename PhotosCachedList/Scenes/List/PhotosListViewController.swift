//
//  PhotosListViewController.swift
//  PhotosCachedList
//
//  Created by Ahmed Madeh on 14/08/2021.
//

import UIKit

class PhotosListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    let dataSource: DataSource
    var model = PagedModel<PhotoModel>()
    
    // MARK: - Life Cycle
    init(dataSource: DataSource) {
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(String(describing: type(of: self)) + "  Deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Functions
    func setupView() {
        tableView.registerCell(ofType: PhotoTableViewCell.self)
        getPhotosData()
    }
    
    func getPhotosData() {
        dataSource.loadData().done { [weak self] response in
            guard let self = self else { return }
            self.model.append(items: response)
            CacheManager.cache(response)
            self.tableView.reloadData()
        }.catch { error in }.finally { }
    }
    
    func getMorePhotoData() {
        dataSource.loadMoreData(page: model.nextPage)?.done({[weak self] response in
            guard let self = self else { return }
            self.model.append(items: response)
            CacheManager.cache(response)
            self.tableView.reloadData()
        }).catch { error in }.finally { }
    }
    
    // MARK: - Actions

}

extension PhotosListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        model.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PhotoTableViewCell = tableView.dequeueReusableCell()!
        let item = model.items[indexPath.section][indexPath.row]
        cell.populate(item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = AdPlaceholderView()
        view.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 116)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 116
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(PhotoDetailsViewController(photoModel: model.items[indexPath.section][indexPath.row]), animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if model.hasNextPage && section + 1 == model.items.count {
            getMorePhotoData()
        }
    }
    
}
