//
//  ProductCell.swift
//  Shopping App
//
//  Created by Raghavendra reddy on 23/12/21.
//

import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    class func identifier ()-> String{
        String(describing: self)
    }
    class func nib() -> UINib{
        UINib(nibName: identifier(), bundle: nil)
    }
    
    var cellViewModel: ImageElement? {
        didSet {
            authorLabel.text = cellViewModel?.author
            titleLabel.text = cellViewModel?.filename
            DispatchQueue.main.async {
                self.productImage.loadImageFromUrl(urlString: "https://picsum.photos/200/300?image=\(self.cellViewModel?.id ?? 0)")
            }
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
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
        authorLabel.text = nil
        titleLabel.text = nil
        productImage.image = nil
        
    }
    
}



