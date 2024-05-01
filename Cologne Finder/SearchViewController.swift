//
//  SearchViewController.swift
//  Cologne Finder
//
//  Created by Manav Arora on 4/17/24.
//

import UIKit


class SearchViewController: UIViewController, UISearchBarDelegate{

    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var FilterButton: UIButton!
    var colognes: [Cologne] = []
    @IBOutlet weak var infoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationController = self.navigationController {
            // SearchViewController is embedded within a navigation controller
            print("SearchViewController is embedded within a navigation controller")
        } else {
            // SearchViewController is not embedded within a navigation controller
            print("SearchViewController is not embedded within a navigation controller")
        }
        // Do any additional setup after loading the view.
        SearchBar.delegate = self
                
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
        
        infoButton.addTarget(self, action: #selector(showAppInfo(_:)), for: .touchUpInside)
    }
    
    @objc func showAppInfo(_ sender: UIButton) {
            // Display tooltip or alert with app information
            let alert = UIAlertController(title: "App Information", message: "This app helps you find and learn about different colognes.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        
        // Find matching cologne based on search text
        if let cologne = colognes.first(where: { $0.name.lowercased() == searchText.lowercased() }) {
            print("im here")
            print(searchText)
            // Navigate to DetailViewController and pass cologne data
            if let detailVC = storyboard?.instantiateViewController(withIdentifier:"DetailViewController") as? DetailViewController {
                detailVC.cologne = cologne // Assigning the cologne to the detail view controller's property
                navigationController?.pushViewController(detailVC, animated: true)
            }
        } else {
            // Display an alert or message indicating that the cologne was not found
            let alert = UIAlertController(title: "Cologne Not Found", message: "Sorry, the cologne you searched for was not found.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
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
