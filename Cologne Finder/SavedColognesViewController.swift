//
//  SavedColognesViewController.swift
//  Cologne Finder
//
//  Created by Manav Arora on 4/17/24.
//

import UIKit

class SavedColognesViewController: UIViewController {
    
    @IBOutlet weak var SavedTableView: UITableView!
    var savedColognes: [[String: Any]] = [] // Array to store saved cologne details
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        savedColognes = UserDefaults.standard.array(forKey: "savedColognes") as? [[String: Any]] ?? []
        
        // Configure table view
        SavedTableView.delegate = self
        SavedTableView.dataSource = self
        SavedTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            // Load saved colognes from UserDefaults and reload table view data
            savedColognes = UserDefaults.standard.array(forKey: "savedColognes") as? [[String: Any]] ?? []
            SavedTableView.reloadData()
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
extension SavedColognesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedColognes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCologneCell", for: indexPath)
        
        let cologne = savedColognes[indexPath.row]
        print("\(cologne)")
        cell.textLabel?.text = cologne["name"] as? String
        cell.detailTextLabel?.text = "\(cologne["brand"] as? String ?? "") - \(cologne["price"] as? Double ?? 0.0)"
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SavedColognesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Instantiate the detail view controller from storyboard
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return
        }
        print("im here")
        // Pass the selected cologne to the detail view controller
//        detailVC.cologne = Cologne(from: savedColognes[indexPath.row])
        // Ensure the navigation controller is not nil
        guard let navigationController = navigationController else {
            print("Error: navigationController is nil.")
            return
        }
        // Extract cologne details from the dictionary
        let cologneDetails = savedColognes[indexPath.row]
        print(cologneDetails)
        let name = cologneDetails["name"] as? String ?? ""
        let brand = cologneDetails["brand"] as? String ?? ""
        let price = cologneDetails["price"] as? Double ?? 0.0
        let mood = cologneDetails["mood"] as? String ?? ""
        
                
                // Initialize a Cologne object with the extracted details
        let imageURLString = cologneDetails["imageURL"] as? String ?? "" // Assuming the URL is stored as a string
                        
                // Initialize a Cologne object with the extracted details
        if let imageURL = URL(string: imageURLString) {
            let cologne = Cologne(name: name, brand: brand, price: price, mood: mood, imageURL: imageURL)
                    
                    // Pass the selected cologne to the detail view controller
            detailVC.cologne = cologne
                    
                    // Push the detail view controller onto the navigation stack
            navigationController.pushViewController(detailVC, animated: true)
        } else {
                    print("Error: Invalid imageURL")
        }
    }
}
