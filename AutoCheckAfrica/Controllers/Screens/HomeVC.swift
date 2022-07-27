//
//  HomeVC.swift
//  AutoCheckAfrica
//
//  Created by Andrew Ananda on 24/07/2022.
//

import UIKit
import RxRelay
import RxSwift

class HomeVC: UIViewController, UITextFieldDelegate {
    
    //MARK: - Properties
    var popularCars = [MakeList]()
    var cars = [CarsModel]()
    fileprivate var viewModel: CarViewModel = CarViewModel()
    fileprivate var bag = DisposeBag()
    fileprivate var activityIndicator = ViewControllerUtils()
    var selectedRow = -1
    var pageItems = 50
    var searchText = ""
    var totalPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: "backgroundColor")
        setupTopView()
        
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        carsCollectionView.delegate = self
        carsCollectionView.dataSource = self
        txfSearch.delegate = self
        popularCollectionView.register(PopularCarsCell.self, forCellWithReuseIdentifier: "cell")
        carsCollectionView.register(CarsViewCell.self, forCellWithReuseIdentifier: "cell")
                
        observeCarsResponse()
        observePopularCars()
    }
    
    private func showLoader() {
        viewModel.showLoading.subscribe(onNext: { res in
            if res {
                self.activityIndicator.showActivityIndicator(self.view)
            }else {
                self.activityIndicator.hideActivityIndicator(self.view)
            }
        }).disposed(by: bag)
        viewModel.totalPages.subscribe(onNext: {res in
            self.totalPage = res
        }).disposed(by: bag)
    }
    
    private func observeCarsResponse() {
        showLoader()
        viewModel.carsLiveData.subscribe(onNext: {[weak self] res in
            self?.cars.removeAll()
            self?.cars.append(contentsOf: res)
            DispatchQueue.main.async {
                self?.carsCollectionView.reloadData()
            }
        }).disposed(by: bag)
        viewModel.fetchCars()
    }
    
    private func observePopularCars() {
        showLoader()
        viewModel.popularCarsLiveData.subscribe(onNext: {[weak self] res in
            self?.popularCars.removeAll()
            self?.popularCars.append(contentsOf: res)
            DispatchQueue.main.async {
                self?.popularCollectionView.reloadData()
            }
        }).disposed(by: bag)
        viewModel.fetchPopularCars()
    }
    
    private func filterCars(q: String) {
        pageItems = 50
        showLoader()
        viewModel.carsLiveData.subscribe(onNext: {[weak self] res in
            self?.cars.removeAll()
            self?.cars.append(contentsOf: res)
            self?.pageItems += 50
            DispatchQueue.main.async {
                self?.carsCollectionView.reloadData()
            }
        }).disposed(by: bag)
        searchText = q
        viewModel.filterCars(query: searchText, size: pageItems)
    }
    
    private func updateCarsList() {
        viewModel.carsLiveData.subscribe(onNext: {[weak self] res in
            self?.cars.removeAll()
            self?.cars.append(contentsOf: res)
            DispatchQueue.main.async {
                self?.carsCollectionView.reloadData()
                self?.pageItems += 50
            }
        }).disposed(by: bag)
        print("TotalPages \(totalPage)")
        if self.pageItems < self.totalPage {
            showLoader()
            viewModel.updateList(query: searchText, size: pageItems)
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if txfSearch.text != "" {
            filterCars(q: txfSearch.text!)
        }
        txfSearch.resignFirstResponder()
        return true
    }
    
    private lazy var exploreTopIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "square.grid.2x2.fill")
        imageView.tintColor = .black
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return imageView
    }()
    
    private lazy var lblExplore: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Explore"
        lbl.font = mediumFont(size: 20)
        return lbl
    }()
    
    private lazy var cartIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "bag")
        imageView.tintColor = .black
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return imageView
    }()
    
    private lazy var topContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private func setupTopView() {
        view.backgroundColor = .white
        view.addSubview(topContainer)
        topContainer.addSubview(exploreTopIcon)
        topContainer.addSubview(lblExplore)
        topContainer.addSubview(cartIcon)
        
        NSLayoutConstraint.activate([
            topContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            topContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            exploreTopIcon.leadingAnchor.constraint(equalTo: topContainer.leadingAnchor, constant: 10),
            exploreTopIcon.topAnchor.constraint(equalTo: topContainer.topAnchor),
            
            lblExplore.leadingAnchor.constraint(equalTo: exploreTopIcon.trailingAnchor, constant: 10),
            lblExplore.topAnchor.constraint(equalTo: topContainer.topAnchor, constant: 5),
            
            cartIcon.topAnchor.constraint(equalTo: topContainer.topAnchor),
            cartIcon.trailingAnchor.constraint(equalTo: topContainer.trailingAnchor, constant: -10)
        ])
        
        configUI()
    }
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var txfSearch: UITextField = {
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholderText(text: "Search")
        txt.setIcon(UIImage(systemName: "magnifyingglass")!)
        txt.layer.cornerRadius = 10
        txt.layer.borderWidth = 1
        txt.layer.borderColor = UIColor.systemGray2.cgColor
        txt.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return txt
    }()
    
    private lazy var switchIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "switch.2")
        imageView.tintColor = .black
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return imageView
    }()
    
    
    private lazy var popularCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 8
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return collectionView
    }()
    
    private lazy var carsCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 8
    
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    
    private func configUI() {
        view.addSubview(containerView)
        containerView.addSubview(txfSearch)
        containerView.addSubview(switchIcon)
        containerView.addSubview(popularCollectionView)
        containerView.addSubview(carsCollectionView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            txfSearch.topAnchor.constraint(equalTo: containerView.topAnchor),
            txfSearch.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            
            
            switchIcon.topAnchor.constraint(equalTo: containerView.topAnchor),
            switchIcon.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            switchIcon.leadingAnchor.constraint(equalTo: txfSearch.trailingAnchor, constant: 10),
            
            popularCollectionView.topAnchor.constraint(equalTo: txfSearch.bottomAnchor, constant: 10),
            popularCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            popularCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            carsCollectionView.topAnchor.constraint(equalTo: popularCollectionView.bottomAnchor, constant: 20),
            carsCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            carsCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            carsCollectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            
        ])
    }
    
}


extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.popularCollectionView {
            return popularCars.count
        }else {
            return cars.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.carsCollectionView {
            let item = cars[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CarsViewCell
            cell.setupData(item)
            return cell
        }
            let item = popularCars[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PopularCarsCell
            cell.setupData(item)
        if selectedRow == indexPath.row {
            cell.layer.borderColor = UIColor(named: "yellowColor")?.cgColor
            cell.layer.borderWidth = 1
        }
        else {
            cell.layer.borderWidth = 0
        }
        
            return cell
    }
    
}


extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout

        if collectionView == self.carsCollectionView {
            return CGSize(width: 350, height: 290)
        }

        let contentInset: CGFloat = (flowayout?.collectionView?.contentInset.top ?? 0.0) + (flowayout?.collectionView?.contentInset.bottom ?? 0.0)
        let sectionInset: CGFloat = (flowayout?.sectionInset.top ?? 0.0) + (flowayout?.sectionInset.bottom ?? 0.0)
        let height = 75 - (sectionInset + contentInset)
        let width: CGFloat = 70
        return CGSize(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = popularCars[indexPath.row]
        if collectionView == self.popularCollectionView {
            filterCars(q: item.name)
            
            if selectedRow == indexPath.row {
                selectedRow = -1
            } else {
                selectedRow = indexPath.row
            }
            carsCollectionView.setContentOffset(CGPoint(x:0,y:0), animated: true)
            popularCollectionView.reloadData()
        } else {
            let item = cars[indexPath.row]
            let vc = CarDetailsVC()
            vc.id =  item.id
            show(vc, sender: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == self.carsCollectionView {
            if indexPath.row == cars.count - 1 {
                updateCarsList()
            }
        }
    }
        
}



