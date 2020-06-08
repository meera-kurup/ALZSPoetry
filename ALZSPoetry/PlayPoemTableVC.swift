//
//  PlayPoemTableVC.swift
//  
//
//  Created by Meera Kurup on 3/17/18.
//

import UIKit
import AWSCore
import AWSDynamoDB
import AWSS3
import AWSAuthCore



class PlayPoemTableVC: UITableViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    var recordings = [Recording]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        customizeNavBar()
        
        //loadRecordings()
        loadRecordings_of_current_user()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordings.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PoemTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PoemTableViewCell  else {
            fatalError("The dequeued cell is not an instance of PoemTableViewCell.")
        }
        
        
        let poemRecording = recordings[indexPath.row]
        cell.recordTitle.text=poemRecording._poemTitle
        //cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
        return cell
        
     }
 
    
    private func loadRecordings() {
        self.recordings.removeAll()
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
        let queryExpression = AWSDynamoDBScanExpression()
        queryExpression.limit = 100
        dynamoDbObjectMapper.scan(Recording.self, expression: queryExpression).continueWith(executor: AWSExecutor.mainThread(), block: { (task:AWSTask!) -> AnyObject! in
            if let output = task.result {
                for poem in output.items {
                    let recodingsItem = poem as? Recording
                    //print("\(recodingsItem!._poemTitle!)")
                    self.recordings.append(recodingsItem!)
                }
            }
            self.tableView.reloadData()
            if let error = task.error as NSError? {
                print("Error: \(error)")
            }
            return nil
        })
    }
    
    private func loadRecordings_of_current_user() {
        self.recordings.removeAll()
        
        // Get uer id to get only the Poems recorded by the current User
        let queryExpression = AWSDynamoDBQueryExpression()
        queryExpression.limit = 100
        queryExpression.keyConditionExpression = "#userId = :userId"
        queryExpression.expressionAttributeNames = [
            "#userId": "userId",
        ]
        queryExpression.expressionAttributeValues = [
            ":userId": AWSIdentityManager.default().identityId!
        ]
        
        // 2) Make the query
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
        dynamoDbObjectMapper.query(Recording.self, expression: queryExpression).continueWith(executor: AWSExecutor.mainThread(), block: { (task:AWSTask!) -> AnyObject! in
            if let output = task.result {
                for poem in output.items {
                    let recodingsItem = poem as? Recording
                    //print("\(recodingsItem!._poemTitle!)")
                    self.recordings.append(recodingsItem!)
                }
            }
            self.tableView.reloadData()
            if let error = task.error as NSError? {
                print("Error: \(error)")
            }
            return nil
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        print(segue.identifier ?? "")
        if(segue.identifier == "playselectedPoem") {
            guard let playViewController = segue.destination as? PlayViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            let buttonPosition = (sender as AnyObject).convert(CGPoint.zero, to: self.tableView)
            let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
            let selectedRecording = recordings[(indexPath?.row)!]
            playViewController.recording = selectedRecording
        }
    }
    
    func sideMenus() {
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth=200
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    
    func customizeNavBar(){
        navigationController?.navigationBar.tintColor = UIColor(displayP3Red: 255/255 , green: 255/255, blue: 255/255, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 255/255, green: 87/255, blue: 35/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes=[kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.white]
    }
    
}
