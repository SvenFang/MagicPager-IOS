//
//  MagicList.swift
//  magicpager
//
//  Created by Sven on 14/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit

@objc public class MagicList: ICollectionMagic, CollectionViewWaterfallLayoutDelegate, UICollectionViewDataSource, MagicCellDelegate {
    
    private var _cellSizeMap: [Int: CGSize] = [:]
    
    override public func createContainerView<V, T>(model: T, frame: CGRect) -> V where V : UICollectionView, T : ListWidgetModel {
        let layout = CollectionViewWaterfallLayout()
        
        layout.minimumInteritemSpacing = 0
        layout.minimumColumnSpacing = 0
        layout.headerHeight = 0
        layout.footerHeight = 0
        layout.headerInset = UIEdgeInsets.zero
        layout.footerInset = UIEdgeInsets.zero
        
        switch model.listType {
        case ListWidgetType.DOUBLE:
            layout.columnCount = 2;
        default:
            layout.columnCount = 1;
        }
        
        var nFrame = frame
        
        if (Int(frame.size.height) < model.items.count) {
            nFrame.size.height = CGFloat(model.items.count)
        }
        
        let collect = UICollectionView.init(frame: nFrame, collectionViewLayout: layout) as! V
        collect.backgroundColor = UIColor.clear
        
        for i in 0...(model.items.count-1) {
            let item = model.items[i]
            collect.register(MagicCollectionCell.self, forCellWithReuseIdentifier: ReuseUtil.reuseId(model: item, index: i))
        }
        collect.delegate = self
        collect.dataSource = self
        collect.showsHorizontalScrollIndicator = false
        collect.showsVerticalScrollIndicator = false
        
        
        collect.addObserver(self, forKeyPath: "contentSize", options:NSKeyValueObservingOptions.new , context: nil)
        
        return collect
    }
    
    //MARK: - refreshCellSize
    var _refreshCellSizeTimer: Timer?
    func needRefreshCellSize() {
        _refreshCellSizeTimer?.invalidate()
        _refreshCellSizeTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(cellSizeTimerAction(timer:)), userInfo: nil, repeats: false)
    }
    
    @objc func cellSizeTimerAction(timer: Timer) {
        (self.containerView as? UICollectionView)?.reloadData()
    }
    
    //MARK: - MagicCell delegate
    public func magicCellResizeSize(width: CGFloat, height: CGFloat, index: Int) {    
        let size = _cellSizeMap[index]
        guard nil == size || size?.width != width || size?.height != height else {
            return
        } 
        _cellSizeMap[index] = CGSize.init(width: width, height: height)
        needRefreshCellSize()
    }
    
    //MARK: - UICollectionView delegate & datasource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (currentModel is ListWidgetModel) {
            return (currentModel as! ListWidgetModel).items.count
        }
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = currentModel as! ListWidgetModel
        let item = model.items[indexPath.row]
        let cell: MagicCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseUtil.reuseId(model: item, index: indexPath.row), for: indexPath) as! MagicCollectionCell
        
        cell.setIndex(index: indexPath.row)
        cell.setDelegate(delegate: self)
        let size = containerView?.frame.size ?? CGSize.zero
        
        let width = size.width / (model.listType == ListWidgetType.DOUBLE ? 2 : 1)
        
        cell.analysis(model: item, maxWidth:width , maxHeight:ModelConstants.WRAP_CONTENT )
        cell.clipsToBounds = true
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let model = currentModel as! ListWidgetModel
        
        let maxWidth = (containerView?.frame.size.width ?? CGSize.zero.width) / (model.listType == ListWidgetType.DOUBLE ? 2 : 1)
        
        var size = _cellSizeMap[indexPath.row]
        guard nil != size else {
            return CGSize.init(width: maxWidth, height: 1)
        }
        size?.width = maxWidth
        return size!
    }
    
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        change?.forEach({ (key, value) in
            if (key == NSKeyValueChangeKey.newKey
                && value is CGSize) {
                let contentSize = value as! CGSize
                let frame = containerView!.frame
                
                if (frame.size.width != contentSize.width
                    || frame.size.height != contentSize.height) {
                    needResizeContentSize(width: contentSize.width, height: contentSize.height)
                }
            }
        })
        
    }
    
    deinit {
        containerView?.removeObserver(self, forKeyPath: "contentSize")
    }
    
}
