//
//  AlbumCell.swift
//  TopAlbums
//
//  Created by Jason Maxwell Custodio on 3/15/20.
//  Copyright © 2020 Jason Maxwell Custodio. All rights reserved.
//

import UIKit

class AlbumCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(album: Album) {
        textLabel?.text = album.name
        detailTextLabel?.text = album.artistName
        imageView?.image = album.artwork
    }
}

