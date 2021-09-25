//
//  PhotoCollectionViewCell.swift
//  Colchugina_2memoryTest
//
//  Created by Ирина Кольчугина on 23.09.2021.
//

import UIKit
import Kingfisher

final class PhotoCollectionViewCell: UICollectionViewCell {

    //MARK: - Public properties
    static let reusableID = "PhotoCollectionViewCell"

    //MARK: - Private properties
    private let photoImageView = UIImageView()

    //MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Public methods
    func configur(photoUrl: String) {
        guard let url = URL(string: photoUrl) else {return}
        photoImageView.kf.setImage(with: url)
    }

    //MARK: - Private methods
    private func setViews() {
        contentView.clipsToBounds = true
        contentView.addSubview(photoImageView)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        photoImageView.contentMode = .scaleAspectFill
    }

}

