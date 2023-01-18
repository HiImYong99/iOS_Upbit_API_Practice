import UIKit

class TradeController: UIViewController {
    
    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var coinPrice: UILabel!
    @IBOutlet weak var coinList: UIPickerView!
    @IBOutlet weak var avgPrice: UILabel!
    @IBOutlet weak var valuePrice: UILabel!
    @IBOutlet weak var buyName: UILabel!
    
    var coin: String?
    let coinArr = ["KRW-BTC", "KRW-ETH","KRW-XRP","KRW-ETC","KRW-SOL"]
    var coinManager = CoinManager()
    var avgValue: String?
    var buyValue: String?
    var value = 0
    var buyKrw = 0
    var buyCoinName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        coinManager.delegate = self
        coinList.delegate = self
        coinList.dataSource = self
        
        coinName.text = "코인을 선택하세요"
        coinPrice.text = DecimalWon(value: 0)
    }
    
    @IBAction func coinBuy(_ sender: UIButton) {
        buyValue = avgValue
        buyKrw = value
        avgPrice.text = "매수평균가: \(buyValue ?? "0원")"
        buyName.text = "구매한 코인 \(buyCoinName)"
    }
    
    @IBAction func coinSell(_ sender: UIButton) {
        if buyKrw == 0 {
            valuePrice.text = "실현손익: 0원"
        } else {
            valuePrice.text = "실현손익: \(DecimalWon(value: value - buyKrw))"
        }
        buyKrw = 0
        avgPrice.text = "매수평균가: 0원"
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) { self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    
}
//MARK: - UIPickerViewDataSource
extension TradeController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinArr.count
    }
}


//MARK: - UIPickerViewDelegate
extension TradeController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinArr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinName.text = coinArr[row]
        coinManager.fetchCoin(coinName: coinArr[row])
    }
    
}


//MARK: - CoinManagerDelegate
extension TradeController: CoinManagerDelegate{
    
    func didupdate(data: CoinData) {
        DispatchQueue.main.async {
            self.coinName.text = data.market
            let krwPrice = DecimalWon(value: data.trade_price)
            self.avgValue = krwPrice
            self.value = data.trade_price
            self.buyCoinName = data.market
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
