//
//  MatchesViewController.swift
//  Cologne Finder
//
//  Created by Manav Arora on 4/17/24.
//

import UIKit

class MatchesViewController: UIViewController {

    
    
    @IBOutlet weak var DetailLabel: UILabel!
    @IBOutlet weak var MatchesTableView: UITableView!
    var filteredColognes: [Cologne] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
//            MatchesTableView.register(CologneCell.self, forCellReuseIdentifier: "CologneCell")

            // Set the delegate and data source for the table view
            MatchesTableView.delegate = self
            MatchesTableView.dataSource = self
            
            // Register custom cell if you have one
            // matchesTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MatchesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredColognes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CologneCell", for: indexPath)
        
        let cologne = filteredColognes[indexPath.row]
        cell.textLabel?.text = cologne.name
        cell.detailTextLabel?.text = "\(cologne.brand) - \(cologne.price)"
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MatchesViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        // Update the detail label with the selected cologne details
//        let cologne = filteredColognes[indexPath.row]
//        DetailLabel.text = "\(cologne.name)\n\(cologne.brand) - \(cologne.price)"
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Instantiate the detail view controller from storyboard
            guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
                return
            }
            
            // Pass the selected cologne to the detail view controller
            detailVC.cologne = filteredColognes[indexPath.row]
            
            // Push the detail view controller onto the navigation stack
            navigationController?.pushViewController(detailVC, animated: true)
        }
}
