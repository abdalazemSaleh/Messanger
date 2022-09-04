//
//  Chat+Extention.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-10.
//

import Foundation
import AVFoundation
import AVKit

extension Chat: chatView {
    
    /// Reload message collection
    func reloadMessageCollection() {
        messagesCollectionView.reloadDataAndKeepOffset()
    }
    /// Scroll to last item
    func scrollToLastItem() {
        messagesCollectionView.scrollToLastItem()
    }
    /// Go to viewer screen
    func goToPhotoViewerScreen(url: URL) {
        let vc = PhotoViewer(url: url)
        vc.fullScreenNavigation()
        present(vc, animated: true, completion: nil)
    }
    /// Go to video viewer
    func goToViedoViewer(url: URL) {
        let vc = AVPlayerViewController()
        vc.player = AVPlayer(url: url)
        present(vc, animated: true, completion: nil)
    }

}
