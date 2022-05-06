
import UIKit

class WeatherViewController: UIViewController, WeatherViewProtocol {
    
    @IBOutlet weak var day3Name: UILabel!
    @IBOutlet weak var day3Temp: UILabel!
    @IBOutlet weak var day3Image: UIImageView!
    
    @IBOutlet weak var tomorrowName: UILabel!
    @IBOutlet weak var tomorrowTemp: UILabel!
    @IBOutlet weak var tomorrowImage: UIImageView!
    
    @IBOutlet weak var todayName: UILabel!
    @IBOutlet weak var todayTemp: UILabel!
    @IBOutlet weak var todayImage: UIImageView!
    
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    @IBOutlet weak var searchViewHeight: NSLayoutConstraint!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: UIView! //104 // 350
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    
    var presenter: WeatherPresenterProtocol!
    var searchButtonClicked = false
    var activityIndicator = CActivityIndicator()
    
    @IBOutlet weak var usersTableView: UITableView!
    
    @IBAction func backAction(_ sender: UIButton) {
        closeSearchView()
    }
    @IBAction func closeAction(_ sender: UIButton) {
        closeSearchView()
    }
    @IBAction func searchAction(_ sender: UIButton) {
        openSearchView()
    }
    func closeSearchView(){
        searchButtonClicked = false
        UIView.animate(withDuration: 0.5) {[weak self] in
            guard let self = self else {return}
            self.searchView.isHidden = true
            self.searchView.alpha = 0
            self.searchViewHeight.constant = 0
            self.closeButton.isHidden = true
            self.view.layoutIfNeeded()
        } completion: { _ in}
    }
    func openSearchView(){
        searchButtonClicked = true
        UIView.animate(withDuration: 0.2) {[weak self] in
            guard let self = self else {return}
            self.searchView.isHidden = false
            self.searchViewHeight.constant = 134
            self.searchView.alpha = 1
            self.view.layoutIfNeeded()
        } completion: { _ in}
    }
    func NavigationBarClear() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    
    func HidesNavigationBar(NavigationBar: Bool,BackButton: Bool) {
        self.navigationController?.isNavigationBarHidden = NavigationBar
        self.navigationItem.hidesBackButton = BackButton
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        searchSettings()
        timeLabel.text = getTime()
        dateLabel.text = getDate()
        HidesNavigationBar(NavigationBar: true, BackButton: true)
        presenter.getWeather(q:"egypt")

    }
  
    func searchSettings(){
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.font = UIFont(name: "SegoeUI-Semibold", size: 13)
            searchBar.searchTextField.backgroundColor = .white
            searchBar.layer.borderWidth = 1
            searchBar.layer.borderColor = UIColor.gray.cgColor
            searchBar.layer.cornerRadius = 15
        }
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            
            textField.backgroundColor = UIColor.white
            textField.leftViewMode = .never
            
            let backgroundView = textField.subviews.first
            backgroundView?.backgroundColor = UIColor.white
            backgroundView?.layer.cornerRadius = 10
            backgroundView?.layer.masksToBounds = true
            backgroundView?.layer.borderWidth = 1
            backgroundView?.layer.borderColor = UIColor.gray.cgColor
        }
        searchBar.setSearchFieldBackgroundImage(UIImage(), for: .normal)
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
    }
    func showLoadingIndicator() {
        self.activityIndicator.start()
    }
    
    func hideLoadingIndicator() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.activityIndicator.stop()
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else {
                return
            }
            self.searchViewHeight.constant = 400
            self.closeButton.isHidden = false
            self.tableView.reloadData()
        }
    }
    
    func showErrorMessage(message: Error) {
        self.showAlert(error: message)
    }
    
    func populateWeatherData(weather:WeatherViewModel){
        closeSearchView()
        timeLabel.text = getTime()//weather.time
        dateLabel.text = getDate()//weather.date
        cityLabel.text = weather.city
        degreeLabel.text = weather.temp_f
        stateLabel.text = weather.state
        windLabel.text = weather.wind_mph
        humidityLabel.text = weather.humidity
        weatherImage.setImageWithUrlString(urlStr: weather.imgURL)
        todayName.text = weather.todayName
        todayTemp.text = weather.todayTempfc
        todayImage.setImageWithUrlString(urlStr: weather.todayImgURL)
        
        tomorrowName.text = weather.tomorrowName
        tomorrowTemp.text = weather.tomorrowTempfc
        tomorrowImage.setImageWithUrlString(urlStr: weather.todayImgURL)
        
        day3Name.text = weather.day3Name
        day3Temp.text = weather.day3Tempfc
        day3Image.setImageWithUrlString(urlStr: weather.day3ImgURL)
    }
    
    func getTime()->String{
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        
        let dateString = formatter.string(from: Date())
        print(dateString)
        
        return dateString
    }
    func getDate()->String{
        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "EEEE, d MMM, yyyy"
        let dateString = df.string(from: date)
        print(dateString)
        return dateString
    }
}
extension WeatherViewController:UITableViewDataSource, UITableViewDelegate{
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "CityTableViewCell", bundle: .main), forCellReuseIdentifier: "CityTableViewCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as! CityTableViewCell
        cell.title.text = "\(presenter.getCity( at: indexPath.row).region ?? "" ) - \(presenter.getCity( at: indexPath.row).country ?? "" )"
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.getWeather(q:presenter.getCity( at: indexPath.row).region ?? "")
    }
}
extension WeatherViewController:UISearchBarDelegate{
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        onDismissKeyboard()
    }
    @objc func onDismissKeyboard() {
        view.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        start_searching(searchBartext:searchBar.text ?? "")
    }
    func start_searching(searchBartext:String){
        DispatchQueue.main.async { [self] in
            self.view.endEditing(true)
            
            if searchBartext != ""{
                presenter.makeSearching(key: searchBartext)
            }else{
                self.showAlert(error: "please enter search text")
            }
        }
    }
}
