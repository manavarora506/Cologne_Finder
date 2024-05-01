//
//  FilterViewController.swift
//  Cologne Finder
//
//  Created by Manav Arora on 4/17/24.
//

import UIKit

class FilterViewController: UIViewController {
    @IBOutlet weak var PriceMaxLabel: UITextField!
    
    @IBOutlet weak var MoodOptionsButton: UIButton!

    @IBOutlet weak var SearchButton: UIButton!
    @IBOutlet weak var EnterPriceLabel: UILabel!
    var colognes: [Cologne] = [] // Assuming you have the array of colognes defined elsewhere
    var selectedMood: String?  // Default selected mood
    @IBOutlet weak var SelectMoodLabel: UILabel!
    override func viewDidLoad() {
            super.viewDidLoad()
            
            // Populate colognes array with data
        colognes = [
            Cologne(name: "Acqua Di Gio", brand: "Giorgio Armani", price: 85.99, mood: "Fresh", imageURL: URL(string: "https://www.giorgioarmanibeauty-usa.com/dw/image/v2/AANG_PRD/on/demandware.static/-/Sites-armani-us-Library/default/dw0c973924/images/pdp/ww-00401-arm/adgh%20edt%20thumbnail%20.jpg?sw=375&sh=375&sm=cut&q=85")),
            Cologne(name: "Bleu de Chanel", brand: "Chanel", price: 105.50, mood: "Sophisticated", imageURL: URL(string: "https://puls-img.chanel.com/1683797550578-editopush1080x1150parfjpg_1150x1080.jpg")),
            Cologne(name: "Dior Sauvage", brand: "Dior", price: 95.75, mood: "Bold", imageURL: URL(string: "https://www.dior.com/dw/image/v2/BGXS_PRD/on/demandware.static/-/Sites-master_dior/default/dwda20a78b/Y0785220/Y0785220_F078524009_E01_GHC.jpg?sw=800")),
            Cologne(name: "Versace Eros", brand: "Versace", price: 70.25, mood: "Sensual", imageURL: URL(string: "https://m.media-amazon.com/images/I/71I33Ob9-LL._AC_UF1000,1000_QL80_.jpg")),
            Cologne(name: "Tom Ford Oud Wood", brand: "Tom Ford", price: 250.00, mood: "Luxurious", imageURL: URL(string: "https://www.sephora.com/productimages/sku/s1565902-main-zoom.jpg?imwidth=315")),
            Cologne(name: "Calvin Klein Eternity", brand: "Calvin Klein", price: 60.00, mood: "Bold", imageURL: URL(string: "https://m.media-amazon.com/images/I/611k4z0+nPL._AC_UF1000,1000_QL80_.jpg")),
            Cologne(name: "Yves Saint Laurent La Nuit de L'Homme", brand: "YSL", price: 95.00, mood: "Sophisticated", imageURL: URL(string: "https://www.sephora.com/productimages/sku/s1200716-main-zoom.jpg")),
            Cologne(name: "Paco Rabanne 1 Million", brand: "Paco Rabanne", price: 80.50, mood: "Luxurious", imageURL: URL(string: "https://cdn2.jomashop.com/media/catalog/product/cache/fde19e4197824625333be074956e7640/p/a/paco-rabanne1-million-paco-rabanne-edt-spray-67-oz-200-ml-m-3349668566372_1.jpg?width=546&height=546")),
            Cologne(name: "Armaf Club De Nuit Intense Man", brand: "Armaf", price: 40.00, mood: "Sensual", imageURL: URL(string: "https://m.media-amazon.com/images/I/51m2Le98GdL._AC_UF1000,1000_QL80_.jpg")),
            Cologne(name: "Creed Aventus", brand: "Creed", price: 400.00, mood: "Luxurious", imageURL: URL(string: "https://creedboutique.com/cdn/shop/files/aventus-100ml-bottle_3413e5f4-3eee-40b3-8451-2546a370ec5b.jpg?v=1713378838&width=1500")),
            Cologne(name: "Issey Miyake L'Eau d'Issey", brand: "Issey Miyake", price: 70.00, mood: "Sophisticated", imageURL: URL(string: "https://us-store.isseymiyake.com/cdn/shop/files/IP55AZ102-01-01_400x.jpg?v=1708734825")),
            Cologne(name: "Jean Paul Gaultier Le Male", brand: "Jean Paul Gaultier", price: 75.00, mood: "Sensual", imageURL: URL(string: "https://m.media-amazon.com/images/I/71WaAXK-5mL.jpg")),
            Cologne(name: "Ralph Lauren Polo Blue", brand: "Ralph Lauren", price: 85.00, mood: "Sophisticated", imageURL: URL(string: "https://m.media-amazon.com/images/I/61Mbl8qAPmL._AC_UF1000,1000_QL80_.jpg"))
        ]
        setUpMoodOptionsMenu()
        
        addBorder(to: PriceMaxLabel)
        addBorder(to: SelectMoodLabel)
        addBorder(to: EnterPriceLabel)
        addBorder(to: SearchButton)
        addBorder(to: MoodOptionsButton)
        }
    func setUpMoodOptionsMenu() {
            let menu = UIMenu(title: "Mood Options", children: generateMenuItems())
            MoodOptionsButton.menu = menu
        }
    func generateMenuItems() -> [UIAction] {
        var menuItems: [UIAction] = []
        
        // Add "All" option
        let allAction = UIAction(title: "All", handler: { [weak self] _ in
            self?.selectedMood = nil // Set selected mood to nil to represent "All"
            self?.MoodOptionsButton.setTitle("All", for: .normal)
        })
        menuItems.append(allAction)
        
        // Extract unique mood options from colognes list
        let uniqueMoods = Set(colognes.map { $0.mood })
        
        // Create a menu item for each unique mood
        for mood in uniqueMoods {
            let action = UIAction(title: mood, handler: { [weak self] _ in
                self?.selectedMood = mood
                self?.MoodOptionsButton.setTitle(mood, for: .normal)
            })
            menuItems.append(action)
        }
        
        return menuItems
    }
    
    @IBAction func SearchButtonTapped(_ sender: UIButton) {
        // Perform search based on filter criteria
        guard let maxPriceText = PriceMaxLabel.text, let maxPrice = Double(maxPriceText) else {
            showAlert(withTitle: "Error", message: "Please enter a valid maximum price.")
            return
        }
        
//        let selectedMood = "Selected Mood" // You need to implement mood selection logic
        
        // Filter colognes based on max price and mood
//        let filteredColognes = colognes.filter { $0.price <= maxPrice && $0.mood == selectedMood }
        
        let filteredColognes = colognes.filter { $0.price <= maxPrice && ($0.mood == selectedMood || selectedMood == nil) }
        print(filteredColognes)
        
        // Perform navigation to MatchesViewController and pass filtered colognes
        if let matchesVC = storyboard?.instantiateViewController(withIdentifier: "MatchesViewController") as? MatchesViewController {
            matchesVC.filteredColognes = filteredColognes
            navigationController?.pushViewController(matchesVC, animated: true)
        }
    }
   
    func showAlert(withTitle title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    
    func addBorder(to view: UIView) {
            view.layer.borderWidth = 1.0
            view.layer.cornerRadius = 8.0
            view.layer.borderColor = UIColor.lightGray.cgColor
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
