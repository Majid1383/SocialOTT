//
//  AboutViewClass.swift
//  secondModule
//
//  Created by apple on 02/12/24.
//

import UIKit

class AboutViewClass: UIView
{

    @IBOutlet var aboutViewContainer: UIView!
    @IBOutlet var descriptionView: UITextView!
    
    override init(frame: CGRect)
    { // for using CustomView in code
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    { // for using CustomView in IB
        super.init (coder: aDecoder)
        commonInit ( )
    }
    private func commonInit()
    {
        Bundle.main.loadNibNamed("AboutViewClass", owner: self,options: nil)
        addSubview(aboutViewContainer)
        aboutViewContainer.frame = self.bounds
        aboutViewContainer.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    func configure(with description: String)
    {
        descriptionView.text = description
    }

}
