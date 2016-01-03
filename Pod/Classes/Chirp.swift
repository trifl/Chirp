import AVFoundation

public class Chirp {
    public class Sound {
        public var id: SystemSoundID
        public private(set) var count: Int = 1
        init(id: SystemSoundID) {
            self.id = id
        }
    }
    
    // MARK: - Constants
    private let kDefaultExtension = "wav"
    
    // MARK: - Singleton
    public static let sharedManager = Chirp()
    
    // MARK: - Private Variables
    public private(set) var sounds = [String:Sound]()
    
    // MARK: - Public
    public func prepareSound(fileName fileName: String) -> Sound? {
        let fixedSoundFileName = self.fixedSoundFileName(fileName: fileName)
        if let sound = soundForKey(fixedSoundFileName) {
            sound.count++
            return sound
        }
        
        if let pathURL = pathURLForSound(fileName: fixedSoundFileName) {
            var soundID: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(pathURL, &soundID)
            let sound = Sound(id: soundID)
            sounds[fixedSoundFileName] = sound
            return sound
        }
        
        return nil
    }
    
    public func playSound(fileName fileName: String) {
        let fixedSoundFileName = self.fixedSoundFileName(fileName: fileName)
        if let sound = soundForKey(fixedSoundFileName) {
            AudioServicesPlaySystemSound(sound.id)
        }
    }
    
    public func removeSound(fileName fileName: String) {
        let fixedSoundFileName = self.fixedSoundFileName(fileName: fileName)
        if let sound = soundForKey(fixedSoundFileName) {
            sound.count--
            if sound.count <= 0 {
                AudioServicesDisposeSystemSoundID(sound.id)
                sounds.removeValueForKey(fixedSoundFileName)
            }
        }
    }
    
    // MARK: - Private
    private func soundForKey(key: String) -> Sound? {
        return sounds[key]
    }
    
    private func fixedSoundFileName(fileName fileName: String) -> String {
        var fixedSoundFileName = fileName.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
        var soundFileComponents = fixedSoundFileName.componentsSeparatedByString(".")
        if soundFileComponents.count == 1 {
            fixedSoundFileName = "\(soundFileComponents[0]).\(kDefaultExtension)"
        }
        return fixedSoundFileName
    }
    
    private func pathForSound(fileName fileName: String) -> String? {
        let fixedSoundFileName = self.fixedSoundFileName(fileName: fileName)
        let components = fixedSoundFileName.componentsSeparatedByString(".")
        return NSBundle.mainBundle().pathForResource(components[0], ofType: components[1])
    }
    
    private func pathURLForSound(fileName fileName: String) -> NSURL? {
        if let path = pathForSound(fileName: fileName) {
            return NSURL(fileURLWithPath: path)
        }
        return nil
    }
}
