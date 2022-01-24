//
//  ViewController.swift
//  UpaxTest
//
//  Created by Daniel iOS on 21/01/22.
//

import UIKit

class HomeVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - Vars
    let arrayTableCells: [String] = ["Text", "Pic", "Enviar", "Graph","Colors"]
    var imageSelfie: UIImage?
    var databaseViewModel = DatabaseViewModel()
    var storageViewModel = StorageViewModel()
    var spinner: UIView?
    var userName: String = ""
    
    //MARK: - IBActions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Dismiss keyboard
        self.hideKeyboardWhenTappedAround()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        imageSelfie = UIImage(named: "selfie")
        bind()
    }
    
    func bind() {
        
        //Cambio de color desde Firebase
        databaseViewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.view.backgroundColor = self!.databaseViewModel.dataColor
            }
        }
        
        //Resultado de FirebaseStorage
        storageViewModel.refreshResult = { [weak self] () in
            DispatchQueue.main.async {
                self?.removeSpinner()
                let alert = UIAlertController(title: "¡Exito!", message: self!.storageViewModel.dataResult, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self!.present(alert, animated: true, completion: nil)
            }
        }
        
        //Errores de FirebaseStorage
        storageViewModel.refreshErrors = { [weak self] () in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Ocurrió un error", message: self!.storageViewModel.errorAppear, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self!.present(alert, animated: true, completion: nil)
            }
        }
        
    }

    
    //MARK: - Spinner
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        spinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.spinner?.removeFromSuperview()
            self.spinner = nil
        }
    }

}

//MARK: - TableViewDelegates

extension HomeVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayTableCells.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch arrayTableCells[section] {
        case "Text":
            return "Ingresa tu Nombre"
        case "Pic":
            return "Toma una selfie"
        case "Colors":
            return "Elige un color para las pantallas"
        default:
            return""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch arrayTableCells[indexPath.section] {
        case "Text":
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! EditTextTableViewCell
            cell.editText.delegate = self
            return cell
        case "Pic":
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! PicTableViewCell
            cell.imagePic.image = imageSelfie
            return cell
        case "Graph":
            let cell: UITableViewCell = UITableViewCell(style: .default, reuseIdentifier: "cell3")
            cell.textLabel?.text = "Gráficas"
            cell.textLabel?.textColor = UIColor.systemBlue
            cell.accessoryType = .disclosureIndicator
            return cell
        case "Colors":
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell4") as! ColorsTableViewCell
            
            cell.buttonOrange.tintColor = UIColor.systemOrange
            cell.buttonPink.tintColor = UIColor.systemPink
            cell.buttonPurple.tintColor = UIColor.systemPurple
            cell.buttonGreen.tintColor = UIColor.systemTeal
            
            cell.button1 = {
                self.databaseViewModel.sendData(color: "Naranja")
            }
            cell.button2 = {
                self.databaseViewModel.sendData(color: "Rosa")
            }
            cell.button3 = {
                self.databaseViewModel.sendData(color: "Morado")
            }
            cell.button4 = {
                self.databaseViewModel.sendData(color: "Verde")
            }
            
            return cell
        case "Enviar":
            let cell: UITableViewCell = UITableViewCell(style: .default, reuseIdentifier: "cell3")
            cell.textLabel?.text = "Enviar Foto"
            cell.textLabel?.textColor = UIColor.systemBlue
            return cell
            
        default:
            let cell: UITableViewCell = UITableViewCell(style: .default, reuseIdentifier: "cell3")
            debugPrint("No cell identified")
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch arrayTableCells[indexPath.section] {
        case "Pic":
            let alert = UIAlertController(title: "Agregar foto", message: "Tomar foto desde cámara o de sus archivos?", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "camera", style: .default, handler: {
                                            action in
                self.takePhotoWithCamera()
                
            }))
            alert.addAction(UIAlertAction(title: "Mis Archivos", style: .default, handler: {
            action in
                self.choosePhotoFromLibrary()
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

            self.present(alert, animated: true)
        case "Graph":
            //Case of use Storyboards
//            let graphStoryBoard: UIStoryboard = UIStoryboard(name: "Graphics", bundle: nil)
//            let graphView = graphStoryBoard.instantiateViewController(withIdentifier: "GraphView")
//            let graphView = GraphVC(nibName: "GraphVC", bundle: nil)
            let graphView = GraphVC()
            self.navigationController?.pushViewController(graphView, animated: true)
        case "Enviar":
            if userName.isEmpty {
                let alert = UIAlertController(title: "Error", message: "Ingresa tu nombre en el campo", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            let defaultImage = UIImage(named: "selfie")!
            if imageSelfie!.isEqualToImage(defaultImage) {
                let alert = UIAlertController(title: "Error", message: "Aún no has tomado una selfie", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                self.showSpinner(onView: self.view)
                self.storageViewModel.uploadSelfie(imageData: self.imageSelfie!.pngData()!, userName: userName)
            }
        default:
            debugPrint("Cell has no Action")
        }
    }
    
}

//MARK: - TextField Delegate
extension HomeVC: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
    }
    
    @objc func valueChanged(_ textField: UITextField) {
        self.userName = textField.text!
    }
    
    
}

//MARK: - Picker picture
extension HomeVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //Getting Selected Image
        let image = info[UIImagePickerController.InfoKey.editedImage]
            as? UIImage
        guard let userPic = image else {
            return
        }
        
        //SavingPicture in Device if wanted
        //PhotoViewModel.saveUserPic(selfie: userPic)
        
        //Updating Selfie Image
        imageSelfie = userPic
        
        //Updating tableView
        self.tableView.reloadData()
        
        dismiss(animated: true, completion: nil)
    }
    
    func takePhotoWithCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
      }
    func choosePhotoFromLibrary() {
      let imagePicker = UIImagePickerController()
      imagePicker.sourceType = .photoLibrary
      imagePicker.delegate = self
      imagePicker.allowsEditing = true
      present(imagePicker, animated: true, completion: nil)
    }
}

//MARK: - Dismiss keyboard

extension HomeVC {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(HomeVC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//MARK: - Compare Images

extension UIImage {

    func isEqualToImage(_ image: UIImage) -> Bool {
        return self.pngData() == image.pngData()
    }

}
