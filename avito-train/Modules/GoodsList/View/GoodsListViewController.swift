import UIKit

final class GoodsListViewController: BaseViewController {
    
    private let presenter: GoodsPresenterProtocol
    private var viewModels = [GoodCollectionViewCellViewModel]()
    private var viewWidth: CGFloat = UIScreen.main.bounds.width
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let screenWidht = Int(viewWidth) / 2
        let widhtPadding = 24
        let itemWidth = screenWidht - widhtPadding
        let itemHeight = Int(Double(itemWidth) * 1.8)
        let topAndButtonInsets: CGFloat = 0
        let leftAndRightInsets: CGFloat = 16
        layout.sectionInset = .init(top: topAndButtonInsets,
                                    left: leftAndRightInsets,
                                    bottom: topAndButtonInsets,
                                    right: leftAndRightInsets)
        layout.itemSize = .init(width: itemWidth, height: itemHeight)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(GoodsCollectionViewCell.self,
                            forCellWithReuseIdentifier: String(describing: GoodsCollectionViewCell.self))
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    init(presenter: GoodsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        addSuviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}

extension GoodsListViewController: GoodsViewInput {
    func updateCollection(viewModels: [GoodCollectionViewCellViewModel]) {
        self.viewModels = viewModels
        collectionView.reloadData()
    }
}

extension GoodsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: GoodsCollectionViewCell.self),
            for: indexPath) as? GoodsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.fill(viewModel: viewModels[indexPath.row])
        return cell
    }
}

extension GoodsListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = viewModels[indexPath.row]
        viewModel.didTapCell(viewModel.id)
    }
}

private extension GoodsListViewController {
    func addSuviews() {
        view.addSubview(collectionView)
    }
}
