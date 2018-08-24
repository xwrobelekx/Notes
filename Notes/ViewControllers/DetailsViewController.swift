//
//  DetailsViewController.swift
//  Notes
//
//  Created by Kamil Wrobel on 8/24/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var textView: UITextView!
    
    //MARK: - Propeties
    var noteEntry : NoteModel?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateViews()
    }
    
    func UpdateViews() {
        guard let existingNoteEntry = noteEntry else {return}
        textView.text = existingNoteEntry.note
    }

    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard textView.text != nil else {return} // exits save when there is no text
        guard let newNote = textView.text, textView.text != "" else {return} // unwrap the values from the textView, and make sure its not empty
        //check if noteEntry has value, if it does, then we want to edit, if it doesnt then we want to create new one.
        if let existingNote = noteEntry {
            //edit existing note
            NotesModelController.shared.update(newNote: existingNote, newText: newNote)
        } else {
            //create new note
            NotesModelController.shared.create(note: newNote)
        }
        // save to Persistance
        NotesModelController.shared.saveToPersistance()
        
        //pop the view back
        navigationController?.popViewController(animated: true)
        
    }
    


}
