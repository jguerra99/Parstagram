//
//  ProfileViewController.swift
//  Parstagram
//
//  Created by Jose Lopez on 3/13/22.
//

import Foundation
import UIKit
import Parse

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   


    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var profileSelector: UISegmentedControl!
    @IBOutlet weak var profilePic: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//      showbackgroundpic()
        showprofilepic()
        
    }
    func showprofilepic(){
        let user = PFUser.current()
        userNameLabel.text = user?.username
        profilePic.contentMode = .scaleAspectFill
        profilePic.makeRounded()
        let useravatar = user!["profilepic"] as? PFFileObject
        useravatar?.getDataInBackground{ (imageData, error)in
            DispatchQueue.main.async {
              if imageData != nil, error == nil {
                let image = UIImage(data: imageData!)
                  self.profilePic.image = image

              }
           }
    }
    }
    //    func showbackgroundpic(){
//        let user = PFUser.current()
//        backGround.contentMode = .scaleAspectFill
//        let useravatar = user!["backgroundpic"] as? PFFileObject
//        useravatar?.getDataInBackground{ (imageData, error)in
//            DispatchQueue.main.async {
//              if imageData != nil, error == nil {
//                let image = UIImage(data: imageData!)
//                  self.backGround.image = image
//
//              }
//           }
//    }
//    }
    
    func displayAlert() {
            let dialogMessage = UIAlertController(title: "Confirm", message: "Would you Like to Change Image or View?", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "Change", style: .default, handler: { (action) -> Void in
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = .photoLibrary
                self.present(picker, animated: true, completion: nil)
               
            })
         
            let cancel = UIAlertAction(title: "View", style: .cancel) { (action) -> Void in
                print("Cancel button tapped")
            }
            
            //Add OK and Cancel button to dialog message
            dialogMessage.addAction(ok)
            dialogMessage.addAction(cancel)
            
            // Present dialog message to user
            self.present(dialogMessage, animated: true, completion: nil)
            
        }
    @IBAction func backGroundTouch(_ sender: Any) {
        UserDefaults.standard.bool(forKey: "pic") == true
        displayAlert()

        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if UserDefaults.standard.bool(forKey: "pic") == true{
//        backGround.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
////        backGround.contentMode = .scaleAspectFill
//        self.dismiss(animated: true, completion: nil)
//      /*  let image = info[.editedImage] as! UIImage
//
//        let size = CGSize(width: 300, height: 300)
//        let scaledImage = image.af.imageScaled(to: size)
//        backGround.image = scaledImage
//       */
//        let user = PFUser.current()
//        let imageData = backGround.image?.jpegData(compressionQuality: 10)
//        let file = PFFileObject(name: "image.png", data: imageData!)
//        user?["backgroundpic"] = file
//        user?.saveInBackground(block: { (success, error) in
//                if success{
//                    //self.dismiss(animated: true, completion: nil)
//                    print("saved!")
//                }else {
//                    print("erro!")
//                }
//            })
//    }else {
        profilePic.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        profilePic.contentMode = .scaleAspectFill
        self.dismiss(animated: true, completion: nil)
        let user = PFUser.current()
        let imageData = profilePic.image?.jpegData(compressionQuality: 10)
        let file = PFFileObject(name: "image.png", data: imageData!)
        user?["profilepic"] = file
        user?.saveInBackground(block: { (success, error) in
                if success{
                    //self.dismiss(animated: true, completion: nil)
                    print("saved!")
                }else {
                    print("erro!")
                }
            })
    }
    }
    
    @IBAction func proPicTouched(_ sender: Any) {
        UserDefaults.standard.bool(forKey: "pic") == false
        displayAlert()
    }
    
    
}


extension UIImageView {

    func makeRounded() {
        self.layer.cornerRadius = self.frame.size.width / 2

        self.clipsToBounds = true
    }
}
