//
//  ViewController.swift
//  Meme
//
//  Created by Naveen Pandey on 13/08/15.
//  Copyright (c) 2015 navlabs. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    
    
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var navBar: UIToolbar!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : 2 ]
        
        topTextField.defaultTextAttributes=memeTextAttributes
        topTextField.delegate=self
        topTextField.textAlignment=NSTextAlignment.Center
        bottomTextField.defaultTextAttributes=memeTextAttributes
        bottomTextField.textAlignment=NSTextAlignment.Center
        bottomTextField.delegate=self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // Subscribe to keyboard notifications to allow the view to raise when necessary
        self.subscribeToKeyboardNotifications()
        cameraButton.enabled=UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        if (imagePickerView.image==nil){
            shareButton.enabled=false
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // KeyBoard Show Hide
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    
    func unsubscribeFromKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    

    
    //Pick image from camera
    @IBAction func pickImageFromCamera(sender: AnyObject) {
        let imagePicker=UIImagePickerController()
        imagePicker.delegate=self
        imagePicker.sourceType=UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: false, completion: nil)
        
    }
    
    //Pick image from Album
    @IBAction func pickImageFromAlbum(sender: AnyObject) {
        let imagePicker=UIImagePickerController()
        imagePicker.delegate=self
        imagePicker.sourceType=UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: false, completion: nil)
    }
    
    
    // Image Picker Delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]){
        
        if let image=info[UIImagePickerControllerOriginalImage] as? UIImage{
            imagePickerView.image=image
            shareButton.enabled=true
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Take a snapshot of current meme screen
    func generateMemedImage() -> UIImage
    {
        navBar.hidden=true
        toolBar.hidden=true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        navBar.hidden=false
        toolBar.hidden=false
        
        return memedImage
    }
    
    
    //Save meme
    func saveMeme(){
        
        let meme=Meme(topText: topTextField.text, bottomText: bottomTextField.text, image: imagePickerView.image!, memedImage: generateMemedImage())
        
    }
    
    
    //Share Meme
    @IBAction func shareMeme(sender: AnyObject) {
        
        let memedImage=generateMemedImage()
        let activityController=UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityController.completionWithItemsHandler={
            (s: String!, ok: Bool, items: [AnyObject]!, err:NSError!) -> Void in
            self.saveMeme()
            self.dismissViewControllerAnimated(true, completion: nil)         }
        self.presentViewController(activityController, animated: true, completion: nil)
        
    }
    
    
    
    //UITextFieldDelegate Functions
    func textFieldDidBeginEditing(textField: UITextField) {
        if(textField==topTextField){
            topTextField.text=""
        }
        else if(textField==bottomTextField){
            bottomTextField.text=""
        }
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

