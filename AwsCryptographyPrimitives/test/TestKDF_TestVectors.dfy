// Copyright Amazon.com Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

include "../src/Index.dfy"
include "../src/Digest.dfy"
include "TestKDF.dfy"

module TestKDFK_TestVectors {
  import Aws.Cryptography.Primitives
  import UTF8
  import opened Wrappers
  import opened StandardLibrary.UInt
  import opened TestKDF
  
  // UTF-8 encoded "aws-kms-hierarchy"
  const PURPOSE: UTF8.ValidUTF8Bytes := UTF8.EncodeAscii("aws-kms-hierarchy");
  // https://tiny.amazon.com/bhksn4so
  const rawTestVectors: seq<InternalTestVector> := [b1, b2, b3, b4, b5];

  const testVectors: seq<TestVector> := [c1, c2, c3, c4, c5];

  // Internal Test Vectors SHOULD only call RawDerive
  const b1 := InternalTestVector(
    name := "B.1  Test Case 1",
    hash := Primitives.Types.SHA_256,
    IKM := [
      226,   4, 214, 212, 102, 170, 213,   7,
      255, 175, 109, 109, 171,  10,  91,  38,
      21,  44, 158,  33, 231, 100,  55,   4,
      100, 227,  96, 200, 251, 199, 101, 198
    ],
    info := [
      123,  3, 185, 141, 159, 148, 184, 153, 229, 145, 243,
      239, 38,  75, 113, 177, 147, 251, 167,   4,  60, 126,
      149, 60, 222,  35, 188,  83, 132, 188,  26,  98, 147,
      88,  1,  21, 250, 227,  73,  95, 216,  69, 218, 219,
      208, 43, 214,  69,  92, 244, 141,  15,  98, 179,  62,
      98, 54,  74,  58, 128
    ],
    L := 32,
    OKM := [
      119,  13, 250, 182, 166, 164, 164,
      190, 224,  37, 127, 243,  53,  33,
      63, 120, 216,  40, 123,  79, 213,
      55, 213, 193, 255, 250, 149, 105,
      16, 231, 199, 121
    ]
  );

  const b2 := InternalTestVector(
    name := "B.2  Test Case 2",
    hash := Primitives.Types.SHA_256,
    IKM := [
      174, 238, 202,  96, 246, 137, 164, 65,
      177,  59,  12, 188, 212,  65, 216, 45,
      240, 207, 135, 218, 194,  54,  41, 13,
      236, 232, 147,  29, 248, 215,   3, 23
    ],
    info := [
      88, 142, 192,  65, 229, 115,  59, 112,  49,  33,  44,
      85,  56, 239, 228, 246, 170, 250,  76, 218, 139, 146,
      93,  38,  31,  90,  38, 136, 240,   7, 179, 172,  36,
      14, 225,  41, 145, 231, 123, 140, 184,  83, 134, 120,
      97,  89, 102,  22,  74, 129, 135,  43, 209, 207, 203,
      251,  57, 164, 244,  80
    ],
    L := 32,
    OKM := [
      62, 129, 214,  17,  60, 238,  60,  82,
      158, 206, 223, 248, 154, 105, 153, 206,
      37, 182,  24, 193,  94, 225, 209, 157,
      69, 203,  55, 106,  28, 142,  35, 116
    ]
  );

  const b3 := InternalTestVector(
    name := "B.3  Test Case 3",
    hash := Primitives.Types.SHA_256,
    IKM := [
      149, 200, 247, 110,  17,  54, 126,
      181,  85,  38, 162, 179, 147, 174,
      144, 101, 131, 209, 203, 221,  71,
      150,  33,  70, 245,   6, 204, 124,
      172,  18, 244, 100
    ],
    info := [
      202, 214,  14, 144,  75, 158, 156, 139, 254, 180,
      168,  26, 127, 103, 211, 189, 220, 192,  94, 100,
      37,  88, 112,  64,  55, 112, 243,  83,  58, 230,
      221,  99,  76, 234, 165, 108,  83, 230, 136, 189,
      19, 122, 230,   1, 137,  53, 243,  75, 159, 176,
      132, 234,  72, 228, 198, 136, 246, 187, 179, 136
    ],
    L := 32,
    OKM := [
      202, 250,  92, 160,  63,  95, 190, 42,
      36,  32,   4, 171, 203, 211, 222, 16,
      89, 199,  64, 123,  30, 229, 121, 37,
      81,  36, 175,  24, 155, 224, 181, 86
    ]
  );

