import AVFoundation

open class Chirp {
  open class Sound {
    open var id: SystemSoundID
    open fileprivate(set) var count: Int = 1
    init(id: SystemSoundID) {
      self.id = id
    }
  }
  
  // MARK: - Constants
  fileprivate let kDefaultExtension = "wav"
  
  // MARK: - Singleton
  public static let sharedManager = Chirp()
  
  // MARK: - Private Variables
  open fileprivate(set) var sounds = [String:Sound]()
  
  // MARK: - Public
  @discardableResult
  open func prepareSound(fileName: String) -> String? {
    let fixedSoundFileName = self.fixedSoundFileName(fileName: fileName)
    if let sound = soundForKey(fixedSoundFileName) {
      sound.count += 1
      return fixedSoundFileName
    }
    
    if let pathURL = pathURLForSound(fileName: fixedSoundFileName) {
      var soundID: SystemSoundID = 0
      AudioServicesCreateSystemSoundID(pathURL as CFURL, &soundID)
      let sound = Sound(id: soundID)
      sounds[fixedSoundFileName] = sound
      return fixedSoundFileName
    }
    
    return nil
  }
  
  open func playSound(fileName: String) {
    let fixedSoundFileName = self.fixedSoundFileName(fileName: fileName)
    if let sound = soundForKey(fixedSoundFileName) {
      AudioServicesPlaySystemSound(sound.id)
    }
  }
  
  open func removeSound(fileName: String) {
    let fixedSoundFileName = self.fixedSoundFileName(fileName: fileName)
    if let sound = soundForKey(fixedSoundFileName) {
      sound.count -= 1
      if sound.count <= 0 {
        AudioServicesDisposeSystemSoundID(sound.id)
        sounds.removeValue(forKey: fixedSoundFileName)
      }
    }
  }
  
  // MARK: - Private
  fileprivate func soundForKey(_ key: String) -> Sound? {
    return sounds[key]
  }
  
  fileprivate func fixedSoundFileName(fileName: String) -> String {
    var fixedSoundFileName = fileName.trimmingCharacters(in: .whitespacesAndNewlines)
    var soundFileComponents = fixedSoundFileName.components(separatedBy: ".")
    if soundFileComponents.count == 1 {
      fixedSoundFileName = "\(soundFileComponents[0]).\(kDefaultExtension)"
    }
    return fixedSoundFileName
  }
  
  fileprivate func pathForSound(fileName: String) -> String? {
    let fixedSoundFileName = self.fixedSoundFileName(fileName: fileName)
    let components = fixedSoundFileName.components(separatedBy: ".")
    return Bundle.main.path(forResource: components[0], ofType: components[1])
  }
  
  fileprivate func pathURLForSound(fileName: String) -> URL? {
    if let path = pathForSound(fileName: fileName) {
      return URL(fileURLWithPath: path)
    }
    return nil
  }
}
