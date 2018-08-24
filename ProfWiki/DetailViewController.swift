//
//  DetailViewController.swift
//  ProfWiki
//
//  Created by Youssef Elabd on 8/23/18.
//  Copyright © 2018 Youssef Elabd. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var officeLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var rateMyProfessorLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var educationTextView: UITextView!
    
    var id: Int?
    var teacher: Teacher?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Professor"
        
        let url = URL(string: "http://data.cs.purdue.edu:4567/professors/\(id!)")
        
        profileImageView.layer.cornerRadius = 10
        let dataTask = URLSession.shared.dataTask(with: url!) { (data,response,error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                
                let teacher = try? decoder.decode(TeacherDetail.self, from: data)
                
                if let teacher = teacher {
                    print("decoded teacher")
                    DispatchQueue.main.async {
                        self.nameLabel.text = "\(teacher.firstname) \(teacher.lastname)"
                        
                        self.emailLabel.text = teacher.email
                        self.phoneLabel.text = teacher.phone
                        self.officeLabel.text = teacher.office
                        
                        if let rateMyProfessorScore = teacher.ratemyprofessorscore {
                            self.rateMyProfessorLabel.text = String(describing: rateMyProfessorScore)
                        } else {
                            self.rateMyProfessorLabel.text = "N/A"
                        }
                        
                        if let difficulty = teacher.difficulty {
                            self.difficultyLabel.text = String(describing: difficulty)
                        } else {
                            self.difficultyLabel.text = "N/A"
                        }
                        
                        self.educationTextView.text = teacher.education
                        
                        let profileURL = URL(string: teacher.imageurl)
                        
                        URLSession.shared.dataTask(with: profileURL!) { (data, response, error) in
                            if let data = data {
                                let image = UIImage(data: data)
                                DispatchQueue.main.async {
                                    self.profileImageView.image = image
                                }
                            }
                            }.resume()
                    }
                } else {
                    print("coundn't decode teacher")
                }
            }
        }
        
        dataTask.resume()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
