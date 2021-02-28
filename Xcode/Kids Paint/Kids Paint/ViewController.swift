//
//  ViewController.swift
//  Kids Paint
//
//  Created by Oliver Völke on 25.02.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var penCollectionView: PenCollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        penCollectionView.selectedPenHasChanged = (() -> Void)? { [self] in
            self.canvasView.setLineColor(penCollectionView.selectedPen.color)
        }
    }

    private func setupView() {
        canvasView.layer.allowsEdgeAntialiasing = true
        canvasView.layer.allowsGroupOpacity = true
        canvasView.layer.masksToBounds = true
        canvasView.layer.cornerRadius = 3
        
        let penBackgroundImageView = UIImageView()
        penBackgroundImageView.image = UIImage(named: "PenBackground")
        penBackgroundImageView.contentMode = .scaleToFill
        
        penCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        penCollectionView.backgroundView = penBackgroundImageView
    }
    
    @IBAction func DeleteAction(_ sender: Any) {
        canvasView.clear()
    }
    
    @IBAction func UndoAction(_ sender: Any) {
        canvasView.undo()
    }
}

