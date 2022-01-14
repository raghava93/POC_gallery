//
//  ViewController.swift
//  imagePicker
//
//  Created by Raghavendra reddy on 14/01/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageTable: UITableView!
    var activityIndicator = UIActivityIndicatorView()
    lazy var homeModel = HomeViewModel(_networkManager: NetworkManager())
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        navigationController?.title = "Shopping"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        
        
        //        show alert for error
        homeModel.showError = {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.showAlert("Ups, something went wrong.")
            }
        }
        //        show indicator
        homeModel.showLoading = {
            DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
            }
            
        }
        //        hide indicator
        homeModel.hideLoading = {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
        }
        
        //        fetch product details and update in table
        homeModel.getProducts(completion: { [weak self] in
            debugPrint("called reload")
            DispatchQueue.main.async {
                self?.imageTable.reloadData()
            }
        })
        
    }

    //    configure tableview to home view controller
    func configureTable() {
        imageTable.largeContentTitle = "Shopping"
        imageTable.delegate = self
        imageTable.dataSource = self
        imageTable.separatorColor = .gray
        imageTable.separatorStyle = .singleLine
        imageTable.tableFooterView = UIView()
        imageTable.allowsMultipleSelection = false
        imageTable.layoutMargins = UIEdgeInsets.zero
        imageTable.separatorInset = UIEdgeInsets.zero
        imageTable.backgroundView = activityIndicator // add indicator as backgrounf view
        activityIndicator.color = #colorLiteral(red: 0.1808195114, green: 0.1178461984, blue: 0.7841414213, alpha: 1)
        imageTable.center = activityIndicator.center
        activityIndicator.style = .large
        //         register cell for table view
        imageTable.register(ProductCell.nib(), forCellReuseIdentifier: ProductCell.identifier())
    }

}


// MARK:- TableView datasource
extension ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
// MARK:- TableView delegate
extension ViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeModel.ImagesList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier(), for: indexPath) as? ProductCell else { fatalError("xib does not exists") }
        let cellVM = homeModel.getCellViewModel(at: indexPath)
        cell.layoutMargins = .zero
        cell.cellViewModel = cellVM
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let product =  homeModel.getCellViewModel(at: indexPath)!
//        showDetailsVC(product: product)
    }
}
