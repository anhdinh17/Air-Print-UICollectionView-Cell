//
//  ViewController.swift
//  Air Print CollectionView Cell
//
//  Created by Anh Dinh on 1/30/22.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var container: UIView!
    
    var mockArray: [ViewModel] = [
        ViewModel(nameOfAnime: "One Piece", characterName: "Luffy", animeImage: "onePiece", specialSkill: "Gear 4"),
        ViewModel(nameOfAnime: "Kimetsu no Yaiba", characterName: "Zenetsu", animeImage: "zenetsu", specialSkill: "Thunder Breathing")
    ]
    
    lazy private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width,
                                 height: container.bounds.height)
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        let view = UICollectionView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: UIScreen.main.bounds.width ,
                                                  height: container.bounds.height),
                                    collectionViewLayout: layout)
        view.backgroundColor = .blue
        view.delegate = self
        view.dataSource = self
        view.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        return view
    }()
    
    lazy private var viewToPrint: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: container.bounds.width, height: container.bounds.height))
        view.backgroundColor = .brown
        return view
    }()
    
    private let viewFirstLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        label.textAlignment = .center
        label.backgroundColor = .purple
        return label
    }()
    
    private let viewSecondLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 60, width: 150, height: 50))
        label.textAlignment = .center
        label.backgroundColor = .purple
        return label
    }()
    
    private let viewThirdLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 380, width: 150, height: 50))
        label.textAlignment = .center
        label.backgroundColor = .purple
        return label
    }()
    
    private let viewImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 120, width: 250, height: 250))
        image.backgroundColor = .orange
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        container.backgroundColor = .red
        container.addSubview(collectionView)
    }
    
    @IBAction func printButtonTapped(_ sender: Any) {
        getCellContet()
        let printController = UIPrintInteractionController.shared
        let printInfo = UIPrintInfo(dictionary: nil)
        printInfo.outputType = .general
        printInfo.jobName = "print job"
        printController.printInfo = printInfo
        printController.printingItem = viewToPrint.toImage()
        printController.present(animated: true, completionHandler: nil)
    }
    
    func getCellContet(){
        for cell in collectionView.visibleCells {
            guard let indexPath = collectionView.indexPath(for: cell) else {
                return
            }
            let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
            viewToPrint.addSubview(viewFirstLabel)
            viewToPrint.addSubview(viewSecondLabel)
            viewToPrint.addSubview(viewThirdLabel)
            viewToPrint.addSubview(viewImage)
            viewFirstLabel.text = cell.nameOfAnime.text
            viewSecondLabel.text = cell.characterLabel.text
            viewThirdLabel.text = cell.specialSkill.text
            viewImage.image = cell.animeImage.image
            viewFirstLabel.center.x = viewToPrint.center.x
            viewSecondLabel.center.x = viewToPrint.center.x
            viewThirdLabel.center.x = viewToPrint.center.x
            viewImage.center.x = viewToPrint.center.x
        }
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return mockArray.count
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = mockArray[indexPath.row]
            cell.backgroundColor = .green
            cell.configrure(viewModel: viewModel)
            return cell
        }
}

extension UIView {
    func toImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
