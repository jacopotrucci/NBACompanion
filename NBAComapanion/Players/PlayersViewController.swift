//
//  PlayersViewController.swift
//  NBAComapanion
//

import UIKit

class PlayersViewController: UIViewController, EasyRequestDelegate, UITableViewDelegate, UITableViewDataSource {
  
  //----------------------------------------------------------------------------------------------------
  //  PUBLIC PROPERTIES
  //----------------------------------------------------------------------------------------------------
  
  var selectedTeam: TeamModel?
  
  //----------------------------------------------------------------------------------------------------
  //  PRIVATE PROPERTIES
  //----------------------------------------------------------------------------------------------------
  
  private var players = [PlayerModel]()
  
  @IBOutlet private var playersTableView: UITableView!
  @IBOutlet private var headerText: UILabel!
  
  //----------------------------------------------------------------------------------------------------
  //  LIFETIME
  //----------------------------------------------------------------------------------------------------
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // register cells
    playersTableView.register(UINib(nibName: "PlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerTableViewCell" )
    playersTableView.register(UINib(nibName: "NoPlayerAvailableTableViewCell", bundle: nil), forCellReuseIdentifier: "NoPlayerAvailableTableViewCell" )
    
    makeRequest()
    prime()
  }
  
  //----------------------------------------------------------------------------------------------------
  //  OTHERS
  //----------------------------------------------------------------------------------------------------
  
  func prime() {
    //bail out if model is nil
    guard selectedTeam != nil else { return }
    
    headerText.text = "\(selectedTeam?.abbreviation ?? "--") #roster"
  }
  
  //----------------------------------------------------------------------------------------------------
  //  UITableviewDataSource
  //----------------------------------------------------------------------------------------------------
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return players.count
  }
  
  //----------------------------------------------------------------------------------------------------
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if players.first?.id == -999 {
      return tableView.dequeueReusableCell(withIdentifier: "NoPlayerAvailableTableViewCell", for: indexPath)
    }
    
    if let cell = playersTableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as? PlayerTableViewCell {
      let text = "\(players[indexPath.row].first_name ?? "") \(players[indexPath.row].last_name ?? "")"
      cell.prime(with: text)
      return cell
    }
    
    return UITableViewCell()
  }
  
  //----------------------------------------------------------------------------------------------------
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  //----------------------------------------------------------------------------------------------------
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "playerInfo") as? PlayerInfoViewController {
      vc.selectedPlayer = players[indexPath.row]
      show( vc, sender: nil )
    }
  }
  
  //----------------------------------------------------------------------------------------------------
  //  JSONRequest
  //----------------------------------------------------------------------------------------------------
  
  private func makeRequest() {
    EasyRequest<[PlayerModel]>.get(self, path: "data", url: CompanionConstants.NBA_PLAYERS) { (posts) in
      
      self.players = posts.filter({ $0.team?.id == self.selectedTeam?.id })
      
      if self.players.count <= 0 {
        let noPl = PlayerModel()
        noPl.id = -999
        self.players.append(noPl)
      }
      
      DispatchQueue.main.async() {
        self.playersTableView.reloadData()
      }
    }
  }
  
  //----------------------------------------------------------------------------------------------------
  
  func onError() {
    DispatchQueue.main.async() {
      let alert = UIAlertController(title: "Ups", message: "An error has occurred...", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      self.present(alert, animated: true)
    }
  }
}

