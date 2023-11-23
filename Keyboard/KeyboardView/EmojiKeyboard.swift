//
//  SocialActionView.swift
//  Keyboard
//
//  Created by Alex Appadurai on 01/04/22.
//

import UIKit

protocol EmojiKeyboardDelegate:KeyboardViewDelegate{
    func emojiKeyboardSelect(item: EmojiModel)
    func emojiKeyboardChangeBoard()
}

class EmojiKeyboard: KeyboardBaseContentView{
    
    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet weak var spaceButton: KeyButton!
    @IBOutlet weak var shiftButton: KeyButton!
    
    var list: [EmojiModel] = []{
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    override var  keyboardAppearance: UIKeyboardAppearance!{
        didSet{
            super.keyboardAppearance = keyboardAppearance
            let isDarkMode = keyboardAppearance == .dark
            
            spaceButton.isDarkMode = isDarkMode
            shiftButton.isDarkMode = isDarkMode
        }
    }
    weak var delegate: EmojiKeyboardDelegate?
    
    
    override var registerNib: String{
        "EmojiKeyboard"
    }
    override func initialize() {
        super.initialize()
        collectionView.register(EmojiView.self, forCellWithReuseIdentifier: "emojiView")
        collectionView.register(MyHeaderFooterClass.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        
        collectionView.register(MyHeaderFooterClass.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer")
    }
    @IBAction func changeBoardToABCAction(_ button:KeyButton){
        self.delegate?.emojiKeyboardChangeBoard()
    }
    @IBAction func changeNextKeboardAction(_ button:KeyButton){
        self.delegate?.keyboardDidNextGlobalKeyboard()
    }
    @IBAction func spaceButtonAction(_ button:KeyButton){
        delegate?.keyboardDidTapSpace()
    }
    @IBAction func buttonBackspace(_ button:KeyButton){
        self.delegate?.keyboardDidTapBackspace()
    }
    @objc func buttonTap(_ button:KeyButton){
        delegate?.emojiKeyboardSelect(item: list[button.tag])
    }
}

extension EmojiKeyboard: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emojiView", for: indexPath) as! EmojiView
        
        cell.titleLabel.text = list[indexPath.row].emoji
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 30, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.emojiKeyboardSelect(item:  list[indexPath.row])
    }
}

class EmojiView: UICollectionViewCell {
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel = UILabel.init(frame: frame)
        self.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        titleLabel = UILabel.init(frame: frame)
        self.addSubview(titleLabel)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = .init(origin: .init(x: 0, y: 0), size: .init(width: 30, height: 30))
        titleLabel.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        titleLabel.font = UIFont.systemFont(ofSize: 25)
        
    }
    
}

class MyHeaderFooterClass: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.purple
        
        // Customize here
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}
