import UIKit

final class CustomCellView: UIView {
    
    // MARK: – UI components
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return imageView
    }()
    
    private var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textColor = .white
        return label
    }()
    
    // MARK: – Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 7
    }
    
    // MARK: – Configuration functions
    
    func configureView(image: UIImage, text: String) {
        imageView.image = image
        textLabel.text = text
    }
    
    // MARK: – UI setup
    
    private func setup() {
        self.addSubview(imageView)
        self.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            
            // ImageView
            imageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 3),
            imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            
            // TextLabel
            textLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            textLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            textLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            textLabel.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
}
