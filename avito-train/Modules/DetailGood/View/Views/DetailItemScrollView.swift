import UIKit
import SnapKit

extension DetailItemScrollView {
    struct Constants {
        let priceLabelFont: UIFont = .systemFont(ofSize: 36, weight: .bold)
        let titleLabelFont: UIFont = .systemFont(ofSize: 24, weight: .semibold)
        let descriptionFont: UIFont = .systemFont(ofSize: 22, weight: .regular)
        let smallFont: UIFont = .systemFont(ofSize: 18, weight: .regular)
        
        let topBetweenSmallPadding: CGFloat = 8.0
        let sidePadding: CGFloat = 8.0
        let topBetweenTitlePadding: CGFloat = 16.0
        let imageHeight: CGFloat = 300.0
        let contentViewHeight: CGFloat = 700
        
        var viewWidth: CGFloat {
            return UIScreen.main.bounds.width
        }

        let titleColor: UIColor = .label
        let smallColor: UIColor = .systemGray
    }
}

final class DetailItemScrollView: UIScrollView {
    
    // MARK: - Properties
    
    private let constants: Constants
    
    private lazy var contentView: UIView = {
        let view = makeContainer()
        
        return view
    }()
    
    private lazy var itemImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = constants.titleColor
        label.font = constants.priceLabelFont
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = constants.titleColor
        label.font = constants.titleLabelFont
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
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = constants.titleColor
        label.font = constants.descriptionFont
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = constants.titleColor
        label.font = constants.smallFont
        return label
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = constants.titleColor
        label.font = constants.smallFont
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = constants.smallColor
        label.font = constants.smallFont
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        self.constants = Constants()
        super.init(frame: frame)
        setupScrollView()
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(viewModel: DetailItemViewModel) {
        if let imageUrl = URL(string: viewModel.imageUrl) {
            itemImageView.kf.setImage(with: imageUrl)
        }
        priceLabel.text = viewModel.price
        titleLabel.text = viewModel.title
        cityLabel.text = viewModel.location
        createdLabel.text = viewModel.createdAt
        descriptionLabel.text = viewModel.description
        emailLabel.text = viewModel.email
        phoneLabel.text = viewModel.phone
        addressLabel.text = viewModel.address
    }
}

// MARK: - Private

private extension DetailItemScrollView {
    func setupScrollView() {
        showsVerticalScrollIndicator = false
    }
    
    func addSubviews() {
        self.addSubview(contentView)
    }
    
    func makeContainer() -> UIView {
        let view = UIView()
        
        [
            itemImageView, priceLabel, titleLabel, cityLabel, createdLabel,
            descriptionLabel, emailLabel, phoneLabel, addressLabel
        ]
            .forEach({ view.addSubview($0) })
        
        itemImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(constants.imageHeight)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(itemImageView.snp.bottom).offset(constants.topBetweenTitlePadding)
            make.leading.trailing.equalToSuperview().inset(constants.sidePadding)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(constants.topBetweenTitlePadding)
            make.leading.trailing.equalToSuperview().inset(constants.sidePadding)
        }
        
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(constants.topBetweenTitlePadding)
            make.leading.trailing.equalToSuperview().inset(constants.sidePadding)
        }
        
        createdLabel.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom).offset(constants.topBetweenSmallPadding)
            make.leading.trailing.equalToSuperview().inset(constants.sidePadding)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(createdLabel.snp.bottom).offset(constants.topBetweenTitlePadding)
            make.leading.trailing.equalToSuperview().inset(constants.sidePadding)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(constants.topBetweenTitlePadding)
            make.leading.trailing.equalToSuperview().inset(constants.sidePadding)
        }
        
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(constants.topBetweenSmallPadding)
            make.leading.trailing.equalToSuperview().inset(constants.sidePadding)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(constants.topBetweenSmallPadding)
            make.leading.trailing.equalToSuperview().inset(constants.sidePadding)
        }
        
        return view
    }
    
    func makeConstraints() {
        contentView.frame = .init(x: 0, y: 0, width: constants.viewWidth, height: constants.contentViewHeight)
        self.contentSize = contentView.frame.size
    }
}
