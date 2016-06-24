
import UIKit

class ACircleCollectionViewCell: UICollectionViewCell {
  
  var imageName1 = "" {
    didSet {
      imageView1!.image = UIImage(named: imageName1)
    }
  }
  
  
  @IBOutlet weak var imageView1: UIImageView!
  
    @IBOutlet weak var memberName1: UILabel!
  
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
    
    imageView1!.contentMode = .ScaleAspectFill
    
  }
  
  override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
    
    super.applyLayoutAttributes(layoutAttributes)
    
    let acirclelayoutAttributes = layoutAttributes as! ACircleCollectionViewLayoutAttributes
    
    self.layer.anchorPoint = acirclelayoutAttributes.anchorPoint1
    self.center.y += (acirclelayoutAttributes.anchorPoint1.y - 0.5)*CGRectGetHeight(self.bounds)
  }
  
}
