//
//  ViewController.swift
//  Kids Paint
//
//  Created by Oliver Völke on 25.02.21.
//

import UIKit

class ViewController: UIViewController {

    private var activeTool: CanvasTool = .pen
    
    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var penCollectionView: PenCollectionView!
    @IBOutlet weak var toolPenButton: UIButton!
    @IBOutlet weak var toolOvalButton: UIButton!
    @IBOutlet weak var toolRectButton: UIButton!
    
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
        
        highlightActiveToolButton()
    }
    
    private func highlightActiveToolButton() {
        let penImage = activeTool == .pen ? "ToolPenActive" : "ToolPenInactive"
        toolPenButton.setImage(UIImage(named: penImage), for: .normal)
        
        let ovalImage = activeTool == .oval ? "ToolOvalActive" : "ToolOvalInactive"
        toolOvalButton.setImage(UIImage(named: ovalImage), for: .normal)
        
        let rectImage = activeTool == .rect ? "ToolRectActive" : "ToolRectInactive"
        toolRectButton.setImage(UIImage(named: rectImage), for: .normal)
    }
    
    @IBAction func DeleteAction(_ sender: Any) {
        canvasView.clear()
    }
    
    @IBAction func UndoAction(_ sender: Any) {
        canvasView.undo()
    }
    
    @IBAction func ToolPenAction(_ sender: Any) {
        activeTool = .pen
        highlightActiveToolButton()
    }
    
    @IBAction func ToolOvalAction(_ sender: Any) {
        activeTool = .oval
        highlightActiveToolButton()
    }
    
    @IBAction func ToolRectAction(_ sender: Any) {
        activeTool = .rect
        highlightActiveToolButton()
    }
    
}

