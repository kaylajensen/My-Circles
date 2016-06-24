
import UIKit

class ACircleCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
  
  var anchorPoint1 = CGPoint(x: 0.5, y: 0.5)
  
  var angle1: CGFloat = 0 {
    didSet {
      
      zIndex = Int(angle1*1000000)
      transform = CGAffineTransformMakeRotation(angle1)
      
    }
    
  }
  
  override func copyWithZone(zone: NSZone) -> AnyObject {
    
    let copiedAttributes: ACircleCollectionViewLayoutAttributes = super.copyWithZone(zone) as! ACircleCollectionViewLayoutAttributes
    
    copiedAttributes.anchorPoint1 = self.anchorPoint1
    
    copiedAttributes.angle1 = self.angle1
    
    return copiedAttributes
  }
  
}


class ACircleCollectionViewLayout: UICollectionViewLayout {
  
  // size of circle in square form
  let itemSize1 = CGSize(width: 143, height: 143)
  
  
  var angleAtExtreme1: CGFloat {
    return collectionView!.numberOfItemsInSection(0) > 0 ? -CGFloat(collectionView!.numberOfItemsInSection(0)-1)*anglePerItem1 : 0
  }
  
  
  var angle1: CGFloat {
    return angleAtExtreme1*collectionView!.contentOffset.x/(collectionViewContentSize().width - CGRectGetWidth(collectionView!.bounds))
  }
  
  
  // radius of the circle of circles
  var radius1: CGFloat = 177 {
    didSet {
      invalidateLayout()
    }
  }
  
  // each circle gets this much space
  var anglePerItem1: CGFloat {
    return atan(itemSize1.width/radius1)
  }
  
  // create an array of the circles attributes
  var attributesList1 = [ACircleCollectionViewLayoutAttributes]()
  
  override func collectionViewContentSize() -> CGSize {
    return CGSize(width: CGFloat(collectionView!.numberOfItemsInSection(0))*itemSize1.width,
      height: CGRectGetHeight(collectionView!.bounds))
  }
  
  override class func layoutAttributesClass() -> AnyClass {
    return ACircleCollectionViewLayoutAttributes.self
  }
  
  override func prepareLayout() {
    super.prepareLayout()
    
    var startIndex = 0
    
    let centerX = collectionView!.contentOffset.x + (CGRectGetWidth(collectionView!.bounds)/3.0)
    let anchorPointY = ((itemSize1.height/2.0) + radius1)/itemSize1.height
    
    //1
    let theta = atan2(CGRectGetWidth(collectionView!.bounds)/2.0, radius1 + (itemSize1.height/2.0) - (CGRectGetHeight(collectionView!.bounds)/2.0))
    //2
    var endIndex = collectionView!.numberOfItemsInSection(0) - 1
    //3
    if (angle1 < -theta) {
      startIndex = Int(floor((-theta - angle1)/anglePerItem1))
    }
    //4
    endIndex = min(endIndex, Int(ceil((theta - angle1)/anglePerItem1)))
    //5
    if (endIndex < startIndex) {
      endIndex = 0
      startIndex = 0
    }
    
    attributesList1 = (startIndex...endIndex).map { (i) -> ACircleCollectionViewLayoutAttributes in
      let attributes = ACircleCollectionViewLayoutAttributes(forCellWithIndexPath: NSIndexPath(forItem: i, inSection: 0))
      
      attributes.size = self.itemSize1
      attributes.center = CGPoint(x: centerX, y: CGRectGetMidY(self.collectionView!.bounds))
      attributes.angle1 = self.angle1 + (self.anglePerItem1*CGFloat(i))
      attributes.anchorPoint1 = CGPoint(x: 0.5, y: anchorPointY)
      
      return attributes
    }
  }
  
  override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    return attributesList1
  }
  
  override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath)
    -> UICollectionViewLayoutAttributes? {
      return attributesList1[indexPath.row]
  }
  
  override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
    return true
  }
  
  
  // scrolling through circle cells functionality
  override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
    
    var finalContentOffset = proposedContentOffset
    
    let factor = -angleAtExtreme1/(collectionViewContentSize().width - CGRectGetWidth(collectionView!.bounds))
    
    let proposedAngle = proposedContentOffset.x*factor
    
    let ratio = proposedAngle/anglePerItem1
    
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
    
    finalContentOffset.x = multiplier*anglePerItem1/factor
    
    return finalContentOffset
  }
  
}
