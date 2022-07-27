//
//  PopularCarsCell.swift
//  AutoCheckAfrica
//
//  Created by Andrew Ananda on 24/07/2022.
//

import UIKit
import SDWebImage
import SVGKit

class PopularCarsCell: UICollectionViewCell {
    
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
        return view
    }()
    
    var lblTitle: UILabel =  {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.font = .systemFont(ofSize: 12, weight: .regular)
        view.textColor = .black
        view.textAlignment = .center
        view.numberOfLines = 1
        return view
    }()
    
    
    private func setup() {
        self.backgroundColor = .clear
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(lblTitle)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 43),
            imageView.heightAnchor.constraint(equalToConstant: 43),
            
            lblTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 3),
            lblTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            lblTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            lblTitle.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
    func setupData(_ item: MakeList) {
        if item.imageURL.suffix(3) == "svg" {
            let svg = URL(string: item.imageURL)!
            let data = try? Data(contentsOf: svg)
             let receivedimage: SVGKImage = SVGKImage(data: data)
             imageView.image = receivedimage.uiImage
        }else {
            imageView.sd_setImage(with: URL(string: item.imageURL))
        }
        
        lblTitle.text = item.name
    }
    
    
}
