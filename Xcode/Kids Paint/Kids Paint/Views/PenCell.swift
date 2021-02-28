//
//  PenCell.swift
//  Kids Paint
//
//  Created by Oliver Völke on 28.02.21.
//

import UIKit

class PenCell : UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageTopConstraint: NSLayoutConstraint!
    
    override func didMoveToSuperview() {
        raiseImage(isSelected, animated: false)
    }
    
    override init(frame aFrame: CGRect) {
        super.init(frame: aFrame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var isSelected: Bool {
        didSet {
            raiseImage(isSelected, animated: true)
        }
    }
    
    private func raiseImage(_ isSelected: Bool, animated: Bool) {
        self.imageTopConstraint.constant = isSelected ? 0 : 24
        if animated {
            UIView.animate(withDuration: 0.4) {
                self.layoutIfNeeded()
            }
        }
        
       
    }
}
