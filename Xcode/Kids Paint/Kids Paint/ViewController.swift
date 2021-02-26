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

}

