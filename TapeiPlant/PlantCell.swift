//
//  PlantCell.swift
//  TapeiPlant
//
//  Created by Peter Chen on 2021/5/11.
//

import Foundation
import UIKit
class PlantCell: UITableViewCell {
    @IBOutlet var plantCellView: PlantCell!
    @IBOutlet weak var pictureImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var featureLabel: UILabel!
    
    override class func awakeFromNib() {
        Bundle.main.loadNibNamed("PlantCell", owner: self, options: nil)
    }
//    init(_ plant: Plant?) {
//        super.init(style: .default, reuseIdentifier: "PlantCell")
//        guard let plant = plant else { return }
//        self.titleLabel.text = plant.name
//        self.locationLabel.text = plant.location
//        self.featureLabel.text = plant.feature
//    }
//    init(_ imageUrlString: String?, _ title: String?, _ location: String?, _ feature: String?) {
//        super.init(style: .default, reuseIdentifier: "PlantCell")
//        self.titleLabel.text = title
//        self.locationLabel.text = location
//        self.featureLabel.text = feature
//    }
    
    func updateCell(_ plant: Plant?) {
        guard let plant = plant else { return }
        self.titleLabel.text = plant.name
        self.locationLabel.text = plant.location
        self.featureLabel.text = plant.feature
        
        
        if let cachedImage = ImageCache.shared.image(forKey: plant.imageUrl) {
            self.pictureImageView.image = cachedImage
            return
        }
        let urlString = plant.imageUrl.replacingOccurrences(of: "http:", with: "https:")
        guard let url = URL(string: urlString) else { return }
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return }
        urlComponents.scheme = "https"
        let urlSession = URLSession.shared.dataTask(with: urlComponents.url!) { [weak self] (data, response, error) in
            guard error == nil, let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            ImageCache.shared.save(image: image, forKey: urlString)
            DispatchQueue.main.async {
                self?.pictureImageView.image = image
            }
        }
        
        urlSession.resume()
    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
