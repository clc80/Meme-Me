//
//  ViewController.swift
//  Meme Me
//
//  Created by Claudia Contreras on 1/6/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareMemeButton: UIBarButtonItem!
    
    
    let textFieldDel = TextDelegate()
    

    fileprivate func configureFor(_ textField: UITextField, with placeholder: String) {
        
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
                   NSAttributedString.Key.strokeColor : UIColor.black ,
                   NSAttributedString.Key.foregroundColor: UIColor.white ,
                   NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
                   NSAttributedString.Key.strokeWidth: -3.0
               ]
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.autocapitalizationType = .allCharacters
        textField.backgroundColor = UIColor.clear
        textField.borderStyle = .none
        textField.delegate = textFieldDel
        textField.text = placeholder
        
    }
    
    
    
    fileprivate func uiWork() {
        configureFor(topTextField, with: TextField.top.rawValue.uppercased())
        configureFor(bottomTextField, with: TextField.bottom.rawValue.uppercased());
                     
        shareMemeButton.isEnabled = imagePickerView.image != nil ? true : false
        
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
             NotificationCenter.default.addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
             
             NotificationCenter.default.addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        uiWork()
        
            
//       button1.isEnabled = false
//        if imagePickerView.image != nil {
//            button1.isEnabled.toggle()
//        }
    }
    
    
  @objc func keyboardWillShow(notification: NSNotification) {
           guard let userInfo = notification.userInfo else {return}
           guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
    if topTextField.isEditing { return }
           let keyboardFrame = keyboardSize.cgRectValue
           if self.view.frame.origin.y == 0{
               self.view.frame.origin.y -= keyboardFrame.height
           }
       }

       @objc func keyboardWillHide(notification: NSNotification) {
           if self.view.frame.origin.y != 0 {
               self.view.frame.origin.y = 0
           }
       }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
       @IBAction func pickImageFromLibrary(_ sender: Any) {
        getImage(.photoLibrary)
         
     }
     @IBAction func pickImageFromCamera(_ sender: Any) {
        getImage(.camera)
     }
     
    func getImage(_ source: UIImagePickerController.SourceType) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = source
            present(pickerController, animated: true, completion: nil)
    }
    

    
    func imagePickerController(_ picker: UIImagePickerController,
                                  didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
               imagePickerView.image = image
            shareMemeButton.isEnabled.toggle()
           }
           dismiss(animated: true, completion: nil)
       }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
          dismiss(animated: true, completion: nil)
      }
    
    func toggleBarView() {
        navigationController?.isNavigationBarHidden.toggle()
        navigationController?.isToolbarHidden.toggle()
        
    }

    func generateMemedImage() -> UIImage {

        toggleBarView()
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)

        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        toggleBarView()

        return memedImage
    }
    
    @IBAction func shareMeme(sender: Any) {
        shareMemeButton.isEnabled = imagePickerView.image != nil ? true : false
        
        if shareMemeButton.isEnabled {
            let memeImage = generateMemedImage()
                  
                  let controller = UIActivityViewController(activityItems: [memeImage],
                                                            applicationActivities: nil)
                  
                  controller.completionWithItemsHandler = {
                      (activity, success, items, error) in
                      
                      if success {
                        self.save()
                        self.dismiss(animated: true, completion: nil)
                      }
                  }
                  present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelMemeEditor() {
        if let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "TabVC") as? UITabBarController {
        tabVC.modalPresentationStyle = .fullScreen
        present(tabVC, animated: false, completion: nil)
        }
    }
    
    func save() {
        let memeImage = generateMemedImage()
        
        let meme = Meme(topText: self.topTextField.text!,
                        bottomText: self.bottomTextField.text!,
                        originalImage: self.imagePickerView.image!,
                        memedImage: memeImage)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
}



