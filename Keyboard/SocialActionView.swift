//
//  SocialActionView.swift
//  Keyboard
//
//  Created by Alex Appadurai on 01/04/22.
//

import UIKit

protocol SocialActionViewDelegate:AnyObject{
    func socialActionViewSelect(index: Int)
}
class SocialActionView:UIView{
    
    @IBOutlet weak private var contentView: UIView!
    @IBOutlet weak private var collectionView: UICollectionView!
    
    var list: [SocialProfileModel]?
    
    weak var delegate: SocialActionViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("SocialActionView", owner: self, options: nil)
        addSubview(contentView)
        self.setNeedsLayout()
        backgroundColor = .clear
        
        contentView.frame = self.bounds
        contentView.addConstrainInParent()
        contentView.backgroundColor = .clear
        
        collectionView.register(SocialCell.self, forCellWithReuseIdentifier: "socialCell")
        
    }
}

extension SocialActionView: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (list?.count ?? 0)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "socialCell", for: indexPath) as! SocialCell
        cell.imageView.image = UIImage.init(named: list![indexPath.row].type.icon)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 70, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.socialActionViewSelect(index: indexPath.row)
    }
}

class SocialCell: UICollectionViewCell {
    var imageView: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView.init(frame: frame)
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        imageView = UIImageView.init(frame: frame)
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = .init(origin: .init(x: 15, y: 8), size: .init(width: 38, height: 38))
        imageView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
    }
    
}
