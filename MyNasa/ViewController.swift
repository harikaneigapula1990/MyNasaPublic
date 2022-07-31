//
//  ViewController.swift
//  MyNasa
//
//  Created by Dushyanth Potnuru on 24/07/22.
//

import UIKit
import SDWebImage
import ReadMoreTextView
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var addFav: UIButton!
    var viewModel: NasaPictureViewModel!
    @IBOutlet weak var datePicker: UIDatePicker! {
        didSet {
            datePicker.datePickerMode = UIDatePicker.Mode.date
            datePicker.maximumDate = Date()
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var explanationTextView: ReadMoreTextView! {
        didSet {
            explanationTextView.shouldTrim = true
            explanationTextView.maximumNumberOfLines = 2
            explanationTextView.readMoreText = "......Read more"
            explanationTextView.readLessText = "......Read less"
        }
    }
    @IBOutlet weak var pictureOfTheDay: UIImageView! {
        didSet {
            pictureOfTheDay.contentMode = .scaleAspectFill
        }
    }
    var apiSevice: APODService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiSevice = APODService()
        loadAPI()
      //  navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "heart"), style: .plain, target: self, action: #selector(addTapped(_:)))

    }
    
//    @objc func addTapped(_ sender: UIBarButtonItem) {
//        let vc = MyFavViewController(nibName: "MyFavViewController", bundle: nil)
//        self.navigationController?.pushViewController(vc, animated: true)
//
//    }
    
    
    func loadAPI(date: String? = nil) {
        apiSevice?.fetchPictureOfTheDay(date: date).map({ nasaPictureModel in
         self.viewModel = NasaPictureViewModel(model: nasaPictureModel)
            DispatchQueue.main.async {
                self.loadUI()
            }
        })
    }
    
    
    @IBAction func selectDate(_ sender: UIDatePicker) {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "YYYY-MM-dd"
        let stringDate = dateFormat.string(from: datePicker.date).uppercased()
        loadAPI(date: stringDate)
        addFav.isSelected = false
    }
    
    private func loadUI() {
        guard let imageUrl = self.viewModel.model.url else { return }
        pictureOfTheDay.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
        explanationTextView.text = self.viewModel.model.explanation
        titleLabel.text = self.viewModel.model.title
    }

    @IBAction func myFavAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        guard let imageURL = self.viewModel.model.url else { return }
        if !sender.isSelected {
            CoreDataSharedManager.shared.deleteData(url: imageURL)
            sender.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
            sender.tintColor = .black
        } else {
            CoreDataSharedManager.shared.saveData(url: imageURL)
            sender.setImage(#imageLiteral(resourceName: "like"), for: .normal)
            sender.tintColor = .red
        }
    }
    
}

extension ViewController {
    
    func saveData(url: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let favPictureEnitity = NSEntityDescription.entity(forEntityName: "FavPictureEntity", in: managedObjectContext)!
        
        let entity = NSManagedObject(entity: favPictureEnitity, insertInto: managedObjectContext)
        entity.setValue(url, forKey: "picture")
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print(error.userInfo)
        }
        
    }
    
    func deleteData(url: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavPictureEntity")
        fetchRequest.predicate = NSPredicate(format: "picture = %@",url)
        
        do {
            let fetch = try managedObjectContext.fetch(fetchRequest)
            let objectToDelete = fetch[0] as! NSManagedObject
            managedObjectContext.delete(objectToDelete)
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                print(error.userInfo)
            }
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
}
