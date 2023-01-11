protocol CoinManagerDelegate {
    func didupdate(data: CoinData)
    func error(error: Error)
}

import Foundation


struct CoinManager {
    
    let coinURL = "https://api.upbit.com/v1/ticker?markets="
    
    var delegate: CoinManagerDelegate?
    
    func fetchCoin(coinName: String){
        let urlString = "\(coinURL)\(coinName)"
        performRequest(with: urlString)
    }
    
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {data, response, error in
                if error != nil {
                    delegate?.error(error: error!)
                    return
                }
                if let safeData = data {
                    if let coin = self.parseJSON(coinData: safeData) {
                        self.delegate?.didupdate(data: coin)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(coinData: Data) -> CoinData? {
        let decoder1 = JSONDecoder()
        do {
            let decodeData = try decoder1.decode([CoinData].self, from: coinData)
            let market = decodeData[0].market
            let price = decodeData[0].trade_price
            let coin = CoinData(market: market, trade_price: price)
            return coin
            
        } catch {
            delegate?.error(error: error)
            return nil
        }
        
    }
    
}



