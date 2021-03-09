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
    @IBOutlet weak var toolPenButton: UIButton!
    @IBOutlet weak var toolOvalButton: UIButton!
    @IBOutlet weak var toolRectButton: UIButton!
    
    @IBAction func DeleteAction(_ sender: Any) {
        canvasView.clear()
    }
    
    @IBAction func UndoAction(_ sender: Any) {
        canvasView.undo()
    }
    
    @IBAction func ToolPenAction(_ sender: Any) {
        selectedTool = .penTool
    }
    
    @IBAction func ToolOvalAction(_ sender: Any) {
        selectedTool = .ovalTool
    }
    
    @IBAction func ToolRectAction(_ sender: Any) {
        selectedTool = .rectTool
    }
    
    private var selectedTool: Tool = .penTool {
        didSet {
            canvasView.setDrawingTool(selectedTool)
            for view in view.subviews {
                if let button = view as? UIButton,
                   let id = button.accessibilityIdentifier {
                    if id.contains("Tool") {
                        let suffix = selectedTool.rawValue == id ?
                            "Active" : "Inactive"
                        guard let image = UIImage(named: id + suffix) else {
                            assertionFailure("No image for \(id + suffix)")
                            return
                        }
                        button.setImage(image, for: .normal)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        penCollectionView.selectedPenColorHasChanged = (() -> Void)? { [self] in
            self.canvasView.setLineColor(penCollectionView.selectedPen.color)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selectedTool = .penTool
        penCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .top)
    }
    
    private func setupView() {
        canvasView.layer.allowsEdgeAntialiasing = true
        canvasView.layer.allowsGroupOpacity = true
        canvasView.layer.masksToBounds = true
        canvasView.layer.cornerRadius = 3
        
        let penBackgroundImageView = UIImageView()
        penBackgroundImageView.image = UIImage(named: "penBackground")
        penBackgroundImageView.contentMode = .scaleToFill
        
        penCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        penCollectionView.backgroundView = penBackgroundImageView
    }
}

