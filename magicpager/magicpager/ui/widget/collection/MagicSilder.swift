//
//  MagicSilder.swift
//  magicpager
//
//  Created by Sven on 14/11/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import Foundation

@objc class MagicSilder: ICollectionMagic, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MagicCellDelegate {
    
    private var _heightMapping: Dictionary<Int, CGSize> = Dictionary()
    
    override func createContainerView<V, T>(model: T, frame: CGRect) -> V where V : UICollectionView, T : SliderWidgetModel {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collect = UICollectionView.init(frame: frame, collectionViewLayout: layout) as! V
        collect.backgroundColor = UIColor.clear
        
        for i in 0...(model.items.count - 1) {
            let item = model.items[i]
            collect.register(MagicCollectionCell.self,
                             forCellWithReuseIdentifier: ReuseUtil.reuseId(model: item, index: i))
        }
        
        collect.delegate = self
        collect.dataSource = self
        collect.showsHorizontalScrollIndicator = false
        collect.showsVerticalScrollIndicator = false
        
        self.resizeCollect(collect: collect, frame: frame, model: model)
        
        return collect
    }
    
    private func resizeCollect(collect: UICollectionView,frame: CGRect,  model: SliderWidgetModel) {
        var nFrame = frame
        var maxHP: CGFloat = 0
        
        model.items.forEach { (item) in
            maxHP = item.height > maxHP ? item.height : maxHP
        }
        
        let size = getContextSize(width: frame.size.width, 
                                  height: LengthUtil.instance.length2px(length: maxHP))
        
        nFrame.size.width = size.0
        nFrame.size.height = size.1
        collect.frame = nFrame
    }
    
    
    //MARK: - MagicCellDelegate
    func magicCellResizeSize(width: CGFloat, height: CGFloat, index: Int) {
        let size:CGSize = _heightMapping[index] ?? CGSize.zero
        guard size.width != width || size.height != height else {
            return
        } 
        
        _heightMapping[index] = CGSize.init(width: width, height: height)
        (containerView as? UICollectionView)?.performBatchUpdates({ 
            return
        }, completion: { (isCompletion) in
            return
        })
    }
    
    //MARK: - UICollectionView delegate & datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard currentModel is SliderWidgetModel else {
            return 0;
        } 
        
        return (currentModel as! SliderWidgetModel).items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = (currentModel as! SliderWidgetModel).items[indexPath.row]
        let cell: MagicCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseUtil.reuseId(model: item, index: indexPath.row), for: indexPath) as! MagicCollectionCell
        
        cell.setIndex(index: indexPath.row)
        cell.setDelegate(delegate: self)
        cell.analysis(model: item, maxWidth: 0, maxHeight: 0)
        cell.clipsToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return _heightMapping[indexPath.row] ?? CGSize.init(width: 1, height: 1)
    }
    
}
