//
//  PlayerTableViewCell.swift
//  NBAComapanion
//

import UIKit

class PlayerTableViewCell: UITableViewCell {
  
  //----------------------------------------------------------------------------------------------------
  //  PRIVATE PROPERTIES
  //----------------------------------------------------------------------------------------------------
  
  @IBOutlet weak var titleText: UILabel!
  
  //----------------------------------------------------------------------------------------------------
  //  LIFETIME
  //----------------------------------------------------------------------------------------------------
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  //----------------------------------------------------------------------------------------------------
  
  func prime(with text: String) {
    titleText.text = text
  }
}
