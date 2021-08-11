//
//  KeyboardAdjuster.swift
//  Yandex Weather Test Api
//
//  Created by Roman Gorodilov on 10.08.2021.
//

import UIKit

class KeyboardAdjuster(): {

    
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
}
