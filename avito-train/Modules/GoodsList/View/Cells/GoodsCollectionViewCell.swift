import UIKit
import SnapKit
import Kingfisher

extension GoodsCollectionViewCell {
    struct Constants {
        let imageRadius: CGFloat = 8.0
        let titlePadding: CGFloat = 8.0
        let createLabelTopPadding: CGFloat = 4.0
        
        let titleFont: UIFont = .systemFont(ofSize: 18, weight: .regular)
        let priceFont: UIFont = .systemFont(ofSize: 16, weight: .bold)
        let smallFont: UIFont = .systemFont(ofSize: 14, weight: .regular)
        
        let emptyImageName: String = "emptyImage"
        let titleColor: UIColor = .label
        let smallColor: UIColor = .systemGray
    }
}

final class GoodsCollectionViewCell: UICollectionViewCell {
    
    private let constants: Constants
    
    private lazy var itemImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = constants.imageRadius
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = constants.titleColor
        label.font = constants.titleFont
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = constants.titleColor
        label.font = constants.priceFont
        return label
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = constants.smallColor
        label.font = constants.smallFont
        return label
    }()
    
    private lazy var createdLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = constants.smallColor
        label.font = constants.smallFont
        return label
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .label
        view.startAnimating()
        view.hidesWhenStopped = true
        return view
    }()
    
    override init(frame: CGRect) {
        self.constants = Constants()
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImageView.image = nil
        [titleLabel, priceLabel, cityLabel, createdLabel].forEach({ $0.text = nil })
    }
    
    func fill(viewModel: GoodCollectionViewCellViewModel) {
        if let imageUrl = URL(string: viewModel.imageUrl) {
            itemImageView.kf.setImage(with: imageUrl) { _ in
                self.activityIndicator.stopAnimating()
            }
        } else {
            itemImageView.image = UIImage(named: constants.emptyImageName)
        }
        titleLabel.text = viewModel.title
        priceLabel.text = viewModel.price
        cityLabel.text = viewModel.location
        createdLabel.text = viewModel.createdDate
    }
}

private extension GoodsCollectionViewCell {
    func setupCell() {
        
    }
    
    func addSubviews() {
        [itemImageView, titleLabel, priceLabel, cityLabel, createdLabel].forEach({
            self.contentView.addSubview($0)
        })
        itemImageView.addSubview(activityIndicator)
    }
    
    func makeConstraints() {
        itemImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(self.snp.width)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(itemImageView.snp.bottom).offset(constants.titlePadding)
            make.leading.trailing.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(constants.titlePadding)
            make.leading.trailing.equalToSuperview()
        }
        
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(constants.titlePadding)
            make.leading.trailing.equalToSuperview()
        }
        
        createdLabel.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom).offset(constants.createLabelTopPadding)
            make.leading.trailing.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
