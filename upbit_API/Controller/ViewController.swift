
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var coinPrice: UILabel!
    @IBOutlet weak var coinList: UIPickerView!
    
    var coin: String?
    let coinArr = ["KRW-BTC", "KRW-ETH","KRW-XRP","KRW-ETC"]
    var coinManager = CoinManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManager.delegate = self
        coinList.delegate = self
        coinList.dataSource = self
        
        coinName.text = "코인을 선택하세요"
        coinPrice.text = DecimalWon(value: 0)
    }
}


//MARK: - UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinArr.count
    }
}


//MARK: - UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinArr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinName.text = coinArr[row]
        coinManager.fetchCoin(coinName: coinArr[row])
    }
    
}


//MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate{
    
    func didupdate(data: CoinData) {
        DispatchQueue.main.async {
            self.coinName.text = data.market
            let krwPrice = DecimalWon(value: data.trade_price)
            self.coinPrice.text = "\(krwPrice)"
        }
        
    }
    
    func error(error: Error) {
        print(error)
    }
    
    
    
}

//MARK: - comma formatter func
func DecimalWon(value: Int) -> String{
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    let result = numberFormatter.string(from: NSNumber(value: value))! + "원"
    return result
}
