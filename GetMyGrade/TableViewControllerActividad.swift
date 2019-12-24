//
//  TableViewControllerActividad.swift
//  GetMyGrade
//
//  Created by user158022 on 10/10/19.
//  Copyright © 2019 ArturoMendez. All rights reserved.
//

import UIKit


class TableViewControllerActividad: UITableViewController, protocoloAgregaActividad {
     // MARK: - Variables
    var idCategoria: Int!
    var nomMateria: String!
    var nomCategoria: String!
    var listaActividades = [Actividad]()
    var listaActividadesMostrar = [Actividad]()
     // MARK: - Guardar archivos
    func guardaActividades() {
        
        do {
           let data = try PropertyListEncoder().encode(listaActividades)
           try data.write(to: dataFileUrl3())
        }
        catch {
           print("Save Failed")
        }
    }
    func agregaActividad(act: Actividad) {
        listaActividades.append(act)
        listaActividadesMostrar.append(act)
        tableView.reloadData()

    }
     // MARK: - DataFileUrl
    func dataFileUrl3() -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = url.appendingPathComponent("Actividades.plist")
        return pathArchivo
    }
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.title = nomMateria + " - " + nomCategoria
        
        do {
            let data = try Data.init(contentsOf: dataFileUrl3())
            listaActividades = try PropertyListDecoder().decode([Actividad].self, from: data)
        }
        catch {
            print("Error reading or decoding file")
        }
        actualizarActividades()
    }
    // MARK: - Editar calificacion
    @IBAction func editar(_ sender: UIButton) {
        setEditing(false, animated: true)
        let alert = UIAlertController(title: "Editar Calificación", message: nil, preferredStyle: UIAlertController.Style.alert)
        
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Escribe nueva calificación"})
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.default, handler: {(ACTION) in alert.dismiss(animated: true, completion: nil)}))
        
        let submitAction = UIAlertAction(title: "Aceptar", style: .default) { [unowned alert] _ in
            let pond_Nueva = Int(alert.textFields![0].text!)
        
        var x = 0
            while x < self.listaActividades.count{
                
                if self.listaActividades[x].id == sender.tag {
                   print("entro")
                    self.listaActividades[x].calificacion = pond_Nueva!
                }
            
                x += 1
            }
            self.guardaActividades()
            self.tableView.reloadData()
        }
            
        alert.addAction(submitAction)
        self.present(alert, animated: true, completion: nil)
            
    }

    // MARK: - Agregar a arreglo temporal
    func actualizarActividades () -> Void
       {
           var i = 0
        while (listaActividades.count > i)
           {
               if(listaActividades[i].idCategoria == idCategoria)
               {
                let act = listaActividades[i]
                listaActividadesMostrar.append(act)
               }
           i+=1
           }
           
       }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listaActividadesMostrar.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCellActividad
        cell.lbNombre.text=listaActividadesMostrar[indexPath.row].nombre
        cell.lbCalif.text = String(listaActividadesMostrar[indexPath.row].calificacion)
        
        cell.btEditar.tag = listaActividadesMostrar[indexPath.row].id

        
        return cell
        
    }
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    // MARK: - Borrar
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            borrarActividades(idCat: listaActividadesMostrar[indexPath.row].id)
            listaActividadesMostrar.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
           
          
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        
        guardaActividades()
    }
    func borrarActividades(idCat:Int)
    {
        var i=0
        while(i<listaActividades.count)
        {
            if(idCat==listaActividades[i].id)
            {
               listaActividades.remove(at: i)
            }
            i+=1
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="segue_agrega_actividad")
        {
            let viewAgregar = segue.destination as! ViewControllerAgregaActividad
            viewAgregar.delegado = self
            viewAgregar.idCategoria = idCategoria
            setEditing(false, animated: true)
        }
    }
    // MARK: - Restringir rotacion
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask.landscape
    }
    override var shouldAutorotate: Bool {
    return false
    }

}
