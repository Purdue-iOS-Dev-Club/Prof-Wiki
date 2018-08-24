//
//  ViewController.swift
//  ProfWiki
//
//  Created by Youssef Elabd on 8/23/18.
//  Copyright © 2018 Youssef Elabd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var teachers = [Teacher]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let url = URL(string: "http://data.cs.purdue.edu:4567/professors")
        
        URLSession.shared.dataTask(with: url!) { (data,response,error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                
                let teachers = try? decoder.decode([Teacher].self, from: data)
                
                if let teachers = teachers {
                    self.teachers = teachers
                    print("decoded teacher")
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    print("coundn't decode teacher")
                }
            }
        }.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teachers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeacherCell", for: indexPath) as! TeacherCell
        
        let teacher = self.teachers[indexPath.row]
        
        cell.firstNameLabel.text = teacher.firstname
        cell.lastNameLabel.text = teacher.lastname
        cell.profileImageView.layer.cornerRadius = 10
        
        let url = URL(string: teacher.imageurl)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    cell.profileImageView.image = image
                }
            }
        }.resume()
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DetailViewController
        let indexPath = tableView.indexPath(for: sender as! TeacherCell)
        let teacher = self.teachers[indexPath!.row]
        destination.id = teacher.id
    }
    

}

