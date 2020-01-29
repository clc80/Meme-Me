//
//  SentMemeTableViewController.swift
//  Meme Me
//
//  Created by Claudia Contreras on 1/28/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

import UIKit

class SentMemeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var addNewMemeButton: UIBarButtonItem!
    @IBOutlet weak var sentMemeTableView: UITableView!
        
        var memes: [Meme]! {
               let object = UIApplication.shared.delegate
               let appDelegate = object as! AppDelegate
               return appDelegate.memes
            
           }
        
        override func viewDidLoad() {
            
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
                sentMemeTableView.reloadData()
        }
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.memes.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell", for: indexPath) as? MemeTableViewCell else { return UITableViewCell()}
            let meme = self.memes[(indexPath as NSIndexPath).row]
            
            cell.textLabel?.text = meme.topText + " " + meme.bottomText
            cell.imageView?.image = meme.memedImage
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if let memeDetailVC = self.storyboard?.instantiateViewController(identifier: "MemeDetailVC") as? MemeDetailVC {
                memeDetailVC.meme = memes[indexPath.row]
                navigationController?.pushViewController(memeDetailVC, animated: true)
            }
        }
        
        
        @IBAction func createNewMeme() {
            if let memeEditorNC = self.storyboard?.instantiateViewController(withIdentifier: "MemeEditorNC") as? UINavigationController {
                memeEditorNC.modalPresentationStyle = .fullScreen
                present(memeEditorNC, animated: false, completion: nil)
            }
        }
    }

