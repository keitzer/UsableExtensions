import Quick
import Nimble
@testable import TestOpenSource

class XYZMapperTests: QuickSpec {
    override func spec() {
        describe("XYZMapper") {

            var data: [AnyHashable: Any]!
            var subject: XYZMapper!

            let long_1 = NSDecimalNumber(value: Int32.max).adding(NSDecimalNumber(value: 3))
            let long_2 = NSDecimalNumber(value: Int64.max).adding(NSDecimalNumber(value: 3))
            let long_3 = NSDecimalNumber(value: UInt32.max).adding(NSDecimalNumber(value: 3))
            let long_4 = NSDecimalNumber(value: UInt64.max).adding(NSDecimalNumber(value: 3))

            beforeEach {
                data = [
                    1: 2,
                    "int_1": 1,
                    "int_2": -3,
                    "long_1": long_1,
                    "long_2": long_2,
                    "long_3": long_3,
                    "long_4": long_4,
                    "string_1": "there",
                    "string_2": "4",
                    "date_1": Date(timeIntervalSince1970: 10),
                    "date_2": "12/31/2016",
                    "date_3": "2014-04-04T00:00:00.455-04:00",
                    "date_4": "2014-02-02T00:00:00-05:00",
                    "date_5": "Dec 25, 2014",
                    "date_6": "December 25, 2014",
                    "date_7": "Thursday, December 25, 2014",
                    "date_8": "1-8-2016",
                    "bool_1": true,
                    "bool_2": false,
                    "bool_3": "T",
                    "bool_4": "f",
                    "bool_5": "trUe",
                    "bool_6": "FALSE",
                    "bool_7": "y",
                    "bool_8": "N",
                    "bool_9": "1",
                    "bool_0": 0,
                    "bool_A": "On",
                    "bool_B": "oFf",
                    "data_1": "hello".data(using: String.Encoding.utf8)!,
                    "color_1": UIColor.red,
                    "color_2": "#00ff00",
                    "error_1": NSError(domain: "a", code: 2, userInfo: ["hello": "there"]),
                    "dictionary_1": [
                        "double_1": 3.5,
                        "double_2": -2.5,
                        "double_3": 0.0,
                        "double_4": "225.0",
                        "double_5": 325.0,
                        "double_s": "2.5",
                        "int_3": 3,
                        "int_4": 0,
                        "int_s": "10",
                        "string_3": "booyakasha!",
                        "dictionary_2": [
                            "value_1": 1
                        ]
                    ],
                    "array_1": ["A", "B", "C"]
                ]

                subject = XYZMapper(data: data)
            }

            it("should initialize with the value") {
                expect(subject.value).to(beIdenticalTo(data))
            }

            describe("Subscripts") {
                it("string key should return a new mapper with the new value") {
                    let result = subject["string_1"]

                    expect(result.value as? String).to(equal("there"))
                }

                it("number key should return a new mapper with the new value") {
                    let result = subject[1].int

                    expect(result).to(equal(2))
                }
            }

            describe("String") {
                it("should successfully convert value") {
                    let result = subject["string_1"].string

                    expect(result).to(equal("there"))
                }

                it("should successfully convert a huge int") {
                    let result = subject["long_2"].string

                    expect(result).to(equal("\(long_2)"))
                }

                it("should get a string if not originally a string") {
                    let result = subject["bool_1"].string

                    expect(result).to(equal("true"))
                }

                it("should successfully convert from NSData to string") {
                    let result = subject["data_1"].string

                    expect(result).to(equal("hello"))
                }

                it("should get nil if key is not present") {
                    let result = subject["not there"].string

                    expect(result).to(beNil())
                }

                it("should not throw an exception when forced to convert successfully") {
                    let result = try? subject["string_1"].mapString()

                    expect(result).to(equal("there"))
                }

                it("should throw an exception when forced to convert fails") {
                    expect { try subject["not there"].mapString() }.to(throwError { error in
                        expect(error).notTo(beNil())
                    })
                }
                it("should throw an exception when forced to convert when key is not present") {
                    expect { try subject["not there"].mapString() }.to(throwError { error in
                        expect(error).notTo(beNil())
                    })
                }
            }

            describe("Int") {
                it("should successfully convert value") {
                    let result = subject["int_1"].int

                    expect(result).to(equal(1))
                }

                it("should get an Int if originally a string") {
                    let result = subject["string_2"].int

                    expect(result).to(equal(4))
                }

                it("should get an Int equal to floor(value) when value is a decimal") {
                    let result = subject["dictionary_1"]["double_3"].int

                    expect(result).to(equal(0))
                }

                it("should get an Int equal to floor(value) when value is a decimal string") {
                    let result = subject["dictionary_1"]["double_4"].int

                    expect(result).to(equal(225))
                }

                it("should successfully convert value if given a 33-64 bit number (iphone 5 and higher)") {
                    let result = subject["long_1"].int
                    if self.getIntMax() == Int64.max {
                        expect(result).to(equal(long_1.intValue))
                    }
                }

                it("should get nil if given a 33-64 bit number on a 32 bit device (iphone 4s and lower)") {
                    let result = subject["long_1"].int

                    if self.getIntMax() == Int64(Int32.max) {
                        expect(result).to(beNil())
                    }
                }

                it("should get nil if given a too-huge number") {
                    let result = subject["long_2"].int

                    expect(result).to(beNil())
                }

                it("should get nil if cannot convert value") {
                    let result = subject["string_1"].int

                    expect(result).to(beNil())
                }

                it("should get nil if key is not present") {
                    let result = subject["not there"].int

                    expect(result).to(beNil())
                }

                it("should not throw an exception when forced to convert successfully") {
                    let result = try? subject["string_2"].mapInt()

                    expect(result).to(equal(4))
                }

                it("should throw an exception when forced to convert fails") {
                    expect { try subject["string_1"].mapInt() }.to(throwError { error in
                        expect(error).notTo(beNil())
                    })
                }

                it("should throw an exception when forced to convert when key is not present") {
                    expect { try subject["not there"].mapInt() }.to(throwError { error in
                        expect(error).notTo(beNil())
                    })
                }
            }

            describe("Unsigned Int") {
                it("should successfully convert value") {
                    let result = subject["int_1"].uInt

                    expect(result).to(equal(1))
                }

                it("should successfully convert value if given a 33-64 bit number (iphone 5 and higher)") {
                    let result = subject["long_3"].uInt

                    if self.getUIntMax() == UInt64.max {
                        expect(result).to(equal(long_3.uintValue))
                    }
                }

                it("should get nil if given a 33-64 bit number on a 32 bit device (iphone 4s and lower)") {
                    let result = subject["long_3"].uInt

                    if self.getUIntMax() == UInt64(UInt32.max) {
                        expect(result).to(beNil())
                    }
                }

                it("should get nil if given a too-huge number") {
                    let result = subject["long_4"].uInt

                    expect(result).to(beNil())
                }

                it("should get nil if given a negative integer") {
                    let result = subject["int_2"].uInt

                    expect(result).to(beNil())
                }

                it("should get nil if cannot convert value") {
                    let result = subject["string_1"].uInt

                    expect(result).to(beNil())
                }

                it("should get nil if key is not found") {
                    let result = subject["not there"].uInt

                    expect(result).to(beNil())
                }

                it("should not throw an exception when forced to convert successfully") {
                    let result = try? subject["string_2"].mapUInt()

                    expect(result).to(equal(4))
                }

                it("should throw an exception when forced to convert") {
                    expect { try subject["string_1"].mapUInt() }.to(throwError { error in
                        expect(error).notTo(beNil())
                    })
                }

                it("should throw an exception when forced to convert when key is not present") {
                    expect { try subject["not there"].mapUInt() }.to(throwError { error in
                        expect(error).notTo(beNil())
                    })
                }
            }

            describe("Int32") {
                it("should successfully convert value") {
                    let result = subject["int_1"].int32

                    expect(result).to(equal(1))
                }

                it("should successfully convert negative values") {
                    let result = subject["int_2"].int32

                    expect(result).to(equal(-3))
                }

                it("should get nil if cannot convert value") {
                    let result = subject["string_1"].int32

                    expect(result).to(beNil())
                }

                it("should get nil if given a too-huge number") {
                    let result = subject["long_1"].int32

                    expect(result).to(beNil())
                }

                it("should get nil if key is not found") {
                    let result = subject["not there"].int32

                    expect(result).to(beNil())
                }

                it("should not throw an exception when forced to convert successfully") {
                    let result = try? subject["string_2"].mapInt32()

                    expect(result).to(equal(4))
                }

                it("should throw an exception when forced to convert") {
                    expect { try subject["string_1"].mapInt32() }.to(throwError { error in
                        expect(error).notTo(beNil())
                    })
                }

                it("should throw an exception when forced to convert when key is not present") {
                    expect { try subject["not there"].mapInt32() }.to(throwError { error in
                        expect(error).notTo(beNil())
                    })
                }
            }

            describe("Int64") {
                it("should successfully convert value") {
                    let result = subject["int_1"].int64

                    expect(result).to(equal(1))
                }

                it("should successfully convert negative values") {
                    let result = subject["int_2"].int64

                    expect(result).to(equal(-3))
                }

                it("should get nil if cannot convert value") {
                    let result = subject["string_1"].int64

                    expect(result).to(beNil())
                }

                it("should get nil if given a too-huge number") {
                    let result = subject["long_2"].int64

                    expect(result).to(beNil())
                }

                it("should get nil if key is not found") {
                    let result = subject["not there"].int64

                    expect(result).to(beNil())
                }

                it("should not throw an exception when forced to convert successfully") {
                    let result = try? subject["string_2"].mapInt64()

                    expect(result).to(equal(4))
                }

                it("should throw an exception when forced to convert") {
                    expect { try subject["string_1"].mapInt64() }.to(throwError { error in
                        expect(error).notTo(beNil())
                        })
                }

                it("should throw an exception when forced to convert when key is not present") {
                    expect { try subject["not there"].mapInt64() }.to(throwError { error in
                        expect(error).notTo(beNil())
                        })
                }
            }

            describe("Double") {
                it("should successfully convert value") {
                    let result = subject["dictionary_1"]["double_1"].double

                    expect(result).to(equal(3.5))
                }

                it("should successfully convert negative values") {
                    let result = subject["dictionary_1"]["double_2"].double

                    expect(result).to(equal(-2.5))
                }

                it("should successfully convert integers") {
                    let result = subject["dictionary_1"]["int_3"].double
                    expect(result).to(equal(3.0))
                }

                it("should successfully convert 0.0") {
                    let result = subject["dictionary_1"]["double_3"].double

                    expect(result).to(equal(0))
                }

                it("should successfully convert 0") {
                    let result = subject["dictionary_1"]["int_4"].double

                    expect(result).to(equal(0))
                }

                it("should successfully convert strings") {
                    let result = subject["dictionary_1"]["double_s"].double

                    expect(result).to(equal(2.5))
                }

                it("should get nil if cannot convert value") {
                    let result = subject["dictionary_1"]["string_3"].double

                    expect(result).to(beNil())
                }

                it("should get nil if key is not found") {
                    let result = subject["dictionary_1"]["not there"].double

                    expect(result).to(beNil())
                }

                it("should not throw an exception when forced to convert successfully") {
                    let result = try? subject["dictionary_1"]["double_1"].mapDouble()

                    expect(result).to(equal(3.5))
                }

                it("should throw an exception when forced to convert") {
                    expect { try subject["dictionary_1"]["string_3"].mapDouble() }.to(throwError { error in
                        expect(error).notTo(beNil())
                    })
                }

                it("should throw an exception when forced to convert when key is not present") {
                    expect { try subject["dictionary_1"]["not there"].mapDouble() }.to(throwError { error in
                        expect(error).notTo(beNil())
                    })
                }

                it("should successfully convert integers") {
                    let result = subject["dictionary_1"]["int_s"].double

                    expect(result).to(equal(10.0))
                }
            }

            describe("Float") {
                it("should successfully convert value") {
                    let result = subject["dictionary_1"]["double_1"].float

                    expect(result).to(equal(3.5))
                }

                it("should successfully convert negative values") {
                    let result = subject["dictionary_1"]["double_2"].float

                    expect(result).to(equal(-2.5))
                }

                it("should successfully convert integers") {
                    let result = subject["dictionary_1"]["int_3"].float

                    expect(result).to(equal(3.0))
                }

                it("should successfully convert 0.0") {
                    let result = subject["dictionary_1"]["double_3"].float

                    expect(result).to(equal(0))
                }

                it("should successfully convert 0") {
                    let result = subject["dictionary_1"]["int_4"].float

                    expect(result).to(equal(0))
                }

                it("should successfully convert strings") {
                    let result = subject["dictionary_1"]["double_s"].float

                    expect(result).to(equal(2.5))
                }

                it("should get nil if cannot convert value") {
                    let result = subject["dictionary_1"]["string_3"].float

                    expect(result).to(beNil())
                }

                it("should get nil if key is not found") {
                    let result = subject["dictionary_1"]["not there"].float

                    expect(result).to(beNil())
                }

                it("should not throw an exception when forced to convert successfully") {
                    let result = try? subject["dictionary_1"]["double_1"].mapFloat()

                    expect(result).to(equal(3.5))
                }

                it("should throw an exception when forced to convert") {
                    expect { try subject["dictionary_1"]["string_3"].mapFloat() }.to(throwError { error in
                        expect(error).notTo(beNil())
                    })
                }
                
                it("should throw an exception when forced to convert when key is not present") {
                    expect { try subject["dictionary_1"]["not there"].mapFloat() }.to(throwError { error in
                        expect(error).notTo(beNil())
                    })
                }
            }

            describe("Bool") {
                it("should successfully convert value") {
                    let trueResult  = subject["bool_1"].bool
                    let falseResult = subject["bool_2"].bool

                    expect(falseResult).to(beFalse())
                    expect(trueResult).to(beTrue())
                }

                it("should return false for unrecognized string values") {
                    let result = subject["string_1"].bool

                    expect(result).to(beFalse())
                }

                it("should convert T and F to true and false") {
                    let trueResult  = subject["bool_3"].bool
                    let falseResult = subject["bool_4"].bool

                    expect(falseResult).to(beFalse())
                    expect(trueResult).to(beTrue())
                }

                it("should convert strings in a case insensitive manner") {
                    let trueResult  = subject["bool_5"].bool
                    let falseResult = subject["bool_6"].bool

                    expect(falseResult).to(beFalse())
                    expect(trueResult).to(beTrue())
                }

                it("should convert Y and N to true and false") {
                    let trueResult  = subject["bool_7"].bool
                    let falseResult = subject["bool_8"].bool

                    expect(falseResult).to(beFalse())
                    expect(trueResult).to(beTrue())
                }

                it("should convert 0 and 1 to false and true") {
                    let trueResult  = subject["bool_9"].bool
                    let falseResult = subject["bool_0"].bool

                    expect(falseResult).to(beFalse())
                    expect(trueResult).to(beTrue())
                }
                
                it("should convert positive integers to true") {
                    let result  = subject["string_2"].bool
                    
                    expect(result).to(beTrue())
                }

                it("should convert OFF and ON to false and true") {
                    let trueResult  = subject["bool_A"].bool
                    let falseResult = subject["bool_B"].bool

                    expect(falseResult).to(beFalse())
                    expect(trueResult).to(beTrue())
                }

                it("should return nil if key not found") {
                    let result = subject["not there"].bool

                    expect(result).to(beNil())
                }

                it("should not throw an exception when forced to convert successfully") {
                    let result = try? subject["bool_1"].mapBool()

                    expect(result).to(beTrue())
                }

                it("should throw an exception when forced to convert") {
                    expect { try subject["dictionary_1"]["string_3"].mapFloat() }.to(throwError { error in
                        expect(error).notTo(beNil())
                    })
                }

                it("should throw an exception when forced to convert when key is not present") {
                    expect { try subject["dictionary_1"]["not there"].mapFloat() }.to(throwError { error in
                        expect(error).notTo(beNil())
                    })
                }
            }

            describe("Data") {
                it("should successfully convert value") {
                    let result = subject["data_1"].data

                    expect(result).notTo(beNil())
                    expect(String(data: result!, encoding: String.Encoding.utf8)).to(equal("hello"))
                }

                it("should successfully convert value from string") {
                    let result = subject["string_1"].data

                    expect(result).notTo(beNil())
                    expect(String(data: result!, encoding: String.Encoding.utf8)).to(equal("there"))
                }

                it("should get nil if cannot convert value") {
                    let result = subject["bool_1"].data

                    expect(result).to(beNil())
                }

                it("should not throw an exception when forced to convert successfully") {
                    let result = try! subject["data_1"].mapData()

                    expect(result).notTo(beNil())
                    expect(String(data: result, encoding: String.Encoding.utf8)).to(equal("hello"))
                }

                it("should throw an exception when forced to convert") {
                    expect { try subject["not there"].mapData() }.to(throwError { error in
                        expect(error).notTo(beNil())
                    })
                }
            }

            describe("Date") {
                it("should successfully convert value") {
                    let result = subject["date_1"].date

                    expect(result).to(equal(Date(timeIntervalSince1970: 10)))
                }

                it("should successfully convert value from string in Short format") {
                    let result = subject["date_2"].date

                    let formatter = DateFormatter()
                    formatter.dateFormat = DateFormat.short
                    let expected = formatter.date(from: "12/31/2016")

                    expect(result).to(equal(expected))
                }

                it("should successfully convert value from string in Medium format") {
                    let result = subject["date_5"].date

                    let formatter = DateFormatter()
                    formatter.dateStyle = .medium
                    let expected = formatter.date(from: "Dec 25, 2014")

                    expect(result).to(equal(expected))
                }

                it("should successfully convert value from string in Long format") {
                    let result = subject["date_6"].date

                    let formatter = DateFormatter()
                    formatter.dateStyle = .long
                    let expected = formatter.date(from: "December 25, 2014")

                    expect(result).to(equal(expected))
                }

                it("should successfully convert value from string in Full format") {
                    let result = subject["date_7"].date

                    let formatter = DateFormatter()
                    formatter.dateStyle = .full
                    let expected = formatter.date(from: "Thursday, December 25, 2014")

                    expect(result).to(equal(expected))
                }

                it("should successfully convert value from string in Timestamp") {
                    let result = subject["date_3"].date

                    let formatter = DateFormatter()
                    formatter.dateFormat = DateFormat.timeStampWithZone
                    let expected = formatter.date(from: "2014-04-04T00:00:00.455-04:00")

                    expect(result).to(equal(expected))
                }

                it("should successfully convert value from string in ISO format") {
                    let result = subject["date_4"].date

                    let formatter = DateFormatter()
                    formatter.dateFormat = DateFormat.iso8601
                    let expected = formatter.date(from: "2014-02-02T00:00:00-05:00")

                    expect(result).to(equal(expected))
                }

                it("should get nil if cannot convert value") {
                    let result = subject["string_1"].date

                    expect(result).to(beNil())
                }

                it("should get nil if key is not present") {
                    let result = subject["not there"].date

                    expect(result).to(beNil())
                }

                it("should not throw an exception when forced to convert successfully") {
                    let result = try? subject["date_1"].mapDate()

                    expect(result).to(equal(Date(timeIntervalSince1970: 10)))
                }

                it("should not throw an exception when forced to convert successfully from string") {
                    let result = try? subject["date_2"].mapDate()

                    let formatter = DateFormatter()
                    formatter.dateFormat = DateFormat.short
                    let expected = formatter.date(from: "12/31/2016")

                    expect(result).to(equal(expected))
                }

                it("should throw an exception when forced to convert") {
                    expect { try subject["not there"].mapDate() }.to(throwError { error in
                        expect(error).notTo(beNil())
                    })
                }

                it("should get a date from a specified format") {
                    let result = subject["date_3"].date(withFormat: DateFormat.short)

                    let formatter = DateFormatter()
                    formatter.dateFormat = DateFormat.short
                    let expected = formatter.date(from: "04/04/2014")

                    expect(result).to(equal(expected))
                }

                it("should get a date string from a specified format") {
                    let result = subject["date_3"].dateString(withFormat: DateFormat.short)

                    expect(result).to(equal("04/04/2014"))
                }
                
                it("should be able to handle American formatted dates (MM-dd-yyyy)") {
                    let result = subject["date_8"].date(withFormat: DateFormat.short)
                    
                    let expected = "01/08/2016".toDate(withFormat: DateFormat.short)
                    
                    expect(result).to(equal(expected))
                }
            }

            describe("Dictionary") {
                it("should successfully convert value") {
                    let result = subject["dictionary_1"].dictionary

                    expect(result).notTo(beNil())
                    expect(result?["double_1"] as? Double).to(equal(3.5))
                }

                it("should get nil if cannot convert value") {
                    let result = subject["string_1"].dictionary

                    expect(result).to(beNil())
                }

                it("should not throw an exception when forced to convert successfully") {
                    let result = try? subject["dictionary_1"].mapDictionary()

                    expect(result).notTo(beNil())
                    expect(result?["double_1"] as? Double).to(equal(3.5))
                }

                it("should throw an exception when forced to convert") {
                    expect { try subject["not there"].mapDictionary() }.to(throwError { error in
                        expect(error).notTo(beNil())
                    })
                }
            }

            describe("Array") {
                it("should successfully convert value") {
                    let result = subject["array_1"].array

                    expect(result).notTo(beNil())
                    expect(result?[0] as? String).to(equal("A"))
                }

                it("should get nil if cannot convert value") {
                    let result = subject["dictionary_1"].array

                    expect(result).to(beNil())
                }

                it("should not throw an exception when forced to convert successfully") {
                    let result = try? subject["array_1"].mapArray()

                    expect(result).notTo(beNil())
                    expect(result?[0] as? String).to(equal("A"))
                }

                it("should throw an exception when forced to convert") {
                    expect { try subject["not there"].mapArray() }.to(throwError { error in
                        expect(error).notTo(beNil())
                    })
                }
            }

            describe("Color") {
                it("should successfully convert value") {
                    let result = subject["color_1"].color

                    expect(result).to(equal(UIColor.red))
                }

                it("should successfully convert value from string") {
                    let result = subject["color_2"].color

                    expect(result).to(equal(UIColor.green))
                }

                it("should get nil if cannot convert value") {
                    let result = subject["string_1"].color

                    expect(result).to(beNil())
                }

                it("should not throw an exception when forced to convert successfully") {
                    let result = try? subject["color_2"].mapColor()

                    expect(result).to(equal(UIColor.green))
                }

                it("should throw an exception when forced to convert") {
                    expect { try subject["not there"].mapColor() }.to(throwError { error in
                        expect(error).notTo(beNil())
                    })
                }
            }

            describe("Error") {
                it("should successfully convert value") {
                    let result = subject["error_1"].error

                    expect(result?.domain).to(equal("a"))
                }

                it("should get nil if cannot convert value") {
                    let result = subject["string_1"].error

                    expect(result).to(beNil())
                }

                it("should not throw an exception when forced to convert successfully") {
                    let result = try? subject["error_1"].mapError()

                    expect(result?.domain).to(equal("a"))
                }

                it("should throw an exception when forced to convert") {
                    expect { try subject["not there"].mapError() }.to(throwError { error in
                        expect(error).notTo(beNil())
                    })
                }
            }

            describe("Custom Type") {
                it("should successfully convert value") {
                    let result: String? = subject["string_1"].type()

                    expect(result).to(equal("there"))
                }

                it("should get nil if cannot convert value") {
                    let result: Int? = subject["string_1"].type()

                    expect(result).to(beNil())
                }

                it("should not throw an exception when forced to convert successfully") {
                    let result: Int = try! subject["int_1"].mapType()

                    expect(result).notTo(beNil())
                    expect(result).to(equal(1))
                }

                it("should throw an exception when forced to convert") {
                    expect { try subject["not there"].mapType() }.to(throwError { error in
                        expect(error).notTo(beNil())
                    })
                }
            }

            describe("Mappable") {
                class TestMappable: XYZMappable {
                    var mapper: XYZMapper?
                    required init?(mapper: XYZMapper) {
                        self.mapper = mapper
                    }
                }

                it("should output a mappable object with data") {
                    let testMap: TestMappable? = XYZMapper.map(withData: data as AnyObject?)

                    expect(testMap).notTo(beNil())
                    expect(testMap?.mapper?.value as? [NSObject: AnyObject]).notTo(beIdenticalTo(data))
                }

                it("should output a mappable object from subject") {
                    let testMap: TestMappable? = subject.map()

                    expect(testMap).notTo(beNil())
                    expect(testMap?.mapper?.value as? [NSObject: AnyObject]).notTo(beIdenticalTo(data))
                }
            }

            describe("Dictionary Extension") {
                it("should return a XYZMapper with value set to dictionary") {
                    let dictionary: [NSObject: Any] = [
                        "hello" as NSObject: "there"
                    ]

                    let mapper = dictionary.mapper
                    let result = mapper["hello"].string

                    expect(result).to(equal("there"))
                }
            }
        }
    }

    private func getUIntMax() -> UInt64 { return UInt64(UInt.max) }
    private func getIntMax()  -> Int64  { return Int64(Int.max) }
}
