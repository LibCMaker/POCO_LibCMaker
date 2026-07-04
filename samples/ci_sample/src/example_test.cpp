/*****************************************************************************
 * Project:  LibCMaker
 * Purpose:  A CMake build scripts for build libraries with CMake
 * Author:   NikitaFeodonit, nfeodonit@yandex.com
 *****************************************************************************
 *   Copyright (c) 2017-2026 NikitaFeodonit
 *
 *    This file is part of the LibCMaker project.
 *
 *    This program is free software: you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published
 *    by the Free Software Foundation, either version 3 of the License,
 *    or (at your option) any later version.
 *
 *    This program is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *    See the GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with this program. If not, see <http://www.gnu.org/licenses/>.
 ****************************************************************************/

// The code is based on the code from
// <poco>/Foundation/testsuite/src/UTF8StringTest.cpp


//
// UTF8StringTest.cpp
//
// Copyright (c) 2004-2006, Applied Informatics Software Engineering GmbH.
// and Contributors.
//
// SPDX-License-Identifier:     BSL-1.0
//


#include "Poco/Foundation.h"
#include "Poco/UTF8String.h"

#include "gtest/gtest.h"

#include <iostream>

using Poco::UTF8;

void testCompare()
{
  std::string a1("aaaaa");
  std::string b1("bbbbb");

  EXPECT_TRUE(UTF8::icompare(a1, b1) < 0);

  std::string a2("aaaaa");
  std::string b2("BBBBB");

  EXPECT_TRUE(UTF8::icompare(a2, b2) < 0);

  std::string a3("AAAAA");
  std::string b3("bbbbb");

  EXPECT_TRUE(UTF8::icompare(a3, b3) < 0);

  std::string a4("aaaaa");
  std::string b4("AAAAA");

  EXPECT_TRUE(UTF8::icompare(a4, b4) == 0);

  std::string a5("AAAAA");
  std::string b5("bbbbb");

  EXPECT_TRUE(UTF8::icompare(a5, b5) < 0);

  std::string a6("\303\274\303\266\303\244"); // "u"o"a
  std::string b6("\303\234\303\226\303\204"); // "U"O"A

  EXPECT_TRUE(UTF8::icompare(a6, b6) == 0);
}


void testTransform()
{
  std::string s1("abcde");
  UTF8::toUpperInPlace(s1);
  EXPECT_TRUE(s1 == "ABCDE");

  std::string s2("aBcDe123");
  UTF8::toUpperInPlace(s2);
  EXPECT_TRUE(s2 == "ABCDE123");

  std::string s3("\303\274\303\266\303\244"); // "u"o"a
  UTF8::toUpperInPlace(s3);
  EXPECT_TRUE(s3 == "\303\234\303\226\303\204"); // "U"O"A
  UTF8::toLowerInPlace(s3);
  EXPECT_TRUE(s3 == "\303\274\303\266\303\244"); // "u"o"a

  // a mix of invalid sequences
  std::string str = "\xC2\xE5\xF0\xF8\xE8\xED\xFB+-++";
  EXPECT_TRUE("???+-++" == UTF8::toLower(str));
}


void testEscape()
{
  std::string s1("A \t, a \v, and an \a walk into a |, and the barman says \xD0\x82");

  EXPECT_TRUE(UTF8::escape(s1) == "A \\t, a \\v, and an \\a walk into a |, and the barman says \\u0402");
  EXPECT_TRUE(UTF8::escape(s1, true) == "A \\t, a \\u000B, and an \\u0007 walk into a |, and the barman says \\u0402");
}


void testUnescape()
{
  std::string s1("A \\t, a \\u000B, and an \\u0007 walk into a |, and the barman says \\u0402");
  std::string s2("A \\t, a \\v, and an \\a walk into a |, and the barman says \\u0402");
  std::string s3("\\\\");

  EXPECT_TRUE(UTF8::unescape(s1) == "A \t, a \v, and an \a walk into a |, and the barman says \xD0\x82");
  EXPECT_TRUE(UTF8::unescape(s2) == "A \t, a \v, and an \a walk into a |, and the barman says \xD0\x82");
  EXPECT_TRUE(UTF8::unescape(s3) == "\\");
}


TEST(Examle, test) {
  testCompare();
  testTransform();
  testEscape();
  testUnescape();

  EXPECT_TRUE(true);
}
