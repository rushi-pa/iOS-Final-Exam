//
//  BoredApiFetcher.swift
//  rushipatel_order
//
//  Created by Rushi Patel on 2021-04-20.
//

import Foundation
class WeathersFetcher : ObservableObject{
    
    var apiURL = "https://www.boredapi.com/api/activity"
    
    @Published var weatherList = Weather()
    private static var shared : WeathersFetcher?
    
    static func getInstance() -> WeathersFetcher{
        if shared != nil{
            return shared!
        }else{
            return WeathersFetcher()
        }
        
    }
    func fetchDataFromAPI(){
        
        guard let api = URL(string: apiURL) else{
            return
        }
        URLSession.shared.dataTask(with: api){(data: Data?, response: URLResponse?, error : Error?) in
            
            if let err = error{
                print(#function, "Couldn't fetch data", err)
            }else{
                DispatchQueue.global().async{
                    do{
                        if let jsonData = data{
                            let decoder = JSONDecoder()
                            let decodedList = try decoder.decode(Weather.self, from: jsonData)
                            DispatchQueue.main.async {
                                self.weatherList = decodedList
                            }
                        }else{
                            print(#function, "No data found!!")
                        }
                    }catch  let error{
                        print(#function, error)
                    }
                }
            }
            
        }.resume()
    }
}
