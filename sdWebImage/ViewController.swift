//
//  ViewController.swift
//  sdWebImage
//
//  Created by Mohan K on 13/02/23.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    var dogAllData:DogData?
    var dogImageAllLinks = [String]()
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchData()
    }
    
    func fetchData() {
        let url = URL(string: "https://dog.ceo/api/breed/hound/images")
        let task = URLSession.shared.dataTask(with: url!, completionHandler:{
            (data,response, error) in
            guard let data = data, error == nil else
            {
                print("Error Occured while Accessing Data")
                return
            }
            var dogObject:DogData?
            do{
                dogObject = try JSONDecoder().decode(DogData.self, from: data)
                
            }
            catch {
                print("Error While Decoding JSon into swift structure \(error)")
                
            }
            self.dogAllData = dogObject
            self.dogImageAllLinks = self.dogAllData!.message
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        })
        task.resume()
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogImageAllLinks.count    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myTableViewCell", for: indexPath) as! myTableViewCell
        if let imageURL = URL(string: dogImageAllLinks[indexPath.row]) {
            cell.imgImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgImage.sd_imageIndicator?.startAnimatingIndicator()
            cell.imgImage.sd_setImage(with: imageURL,
                                      placeholderImage: UIImage(named: "empty"),
                                      options: .continueInBackground,
                                      completed: nil)
            cell.imgImage.contentMode = .scaleAspectFit
            cell.imgImage.layer.cornerRadius = 50
        }
        else {
            print ("Invalid URL - No Image")
            cell.imgImage.image = UIImage(named: "empty")
        }
        return cell
    }
    
    
}
