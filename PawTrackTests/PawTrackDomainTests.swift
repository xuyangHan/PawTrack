import XCTest
@testable import PawTrack

final class PawTrackDomainTests: XCTestCase {
    func testWeightValidationAcceptsReasonableValue() throws {
        XCTAssertNoThrow(try DomainValidator.validateWeight(4.2))
    }

    func testWeightValidationRejectsNegativeValue() {
        XCTAssertThrowsError(try DomainValidator.validateWeight(-1))
    }

    func testFoodValidationRejectsHugeWaterAmount() {
        XCTAssertThrowsError(try DomainValidator.validateFood(20, 20_000))
    }

    func testMedicationValidationRejectsFutureDate() {
        let future = Date().addingTimeInterval(3600 * 2)
        XCTAssertThrowsError(try DomainValidator.validateMedication(dose: 1, occurredAt: future))
    }
}
