//
//  DetailViewController.swift
//  Cologne Finder
//
//  Created by Manav Arora on 4/17/24.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var cologneInfoStack: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var cologneImageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    
    var cologne: Cologne?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Hide the cologne info stack initially
        cologneInfoStack.isHidden = true
        
        // Update UI with cologne data if available
        if let cologne = cologne {
            nameLabel.text = "Name: \(cologne.name)"
            brandLabel.text = "Brand: \(cologne.brand)"
            priceLabel.text = "Price: \(String(format: "$%.2f", cologne.price))"// Format price with two decimal places
            moodLabel.text = "Mood: \(cologne.mood)" // Add label prefix for clarity
            
            // Show the cologne info stack once data is available
            cologneInfoStack.isHidden = false
            
            if let imageURL = cologne.imageURL {
                            loadImage(from: imageURL)
            }
        }
        applyBorder(to: nameLabel)
        applyBorder(to: brandLabel)
        applyBorder(to: priceLabel)
        applyBorder(to: moodLabel)
//        applyBorder(to: cologneInfoStack) // Apply border to the stack view
        saveButton.layer.cornerRadius = 8
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = UIColor.systemBlue.cgColor
        saveButton.setTitleColor(.systemBlue, for: .normal)
    }
    func applyBorder(to view: UIView) {
            view.layer.borderWidth = 1.0
            view.layer.cornerRadius = 8.0
            view.layer.borderColor = UIColor.lightGray.cgColor
        }
    
    func applyBorder(to label: UILabel) {
            label.layer.borderWidth = 1.0
            label.layer.cornerRadius = 8.0
            label.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func loadImage(from url: URL) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.cologneImageView.image = image
                    }
                } else {
                    print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
                }
            }.resume()
        }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
//        guard let cologne = cologne else {
//                return
//            }
//            
//            // Check if the cologne is already saved
//            let savedColognes = UserDefaults.standard.array(forKey: "savedColognes") as? [[String: Any]] ?? []
//            if savedColognes.contains(where: { $0["name"] as? String == cologne.name }) {
//                showAlert(withTitle: "Already Saved", message: "This cologne has already been saved.")
//                return
//            }
//            
//            // Save cologne details
//            var updatedSavedColognes = savedColognes
//            let cologneDict: [String: Any] = ["name": cologne.name, "brand": cologne.brand, "price": cologne.price, "mood": cologne.mood]
//            updatedSavedColognes.append(cologneDict)
//            UserDefaults.standard.set(updatedSavedColognes, forKey: "savedColognes")
//            
//            // Show save confirmation alert
//            showAlert(withTitle: "Saved", message: "Cologne details saved successfully!")
        guard let cologne = cologne else {
                    return
                }
                
                // Check if the cologne is already saved
                var savedColognes = UserDefaults.standard.array(forKey: "savedColognes") as? [[String: Any]] ?? []
                if let index = savedColognes.firstIndex(where: { $0["name"] as? String == cologne.name }) {
                        // If cologne is already saved, remove it
                        savedColognes.remove(at: index)
                        UserDefaults.standard.set(savedColognes, forKey: "savedColognes")
                        
                        // Update UI and show confirmation alert
                        saveButton.setTitle("Save", for: .normal)
                        saveButton.setTitleColor(.systemBlue, for: .normal) // Set button color to blue
                        showAlert(withTitle: "Unsaved", message: "Cologne removed from saved list.")
                    } else {
                        // If cologne is not saved, save it
                        let imageURLString = cologne.imageURL?.absoluteString ?? "" // Convert URL to string
                        let cologneDict: [String: Any] = [
                            "name": cologne.name,
                            "brand": cologne.brand,
                            "price": cologne.price,
                            "mood": cologne.mood,
                            "imageURL": imageURLString
                        ]
                        savedColognes.append(cologneDict)
                        print(savedColognes)
                        UserDefaults.standard.set(savedColognes, forKey: "savedColognes")
                        
                        // Update UI and show confirmation alert
                        saveButton.setTitle("Unsave", for: .normal)
                        saveButton.setTitleColor(.systemRed, for: .normal) // Set button color to red
                        
                        showAlert(withTitle: "Saved", message: "Cologne details saved successfully!")
                    }
                }
    
        
        func showAlert(withTitle title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
}
