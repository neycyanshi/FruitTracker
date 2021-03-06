//
//  FruitTableViewController.swift
//  FruitTracker
//
//  Created by yanshi on 2019/1/6.
//  Copyright © 2019 BodyFusion Inc. All rights reserved.
//

import os.log
import UIKit

class FruitTableViewController: UITableViewController {
  // MARK: Properties

  var fruits = [Fruit]()

  override func viewDidLoad() {
    super.viewDidLoad()

    // Use the edit button item provided by the table view controller.
    navigationItem.leftBarButtonItem = editButtonItem

    // Load any saved fruits, otherwise load sample data.
    if let loadedFruits = loadFruits() {
      fruits += loadedFruits
    } else {
      loadSampleFruits()
    }

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
  }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fruits.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Table view cells are reused and should be dequeued using a cell identifier.
    let cellIdentifier = "FruitTableViewCell"
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FruitTableViewCell
    else {
      fatalError("The dequeued cell is not an instance of FruitTableViewCell.")
    }

    // Fetches the appropriate fruit for the data source layout.
    let fruit = fruits[indexPath.row]

    // Configure the cell...
    cell.nameLabel.text = fruit.name
    cell.photoImageView.image = fruit.photo
    cell.ratingControl.rating = fruit.rating

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
      fruits.remove(at: indexPath.row)
      saveFruits()
      tableView.deleteRows(at: [indexPath], with: .fade)
    } else if editingStyle == .insert {
      // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
  }

  /*
  // Override to support rearranging the table view.
  override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

  }
  */

  /*
  // Override to support conditional rearranging of the table view.
  override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
      // Return false if you do not want the item to be re-orderable.
      return true
  }
  */

  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)

    switch segue.identifier {
    case "AddItem":
      os_log("Adding a new fruit.", log: OSLog.default, type: .debug)

    case "ShowDetail":
      guard let fruitDetailViewController = segue.destination as? FruitViewController else {
        fatalError("Unexpected destination: \(segue.destination)")
      }

      guard let selectedFruitCell = sender as? FruitTableViewCell else {
        fatalError("Unexpected sender: \(sender as Any)")
      }

      guard let indexPath = tableView.indexPath(for: selectedFruitCell) else {
        fatalError("The selected cell is not being displayed by the table.")
      }

      let selectedFruit = fruits[indexPath.row]
      fruitDetailViewController.fruit = selectedFruit

    default:
      fatalError("Unexpected Segue Identifier: \(segue.identifier!)")
    }
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
  }

  // MARK: Actions

  @IBAction func unwindToFruitList(sender: UIStoryboardSegue) {
    if let sourceViewController = sender.source as? FruitViewController, let fruit = sourceViewController.fruit {
      // Update an existing fruit if tableViewCell is selected
      if let selectedIndexPath = tableView.indexPathForSelectedRow {
        fruits[selectedIndexPath.row] = fruit
        tableView.reloadRows(at: [selectedIndexPath], with: .none)
      } else {
        // Add a new fruit
        let newIndexPath = IndexPath(row: fruits.count, section: 0)
        fruits.append(fruit)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
      }

      // Save the fruits
      saveFruits()
    }
  }

  // MARK: Private Methods

  private func loadSampleFruits() {
    let photo1 = UIImage(named: "fruit1")
    let photo2 = UIImage(named: "fruit2")
    let photo3 = UIImage(named: "fruit3")

    guard let fruit1 = Fruit(name: "Caprese Salad", photo: photo1, rating: 4)
    else {
      fatalError("Unable to instantiate fruit1")
    }

    guard let fruit2 = Fruit(name: "Chicken and Potatoes", photo: photo2, rating: 5)
    else {
      fatalError("Unable to instantiate fruit2")
    }

    guard let fruit3 = Fruit(name: "Pasta with Meatballs", photo: photo3, rating: 3)
    else {
      fatalError("Unable to instantiate fruit3")
    }

    fruits += [fruit1, fruit2, fruit3]
  }

  private func saveFruits() {
    do {
      let data = try NSKeyedArchiver.archivedData(withRootObject: fruits, requiringSecureCoding: false)
      try data.write(to: Fruit.ArchiveURL)
      os_log("Fruits successfully saved.", log: OSLog.default, type: .debug)
    } catch {
      os_log("Failed to save fruits.", log: OSLog.default, type: .error)
    }
  }

  private func loadFruits() -> [Fruit]? {
    do {
      let data = try Data(contentsOf: Fruit.ArchiveURL)
      if let fruits = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Fruit] {
        os_log("Fruits successfully loaded", log: OSLog.default, type: .debug)
        return fruits
      }
    } catch {
      os_log("Failed to load fruits.", log: OSLog.default, type: .error)
    }
    return nil
  }
}
