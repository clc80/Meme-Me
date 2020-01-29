//
//  SentMemesCollectionViewController.swift
//  Meme Me
//
//  Created by Claudia Contreras on 1/28/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

import UIKit

class SentMemeCollectionsViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var addNewMemeButton: UIBarButtonItem!
    
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0

            flowLayout.minimumInteritemSpacing = space
            flowLayout.minimumLineSpacing = space
            flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        collectionView!.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as? MemeCollectionViewCell else { return UICollectionViewCell() }
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.collectionMemeCell?.image = meme.memedImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
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
