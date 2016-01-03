// https://github.com/Quick/Quick

import Quick
import Nimble
import Chirp

class TableOfContentsSpec: QuickSpec {
    override func spec() {
        describe("Chirp") {            
            describe("when prepare sound") {
                context("and the file exists") {
                    beforeEach {
                        Chirp.sharedManager.prepareSound(fileName: "test.mp3")
                    }
                    
                    afterEach {
                        Chirp.sharedManager.removeSound(fileName: "test.mp3")
                    }
                    
                    it("should have sound in cache") {
                        let keyExists = Chirp.sharedManager.sounds["test.mp3"] != nil
                        expect(keyExists) == true
                    }

                    describe("when removing sound") {
                        beforeEach {
                            Chirp.sharedManager.removeSound(fileName: "test.mp3")
                        }
                        
                        it("should not have sound in cache") {
                            let keyExists = Chirp.sharedManager.sounds["test.mp3"] != nil
                            expect(keyExists) == false
                        }
                    }
                    
                    describe("when removing a sound once but preparing twice") {
                        beforeEach {
                            Chirp.sharedManager.prepareSound(fileName: "test.mp3")
                            Chirp.sharedManager.removeSound(fileName: "test.mp3")
                        }
                        
                        it("should have sound in cache with count 1") {
                            let keyExists = Chirp.sharedManager.sounds["test.mp3"] != nil
                            expect(keyExists) == true
                            expect(Chirp.sharedManager.sounds["test.mp3"]?.count) == 1
                        }
                    }
                }
                
                context("and the file doesn't exist") {
                    beforeEach {
                        Chirp.sharedManager.prepareSound(fileName: "test2")
                    }
                    
                    afterEach {
                        Chirp.sharedManager.removeSound(fileName: "test2")
                    }
                    
                    it("should not have sound in cache") {
                        let keyExists = Chirp.sharedManager.sounds["test2"] != nil
                        expect(keyExists) == false
                    }
                }
            }
            
            describe("when play sound without prepare") {
                context("and the file exists") {
                    beforeEach {
                        Chirp.sharedManager.playSound(fileName: "test.mp3")
                    }
                    
                    it("should not have sound in cache") {
                        let keyExists = Chirp.sharedManager.sounds["test.mp3"] != nil
                        expect(keyExists) == false
                    }
                }
            }
        
        }
    }
}
