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
        let width = 80
        return CGSize.init(width: width, height: width + 5)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.socialActionViewSelect(index: indexPath.row)
    }
}

class SocialCell: UICollectionViewCell {
    var imageView: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    private func initView(){
        imageView = UIImageView.init(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        
        self.addConstraint(.init(item: imageView!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(.init(item: imageView!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        self.addConstraint(NSLayoutConstraint.init(item: self.imageView!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 42))
        self.addConstraint(NSLayoutConstraint.init(item: self.imageView!, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 42))

        
        imageView.layer.cornerRadius = 10
        imageView.layer.shadowColor = UIColor.gray.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        imageView.layer.shadowRadius = 4.0
        imageView.layer.shadowOpacity = 0.5
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.white
        self.layer.cornerRadius = 12

    }
    
}
