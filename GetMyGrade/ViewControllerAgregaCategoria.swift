//
//  ViewControllerAgregaCategoria.swift
//  GetMyGrade
//
//  Created by user158022 on 10/10/19.
//  Copyright © 2019 ArturoMendez. All rights reserved.
//

import UIKit
protocol protocoloAgregaCategoria{
    func agregaCategoria(cat:Categoria)->Void
    func guardaCategorias()->Void
}
class ViewControllerAgregaCategoria: UIViewController {
    // MARK: - Variables y Outlets
    var delegado: protocoloAgregaCategoria!
    var idMateria : Int!
    var scrollOffset : CGFloat = 0
    var distance : CGFloat = 0
    var listaCategorias = [Categoria]()
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfPorcentaje: UITextField!
    @IBAction func quitaTeclado() {
        view.endEditing(true)
    }
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let data = try Data.init(contentsOf: dataFileUrl())
            listaCategorias = try PropertyListDecoder().decode([Categoria].self, from: data)
        }
        catch {
            print("Error reading or decoding file")
        }
    }
    // MARK: - DataFileUrl
    func dataFileUrl() -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = url.appendingPathComponent("Categorias.plist")
        return pathArchivo
    }
// MARK: -Acumulado de Porcentaje
    func calcularPorc() -> Int {
        var acum = 0
        var i = 0
        while(listaCategorias.count>i)
        {
            if(listaCategorias[i].idMateria == idMateria)
            {
                acum+=listaCategorias[i].ponderacion
            }
            i = i + 1
        }
        return acum
    }
// MARK: - Guardar datos escritos
    @IBAction func guardar(_ sender: UIButton) {
        let nom = tfNombre.text
        let porc = Int(tfPorcentaje.text!)
        let porcAcum = calcularPorc() + porc!
        if(porcAcum>100)
        {
            let alertController = UIAlertController(title: "Alerta", message: "Se esta agregando una calificacion arriba de 100", preferredStyle: .alert)
            let cancelar = UIAlertAction(title: "Modificar", style: .default) { (action) in
                        
            }
                let aceptar = UIAlertAction(title: "Aceptar", style: .default){
                    (action) in
                        let number = Int.random(in: 0 ... 10000)
                    let unaCat = Categoria(nombre:nom!, ponderacion: porc!, id: number, idMateria: self.idMateria, calificacion: 0)
                    self.delegado.agregaCategoria(cat: unaCat)
                    self.delegado.guardaCategorias()
                    self.navigationController?.popViewController(animated: true)
                }
            alertController.addAction(aceptar)
            alertController.addAction(cancelar)
            present(alertController,animated: true,completion: nil)
        }
        if nom != "", porc != nil , porcAcum<=100
        {
            let number = Int.random(in: 0 ... 10000)
            let unaCat = Categoria(nombre:nom!, ponderacion: porc!, id: number, idMateria: idMateria, calificacion: 0)
            delegado.agregaCategoria(cat: unaCat)
            delegado.guardaCategorias()
            navigationController?.popViewController(animated: true)
        }
    }
   // MARK: -Esconder Teclado
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
        @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {

            var safeArea = self.view.frame
            safeArea.size.height += scrollView.contentOffset.y
            safeArea.size.height -= keyboardSize.height + (UIScreen.main.bounds.height*0.04) // Adjust buffer to your liking

            // determine which UIView was selected and if it is covered by keyboard

            let activeField: UIView? = [tfNombre,tfPorcentaje].first { $0.isFirstResponder }
            if let activeField = activeField {
                if safeArea.contains(CGPoint(x: 0, y: activeField.frame.maxY)) {
                    print("No need to Scroll")
                    return
                } else {
                    distance = activeField.frame.maxY - safeArea.size.height
                    scrollOffset = scrollView.contentOffset.y
                    self.scrollView.setContentOffset(CGPoint(x: 0, y: scrollOffset + distance), animated: true)
                }
            }
            // prevent scrolling while typing

            scrollView.isScrollEnabled = false
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
            if distance == 0 {
                return
            }
            // return to origin scrollOffset
            self.scrollView.setContentOffset(CGPoint(x: 0, y: scrollOffset), animated: true)
            scrollOffset = 0
            distance = 0
            scrollView.isScrollEnabled = true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - Restringir rotacion
      override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
      return UIInterfaceOrientationMask.landscape
      }
      override var shouldAutorotate: Bool {
      return false
      }
}
