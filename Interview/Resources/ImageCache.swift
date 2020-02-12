import UIKit

class ImageCache {
    
    //****************************************************************
    //MARK: Public Properties
    //****************************************************************
    
    static let sharedInstance = ImageCache()
    
    //****************************************************************
    //MARK: Private Properties
    //****************************************************************
    
    private let imageCache: NSCache<AnyObject, AnyObject>
    
    //****************************************************************
    //MARK: Life Cicle
    //****************************************************************
    
    init(_ imageCache: NSCache<AnyObject, AnyObject> = NSCache<AnyObject, AnyObject>()) {
        self.imageCache = imageCache
    }
    
    //****************************************************************
    //MARK: Public Methods
    //****************************************************************
    
    func isImageOnCache(url: String) -> Bool {
        if (imageCache.object(forKey: url as AnyObject) as? UIImage) != nil {
            return true
        }
        return false
    }
    
    func returnImageFromCache(url: String) -> UIImage {
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            return imageFromCache
        }
        return UIImage()
    }
    
    func setImageOnCache(image: UIImage, url: String) {
        imageCache.setObject(image, forKey: url as AnyObject)
    }
}
