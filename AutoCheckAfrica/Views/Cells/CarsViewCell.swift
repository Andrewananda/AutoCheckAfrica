//
//  CarsViewCell.swift
//  AutoCheckAfrica
//
//  Created by Andrew Ananda on 27/07/2022.
//

import UIKit
import SDWebImage

class CarsViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var imageView: UIImageView =  {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    var lblTitle: UILabel =  {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.font = .systemFont(ofSize: 18, weight: .bold)
        view.textColor = UIColor(named: "blackColor")
        view.numberOfLines = 1
        return view
    }()
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowOpacity = 0.2
        view.layer.shouldRasterize = true
        view.layer.shadowOffset = CGSize(width: -1, height: 1)
        view.backgroundColor = .white
        return view
    }()
    
    var lblOldAmount: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(named: "grayColor")
        lbl.numberOfLines = 1
        return lbl
    }()
    
    var lblAmount: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(named: "blackColor")
        lbl.numberOfLines = 1
        lbl.text = "Kes \(200000)"
        return lbl
    }()
    
    var addIcon: UIImageView =  {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.image = UIImage(systemName: "plus")
        view.tintColor = UIColor(named: "yellowColor")
        return view
    }()
    
    private var iconView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 30).isActive = true
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        view.backgroundColor = UIColor(named: "blackColor")
        view.layer.cornerRadius = 10
        return view
    }()
    
    private func setup() {
        self.backgroundColor = .white
        self.addSubview(cardView)
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(lblTitle)
        self.contentView.addSubview(lblOldAmount)
        self.contentView.addSubview(lblAmount)
        self.contentView.addSubview(iconView)
        self.contentView.addSubview(addIcon)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 50),
            cardView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: -50),
            imageView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            imageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            lblTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            lblTitle.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            
            lblOldAmount.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 5),
            lblOldAmount.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            
            lblAmount.topAnchor.constraint(equalTo: lblOldAmount.bottomAnchor, constant: 5),
            lblAmount.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            
            iconView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
            iconView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            
            addIcon.topAnchor.constraint(equalTo: iconView.topAnchor, constant: 5),
            addIcon.leadingAnchor.constraint(equalTo: iconView.leadingAnchor, constant: 5),
            addIcon.trailingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: -5),
            addIcon.bottomAnchor.constraint(equalTo: iconView.bottomAnchor, constant: -5),
        ])
    }
    
    func setupData(_ item: CarsModel) {
                
        let onlineUrl = URL(string: item.imageURL)
        
        //var loaclFileUrl = Bundle.main.url(forResource: "2", withExtension: "webp")
            DispatchQueue.main.async {
                self.imageView.sd_setImage(with: onlineUrl)
            }
        
        
        lblTitle.text = item.title
        if item.marketplacePrice < item.marketplaceOldPrice {
            lblOldAmount.attributedText = "Kes \(formatAmount(amount: item.marketplaceOldPrice))".strikeThrough()
        }
        lblAmount.text =  String(describing: "Kes \(formatAmount(amount: item.marketplacePrice))")
    }
}
