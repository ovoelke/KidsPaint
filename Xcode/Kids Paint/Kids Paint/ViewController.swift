//
//  ViewController.swift
//  Kids Paint
//
//  Created by Oliver Völke on 25.02.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var canvasView: CanvasView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        canvasView.layer.allowsEdgeAntialiasing = true
        canvasView.layer.allowsGroupOpacity = true
        canvasView.layer.masksToBounds = true
        canvasView.layer.cornerRadius = 3
    }
    
    @IBAction func PenBlackAction(_ sender: Any) {
        canvasView.setLineColor(.black)
    }
    
    @IBAction func PenBlueAction(_ sender: Any) {
        canvasView.setLineColor(.blue)
    }
    
    @IBAction func PenRedAction(_ sender: Any) {
        canvasView.setLineColor(.red)
    }
    
    @IBAction func PenGreenAction(_ sender: Any) {
        canvasView.setLineColor(.green)
    }
    
    @IBAction func DeleteAction(_ sender: Any) {
        canvasView.clear()
    }
    
    @IBAction func UndoAction(_ sender: Any) {
        canvasView.undo()
    }
}

