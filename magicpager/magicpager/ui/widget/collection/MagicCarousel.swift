//
//  MagicCarousel.swift
//  magicpager
//
//  Created by Sven on 14/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit

@objc public class MagicCarousel: ICollectionMagic, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MagicCellDelegate{
    
    
    private var _dotsView: CarouselDotsView? = nil
    
    private var _timer: Timer? = nil
    
    private var _maxRow: Int = 0
    
    override public func createContainerView<V, T>(model: T, frame: CGRect) -> V where V : UICollectionView, T : CarouselWidgetModel {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collect = UICollectionView.init(frame: frame, collectionViewLayout: layout) as! V
        collect.backgroundColor = UIColor.clear
        collect.register(MagicCollectionCell.self, forCellWithReuseIdentifier: "cell")
        collect.delegate = self
        collect.dataSource = self
        collect.showsHorizontalScrollIndicator = false
        collect.showsVerticalScrollIndicator = false
        collect.isPagingEnabled = true
        
        resizeCollect(collect: collect, frame: frame, model: model)
        setupTimer(model: model)
        return collect
    }
    
    private func resizeCollect(collect: UICollectionView,frame: CGRect,  model: CarouselWidgetModel) {
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
    
    override public func magicDidAppear() {
        guard currentModel is CarouselWidgetModel else {
            return
        }
        //是否显示点
        if ((currentModel as! CarouselWidgetModel).dots) {
            showDots(container: self, model: currentModel as! CarouselWidgetModel)
        }
    }
    
    private func showDots(container: UIView, model: CarouselWidgetModel) {
        
        if (nil == _dotsView || nil == _dotsView?.superview ) {
            _dotsView = CarouselDotsView.init(frame: CGRect.zero)
            
            container.addSubview(_dotsView!)
            
            _dotsView?.snp_makeConstraints({ (maker) in
                maker.left.right.bottom.equalTo(container)
                maker.height.equalTo(model.dotsContainerHeight.toPoint())
            })
        }
        
        _dotsView?.setDots(count: model.items.count, 
                          dotSelectedColor: model.dotSelectedColor, 
                          dotDefaultColor: model.dotDefaultColor, 
                          dotSpace: model.dotSpace.toPoint(), 
                          dotWidth: model.dotWidth.toPoint())
    }
    
    private func setupTimer(model: CarouselWidgetModel) {
        guard model.autoPlay else {
            _timer?.invalidate()
            return
        }
        
        _timer?.invalidate()
        
        _timer = Timer.scheduledTimer(timeInterval: TimeInterval(model.duration/1000), target: self, selector: #selector(moveToNext(sender:)), userInfo: nil, repeats: true)
    }
    
    
    
    
    //MARK: - MagicCell delegate
    public func magicCellResizeSize(width: CGFloat, height: CGFloat, index: Int) {
        
    }
    
    //MARK: - UICollectionView delegate & datasource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard currentModel is CarouselWidgetModel else {
            _maxRow = 0
            return _maxRow;
        } 
        
        guard (currentModel as! CarouselWidgetModel).items.count > 1 else {
            _maxRow = (currentModel as! CarouselWidgetModel).items.count 
            return _maxRow
        }
        
        _maxRow = 255
        return _maxRow
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = currentModel as! CarouselWidgetModel
        let item = model.items[(indexPath.row % model.items.count)]
        let cell: MagicCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MagicCollectionCell
        
        cell.setIndex(index: indexPath.row)
        cell.setDelegate(delegate: self)
        let size = containerView?.frame.size ?? CGSize.zero
        cell.analysis(model: item, maxWidth:size.width , maxHeight:size.height )
        cell.clipsToBounds = true
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return containerView?.frame.size ?? CGSize.zero
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        refreshDots()
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard !decelerate else {
            return
        }
        
        refreshDots()
    }
    
    func refreshDots() {
        guard containerView is UICollectionView
            && currentModel is CarouselWidgetModel
            && nil != _dotsView else {
            return
        } 
        
        let index: Int = Int(((containerView as! UICollectionView).contentOffset.x / containerView!.frame.size.width).rounded())
        _dotsView!.setSelectIndex(index: index % (currentModel as! CarouselWidgetModel).items.count)
    }
    
    @objc private func moveToNext(sender: Any) {
        guard containerView is UICollectionView else {
            return
        }
        
        //是否正在拖动或惯性移动
        guard !(containerView as! UICollectionView).isDragging 
            && !(containerView as! UICollectionView).isDecelerating else {
            return
        }
        
        let index: Int = Int(((containerView as! UICollectionView).contentOffset.x / containerView!.frame.size.width).rounded())
        
        let toIndex = (index + 1) < _maxRow ? (index + 1) : 0 
        
        (containerView as! UICollectionView)
            .scrollToItem(at: IndexPath.init(row: toIndex, section: 0), 
                          at: UICollectionView.ScrollPosition.centeredHorizontally, 
                          animated: true)
        
        _dotsView?.setSelectIndex(index: toIndex % (currentModel as! CarouselWidgetModel).items.count)
    }
    
    override public func removeFromSuperview() {
        super.removeFromSuperview()
        _timer?.invalidate()
    }
    
    override public func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        guard currentModel is CarouselWidgetModel else {
            return
        }
        
        setupTimer(model: currentModel as! CarouselWidgetModel)
    }
}
