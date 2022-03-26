//
//  ViewController.swift
//  ToDo
//
//  Created by Pudilic Seby on 15.03.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DisplayViewControllerDelegate, EditViewControllerDelegate {
    
    var care: Int = 0
    
    var items = [Task]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var taskTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)) //printam locul unde se afla baza de date pentru stocare locala
        
        overrideUserInterfaceStyle = .light
        
        taskTableView.dataSource = self
        taskTableView.delegate = self
        
        taskTableView.separatorStyle = .none
        taskTableView.showsVerticalScrollIndicator = false
        
        loadItems()
    }
    
    //MARK: - TableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = taskTableView.dequeueReusableCell(withIdentifier: "taskCell") as! TaskCellVC
        
        cell.taskTitle.text = items[indexPath.row].title
        switch (items[indexPath.row].done) {
        case true: cell.doneButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        default: cell.doneButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
        
        switch (items[indexPath.row].color) {
        case 1: cell.colorView.backgroundColor = UIColor(named: "color_first")
        case 2: cell.colorView.backgroundColor = UIColor(named: "color_second")
        case 3: cell.colorView.backgroundColor = UIColor(named: "color_third")
        case 4: cell.colorView.backgroundColor = UIColor(named: "color_fourth")
        default:
            cell.colorView.backgroundColor = UIColor(named: "color_first")
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    //MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        care = indexPath.row
        switchState = items[indexPath.row].done
        selected_colour = Int(items[indexPath.row].color)
        self.performSegue(withIdentifier: "editIdentifier", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        context.delete(items[indexPath.row])
        items.remove(at: indexPath.row)
        saveItems()
        tableView.reloadData()
    }
    
    
    
    
    
    //MARK: - Model Manupulation Methods
    
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving category \(error)")
        }
        
        taskTableView.reloadData()
        
    }
    
    func loadItems() {
        
        let request : NSFetchRequest<Task> = Task.fetchRequest()
        
        do{
            items = try context.fetch(request)
        } catch {
            print("Error loading categories \(error)")
        }
        
        taskTableView.reloadData()
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "sequeIdentifier", sender: self)
    }
    
    //MARK: - aici lucram la segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "sequeIdentifier") {
            let displayVC = segue.destination as! TaskViewController
            displayVC.delegate = self
        }
        
        if(segue.identifier == "editIdentifier") {
            let displayVC = segue.destination as! EditTaskViewController
            displayVC.delegate = self
            titluEdit = items[care].title!
            
        }
    }
    
    //MARK: - metode delegate pentru data care vine inapoi din celelate VC
    
    func dataBack(textForTitle: String, colorTag: Int) {
        if (textForTitle != "") {
            let newTask = Task(context: context)
            newTask.title = textForTitle
            newTask.done = false
            newTask.color = Int32(colorTag)
            items.append(newTask)
            saveItems()
            taskTableView.reloadData()
        }
    }
    
    func dataEditBack(textForTitle: String, colorTag: Int, switchDone: Bool) {
        items[care].setValue(textForTitle, forKey: "title")
        items[care].setValue(colorTag, forKey: "color")
        items[care].setValue(switchDone, forKey: "done")
        saveItems()
        taskTableView.reloadData()
    }
    
}

