//
//  MyFavCollectionViewController.swift
//  MyNasa
//
//  Created by Dushyanth Potnuru on 31/07/22.
//

import UIKit
import CoreData

private let reuseIdentifier = "Cell"

class MyFavCollectionViewController: UICollectionViewController {
    var myFavList = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Fav pictures"
        myFavList = CoreDataSharedManager.shared.retriveData()
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return myFavList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MyFavPictureCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "privateCell", for: indexPath) as! MyFavPictureCollectionViewCell
        let imageUrl = myFavList[indexPath.row]
        cell.imageVIew.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
        // Configure the cell
    
        return cell
    }
  
}
extension MyFavCollectionViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let itemsPerRow:CGFloat = 1
            let padding:CGFloat = 20
            let itemWidth = (collectionView.bounds.width / itemsPerRow) - padding
            let itemHeight = collectionView.bounds.height - (2 * padding)
            return CGSize(width: itemWidth, height: itemHeight)
    }

}
