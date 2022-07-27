//
//  CarDetailsVC.swift
//  AutoCheckAfrica
//
//  Created by Andrew Ananda on 27/07/2022.
//

import UIKit
import RxRelay
import RxSwift
import SDWebImage


class CarDetailsVC: UIViewController {

    //MARK: - Properties
    var id  = ""
    fileprivate var viewModel: CarDetailsViewModel = CarDetailsViewModel()
    fileprivate var bag = DisposeBag()
    fileprivate var activityIndicator = ViewControllerUtils()
    
    override func viewDidLoad() {
       super.viewDidLoad()
      self.view.backgroundColor = UIColor(named: "backgroundColor")
       setupUI()
       showLoader()
       loadCarDetails()
        
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let backButton = UIBarButtonItem()
        backButton.title = "Cars"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func showLoader() {
        viewModel.showLoading.subscribe(onNext: { res in
            if res {
                self.activityIndicator.showActivityIndicator(self.view)
            }else {
                self.activityIndicator.hideActivityIndicator(self.view)
            }
        }).disposed(by: bag)
    }
    
    
    private func displayData(data: CarDetailResponse) {
        carTitle.text = data.carName
        
        let onlineUrl = URL(string: data.imageURL)
        DispatchQueue.main.async {
            self.imageView.sd_setImage(with: onlineUrl)
        }
        lblyear.text = String(describing: data.year)
        txtMileage.text = String(describing: data.mileage)
        txtTransmission.text = data.transmission
        txtInteriorColor.text = data.interiorColor
        txtExteriorColor.text = data.exteriorColor
        lblOldAmount.text = String(describing: "Kes \(formatAmount(amount: data.marketplacePrice))")
        bottomTransaction.text = String(describing: "Kes \(formatAmount(amount: data.marketplacePrice))")
        txtInspectorFullName.text = data.inspectorDetails.inspectorFullName
    }
    
    private func loadCarDetails() {
        viewModel.carDetailsLiveData.subscribe(onNext: {res in
            self.displayData(data: res)
        }).disposed(by: bag)
        viewModel.fetchCarDetails(id: id)
    }
    
    
    private lazy var carTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(named: "blackColor")
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowOpacity = 0.2
        view.layer.shouldRasterize = true
        view.heightAnchor.constraint(equalToConstant: 400).isActive = true
        view.layer.shadowOffset = CGSize(width: -1, height: 1)
        return view
    }()
    
    var imageView: UIImageView =  {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var lblOldAmount: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(named: "grayColor")
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private lazy var lblOld: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(named: "blackColor")
        lbl.numberOfLines = 1
        lbl.font = .systemFont(ofSize: 18, weight: .bold)
        lbl.text = "Price"
        return lbl
    }()
    
