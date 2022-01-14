//
//  CollectionCell.swift
//  imageGallery
//
//  Created by Raghavendra reddy on 13/01/22.
//

import UIKit

class CollectionCell: UICollectionViewCell {

    @IBOutlet weak var authourLabel: UILabel!
    @IBOutlet weak var pictureLabel: UILabel!
    @IBOutlet weak var picture: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    class func identifier ()-> String{
        String(describing: self)
    }
    class func nib() -> UINib{
        UINib(nibName: identifier(), bundle: nil)
    }
    
    

    var cellViewModel: ImageElement? {
        didSet {
           
            DispatchQueue.main.async {
                self.authourLabel.text = self.cellViewModel?.author
                self.pictureLabel.text = self.cellViewModel?.filename
                
                self.picture.loadImageFromUrl(urlString: "https://picsum.photos/200/300?image=\(self.cellViewModel?.id ?? 10)")
            }
            
            
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        authourLabel.text = nil
        picture.image = nil
        
    }
    
}
