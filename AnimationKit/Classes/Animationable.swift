import UIKit

public protocol Animationable {}
extension NSObject: Animationable {}

public class Animation<Origin> {
  var origin: Origin
  
  init(origin: Origin) {
    self.origin = origin
  }
}

extension Animationable {
  public var ani: Animation<Self> {
    return Animation(origin: self)
  }
}
