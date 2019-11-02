//
//  TableViewControllerCategoria.swift
//  GetMyGrade
//
//  Created by user158022 on 10/10/19.
//  Copyright © 2019 ArturoMendez. All rights reserved.
//

import UIKit

class TableViewControllerCategoria: UITableViewController, protocoloAgregaCategoria {
    func guardaCategorias() {
        do {
           let data = try PropertyListEncoder().encode(listaCategorias)
           try data.write(to: dataFileUrl())
        }
        catch {
           print("Save Failed")
        }
    }
    
    func agregaCategoria(cat: Categoria) {
        listaCategorias.append(cat)
        listaCategoriasMostrar.append(cat)
        tableView.reloadData()
    }
    var idMateria: Int!
    var nomMateria: String!
    var listaCategorias = [Categoria]()
    var listaCategoriasMostrar = [Categoria]()
    
    func dataFileUrl() -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = url.appendingPathComponent("Categorias.plist")
        return pathArchivo
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.title = nomMateria + " - Categorías"
        
        do {
            let data = try Data.init(contentsOf: dataFileUrl())
            listaCategorias = try PropertyListDecoder().decode([Categoria].self, from: data)
        }
        catch {
            print("Error reading or decoding file")
        }
         actualizarCategorias()
        
    }
    func actualizarCategorias () -> Void
    {
        var i = 0
        while (listaCategorias.count > i)
        {
            if(listaCategorias[i].idMateria == idMateria)
            {
              let cat = listaCategorias[i]
                listaCategoriasMostrar.append(cat)
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
        // #warning Incomplete implementation, return the number of row
        
        return listaCategoriasMostrar.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text=listaCategoriasMostrar[indexPath.row].nombre
        cell.detailTextLabel?.text = String(listaCategoriasMostrar[indexPath.row].ponderacion)
        return cell
    }
    
   
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            listaCategoriasMostrar.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        
        guardaCategorias()
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        let temp = listaCategorias[fromIndexPath.row]
        listaCategorias[fromIndexPath.row] = listaCategorias[to.row]
        listaCategorias[to.row] = temp
        
        guardaCategorias()
        

    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="segue_agrega_categoria")
        {
            let viewAgregar = segue.destination as! ViewControllerAgregaCategoria
            viewAgregar.delegado = self
            viewAgregar.idMateria = idMateria
        }
        else
        {
            let vistaActividad = segue.destination as! TableViewControllerActividad
            let indexPath = tableView.indexPathForSelectedRow!
            vistaActividad.idCategoria = listaCategoriasMostrar[indexPath.row].id
            vistaActividad.nomMateria = nomMateria
            vistaActividad.nomCategoria = listaCategorias[indexPath.row].nombre
        }
    }
   
    

}
