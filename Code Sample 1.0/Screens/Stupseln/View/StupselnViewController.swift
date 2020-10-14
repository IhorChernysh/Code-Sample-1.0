//
//  StupselnViewController.swift
//  p153-ios
//
//  Created by ihor-ios on 10.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import SnapKit
import RxCocoa
import RxDataSources
import RxSwift
import JGProgressHUD

class StupselnViewController: UIViewController {

    // MARK: - UI Properties
    
    private let navigationView: UIView = {
        let view = UIView(color: .white)
        view.layer.shadowColor = UIColor.darkWithZeroPointOneAlpha.cgColor
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 1
        view.layer.shadowOpacity = 1
        return view
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(title: "Zurück", image: UIImage(), titleColor: .dark212121Color, font: UIFont.boldSystemFont(ofSize: 17), backgroundColor: .white)
        button.tintColor = .dark212121Color
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = .init(width: view.frame.width, height: 160)
        layout.itemSize = .init(width: view.frame.width - (spaceBetweenScreenAndCell * 2), height: 60)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 90, right: 0)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(StupselnCell.self, forCellWithReuseIdentifier: StupselnCell.description())
        collectionView.register(StupselnReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StupselnReusableView.description())
        return collectionView
    }()
    
    private let bottomContainerView = UIView(color: .white)
    
    private let bottomApplyButton: UIButton = {
        let button = UIButton(title: "Stupsler abschicken", titleColor: #colorLiteral(red: 0.3725490196, green: 0.4862745098, blue: 0.5490196078, alpha: 1), font: UIFont.boldSystemFont(ofSize: 17), backgroundColor: #colorLiteral(red: 0.8588235294, green: 0.8823529412, blue: 0.8901960784, alpha: 1), cornerRadius: 4)
        button.isUserInteractionEnabled = false
        return button
    }()
    private let progressHud = JGProgressHUD(style: .dark)
    
    // MARK: - Properties
    
    private let spaceBetweenScreenAndCell: CGFloat = 28
    private let disposeBag = DisposeBag()
    private var stupselnViewModel: StupselnViewModel!
    
    // MARK: - Init
    
    init(viewModel: StupselnViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.stupselnViewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Lifecycle

extension StupselnViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCurrentUI()
        setupBinding()
        fetchStupslers()
    }
}

// MARK: - Methods

extension StupselnViewController {
    private func setupCurrentUI() {
        view.backgroundColor = .white
        setNavigationController()
        addApplyButton()
        addCollectionView()
    }
    
    private func setupBinding() {
        // OLD DATA SOURCE FOR COLLECTION VIEW

//        let (configureCollectionViewCell, configureSupplementaryView) = self.collectionViewDataSourceUI()
//        let dataSource = RxCollectionViewSectionedAnimatedDataSource<StupselnSection>(configureCell: configureCollectionViewCell, configureSupplementaryView: configureSupplementaryView)
//
//        stupselnViewModel
//            .stupselnSectionRelay
//            .asObservable()
//            .bind(to: collectionView.rx.items(dataSource: dataSource))
//            .disposed(by: disposeBag)
//
//        collectionView.rx
//            .modelSelected(Stupslers.self)
//            .subscribe(onNext: { [weak self] stupsler in
//                if let previousMessage = self?.stupselnViewModel.selectedStupselnRelay.value {
//                    if previousMessage.text != stupsler.text {
//                        var updated = stupsler
//                        updated.isSelected = !stupsler.isSelected
//                        self?.stupselnViewModel.selectedStupselnRelay.accept(updated)
//                    } else {
//                        self?.stupselnViewModel.selectedStupselnRelay.accept(nil)
//                    }
//                } else {
//                    var updated = stupsler
//                    updated.isSelected = !stupsler.isSelected
//                    self?.stupselnViewModel.selectedStupselnRelay.accept(updated)
//                }
//
//                var allItems = self?.stupselnViewModel.allDefaultInactiveStupslers
//
//                let itemsForUpdate = allItems?.enumerated().filter { $0.element.text == stupsler.text }
//                var elementForUpdate = itemsForUpdate?.first?.element
//                elementForUpdate?.isSelected = !stupsler.isSelected
//                allItems?.remove(at: itemsForUpdate?.first?.offset ?? 0)
//                if let updatedElement = elementForUpdate {
//                    allItems?.insert(updatedElement, at: itemsForUpdate?.first?.offset ?? 0)
//                }
//                if let updatedItems = allItems {
//                    let updatedSection = [StupselnSection(headerImage: UIImage(), title: "", description: "", stupselnItems: updatedItems)]
//                    self?.stupselnViewModel.stupselnSectionRelay.accept(updatedSection)
//                }
//            })
//            .disposed(by: disposeBag)

        stupselnViewModel
            .allStupslersSubject
            .asObservable()
            .subscribe(onNext: { [weak self] stupslers in
                guard let self = self else { return }
                self.view.removeSpinner(progressHud: self.progressHud)
                let stupselnSection = [StupselnSection(headerImage: UIImage(), title: "", description: "", stupselnItems: stupslers)]
                self.stupselnViewModel.allStupslers = stupslers
                self.stupselnViewModel.allDefaultInactiveStupslers = stupslers
                self.collectionView.reloadData()
                self.stupselnViewModel.stupselnSectionRelay.accept(stupselnSection)
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.view.removeSpinner(progressHud: self.progressHud)
                let alert = self.alert(title: "Something wrong", message: error.localizedDescription, actions: [UIAlertAction(title: "Cancel", style: .default)], style: .alert)
                self.present(alert, animated: true)
            })
            .disposed(by: disposeBag)
        
        stupselnViewModel
            .selectedStupselnRelay
            .asObservable()
            .subscribe(onNext: { stupselnModel in
                self.updateButtonState(isEnable: stupselnModel?.isSelected ?? false)
            })
            .disposed(by: disposeBag)
        
        stupselnViewModel
            .didPostStupslerSubject
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
                }, onError: { [weak self] error in
                    guard let self = self else { return }
                    let alert = self.alert(title: "Something wrong!", message: error.localizedDescription, actions: [UIAlertAction(title: "Cancel", style: .default)], style: .alert)
                    self.view.removeSpinner(progressHud: self.progressHud)
                    self.present(alert, animated: true)
            })
            .disposed(by: disposeBag)
        
        backButton.rx
            .tap
            .bind { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
        }
        .disposed(by: disposeBag)
        
        bottomApplyButton.rx
            .tap
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.view.addSpinner(progressHud: self.progressHud)
                self.stupselnViewModel.sendStupsler()
        }
        .disposed(by: disposeBag)
    }
    
    private func fetchStupslers() {
        view.addSpinner(progressHud: progressHud)
        stupselnViewModel.fetchAllStupslers()
    }
    // OLD DATA SOURCE FOR COLLECTION VIEW
    
