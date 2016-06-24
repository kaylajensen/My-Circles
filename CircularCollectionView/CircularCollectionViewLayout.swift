
import UIKit

class CircularCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
  
  var anchorPoint = CGPoint(x: 0.5, y: 0.5)
  
  var angle: CGFloat = 0 {
    didSet {
      
      zIndex = Int(angle*1000000)
      transform = CGAffineTransformMakeRotation(angle)
      
    }
    
  }
  
  override func copyWithZone(zone: NSZone) -> AnyObject {
    
    let copiedAttributes: CircularCollectionViewLayoutAttributes = super.copyWithZone(zone) as! CircularCollectionViewLayoutAttributes
    
    copiedAttributes.anchorPoint = self.anchorPoint
    
    copiedAttributes.angle = self.angle
    
    return copiedAttributes
  }
  
} // end of CircularCollectionViewLayoutAttributes class


class CircularCollectionViewLayout: UICollectionViewLayout {
  
  // size of circle in square form
  let itemSize = CGSize(width: 143, height: 143)
  
  
  var angleAtExtreme: CGFloat {
    return collectionView!.numberOfItemsInSection(0) > 0 ? -CGFloat(collectionView!.numberOfItemsInSection(0)-1)*anglePerItem : 0
  }
  
  
  var angle: CGFloat {
    return angleAtExtreme*collectionView!.contentOffset.x/(collectionViewContentSize().width - CGRectGetWidth(collectionView!.bounds))
  }
  
  
  // radius of the circle of circles
  var radius: CGFloat = 177 {
    didSet {
      invalidateLayout()
    }
  }
  
  // each circle gets this much space
  var anglePerItem: CGFloat {
    return atan(itemSize.width/radius)
  }
  
  // create an array of the circles attributes
  var attributesList = [CircularCollectionViewLayoutAttributes]()
  
  override func collectionViewContentSize() -> CGSize {
    return CGSize(width: CGFloat(collectionView!.numberOfItemsInSection(0))*itemSize.width,
      height: CGRectGetHeight(collectionView!.bounds))
  }
  
  override class func layoutAttributesClass() -> AnyClass {
    return CircularCollectionViewLayoutAttributes.self
  }
  
  override func prepareLayout() {
    super.prepareLayout()
    
    var startIndex = 0
    
    let centerX = collectionView!.contentOffset.x + (CGRectGetWidth(collectionView!.bounds)/3.0)
    let anchorPointY = ((itemSize.height/2.0) + radius)/itemSize.height
    
    //1
    let theta = atan2(CGRectGetWidth(collectionView!.bounds)/2.0, radius + (itemSize.height/2.0) - (CGRectGetHeight(collectionView!.bounds)/2.0))
    //2
    var endIndex = collectionView!.numberOfItemsInSection(0) - 1
    //3
    if (angle < -theta) {
      startIndex = Int(floor((-theta - angle)/anglePerItem))
    }
    //4
    endIndex = min(endIndex, Int(ceil((theta - angle)/anglePerItem)))
    //5
    if (endIndex < startIndex) {
      endIndex = 0
      startIndex = 0
    }
    
    attributesList = (startIndex...endIndex).map { (i) -> CircularCollectionViewLayoutAttributes in
      let attributes = CircularCollectionViewLayoutAttributes(forCellWithIndexPath: NSIndexPath(forItem: i, inSection: 0))
      
      attributes.size = self.itemSize
      attributes.center = CGPoint(x: centerX, y: CGRectGetMidY(self.collectionView!.bounds))
      attributes.angle = self.angle + (self.anglePerItem*CGFloat(i))
      attributes.anchorPoint = CGPoint(x: 0.5, y: anchorPointY)
      
      return attributes
    }
  }
  
  override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    return attributesList
  }
  
  override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath)
    -> UICollectionViewLayoutAttributes? {
      return attributesList[indexPath.row]
  }
  
  override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
    return true
  }
  
  
  // scrolling through circle cells functionality
  override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
    
    var finalContentOffset = proposedContentOffset
    
    let factor = -angleAtExtreme/(collectionViewContentSize().width - CGRectGetWidth(collectionView!.bounds))
    
    let proposedAngle = proposedContentOffset.x*factor
    
    let ratio = proposedAngle/anglePerItem
    
    var multiplier: CGFloat
    
    if (velocity.x > 0) {
      multiplier = ceil(ratio)
    }
    else if (velocity.x < 0) {
      multiplier = floor(ratio)
    }
    else {
      multiplier = round(ratio)
    }
    
    finalContentOffset.x = multiplier*anglePerItem/factor
    
    return finalContentOffset
  }
  
}
