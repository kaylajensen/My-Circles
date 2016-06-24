//
//  InvitationTableViewCell.swift
//  CircularCollectionView
//
//  Created by Kayla Kerney on 12/11/15.
//  Copyright © 2015 Rounak Jain. All rights reserved.
//

import UIKit

class InvitationTableViewCell: UITableViewCell {

  
  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var rejectButton: UIButton!
  @IBOutlet weak var acceptButton: UIButton!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var membersLabel: UILabel!
  @IBOutlet weak var createdByLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

}
