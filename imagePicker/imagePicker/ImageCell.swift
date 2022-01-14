//
//  ImageCell.swift
//  imageGallery
//
//  Created by Raghavendra reddy on 13/01/22.
//

import UIKit

class ImageCell: UITableViewCell {

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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var cellViewModel: ImageElement? {
        didSet {
           
            DispatchQueue.main.async {
                print("https://picsum.photos/200/300?image=\(String(describing: self.cellViewModel?.id)))")
                self.picture.loadImageFromUrl(urlString: "https://picsum.photos/200/300?image=1")
            }
            
            
        }
    }
    
    func initView() {
        // Cell view customization
        backgroundColor = .clear
        
        // Line separator full width
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
