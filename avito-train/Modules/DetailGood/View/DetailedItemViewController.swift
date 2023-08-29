import UIKit
import SnapKit

final class DetailedItemViewController: BaseViewController {
    
    private let presenter: DetailedItemPresenterProtocol
    
    private lazy var scrollView: DetailItemScrollView = {
        return DetailItemScrollView()
    }()
    
    init(presenter: DetailedItemPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
    }
    
    private func setupView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        navigationController?.navigationBar.tintColor = .label
    }
}

extension DetailedItemViewController: DetailedItemViewInput {
    func updateViewModel(viewModel: DetailItemViewModel) {
        scrollView.fill(viewModel: viewModel)
    }
}
