//
//  FruitTableViewCell.swift
//  FruitTracker
//
//  Created by gkw on 2019/1/6.
//  Copyright © 2019 BodyFusion Inc. All rights reserved.
//

import UIKit

class FruitTableViewCell: UITableViewCell {
  // MARK: Properties

  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var photoImageView: UIImageView!
  @IBOutlet var ratingControl: RatingControl!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
}
