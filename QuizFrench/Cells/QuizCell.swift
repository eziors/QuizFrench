import UIKit

class QuizCell: UICollectionViewCell {
    
    static let reuseID = "QuizCell"
    let item = UILabel()
    
    private var widthConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(for letter: TextItem) {
        item.text = letter.item
        configureCellWidth()
    }
    
    private func configure() {
        addSubview(item)
        item.translatesAutoresizingMaskIntoConstraints = false
        item.textColor = .label
        item.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        item.backgroundColor = UIColor.systemGray6
        item.layer.cornerRadius = 5
        item.layer.borderWidth = 2
        item.clipsToBounds = true
        item.layer.borderColor = UIColor.systemGray3.cgColor
        item.textAlignment = .center
        
        NSLayoutConstraint.activate([
            item.topAnchor.constraint(equalTo: topAnchor),
            item.leadingAnchor.constraint(equalTo: leadingAnchor),
            item.trailingAnchor.constraint(equalTo: trailingAnchor),
            item.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func configureCellWidth() {
        let charCount: Int = item.text?.count ?? 0
        var minimumWidth: CGFloat = 0
        
        switch minimumWidth {
        case _ where charCount <= 1:
            minimumWidth = 40
        case _ where charCount <= 3:
            minimumWidth = 60
        case _ where charCount <= 9:
            minimumWidth = 100
        default:
            minimumWidth = 160
            break
        }
        
        // Remove qualquer restrição de largura anterior
        widthConstraint?.isActive = false
        
        // Define e ativa a nova restrição de largura
        widthConstraint = item.widthAnchor.constraint(greaterThanOrEqualToConstant: minimumWidth)
        widthConstraint?.isActive = true
    }
}
