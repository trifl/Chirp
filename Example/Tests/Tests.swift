// https://github.com/Quick/Quick

import Quick
import Nimble
import Chirp

class TableOfContentsSpec: QuickSpec {
    override func spec() {
        describe("Chirp") {
            it("should exist") {
                expect(Chirp.sharedManager) != nil
            }
            
            describe("when prepare sound") {
                context("and the file exists") {
                    beforeEach {
                        Chirp.sharedManager.prepareSound(fileName: "test.mp3")
                    }
                    
                    afterEach {
                        Chirp.sharedManager.removeSound(fileName: "test.mp3")
                    }
                    
                    it("should have sound in cache") {
                        let keyExists = Chirp.sharedManager.soundIDs["test.mp3"] != nil
                        expect(keyExists) == true
                    }

                    describe("when removing sound") {
                        beforeEach {
                            Chirp.sharedManager.removeSound(fileName: "test.mp3")
                        }
                        
                        it("should not have sound in cache") {
                            let keyExists = Chirp.sharedManager.soundIDs["test.mp3"] != nil
                            expect(keyExists) == false
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
                        let keyExists = Chirp.sharedManager.soundIDs["test2"] != nil
                        expect(keyExists) == false
                    }
                }
            }
        }
    }
}
