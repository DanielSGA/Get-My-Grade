//
//  TableViewControllerMateria.swift
//  GetMyGrade
//
//  Created by user158022 on 10/10/19.
//  Copyright © 2019 ArturoMendez. All rights reserved.
//

import UIKit

class TableViewControllerMateria: UITableViewController, protocoloAgregaMateria {
    func guardaMaterias() {
        do {
           let data = try PropertyListEncoder().encode(listaMaterias)
           try data.write(to: dataFileUrl())
        }
        catch {
           print("Save Failed")
        }
    }
    
    func agregaMateria(mat: Materia) {
        listaMaterias.append(mat)
        tableView.reloadData()
    }
    
    var listaMaterias = [Materia]()
    
    func dataFileUrl() -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = url.appendingPathComponent("Materias.plist")
        return pathArchivo
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.title = "Materias"
        
        do {
            let data = try Data.init(contentsOf: dataFileUrl())
            listaMaterias = try PropertyListDecoder().decode([Materia].self, from: data)
        }
        catch {
            print("Error reading or decoding file")
        }
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listaMaterias.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text=listaMaterias[indexPath.row].nombre
        cell.detailTextLabel?.text=" "

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
            listaMaterias.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        
        guardaMaterias()
        
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        let temp = listaMaterias[fromIndexPath.row]
        listaMaterias[fromIndexPath.row] = listaMaterias[to.row]
        listaMaterias[to.row] = temp
        
        guardaMaterias()

    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="segue_agrega_materia")
        {
            let viewAgregar = segue.destination as! ViewControllerAgregaMateria
            viewAgregar.delegado = self
        }
        else
        {
            let vistaCategoria = segue.destination as! TableViewControllerCategoria
            let indexPath = tableView.indexPathForSelectedRow!
            vistaCategoria.idMateria = listaMaterias[indexPath.row].id
            vistaCategoria.nomMateria = listaMaterias[indexPath.row].nombre
           
        }
    }
   
}
