import UIKit

class UserIdsLegacy {
    static let legacyIds = ["a10", "a11", "a12"]
    
    static func isLegacy(id: String) -> Bool {
        return legacyIds.contains(id)
    }
}

class ListContactsViewController: UIViewController {
    
    //****************************************************************
    //MARK: Private Methods
    //****************************************************************
    
    private var viewModel: ListContactsViewModel!
    
    //****************************************************************
    //MARK: View Creation
    //****************************************************************
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120
        tableView.register(ContactCell.self, forCellReuseIdentifier: String(describing: ContactCell.self))
        return tableView
    }()
    
    func configureViews() {
        view.backgroundColor = .red
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    //****************************************************************
    //MARK: Life Cicle
    //****************************************************************
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ListContactsViewModel()
        configureViews()
        
        navigationController?.title = "Lista de contatos"
        
        loadData()
    }
    
    //****************************************************************
    //MARK: Private Methods
    //****************************************************************
    
    private func isLegacy(contact: Contact) -> Bool {
        return UserIdsLegacy.isLegacy(id: contact.id)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    private func loadData() {
        viewModel.loadContacts(
            success: {
                self.tableView.reloadData()
        }, failure: { (title, message) in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        })
    }
}

extension ListContactsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContactCell.self), for: indexPath) as? ContactCell else {
            return UITableViewCell()
        }
        
        let contact = viewModel.contacts[indexPath.row]
        
        let cellViewModel = ContactCellViewModel(contact: contact, service: ListContactService())
        
        cell.setup(viewModel: cellViewModel)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        
        let contato = viewModel.contacts[index]
        
        if isLegacy(contact: contato) {
            showAlert(title: "Atenção", message: "Você tocou no contato sorteado")
        } else {
            showAlert(title: "Você tocou em", message: contato.name)
        }
    }
}