//    private func collectionViewDataSourceUI() -> (CollectionViewSectionedDataSource<StupselnSection>.ConfigureCell, CollectionViewSectionedDataSource<StupselnSection>.ConfigureSupplementaryView) {
//        return (
//            { _, collectionView, indexPath, itemToSet in
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StupselnCell.description(), for: indexPath) as? StupselnCell
//            cell?.configure(stupseln: itemToSet)
//            return cell ?? UICollectionViewCell()
//        },
//            { dataSource, collectionView, kind, indexPath in
//                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StupselnReusableView.description(), for: indexPath)
//                return headerView
//        }
//        )
//    }
}

// MARK: - UICollectionViewDataSource

extension StupselnViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stupselnViewModel.allStupslers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StupselnReusableView.description(), for: indexPath)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StupselnCell.description(), for: indexPath) as? StupselnCell else { return StupselnCell() }
        let stupslerToSet = stupselnViewModel.allStupslers[indexPath.item]
        cell.configure(stupseln: stupslerToSet)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let stupsler = stupselnViewModel.allStupslers[indexPath.item]
        if let previousMessage = self.stupselnViewModel.selectedStupselnRelay.value {
            if previousMessage.text != stupsler.text {
                var updated = stupsler
                updated.isSelected = !stupsler.isSelected
                self.stupselnViewModel.selectedStupselnRelay.accept(updated)
            } else {
                self.stupselnViewModel.selectedStupselnRelay.accept(nil)
            }
        } else {
            var updated = stupsler
            updated.isSelected = !stupsler.isSelected
            self.stupselnViewModel.selectedStupselnRelay.accept(updated)
        }
        
        var allItems = self.stupselnViewModel.allDefaultInactiveStupslers

        let itemsForUpdate = allItems.enumerated().filter { $0.element.text == stupsler.text }
        var elementForUpdate = itemsForUpdate.first?.element
        elementForUpdate?.isSelected = !stupsler.isSelected
        allItems.remove(at: itemsForUpdate.first?.offset ?? 0)
        if let updatedElement = elementForUpdate {
            allItems.insert(updatedElement, at: itemsForUpdate.first?.offset ?? 0)
        }
        self.stupselnViewModel.allStupslers = allItems
        self.collectionView.reloadData()
    }
}

// MARK: - Setup Layout

extension StupselnViewController {
    private func setNavigationController() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        // allow swipe from left
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(40)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "Stupsler"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        
        navigationView.addSubviews([backButton, titleLabel])
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func addApplyButton() {
        view.addSubview(bottomContainerView)
        bottomContainerView.addSubview(bottomApplyButton)
        
        bottomContainerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.height.equalTo(84)
        }
        view.bringSubviewToFront(bottomContainerView)
        bottomApplyButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.leading.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.top.equalToSuperview().offset(10)
        }
    }
    
    private func addCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomContainerView.snp.top)
        }
        view.bringSubviewToFront(navigationView)
    }
    
    private func updateButtonState(isEnable: Bool) {
        if isEnable {
            self.bottomApplyButton.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.3) {
                self.bottomApplyButton.backgroundColor = .membershipGreenColor
                self.bottomApplyButton.setTitleColor(.white, for: .normal)
            }
        } else {
            self.bottomApplyButton.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.3) {
                self.bottomApplyButton.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8823529412, blue: 0.8901960784, alpha: 1)
                self.bottomApplyButton.setTitleColor(#colorLiteral(red: 0.3725490196, green: 0.4862745098, blue: 0.5490196078, alpha: 1), for: .normal)
            }
        }
    }
}