    private lazy var yearLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(named: "blackColor")
        lbl.numberOfLines = 1
        lbl.font = .systemFont(ofSize: 18, weight: .bold)
        lbl.text = "Year of manufacture: "
        return lbl
    }()
    
    private lazy var lblyear: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(named: "grayColor")
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private lazy var lblMileage: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(named: "blackColor")
        lbl.numberOfLines = 1
        lbl.font = .systemFont(ofSize: 18, weight: .bold)
        lbl.text = "Mileage: "
        return lbl
    }()
    
    private lazy var txtMileage: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(named: "grayColor")
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private lazy var lblTransmission: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(named: "blackColor")
        lbl.numberOfLines = 1
        lbl.backgroundColor = .clear
        lbl.font = .systemFont(ofSize: 18, weight: .bold)
        lbl.text = "Transmission: "
        return lbl
    }()
    
    private lazy var txtTransmission: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(named: "grayColor")
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private lazy var lblInteriorColor: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(named: "blackColor")
        lbl.numberOfLines = 1
        lbl.font = .systemFont(ofSize: 18, weight: .bold)
        lbl.text = "Interior Color: "
        return lbl
    }()
    
    private lazy var txtInteriorColor: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(named: "grayColor")
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private lazy var lblExteriorColor: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(named: "blackColor")
        lbl.numberOfLines = 1
        lbl.font = .systemFont(ofSize: 18, weight: .bold)
        lbl.text = "Exterior Color: "
        return lbl
    }()
    
    private lazy var txtExteriorColor: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(named: "grayColor")
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private lazy var lblInspectorFullName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(named: "blackColor")
        lbl.numberOfLines = 1
        lbl.font = .systemFont(ofSize: 18, weight: .bold)
        lbl.text = "Inspector Name: "
        return lbl
    }()
    
    private lazy var txtInspectorFullName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(named: "grayColor")
        lbl.numberOfLines = 1
        return lbl
    }()
    
    
    private lazy var bottomCardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.shadowOpacity = 0.2
        view.layer.shouldRasterize = true
        view.heightAnchor.constraint(equalToConstant: 150).isActive = true
        view.layer.shadowOffset = CGSize(width: -1, height: 1)
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var btnAdd: UIButton = {
        let btn = UIButton()
        btn.setTitle("Buy Car", for: .normal)
        btn.setTitleColor(UIColor(named: "yellowColor"), for: .normal)
        btn.backgroundColor = UIColor(named: "blackColor")
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(displayAlert), for: .touchDown)
        return btn
    }()
    
    @objc func displayAlert() {
        let alert = UIAlertController(title: "Comming Soon!", message: "\nWork in progress...", preferredStyle: .alert)
        let action=UIAlertAction(title: "Dismiss", style: .destructive, handler:{ action in
            DispatchQueue.main.async(execute: {
            })
        })
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    private lazy var bottomTransaction : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(named: "yellowColor")
        lbl.font = .systemFont(ofSize: 18, weight: .bold)
        return lbl
    }()
    
    private func setupUI() {
        view.addSubview(carTitle)
        view.addSubview(cardView)
        view.addSubview(imageView)
        cardView.addSubview(lblOldAmount)
        cardView.addSubview(lblOld)
        cardView.addSubview(yearLbl)
        cardView.addSubview(lblyear)
        cardView.addSubview(lblMileage)
        cardView.addSubview(txtMileage)
        cardView.addSubview(lblTransmission)
        cardView.addSubview(txtTransmission)
        cardView.addSubview(lblInteriorColor)
        cardView.addSubview(txtInteriorColor)
        cardView.addSubview(lblExteriorColor)
        cardView.addSubview(txtExteriorColor)
        cardView.addSubview(lblInspectorFullName)
        cardView.addSubview(txtInspectorFullName)
        view.addSubview(bottomCardView)
        bottomCardView.addSubview(btnAdd)
        bottomCardView.addSubview(bottomTransaction)
        
        
        NSLayoutConstraint.activate([
            carTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            carTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            cardView.topAnchor.constraint(equalTo: carTitle.bottomAnchor, constant: 60),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            imageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: -50),
            imageView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            imageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
            imageView.widthAnchor.constraint(equalToConstant: 270),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            lblOld.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,constant: 10),
            lblOld.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            
            lblOldAmount.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            lblOldAmount.leadingAnchor.constraint(equalTo: lblOld.trailingAnchor, constant: 10),
            
            yearLbl.topAnchor.constraint(equalTo: lblOld.bottomAnchor, constant: 10),
            yearLbl.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            lblyear.topAnchor.constraint(equalTo: lblOld.bottomAnchor, constant: 10),
            lblyear.leadingAnchor.constraint(equalTo: yearLbl.trailingAnchor, constant: 10),
            
            lblMileage.topAnchor.constraint(equalTo: lblyear.bottomAnchor, constant: 10),
            txtMileage.topAnchor.constraint(equalTo: lblyear.bottomAnchor, constant: 10),
            lblMileage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            txtMileage.leadingAnchor.constraint(equalTo: lblMileage.trailingAnchor, constant: 10),
            
            lblTransmission.topAnchor.constraint(equalTo: txtMileage.bottomAnchor, constant: 10),
            txtTransmission.topAnchor.constraint(equalTo: txtMileage.bottomAnchor, constant: 10),
            lblTransmission.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            txtTransmission.leadingAnchor.constraint(equalTo: lblTransmission.trailingAnchor, constant: 10),
            
            lblInteriorColor.topAnchor.constraint(equalTo: txtTransmission.bottomAnchor, constant: 10),
            txtInteriorColor.topAnchor.constraint(equalTo: txtTransmission.bottomAnchor, constant: 10),
            lblInteriorColor.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,constant: 10),
            txtInteriorColor.leadingAnchor.constraint(equalTo: lblInteriorColor.trailingAnchor, constant: 10),
            
            lblExteriorColor.topAnchor.constraint(equalTo: txtInteriorColor.bottomAnchor, constant: 10),
            txtExteriorColor.topAnchor.constraint(equalTo: txtInteriorColor.bottomAnchor, constant: 10),
            lblExteriorColor.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            txtExteriorColor.leadingAnchor.constraint(equalTo: lblExteriorColor.trailingAnchor, constant: 10),
            
            lblInspectorFullName.topAnchor.constraint(equalTo: txtExteriorColor.bottomAnchor, constant: 10),
            txtInspectorFullName.topAnchor.constraint(equalTo: txtExteriorColor.bottomAnchor, constant: 10),
            lblInspectorFullName.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            txtInspectorFullName.leadingAnchor.constraint(equalTo: lblInspectorFullName.trailingAnchor, constant: 10),
            
            bottomCardView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            btnAdd.bottomAnchor.constraint(equalTo: bottomCardView.bottomAnchor, constant: -50),
            btnAdd.leadingAnchor.constraint(equalTo: bottomCardView.leadingAnchor, constant: 20),
            btnAdd.trailingAnchor.constraint(equalTo: bottomCardView.trailingAnchor, constant: -20),
            
            bottomTransaction.topAnchor.constraint(equalTo: bottomCardView.topAnchor, constant: 10),
            bottomTransaction.trailingAnchor.constraint(equalTo: bottomCardView.trailingAnchor, constant: -10),
        ])
        
        
    }

}
