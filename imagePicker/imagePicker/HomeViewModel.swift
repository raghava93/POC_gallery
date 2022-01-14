//
//  HomeViewModel.swift
//  Shopping App
//
//  Created by Raghavendra reddy on 22/12/21.
//

import Foundation


class HomeViewModel{
    
    var ImagesList:[ImageElement]? = nil
    var networkManager:NetworkManager?
    
//    callbacks for handling UI
    var showError: (()->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?
    
//    initialiser with network manager as dependency
    init(_networkManager:NetworkManager) {
        networkManager = _networkManager
    }
    
    
    //     fetch data from API
    func getProducts(completion:@escaping (()->Void))  {
        self.showLoading?()
            //  check for internet connectivity
            if (!Reachability.isConnectedToNetwork()){
                    hideLoading?()
                    completion()
                    showError!()
            }else{
                // fetch product details from DB
                networkManager?.fetchResponse(url: Urls.productsUrl, httpHeader:.application_json, complete: { [weak self] (success, response) in
                    if success {
                        do {
                            // decode product model from JSON
                            let model = try JSONDecoder().decode([ImageElement].self, from: response!)
                            
                            self!.ImagesList = model.sorted{
                                $0.id < $1.id
                            }
                            self?.hideLoading?()
                            completion()
                           
                        } catch (let fail) {
                            debugPrint("failed model \(fail.localizedDescription)")
                            self?.showError?()
                        }
                    } else {
                        self?.showError?()
                    }
                })
            }
        
        
    }
    
    // get cell details
    func getCellViewModel(at indexPath: IndexPath) -> ImageElement? {
        
        return ImagesList?[indexPath.row]
    }
    
    
}

