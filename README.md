# Chirp

The easiest way to prepare, play, and remove sounds in your Swift app!

##Installation
###Cocoapods Installation
Chirp is available on CocoaPods. Just add the following to your project Podfile:

```
pod 'Chirp', '~> 1.0'
```

###Non-Cocoapods Installation
You can drop Chirp.swift directly into your project, or drag the Chirp project into your workspace.

### Sample code
`prepareSound` lets you preload a sound into memory
```swift
/* MyViewController.swift */

override func viewDidLoad() {
    super.viewDidLoad()
    
    // Load sounds into memory
    Chirp.sharedManager.prepareSound("boop") // default extension is .wav
    Chirp.sharedManager.prepareSound("ding.mp3") // so other extensions you must name explicitly
}
```

`playSound` plays the preloaded sound
```swift
func submitButtonTouched(button: UIButton) {
    // Since the sound is already loaded into memory, this will play immediately
    Chirp.sharedManager.playSound("boop") 
    
    // example function that might get called when you touch a button
    submitForm() 
}
```

`playSound` can also just play sounds on the fly
```swift
func submissionDidFinish(success: Bool) {
    if success {
        // This will also play immediately because you loaded the sound into memory in ViewDidLoad()
        Chirp.sharedManager.playSound("ding.mp3")  
    } else {
        // This sound was not preloaded into memory, but that's ok! playSound will load it into memory and play it.
        // You might experience a noticeable delay for this sound
        Chirp.sharedManager.playSound("oops.mp3")
    }
}
```

`removeSound` removes the sound from memory
```swift
deinit {
    // Cleanup is really simple!
    Chirp.sharedManager.removeSound("boop")
    Chirp.sharedManager.removeSound("ding.mp3")
    Chirp.sharedManager.removeSound("oops.mp3")
    
    // If you never loaded the sounds, e.g. viewDidLoad wasn't called, or submission never failed or succeeded,
    // that's ok, because these will function as no-ops
}
```

Enjoy!  I know sound management can be a little annoying. Hopefully this helps your project out a little bit.
