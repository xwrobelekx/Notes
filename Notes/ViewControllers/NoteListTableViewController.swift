//
//  NoteListTableViewController.swift
//  Notes
//
//  Created by Kamil Wrobel on 8/24/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit

class NoteListTableViewController: UITableViewController {
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return NotesModelController.shared.notesListArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath)
        let note = NotesModelController.shared.notesListArray[indexPath.row]
        cell.textLabel?.text = note.note
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let noteItem = NotesModelController.shared.notesListArray[indexPath.row]
            NotesModelController.shared.delete(note: noteItem)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //MARK: - Black Diamond move row
    //move row
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // source indexPath
        //grab a note from the cell we want to move
        let note = NotesModelController.shared.notesListArray[sourceIndexPath.row]
        //remove old note from array
        NotesModelController.shared.delete(note: note)
        // insert that note at new location in array
        NotesModelController.shared.notesListArray.insert(note, at: destinationIndexPath.row)
        //destinationIndexPath cannot be higher than items count in array - 1
        tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "etitExistingEntrySegue" {
            let destinationcVC = segue.destination as? DetailsViewController
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let existingNote = NotesModelController.shared.notesListArray[indexPath.row]
            destinationcVC?.noteEntry = existingNote
            destinationcVC?.view.backgroundColor = UIColor(red: 113.0/255.0, green: 236.0/255.0, blue: 216.0/255.0, alpha: 1.0)
            destinationcVC?.navigationItem.title = "Editing mode"
        }
        if segue.identifier == "createNewNoteSegue" {
            let destinationVC = segue.destination as? DetailsViewController
            destinationVC?.navigationItem.title = "Compose new note"
        }
    }
    
    //MARK: - Actions
    @IBAction func editButtonTapped(_ sender: Any) {
        if tableView.isEditing != true {
            tableView.isEditing = true
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: "editButtonTapped:")
        } else {
            tableView.isEditing = false
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .done, target: self, action: "editButtonTapped:")
            
        }
    }
}
