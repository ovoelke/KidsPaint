//
//  PenCollectionView.swift
//  Kids Paint
//
//  Created by Oliver Völke on 27.02.21.
//

import UIKit

class PenCollectionView : UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let reuseIdentifier = "penCell"
    let penCellSize = CGSize(width: 72, height: 102)
    
    private var selectedPenIndex: Int = 0 {
        didSet {
            selectedPenColorHasChanged?()
        }
    }
    
    var selectedPen: Pen {
        get {
            return PenColors[selectedPenIndex]
        }
    }
    
    var selectedPenColorHasChanged: (() -> Void)?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let cellNib = UINib(nibName: "PenCell", bundle: nil)
        
        register(cellNib, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        dataSource = self
        delegate = self
        reloadData()
    }
    
    // MARK: DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PenColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PenCell else { return UICollectionViewCell() }
        
        cell.imageView.image = UIImage(named: PenColors[indexPath.row].imageName)
        
        return cell
    }
    
    // MARK: Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedPenIndex = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: penCellSize.width, height: penCellSize.height)
    }
    
}
