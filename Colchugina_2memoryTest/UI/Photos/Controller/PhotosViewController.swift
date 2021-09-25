//
//  PhotosViewController.swift
//  Colchugina_2memoryTest
//
//  Created by Ирина Кольчугина on 23.09.2021.
//

import UIKit

final class PhotoViewController: UIViewController {
    
    //MARK: - Private properties
    private var photoCollectionView: UICollectionView?
    private var photos = [SearchResults]()
    
    //MARK: - Life cycle
    init(result: [SearchResults], request: String) {
        super.init(nibName: nil, bundle: nil)
        title = request
        self.photos = result
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView() 
    }
    
}

//MARK: - extension
extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - Life cycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        photoCollectionView?.frame = view.bounds
    }
    
    //MARK: - Public methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reusableID, for: indexPath) as? PhotoCollectionViewCell else {return UICollectionViewCell()}
        cell.configur(photoUrl: photos[indexPath.row].urls.regular)
        return cell
    }
    
    //MARK: - Private methods
    private func setView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.width/3)-4,
                                 height:  (view.frame.height/3)-4)
        
        photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        photoCollectionView?.dataSource = self
        photoCollectionView?.delegate = self
        photoCollectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reusableID)
        photoCollectionView?.backgroundColor = .white
        view.addSubview(photoCollectionView ?? UICollectionView())
    }
    
}
