//
//  SearchViewController.swift
//  Colchugina_2memoryTest
//
//  Created by Ирина Кольчугина on 23.09.2021.
//

import UIKit

final class SearchViewController: UIViewController, UISearchBarDelegate {
    
    //MARK: - Private properties
    private let titleLabel = UILabel()
    private let searchBar = UISearchBar()
    private let doneButton = UIButton(type: .system)
    private var searchResult = [SearchResults]()
    private var searchRequest = ""
    private var indicatorView = UIView()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    
    //MARK: - Public methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        startSearching()
    }
    
    //MARK: - Private methods
    private func setViews() {
        navigationItem.title = "Search photos"
        
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        searchBar.placeholder = "Type the image title"
        searchBar.delegate = self
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: searchBar.topAnchor, constant: -10)
        ])
        titleLabel.text = "Hi! It's pinterest simple version"
        
        view.addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doneButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            doneButton.widthAnchor.constraint(equalToConstant: 150),
            doneButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        doneButton.setTitle("Search", for: .normal)
        doneButton.backgroundColor = .systemBlue
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.layer.cornerRadius = 10
        doneButton.addTarget(self, action: #selector(searchCancelled(_:)), for: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        
        view.addGestureRecognizer(tapGesture)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc
    private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height/5
            }
        }
    }
    
    @objc
    private func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc
    private func searchCancelled(_ button: UIButton) {
        startSearching()
    }
    
    private func startSearching() {
        if NetworkMonitor.shared.isConnected {
            view.endEditing(true)
            showActivityIndicator()
            searchRequest = searchBar.searchTextField.text ?? ""
            DispatchQueue.global().async {
                self.getPhotoList(searchRequest: self.searchRequest)
            }
        }
        else {
            presentErrorAlert(messege: "No internet connection. \nPlease connect and try again")
        }
    }
    
    
    private func getPhotoList(searchRequest: String) {
        let network = NetworkLayer()
        network.fetchPhotos(photosName: searchRequest) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let photos):
                self.searchResult = photos.results
                DispatchQueue.main.async {
                    self.hideActivityIndicator()
                    guard !photos.results.isEmpty else {
                        return self.presentErrorAlert(messege: "No photos from this request")
                    }
                    self.pushVC()
                }
            }
        }
    }
    
    private func presentErrorAlert(messege: String) {
        let alert = UIAlertController(title: "Ooops!", message: messege, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    private func pushVC() {
        searchBar.searchTextField.text = .none
        let vc = PhotoViewController(result: searchResult, request: searchRequest)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showActivityIndicator() {
        view.addSubview(indicatorView)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicatorView.topAnchor.constraint(equalTo: view.topAnchor),
            indicatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            indicatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            indicatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        indicatorView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicatorView.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicator.centerYAnchor.constraint(equalTo: indicatorView.centerYAnchor),
            indicator.centerXAnchor.constraint(equalTo: indicatorView.centerXAnchor)
        ])
        indicator.startAnimating()
    }
    
    private func hideActivityIndicator() {
        indicatorView.removeFromSuperview()
    }
    
}

