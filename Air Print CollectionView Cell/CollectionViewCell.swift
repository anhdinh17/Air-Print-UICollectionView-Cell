//
//  CollectionViewCell.swift
//  Air Print CollectionView Cell
//
//  Created by Anh Dinh on 1/30/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameOfAnime: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var animeImage: UIImageView!
    @IBOutlet weak var specialSkill: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configrure(viewModel: ViewModel){
        nameOfAnime.text = viewModel.nameOfAnime
        characterLabel.text = viewModel.characterName
        animeImage.image = UIImage(named: viewModel.animeImage)
        specialSkill.text = viewModel.specialSkill
    }
}
