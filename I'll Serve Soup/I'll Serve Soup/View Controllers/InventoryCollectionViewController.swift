//
//  InventoryCollectionViewController.swift
//  I'll Serve Soup
//
//  Created by Nathanael Youngren on 2/11/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

class InventoryCollectionViewController: UICollectionViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        itemController.getItems { (error) in
            if let error = error {
                print("There was error displaying the data: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemController.items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath)
        guard let itemCell = cell as? ItemCollectionViewCell else { return cell }
        let item = itemController.items[indexPath.row]
        itemCell.itemNameLabel.text = item.name
        itemCell.itemAmountLabel.text = "\(item.amount)"
        return itemCell
    }

    @IBAction func unwindToInventoryCVC(segue: UIStoryboardSegue) { }
    
    let itemController = ItemController()
}

extension InventoryCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width / 2
        let height = width
        return CGSize(width: width, height: height)
    }
}
