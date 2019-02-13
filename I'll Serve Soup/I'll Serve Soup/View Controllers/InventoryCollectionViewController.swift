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
        setAppearance()
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
        itemCell.backgroundColor = AppearanceHelper.pink
        return itemCell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Edit" {
            guard let editVC = segue.destination as? ItemViewController,
            let cell = sender as? UICollectionViewCell,
            let index = collectionView.indexPath(for: cell) else { return }
            let item = itemController.items[index.row]
            editVC.item = item
        }
    }
    
    func setAppearance() {
        accountButton.title = "👤"
    }

    @IBAction func unwindToInventoryCVC(segue: UIStoryboardSegue) { }
    
    let itemController = ItemController()
    let edgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    let itemsPerRow: CGFloat = 2
    @IBOutlet weak var accountButton: UIBarButtonItem!
}

extension InventoryCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = edgeInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return edgeInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return edgeInsets.left
    }
}
