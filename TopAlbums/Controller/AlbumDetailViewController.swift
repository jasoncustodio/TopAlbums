//
//  AlbumDetailViewController.swift
//  TopAlbums
//
//  Created by Jason Maxwell Custodio on 3/15/20.
//  Copyright © 2020 Jason Maxwell Custodio. All rights reserved.
//

import UIKit
import SafariServices

final class AlbumDetailViewController: UIViewController {
    
    private var albumArtwork = UIImageView()
    private var name = UILabel()
    private var artistName = UILabel()
    private var genres = UILabel()
    private var releaseDate = UILabel()
    private var copyright = UILabel()
    
    private var button = UIButton()
    
    var album: Album?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubViews()
        setupImageView()
        setupLabels()
        setupButton()
    }
    
    private func addSubViews() {
        view.addSubview(albumArtwork)
        view.addSubview(artistName)
        view.addSubview(name)
        view.addSubview(genres)
        view.addSubview(releaseDate)
        view.addSubview(copyright)
        view.addSubview(button)
    }
    
    private func setupImageView() {
        albumArtwork.image = album?.artwork
        
        albumArtwork.centerMePlease(on: view)
        albumArtwork.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        albumArtwork.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
        albumArtwork.widthAnchor.constraint(equalTo: albumArtwork.heightAnchor).isActive = true
    }
    
    private func setupLabels() {
        name.text = "Album Name: \(album?.name ?? "?")"
        name.constraintLabel(to: albumArtwork, on: view)
        
        artistName.text = "Artist Name: \(album?.artistName ?? "?")"
        artistName.constraintLabel(to: name, on: view)
        
        genres.text = "Genre: \(album?.genres.first?.name ?? "?")"
        genres.constraintLabel(to: artistName, on: view)
        
        releaseDate.text = "Release Date: \(album?.releaseDate ?? "?")"
        releaseDate.constraintLabel(to: genres, on: view)
        
        copyright.text = "Copyright: \(album?.copyright ?? "?")"
        copyright.constraintLabel(to: releaseDate, on: view)
    }
    
    private func setupButton() {
        button.backgroundColor = .darkGray
        button.setTitleColor(.white, for: .normal)
        button.setTitle("PRESS ME PLEASE", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        button.centerMePlease(on: view)
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }
    
    @objc private func buttonTapped() {
        guard let url = album?.url else {
            return
        }
        
        let itunes = SFSafariViewController(url: url)
        itunes.delegate = self
        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(itunes, animated: true)
    }
}

extension AlbumDetailViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        navigationController?.popViewController(animated: true)
        navigationController?.isNavigationBarHidden = false
    }
}

private extension UIView {
    func centerMePlease(on superView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
    }
}

private extension UILabel {
    func constraintLabel(to topView: UIView, on superView: UIView) {
        self.centerMePlease(on: superView)
        self.numberOfLines = 0
        self.leadingAnchor.constraint(greaterThanOrEqualTo: superView.leadingAnchor, constant: 25).isActive = true
        self.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 25).isActive = true
    }
}
