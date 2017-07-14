//
//  AddStudentViewController.swift
//  TableViewSample
//
//  Created by avnish kumar on 28/06/17.
//  Copyright © 2017 avnish kumar. All rights reserved.
//

import UIKit

class AddStudentViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var pencilButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    weak var addStudentDelegate:StudentDataUpdate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addImageAction(_ sender: UIButton) {
        
        let imagepicker = UIImagePickerController()
        imagepicker.sourceType = .photoLibrary
        imagepicker.delegate = self
        self.present(imagepicker, animated: true, completion: nil)
    
    }
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            self.imageView.image = image
            pencilButton.isHidden = true
        }
        picker.dismiss(animated: true, completion: nil)
    }
  
    @IBAction func submitButtonAction(_ sender: UIButton) {
        
        addStudentDelegate?.updateStudentDataInTable(student: Student(name: nameTextField.text!, photo: imageView.image!))
        self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
