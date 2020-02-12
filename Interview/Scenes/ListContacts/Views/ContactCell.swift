import UIKit

class ContactCell: UITableViewCell {
    
    //****************************************************************
    //MARK: Public Properties
    //****************************************************************
    
    var viewModel: ContactCellViewModel?
    
    //****************************************************************
    //MARK: Life Cicle
    //****************************************************************
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contactImage.image = nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contactImage.image = UIImage(named: "oi")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureViews()
    }
    
    //****************************************************************
    //MARK: Public Methods
    //****************************************************************
    
    func setup(viewModel: ContactCellViewModel) {
        self.viewModel = viewModel
        viewModel.fetchPhoto { image in
            DispatchQueue.main.async {
                self.contactImage.image = image
            }
        }
        fullnameLabel.text = viewModel.name
    }
    
    //****************************************************************
    //MARK: View Creation
    //****************************************************************
    
    lazy var contactImage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    lazy var fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configureViews() {
        contentView.addSubview(contactImage)
        contentView.addSubview(fullnameLabel)
        
        contactImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        contactImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        contactImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        contactImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        fullnameLabel.leadingAnchor.constraint(equalTo: contactImage.trailingAnchor, constant: 16).isActive = true
        fullnameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        fullnameLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        fullnameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
