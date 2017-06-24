//
//  TaggerViewController.swift
//  LinguisticsPlayground
//
//  Created by Dylan Elliott on 24/6/17.
//  Copyright © 2017 Dylan Elliott. All rights reserved.
//

import UIKit

class TaggerViewController: UIViewController {

    @IBOutlet weak var entryTextView: UITextView!
    @IBOutlet weak var tagSchemeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var analyseButton: UIButton!
    @IBOutlet weak var outputTextView: UITextView!
    
    let tagSchemes : [String : NSLinguisticTagScheme] = ["Lemma" : .lemma, "Class" : .lexicalClass, "Name" : .nameType, "Token" : .tokenType, "Language" : .language, "Script" : .script]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagSchemeSegmentedControl.removeAllSegments()
        for tagScheme in tagSchemes.keys {
            tagSchemeSegmentedControl.insertSegment(withTitle: tagScheme, at: tagSchemeSegmentedControl.numberOfSegments, animated: false)
        }
        tagSchemeSegmentedControl.selectedSegmentIndex = 0
        
        let textViewCornerRadius : CGFloat = 10
        let buttonCornerRadius : CGFloat = 5
        entryTextView.layer.cornerRadius = textViewCornerRadius
        analyseButton.layer.cornerRadius = buttonCornerRadius
        outputTextView.layer.cornerRadius = textViewCornerRadius
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func analyseButtonTapped(_ sender: Any) {
        let inputText = entryTextView.text!
        let taggerUnit = NSLinguisticTaggerUnit.word
        
        let selectedSchemeIndex = tagSchemeSegmentedControl.selectedSegmentIndex
        let selectedSchemeName = tagSchemeSegmentedControl.titleForSegment(at: selectedSchemeIndex)!
        let tagScheme = tagSchemes[selectedSchemeName]!
        
        var tagResults : [String] = []
        
        NSLinguisticTagger.enumerateTags(for: inputText, range: NSMakeRange(0, inputText.count), unit: taggerUnit, scheme: tagScheme, options: [.omitWhitespace, .omitPunctuation], orthography: nil) { (tag, range, stop) in
            
            let input =  (inputText as NSString).substring(with: range)
            let output = tag != nil ? tag!.rawValue : "nil"
            
            tagResults.append("Input: \(input), Output: \(output)")
        }
        
        outputTextView.text = tagResults.joined(separator: "\n")
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
