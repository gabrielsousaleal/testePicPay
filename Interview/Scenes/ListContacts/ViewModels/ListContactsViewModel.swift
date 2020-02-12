import Foundation

final class ListContactsViewModel {
    
    //****************************************************************
    //MARK: Private Properties
    //****************************************************************
    
    private let service = ListContactService()
    private (set) var contacts: [Contact] = []
    
    //****************************************************************
    //MARK: Public Methods
    //****************************************************************
            
    func loadContacts(success: @escaping () -> Void, failure: @escaping (_ title: String, _ message: String) -> Void) {
        service.fetchContacts { result in
            switch result {
            case .success(let contacts):
                self.contacts = contacts
                success()
            case .failure(let error):
                failure(error.localizedDescription, error.localizedDescription)
            }
        }
    }
}
