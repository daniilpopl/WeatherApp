//
//  TableViewDataSource.swift
//  WeatherApp
//
//  Created by cidr5 on 4/28/18.
//  Copyright © 2018 Ivan Akulov. All rights reserved.
//

import Foundation
import UIKit

class PassTableDataSource: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var superController: UIViewController?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell") else {return UITableViewCell(style: .default, reuseIdentifier: nil)}
        
        return cell
    }
}