  const b4 := InternalTestVector(
    name := "B.4  Test Case 4",
    hash := Primitives.Types.SHA_256,
    IKM := [
      77,   5,  57,  31, 214, 251,  30,  41,
      46, 120, 171, 150,  25, 177, 183,  42,
      125,  99, 238,  89, 215,  67,  93, 215,
      24, 151, 185, 255, 126, 231, 174, 112
    ],
    info := [
      240, 120, 230, 249, 183, 248,  45, 100,  85,  79,
      166, 182,   4, 200,   8, 241, 155,  31, 106, 214,
      114, 125, 183, 170, 111,  28, 134, 105,  78,  16,
      75,  82,  86, 200, 180,   3, 153,  25, 100, 100,
      129, 215, 234,  36,  82, 199,  44,  23, 163, 232,
      215, 211, 145,  98, 133,  70,  10, 165, 235, 129
    ],
    L := 32,
    OKM := [
      107,  22, 232, 245,  59, 131,  26, 165,
      232, 107, 249, 122,  92,  79, 163, 125,
        8, 155, 193, 114, 218,  90,  30, 127,
      102,  45, 212, 165, 149,  51, 154, 183
    ] 
  );

  const b5 := InternalTestVector(
    name := "B.5  Test Case 5",
    hash := Primitives.Types.SHA_256,
    IKM := [
      15, 104, 168,  47, 241, 103,  22, 52,
      204, 145,  54, 197, 100, 169, 224, 42,
      118, 118,  33, 221, 116, 161, 191, 92,
      36,  18, 155, 128, 130,  20, 183, 82
    ],
    info := [
      100, 133, 153, 128, 156,  44,  78, 124, 106,  94,
      108,  68, 159,   0,  49, 235, 245,  92,  54,  97,
      168, 149, 180,  77, 176,  87,  46, 232, 128, 131,
      177, 244, 177,  38,   2, 170,  85, 252,  29, 241,
      80, 166,  90, 109, 110, 237, 160, 170, 121, 164,
      52, 161,   3, 155, 145, 181, 165, 143, 199, 241
    ],
    L := 32,
    OKM :=[
      226, 151, 100,  15, 119, 104,  72,  93,
      74, 110, 124, 254,  36,  95, 139, 250,
      132, 112,  13, 153, 118,  38, 146, 234,
      26,  66,  92, 204,   2, 117, 232, 245
    ] 
  );

  // Generated Test Vectors CAN call KdfCounterMode
  const c1 := TestVector(
    name := "C.1 Test Case 1",
    hash := Primitives.Types.SHA_256,
    IKM := [
      125, 201, 189, 252, 37,  52,   4, 124,
      254,  99, 233, 235, 41, 123, 119,  82,
      81,  73, 237, 125, 74, 252, 233, 198,
      68,  15,  53,  14, 97, 239,  62, 208
    ],
    info := [
      119, 218, 233, 62, 104, 155,
      88,  29,  62,  6, 235,   1,
      200, 211, 186,  2
    ],
    purpose := PURPOSE,
    L := 32,
    OKM := [
      188, 232, 152, 114,  85, 137, 174,
      192, 143, 152,  52, 179, 184,  15,
      220,  63, 241, 115, 144, 126,  85,
      116, 231,  41, 253, 206,  18, 124,
      247, 109, 183, 204
    ]
  );

  const c2 := TestVector(
    name := "C.2 Test Case 2",
    hash := Primitives.Types.SHA_256,
    IKM := [
      80,  22, 113,  23, 118,  68,  10,  32,
      75, 169, 199, 192, 255, 220, 214,  60,
      182,   1, 126, 147, 171, 233, 110, 177,
      35, 145, 217, 129,  30,   9,  80, 159
    ],
    info := [
      210, 241, 192, 158, 103,
      66,  27,  35, 143,  66,
      168, 189,  82, 171, 211,
      252
    ],
    purpose := PURPOSE,
    L := 32,
    OKM := [
      54, 206, 174,  72, 237, 133,  85, 156,
      93,  53, 120, 152, 118,  82,  89,  33,
      114,  98, 204, 236, 138,  57, 162, 118,
      85,  92, 199, 232, 240, 252,  92,  97
    ]
  );

