//
//  AlbumTableViewController.swift
//  TopAlbums
//
//  Created by Jason Maxwell Custodio on 3/15/20.
//  Copyright © 2020 Jason Maxwell Custodio. All rights reserved.
//

import UIKit

final class AlbumTableViewController: UIViewController {
    
    private var albumList: [Album] = []
    private var tableView = UITableView()
    private let cellIdentifier = "cell"
    private var isRefreshing = true
    
    override func viewDidLoad() {
        title = "Top 10 Albums"
        setupRefreshControl()
        fetchRSS()
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.tableFooterView = UIView()
        tableView.register(AlbumCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.pin(to: view)
    }
    
    private func setupRefreshControl() {
        let refresh = UIRefreshControl()
        tableView.refreshControl = refresh
        tableView.refreshControl?.beginRefreshing()
    }
}

extension AlbumTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isRefreshing ? 0 : albumList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AlbumCell else {
            return UITableViewCell()
        }
        
        cell.set(album: albumList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailScreen = AlbumDetailViewController()
        detailScreen.album = albumList[indexPath.row]
        navigationController?.pushViewController(detailScreen, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var album = albumList[indexPath.row]
        
        if let _ = album.artwork {
            return
        }
        
        let request = NetworkRequest(url: album.artworkUrl)
        request.execute { [weak self] (data) in
            guard let data = data else {
                return
            }
            
            album.artwork = UIImage(data: data)
            self?.albumList[indexPath.row] = album
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
    }
}

private extension AlbumTableViewController {
    func fetchRSS() {
        let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json")!
        let request = NetworkRequest(url: url)
        request.execute() { [weak self] (data) in
            self?.isRefreshing = false
            self?.tableView.reloadData()
            self?.tableView.refreshControl?.endRefreshing()
            self?.tableView.refreshControl?.removeFromSuperview()
            if let data = data {
                self?.decode(data)
            }
        }
    }
    
    func decode(_ data: Data) {
        if let rss = try? JSONDecoder().decode(AppleRSS.self, from: data) {
            albumList = rss.feed.results
            tableView.reloadData()
        }
    }
}

