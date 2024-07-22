import UIKit

final class PhenomenaCell: UICollectionViewCell {
    
    // MARK: – UI Components
    
    lazy var customView: CustomCellView = {
        let view = CustomCellView()
        view.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 3.0
        view.layer.shadowOpacity = 0.45
        view.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        view.layer.borderColor = #colorLiteral(red: 0.1174738631, green: 0.1263167262, blue: 0.1394138932, alpha: 1)
        view.layer.borderWidth = 0.5
        return view
    }()
    
    // MARK: – Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: – Configuration functions
    
    func configureView(image: UIImage, text: String) {
        customView.configureView(image: image, text: text)
    }
    
    func toggleSelected() {
        if (isSelected) {
            customView.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 0.5)
        } else {
            customView.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        }
    }
    
    // MARK: – UI setup
    
    private func setupSelf() {
        self.backgroundColor = .clear
        
        self.addSubview(customView)
        
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            customView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            customView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}
