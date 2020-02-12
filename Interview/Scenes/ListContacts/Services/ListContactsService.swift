import UIKit

class ListContactService {
    func fetchContacts(completion: @escaping (Result<[Contact], Error>) -> Void) {
        /// Usa URLSession para acessar a API e retorna
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.success(fakeList))
        }
    }
    
    func fetchPhoto(urlPhoto: URL, completion: @escaping (UIImage) ->()) {
        do {
            let data = try Data(contentsOf: urlPhoto)
            let image = UIImage(data: data) ?? UIImage()
            completion(image)
        } catch _ {}
    }
}
