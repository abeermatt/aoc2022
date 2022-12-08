import XCTest

final class Day8Test: XCTestCase {

    func testSampleInputPart1() throws {
        let input =
"""
30373
25512
65332
33549
35390
"""
            .toLines()
        
        XCTAssertEqual(21, Day8.Part1.run(input))
        
    }
    
    func testSampleInputPart3() throws {
        let input =
"""
30373
25512
65332
33549
35390
"""
            .toLines()
        
        XCTAssertEqual(8, Day8.Part2.run(input))
        
    }



}
