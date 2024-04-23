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
            Cologne(name: "Tom Ford Oud Wood", brand: "Tom Ford", price: 250.00, mood: "Luxurious", imageURL: URL(string: "https://www.sephora.com/productimages/sku/s1565902-main-zoom.jpg?imwidth=315"))
        ]
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
