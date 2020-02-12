import UIKit

struct ContactCellViewModel {
    
    //****************************************************************
    //MARK: Private Properties
    //****************************************************************
    
    private let contact: Contact
    private let service: ListContactService
    
    //****************************************************************
    //MARK: Public Properties
    //****************************************************************
    
    var name: String {
        return contact.name
    }
    
    //****************************************************************
    //MARK: Life Cicle
    //****************************************************************
    
    init(contact: Contact, service: ListContactService) {
        self.contact = contact
        self.service = service
    }
    
    //****************************************************************
    //MARK: Public Methods
    //****************************************************************
    
    func fetchPhoto(completion: @escaping(UIImage) ->()){
        
        let urlString = contact.photoURL
        
        if ImageCache.sharedInstance.isImageOnCache(url: urlString) {
            let image = ImageCache.sharedInstance.returnImageFromCache(url: urlString)
            completion(image)
        }
        
        if let url = URL(string: urlString) {
            
            let queue = DispatchQueue.init(label: "photoQueue")
            
            queue.async {
                self.service.fetchPhoto(urlPhoto: url) { image in
                    ImageCache.sharedInstance.setImageOnCache(image: image, url: urlString)
                    completion(image)
                }
            }
        }
        
        completion(UIImage())
    }
}
