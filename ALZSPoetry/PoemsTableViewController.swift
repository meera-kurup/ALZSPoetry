//
//  PoemsTableViewController.swift
//  ALZ Poetry PoC
//
//  Created by Jeesmon Jacob on 2/25/18.
//  Copyright © 2018 Jeesmon Jacob. All rights reserved.
//

import UIKit
import AWSCore
import AWSDynamoDB
import AWSS3


class PoemsTableViewController: UITableViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var poems = [Poem]()
    var recordings = [Recording]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        customizeNavBar()
        loadPoems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poems.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PoemTableViewCell2"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PoemTableViewCell2  else {
            fatalError("The dequeued cell is not an instance of PoemTableViewCell.")
        }

        let poem = poems[indexPath.row]
        cell.title.text = poem._title
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
        return cell
    }


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        print(segue.identifier ?? "")
        
        if(segue.identifier == "Record") {
            guard let recordViewController = segue.destination as? RecordViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            let buttonPosition = (sender as AnyObject).convert(CGPoint.zero, to: self.tableView)
            let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
            
            let selectedPoem = poems[(indexPath?.row)!]
            recordViewController.poem = selectedPoem
        }
        else if(segue.identifier == "Play") {
            guard let playViewController2 = segue.destination as? PlayViewController2 else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            let buttonPosition = (sender as AnyObject).convert(CGPoint.zero, to: self.tableView)
            let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
            
            let selectedPoem = poems[(indexPath?.row)!]
            playViewController2.poem = selectedPoem
            
        }
    }

    private func loadPoems() {
        self.poems.removeAll()
        
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
        let queryExpression = AWSDynamoDBScanExpression()
        queryExpression.limit = 100
        dynamoDbObjectMapper.scan(Poem.self, expression: queryExpression).continueWith(executor: AWSExecutor.mainThread(), block: { (task:AWSTask!) -> AnyObject! in
            if let output = task.result {
                for poem in output.items {
                    let poemItem = poem as? Poem
                    //print("\(poemItem!._title!)")
                    self.poems.append(poemItem!)
                }
                
            }
            
            self.tableView.reloadData()
            if let error = task.error as NSError? {
                print("Error: \(error)")
            }
            
            return nil
        })
    }
 
    /*
    // REMOVE ME: For testing purpose only
    @IBAction func addPoem(_ sender: Any) {
        // Poem
        let poem: Poem = Poem()
        poem._id = UUID().uuidString
        poem._title = "Poem \(poem._id!)"
        poem._fileName = "\(poem._id!).html"
        poem._updatedAt = Date().timeIntervalSince1970 as NSNumber
        
        // Upload html to s3
        var data: Data = Data() // Data to be uploaded
        let dataString = "<html><body><h1>Test</h1></body></html>"
        data = dataString.data(using: String.Encoding.utf8)!
        
        let expression = AWSS3TransferUtilityUploadExpression()
        expression.progressBlock = {(task, progress) in
            DispatchQueue.main.async(execute: {
                // Do something e.g. Update a progress bar.
            })
        }
        
        var completionHandler: AWSS3TransferUtilityUploadCompletionHandlerBlock?
        completionHandler = { (task, error) -> Void in
            DispatchQueue.main.async(execute: {
                // Do something e.g. Alert a user for transfer completion.
                // On failed uploads, `error` contains the error object.
            })
        }
        
        let transferUtility = AWSS3TransferUtility.default()
        
        transferUtility.uploadData(data,
           bucket: S3BucketName,
           key: "public/\(poem._fileName!)",
           contentType: "text/html",
           expression: expression,
           completionHandler: completionHandler).continueWith {
                (task) -> AnyObject! in
                if let error = task.error {
                    print("Error: \(error.localizedDescription)")
                }
            
                if let _ = task.result {
                    // Do something with uploadTask.
                }
                return nil;
            }
        
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
        dynamoDbObjectMapper.save(poem, completionHandler: {
            (error: Error?) -> Void in
            
            if let error = error {
                print("Amazon DynamoDB Save Error: \(error)")
                return
            }
            print("An item was saved.")
            
            self.loadPoems()
        })
    }
   */
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
