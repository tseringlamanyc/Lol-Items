//
//  ViewController.swift
//  Lol-Items
//
//  Created by Tsering Lama on 11/24/20.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    let apiClient = APIClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }

    private func loadItems() {
        apiClient.fetchItems { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let items):
                dump(items)
            }
        }
    }

}

