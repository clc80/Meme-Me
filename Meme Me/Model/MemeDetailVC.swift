//
//  MemeDetailVC.swift
//  Meme Me
//
//  Created by Claudia Contreras on 1/28/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailVC: UIViewController {
    
    var meme: Meme!
    
    @IBOutlet weak var imageDetailView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageDetailView.image = meme.memedImage
    }
    
    @IBAction func sendMemeDetail(_ sender: Any) {
        
        let memeDetail = imageDetailView.image
        let controller = UIActivityViewController(activityItems: [memeDetail],
        applicationActivities: nil)
        present(controller, animated: true, completion: nil)
        
    }
    
    
}
