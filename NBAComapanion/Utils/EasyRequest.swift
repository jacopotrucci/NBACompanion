//
//  EasyRequestDelegate.swift
//  NBAComapanion
//

import Foundation

//----------------------------------------------------------------------------------------------------
//  PROTOCOL
//----------------------------------------------------------------------------------------------------

protocol EasyRequestDelegate: class {
  func onError()
}

//----------------------------------------------------------------------------------------------------
// EasyRequest - workflow
//----------------------------------------------------------------------------------------------------

public struct EasyRequest<Model: Codable> {
  
  public typealias SuccessCompletionHandler = (_ response: Model) -> Void
  
  //----------------------------------------------------------------------------------------------------
  
  static func get(_ delegate: EasyRequestDelegate?,
                  path: String, url: String,
                  success successCallback: @escaping SuccessCompletionHandler
  ) {
    
    //if not lets call the delegate to manage the error
    guard let urlComponent = URLComponents(string: url), let usableUrl = urlComponent.url else {
      delegate?.onError()
      return
    }
    
    var request = URLRequest(url: usableUrl)
    request.httpMethod = "GET"
    request.addValue("485e3d6dddmsh744338c35e6ec06p134d17jsn21f58e06467f", forHTTPHeaderField: "x-rapidapi-key")
    request.addValue("free-nba.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
    request.addValue("true", forHTTPHeaderField: "useQueryString")
    
    var dataTask: URLSessionDataTask?
    let defaultSession = URLSession(configuration: .default)
    
    dataTask =
      defaultSession.dataTask(with: request) { data, response, error in
        defer {
          dataTask = nil
        }
        if error != nil {
          delegate?.onError()
        } else if
          let data = data,
          let response = response as? HTTPURLResponse,
          response.statusCode == 200 {
          guard let model = self.parsedModel(with: data, at: path) else {
            delegate?.onError()
            return
          }
          successCallback(model)
        }
      }
    dataTask?.resume()
  }
  
  //----------------------------------------------------------------------------------------------------
  
  static func parsedModel(with data: Data, at path: String) -> Model? {
    do {
      let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
      
      if let dictAtPath = json?.value(forKeyPath: path) {
        let jsonData = try JSONSerialization.data(withJSONObject: dictAtPath,
                                                  options: [])
        let decoder = JSONDecoder()
        
        let model = try decoder.decode(Model.self, from: jsonData)
        return model
      } else {
        return nil
      }
    } catch {
      return nil
    }
  }
}


