//
//  TeamDetailTableViewCell.swift
//  NBAComapanion
//

import UIKit

class TeamDetailTableViewCell: UITableViewCell {
  
  //----------------------------------------------------------------------------------------------------
  //  PRIVATE PROPERTIES
  //----------------------------------------------------------------------------------------------------
  
  @IBOutlet private var titleText: UILabel!
  @IBOutlet private var divisionText: UILabel!
  @IBOutlet private var cityText: UILabel!
  
  //----------------------------------------------------------------------------------------------------
  //  LIFETIME
  //----------------------------------------------------------------------------------------------------
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  //----------------------------------------------------------------------------------------------------
  
  func prime(with model: TeamModel) {
    titleText.text = model.full_name
    
    //style text
    var mainString = "Division: \(model.division ?? "")"
    var stringToColor = "Division:"
    var range = (mainString as NSString).range(of: stringToColor)

    var mutableAttributedString = NSMutableAttributedString.init(string: mainString)
    mutableAttributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 13, weight: .semibold), range: range)
    
    divisionText.attributedText = mutableAttributedString
    
    mainString = "City: \(model.city ?? "")"
    stringToColor = "City:"
    range = (mainString as NSString).range(of: stringToColor)

    mutableAttributedString = NSMutableAttributedString.init(string: mainString)
    mutableAttributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 13, weight: .semibold), range: range)
        
    cityText.attributedText = mutableAttributedString
  }
}
