//
//  FeedViewController.swift
//  insta
//
//  Created by Harrison Groll on 3/19/21.
//

import UIKit
import Parse

import AlamofireImage
class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    var posts = [PFObject]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.rowHeight = 194
        //tableView.rowHeight = UITableView.automaticDimension

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className: "post")
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackground(block: {(posts, error) in
            if posts != nil {
                self.posts = posts!
        
                self.tableView.reloadData()
            } else {
                
            }
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("HERE!aa!")
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        print("HERE!!")
        let post = posts[indexPath.row]
        let user = post["author"] as! PFUser
        cell.usernameLabel.text = user.username
        print("CAPTION = \(cell.captionLabel.text)")
        cell.captionLabel.text = (post["caption"] as! String)
       
        
        let imageFile = post["image"] as! PFFileObject
        let strUrl = imageFile.url!
        let url = URL(string: strUrl)!
        cell.photoView.af_setImage(withURL: url)
        
        return cell
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
