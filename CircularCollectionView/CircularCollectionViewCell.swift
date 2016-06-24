
import UIKit

class CircularCollectionViewCell: UICollectionViewCell {
  
  var imageName = "" {
    didSet {
      imageView!.image = UIImage(named: imageName)
      }
  }
  
  @IBOutlet weak var imageView: UIImageView?
  @IBOutlet weak var imageLabel: UILabel!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    // set main view of cell's (circle) custom content
    contentView.layer.cornerRadius = 69
    contentView.layer.borderWidth = 3
    contentView.layer.borderColor = UIColor(red: 105/255, green: 131/255, blue: 142/255, alpha: 1.0).CGColor
    
    contentView.layer.shouldRasterize = true
    contentView.layer.rasterizationScale = UIScreen.mainScreen().scale
    contentView.clipsToBounds = true
    
    
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    imageView!.contentMode = .ScaleAspectFill
    
  }
  
  override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
    
    super.applyLayoutAttributes(layoutAttributes)
    
    let circularlayoutAttributes = layoutAttributes as! CircularCollectionViewLayoutAttributes
    
    self.layer.anchorPoint = circularlayoutAttributes.anchorPoint
    self.center.y += (circularlayoutAttributes.anchorPoint.y - 0.5)*CGRectGetHeight(self.bounds)
  }
  
}
