# Chirp

The easiest way to prepare, play, and remove sounds in your Swift app!

##Installation
###CocoaPods Installation
Chirp is available on CocoaPods. Just add the following to your project Podfile:

```
pod 'Chirp', '~> 1.1'
```

###Non-CocoaPods Installation
You can drop Chirp.swift directly into your project, or drag the Chirp project into your workspace.

### Sample code
`prepareSound` is used to preload a sound into memory. This increases the retain count of the sound by 1. You must call this method before calling playSound
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
