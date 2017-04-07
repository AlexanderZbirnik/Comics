//
//  AboutUsViewController.swift
//  Comics
//
//  Created by Alex Zbirnik on 22.03.17.
//  Copyright © 2017 com.alexzbirnik. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController, ReuseIdentifierProtocol {
    
    @IBOutlet weak var aboutUsLabel: UILabel!
    
    //MARK: -  Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.aboutUsLabel.text =
        "Comics is a medium used to express ideas by images, often combined with text or other visual information. Comics frequently takes the form of juxtaposed sequences of panels of images. Often textual devices such as speech balloons, captions, and onomatopoeia indicate dialogue, narration, sound effects, or other information. Size and arrangement of panels contribute to narrative pacing. Cartooning and similar forms of illustration are the most common image-making means in comics; fumetti is a form which uses photographic images. Common forms of comics include comic strips, editorial and gag cartoons, and comic books. Since the late 20th century, bound volumes such as graphic novels, comic albums, and tankōbon have become increasingly common, and online webcomics have proliferated in the 21st century."
    }
}
