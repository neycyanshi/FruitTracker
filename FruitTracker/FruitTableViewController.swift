//
//  FruitTableViewController.swift
//  FruitTracker
//
//  Created by gkw on 2019/1/6.
//  Copyright © 2019 BodyFusion Inc. All rights reserved.
//

import UIKit

class FruitTableViewController: UITableViewController {
  // MARK: Properties

  var fruits = [Fruit]()

  override func viewDidLoad() {
    super.viewDidLoad()

    // Load the sample data.
    loadSampleFruits()

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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

  // MARK: Actions

  @IBAction func unwindToFruitList(sender: UIStoryboardSegue) {
    if let sourceViewController = sender.source as? FruitViewController, let fruit = sourceViewController.fruit {
      // Add a fruit
      let newIndexPath = IndexPath(row: fruits.count, section: 0)
      fruits.append(fruit)
      tableView.insertRows(at: [newIndexPath], with: .automatic)
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
}
