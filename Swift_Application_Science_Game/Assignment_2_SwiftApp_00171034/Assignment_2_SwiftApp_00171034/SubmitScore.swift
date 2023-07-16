//
//  SubmitScore.swift
//  Assignment_2_SwiftApp_00171034
//
//  Created by user212086 on 4/21/23.
//

import UIKit

class SubmitScore: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate{
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var scoreToSubmit: Int = 0
    
    @IBOutlet weak var pickImage: UIImageView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var submitScoreText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        userName.delegate = self
        appDelegate.myModel.setBackground(parent: self.view)
        scoreToSubmit = appDelegate.myModel.getCurrentUserScore()
        setScoreLabel(score: String(scoreToSubmit))
    }
    
    /*
     Allows the user to select an image from the saved photos album in the phone
     */
    @IBAction func selectImage(_ sender: Any) {
        let imgPicker = UIImagePickerController()
        imgPicker.sourceType = .savedPhotosAlbum
        imgPicker.allowsEditing = true //enables image to be cropped
        imgPicker.delegate = self
        self.present(imgPicker, animated: true, completion: nil)
        
    }
    
    /*
     Sets the score label text
     @param score obtained by user
     */
    func setScoreLabel(score: String)
    {
        submitScoreText.text = "Your Score: " + score
    }
    
    /*
     Sets a character limit for the name textfield
     */
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldLength = textField.text else {return true} //checks field is not nil
        let count = textFieldLength.count + string.count - range.length //caluate length of string
        
        return count <= 14 //Maximum characters
        
    }
    
    /*
     *Image picker controller, assigns the chosen image to the pickImage
     *outlet, checks if the image is edited or the original before assigning
     */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                
        if let editImg = info[.editedImage] as? UIImage {
            pickImage.image = editImg
        } else if let origImg = info[.originalImage] as? UIImage{
            pickImage.image = origImg
        } else {
            return
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    /*
     Dismisses the image picker if the user selects cancel
     */
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func checkImg(img:UIImageView) -> UIImage{
        if let imgUpload = pickImage{
            return imgUpload.image!
        } else{
            return UIImage(named: "img1")!
        }
            
    }
    
    
    /*
     Submits the high score details to the myModel array to be displayed on following page.
     */
    @IBAction func submit(_ sender: Any) {
    
        let defaultImg = UIImage(named: "img1")! //Sets a default image to be used if pickImage is null
        
        
        if let name = userName.text?.trimmingCharacters(in: .whitespaces), !name.isEmpty{
            appDelegate.myModel.addHighScore(name: name, score: scoreToSubmit, image: pickImage.image ?? defaultImg)  //default image used here, avoids if statement
            performSegue(withIdentifier: "ShowHighScores", sender: nil)
            
        } else{
            makeToast(message: "Please enter a name!")
        }
    }
    
    /*
     Creates a toast pop-up to tell the user that they haven't entered any text in the textfield
     */
    func makeToast(message : String) {

        let popUpLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100, y: self.view.frame.size.height*0.45, width: 200, height: 55))
        popUpLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        popUpLabel.textColor = UIColor.red
        popUpLabel.font = .systemFont(ofSize: 20.0)
        popUpLabel.textAlignment = .center;
        popUpLabel.text = message
        popUpLabel.alpha = 1.0
        popUpLabel.layer.cornerRadius = 9;
        popUpLabel.clipsToBounds  =  true
        self.view.addSubview(popUpLabel)    //adds label as a subview
        UIView.animate(withDuration: 2.0, delay: 3, options: .curveLinear, animations: {    //animates label to fade out after 3 seconds
            popUpLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            popUpLabel.removeFromSuperview()
        })
    }
    
    
}
