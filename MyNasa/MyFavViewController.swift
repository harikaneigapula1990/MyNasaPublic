//
//  MyFavViewController.swift
//  MyNasa
//
//  Created by Dushyanth Potnuru on 31/07/22.
//

import UIKit
import CoreData

class MyFavViewController: UIViewController {
    var myFavList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        retriveData()

        // Do any additional setup after loading the view.
    }
    
    func retriveData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavPictureEntity")
        
        do {
            let fetch = try managedObjectContext.fetch(fetchRequest)
            for data in fetch as! [NSManagedObject] {
                myFavList.append(data.value(forKey: "picture") as! String)
            }
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                print(error.userInfo)
            }
        } catch {
            print(error.localizedDescription)
        }
        
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
