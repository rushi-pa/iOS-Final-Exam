import UIKit
import Combine
class ViewController: UIViewController {
    
    @IBOutlet weak var qwerty :UILabel!
    private var taskList : [ToDo] = [ToDo]()
    private let dbHelper = DatabaseHelper.getInstance()
    
    private let weathersFetcher = WeathersFetcher.getInstance()
    private var weatherList : Weather = Weather()
    private var cancellables: Set<AnyCancellable> = []
        private let validation: ValidationService
       
       init(validation: ValidationService) {
           self.validation = validation
           super.init(nibName: nil, bundle: nil)
       }
       
       required init?(coder: NSCoder) {
           self.validation = ValidationService()
           super.init(coder: coder)
       }
    private func receiveChanges(){
        self.weathersFetcher.$weatherList.receive(on: RunLoop.main)
            .sink{ (weather) in
                print(#function, "Received Weather : ", weather)
                self.weatherList = weather
                print("here it goes");
                print(self.weatherList)
                print(weather);
                   
                
                self.qwerty.text = self.weatherList.activity;

            }
            .store(in : &cancellables)
    }
    private func getActivity(){
        
        self.weathersFetcher.fetchDataFromAPI();
        print("baba");
        print(weatherList);        self.receiveChanges();
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getActivity();
    }

    @IBAction func placeorder(){
        do {
            let newTask = order(name : weatherList.activity);
                        self.dbHelper.insertTask(newTodo: newTask)
                    presentAlert(with: "Order Completed")
                
            } catch {
                present(error)
            }
        
    }
    
    private func present(_ dismissableAlert: UIAlertController) {
           let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel)
           dismissableAlert.addAction(dismissAction)
           present(dismissableAlert, animated: true)
       }
       
       func presentAlert(with message: String) {
           let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
           present(alert)
       }
       
       func present(_ error: Error) {
           presentAlert(with: error.localizedDescription)
       }

    
    //Button cancel specs
    @IBAction func cancel(){
        self.getActivity();
    }
    private func fetchAllToDos(){
        if (self.dbHelper.getAllTodos() != nil){
            self.taskList = self.dbHelper.getAllTodos()!
            print(taskList);
        }else{
            print(#function, "No data recieved from dbHelper")
        }
    }
}
