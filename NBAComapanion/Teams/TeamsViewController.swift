//
//  ViewController.swift
//  NBAComapanion
//

import UIKit

class TeamsViewController: UIViewController, EasyRequestDelegate, UITableViewDelegate, UITableViewDataSource {
  
  //----------------------------------------------------------------------------------------------------
  //  PRIVATE PROPERTIES
  //----------------------------------------------------------------------------------------------------
  
  private var teams = [[TeamModel]]()
  
  @IBOutlet private var teamsTableView: UITableView!
  
  //----------------------------------------------------------------------------------------------------
  //  LIFETIME
  //----------------------------------------------------------------------------------------------------
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // register cells
    teamsTableView.register(UINib(nibName: "TeamDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "TeamDetailTableViewCell" )
    
    makeRequest()
  }
  
  //----------------------------------------------------------------------------------------------------
  //  OTHERS
  //----------------------------------------------------------------------------------------------------
  
  func prime() {
    
  }
  
  //----------------------------------------------------------------------------------------------------
  //  UITableviewDataSource
  //----------------------------------------------------------------------------------------------------
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return teams.count
  }
  
  //----------------------------------------------------------------------------------------------------
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return teams[section].first?.conference
  }
  
  //----------------------------------------------------------------------------------------------------
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return teams[section].count
  }
  
  //----------------------------------------------------------------------------------------------------
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = teamsTableView.dequeueReusableCell(withIdentifier: "TeamDetailTableViewCell", for: indexPath) as? TeamDetailTableViewCell {
      cell.prime(with: teams[indexPath.section][indexPath.row])
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
    if let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "playersVc") as? PlayersViewController {
      vc.selectedTeam = teams[indexPath.section][indexPath.row]
      show( vc, sender: nil )
    }
  }
  
  //----------------------------------------------------------------------------------------------------
  //  JSONRequest
  //----------------------------------------------------------------------------------------------------
  
  private func makeRequest() {
    EasyRequest<[TeamModel]>.get(self, path: "data", url: CompanionConstants.NBA_TEAMS) { (posts) in
      self.teams = Array(Dictionary(grouping:posts){$0.conference}.values)
      DispatchQueue.main.async() {
        self.teamsTableView.reloadData()
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