  const c3 := TestVector(
    name := "C.3 Test Case 3",
    hash := Primitives.Types.SHA_256,
    IKM := [
      57,  90,  16,  46,  83, 54, 189, 241,
      27, 242, 237, 236, 246, 66,  54, 226,
      74, 112,  79, 156, 208, 13, 148,  71,
      117, 211, 139,  57,  73, 69, 122, 236
    ],
    info := [
      51,  15, 183, 124,  82,
      229, 249,  86, 117, 148,
      237, 162,  27, 243, 173,
      108
    ],
    purpose := PURPOSE,
    L := 32,
    OKM := [
      22,  55, 236, 141, 159, 163, 250,
      236,  86,  47, 225, 103, 156, 225,
      228, 146, 166,  45, 244,  39, 136,
      163, 205, 200, 116, 193,  20, 147,
      112, 254, 210, 194
    ]
  );
  
  const c4 := TestVector(
    name := "C.4 Test Case 4",
    hash := Primitives.Types.SHA_256,
    IKM := [
      152, 192,  25, 223, 239, 154, 175,
      67, 237, 250, 184, 146, 228, 243,
      227,   1, 128, 247, 228, 152, 142,
      131, 149,  41,  60,  70, 244,  58,
      166, 234,  86, 189
    ],
    info := [
      243, 160, 102, 127, 219,
      137, 115,  38, 187, 216,
      48,  80, 151, 168, 148,
      71
    ],
    purpose := PURPOSE,
    L := 32,
    OKM := [
      191, 112,  86, 234, 220, 233, 122, 154,
      100, 188, 230, 238, 239, 155,  54,  32,
      97,  35,  51, 160, 121, 235,  42,  64,
      145, 105,  15, 153, 162,  89,   9, 156
    ]
  );

  const c5 := TestVector(
    name := "C.5 Test Case 5",
    hash := Primitives.Types.SHA_256,
    IKM := [
      166, 236, 116,  51, 140, 189, 192, 175,
      42, 154,  51,  26, 208, 149,  76, 159,
      174, 162, 207,   4, 108, 232, 196, 240,
      12,  57, 228, 155,  97,  75,  42,  66
    ],
    info := [
      236, 169, 233,  45,  43,
      25, 122, 243, 152, 191,
      154,  55,  45, 134, 159,
      220
    ],
    purpose := PURPOSE,
    L := 32,
    OKM := [
      156,  11,  20, 251, 100, 227, 163, 161,
       30,  45, 242,   2, 248, 246,  44,  11,
       88, 132, 189, 175,  95,  96,  61,  44,
       98, 160, 212, 136, 140, 222,  57, 151
    ]
  );
  
  method {:test} ExpectInternalTestVectors() {
    for i := 0 to |rawTestVectors| {
      ExpectRawDeriveTestVector(rawTestVectors[i]);
    }

    for i := 0 to |testVectors| {
      ExpectTestVector(testVectors[i]);
    }
  }

  method ExpectRawDeriveTestVector(vector: InternalTestVector)
  {
    var InternalTestVector(name, hash, IKM, info, L, OKM) := vector;
    print name + "\n";
    expect |IKM| == 32 && L == 32 && 4 + |info| < INT32_MAX_LIMIT;

    TestKDF.KdfRawDeriveTest(IKM, info, L, OKM);
  }

  method ExpectTestVector(vector : TestVector)
  {
    var TestVector(name, hash, IKM, info, purpose, L, OKM) := vector;
    print name + "\n";
    
    TestKDF.KdfTest(
      Primitives.Types.KdfCtrInput(
        digestAlgorithm := hash,
        ikm := IKM,
        expectedLength := L,
        purpose := Some(purpose),
        nonce := Some(info)
      ),
      OKM
    );
  }

  datatype InternalTestVector = InternalTestVector(
    nameonly name: string,
    nameonly hash: Primitives.Types.DigestAlgorithm,
    nameonly IKM: seq<uint8>,
    nameonly info: seq<uint8>,
    nameonly L: Primitives.Types.PositiveInteger,
    nameonly OKM: seq<uint8>
  )

  datatype TestVector = TestVector(
    nameonly name: string,
    nameonly hash: Primitives.Types.DigestAlgorithm,
    nameonly IKM: seq<uint8>,
    nameonly info: seq<uint8>,
    nameonly purpose: seq<uint8>,
    nameonly L: Primitives.Types.PositiveInteger,
    nameonly OKM: seq<uint8>
  )
}
