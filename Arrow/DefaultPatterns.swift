//
//  DefaultPatternChoices.swift
//  Arrow
//
//  Created by David Williams on 12/2/20.
//  Copyright © 2020 David Williams. All rights reserved.
//

//
//      0       1       2
//    3   4   5   6   7   8
//  9  10  11  12  13  14  15
//   16  17  18  19  20  21
//     22      23      24
//

struct DefaultPatterns {
    static let choices = [
        ArrowPattern(frames: [
            //  24  20  16  12   8   4   0
            //----....----....----....----  -  --   --->
            0b0000000000000000011000000000,
            0b0000000000000011111000000000,
            0b0001001000001011111100000100,
            0b0000000000000000000000000000,
        ]),
        ArrowPattern(frames: [
            //  24  20  16  12   8   4   0
            //----....----....----....----  -  --  <---
            0b0000000000001100000000000000,
            0b0000000000001111100000000000,
            0b0000010000011111101000001001,
            0b0000000000000000000000000000,
        ]),
        ArrowPattern(frames: [
            //  24  20  16  12   8   4   0
            //----....----....----....----  -> --> --->
            0b0000010000100000111000010001,
            0b0000100010000010111001000010,
            0b0001001000001011111100000100,
            0b0000000000000000000000000000,
        ]),
        ArrowPattern(frames: [
            //  24  20  16  12   8   4   0
            //----....----....----....----  <- <-- <---
            0b0001000100001110000010000100,
            0b0000100001001110100000100010,
            0b0000010000011111101000001001,
            0b0000000000000000000000000000,
        ]),
        ArrowPattern(frames: [
            //  24  20  16  12   8   4   0
            //----....----....----....----  >  >>   >>>
            0b0000010000100000100000010001,
            0b0000110010100010100001010011,
            0b0001111010101010100101010111,
            0b0000000000000000000000000000,
        ]),
        ArrowPattern(frames: [
            //  24  20  16  12   8   4   0
            //----....----....----....----  <  <<   <<<
            0b0001000100000010000010000100,
            0b0001100101000010100010100110,
            0b0001110101010010101010101111,
            0b0000000000000000000000000000,
        ]),
        ArrowPattern(frames: [
            //  24  20  16  12   8   4   0
            //----....----....----....----  <>  <>
            0b0000010000110000101000011001,
            0b0001001100001010000110000100,
        ]),
        ArrowPattern(frames: [
            //  24  20  16  12   8   4   0
            //----....----....----....----  --> flash
            0b0001001000001011111100000100,
            0b0000000000000000000000000000,
        ]),
        ArrowPattern(frames: [
            //  24  20  16  12   8   4   0
            //----....----....----....----  <-- flash
            0b0000010000011111101000001001,
            0b0000000000000000000000000000,
        ]),
        ArrowPattern(frames: [
            //  24  20  16  12   8   4   0
            //----....----....----....----  <-> flash
            0b0001011000011011101100001101,
            0b0000000000000000000000000000,
        ]),
        ArrowPattern(frames: [
            //  24  20  16  12   8   4   0
            //----....----....----....----  : : flash
            0b0001010000000000000000000101,
            0b0000000000000000000000000000,
        ]),
        ArrowPattern(frames: [
            //  24  20  16  12   8   4   0
            //----....----....----....----  ---- flash
            0b0000000000001111111000000000,
            0b0000000000000000000000000000,
        ]),
    ]
}
