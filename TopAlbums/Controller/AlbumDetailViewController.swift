//
//  AlbumDetailViewController.swift
//  TopAlbums
//
//  Created by Jason Maxwell Custodio on 3/15/20.
//  Copyright © 2020 Jason Maxwell Custodio. All rights reserved.
//

import Foundation

import UIKit
import SafariServices

class AlbumDetailViewController: UIViewController {
    
    var albumArtwork = UIImageView()
    var name = UILabel()
    var artistName = UILabel()
    var genres = UILabel()
    var releaseDate = UILabel()
    var copyright = UILabel()
    
    var button = UIButton()
    
    var album: Album?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubViews()
        setupImageView()
        setupLabels()
    }
    
    func addSubViews() {
        view.addSubview(albumArtwork)
        view.addSubview(artistName)
        view.addSubview(name)
        view.addSubview(genres)
        view.addSubview(releaseDate)
        view.addSubview(copyright)
        view.addSubview(button)
    }
    
    func setupImageView() {
        albumArtwork.image = album?.artwork
        
        albumArtwork.centerMePlease(on: view)
        albumArtwork.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        albumArtwork.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
        albumArtwork.widthAnchor.constraint(equalTo: albumArtwork.heightAnchor).isActive = true
    }
    
    func setupLabels() {
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
