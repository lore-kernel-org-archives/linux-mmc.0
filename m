From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH v5 1/4] gpiolib: Pass bitmaps, not integer arrays, to
 get/set array
Date: Thu, 30 Aug 2018 15:35:39 +0000
Message-ID: <34ad57ec954c481d87ef6af58453ee9f@AcuMS.aculab.com>
References: <20180820234341.5271-1-jmkrzyszt@gmail.com>
 <20180829204900.19390-1-jmkrzyszt@gmail.com>
 <20180829204900.19390-2-jmkrzyszt@gmail.com>
 <CANiq72kJT15ELkYr2U5r4-pvGunQFLmZ5dhdZLnjmM7NWBnkNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANiq72kJT15ELkYr2U5r4-pvGunQFLmZ5dhdZLnjmM7NWBnkNQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: 'Miguel Ojeda' <miguel.ojeda.sandonis@gmail.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Dominik Brodowski <linux@dominikbrodowski.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux
List-Id: linux-mmc@vger.kernel.org

RnJvbTogTWlndWVsIE9qZWRhDQo+IFNlbnQ6IDMwIEF1Z3VzdCAyMDE4IDEyOjExDQouLi4NCj4g
PiArICAgICAgIHVuc2lnbmVkIGxvbmcgdmFsdWVfYml0bWFwWzFdOyAgLyogZm9yIERBVEFbMC03
XSwgUlMsIFJXICovDQo+IA0KPiAoSSByZWFkIHlvdXIgY29tbWVudHMgaW4gdGhlIG90aGVyIGVt
YWlsKQ0KPiANCj4gSSBzdGlsbCBmaW5kIHRoaXMgb2RkLCBidXQgaWYgZXZlcnlvbmUgaXMgZ29p
bmcgdG8gaGF2ZSB0aGlzIGNoYW5nZQ0KPiBkb25lIGxpa2UgdGhpcywgY29uc2lzdGVuY3kgaXMg
YmV0dGVyLg0KDQpNYXliZSB0aGVyZSBvdWdodCB0byBiZSBhIGRlZmluZSBzbyB5b3UgY2FuIGRv
Og0KCURFRklORV9CSVRNQVAodmFsdWVfYml0bWFwLCAzMik7DQoNCldoaWxlIGl0IG1pZ2h0IGp1
c3QgZ2VuZXJhdGUgYW4gdW5zaWduZWQgbG9uZyBbXSB0aGVyZSBpcyBwcm9iYWJseQ0Kc2NvcGUg
Zm9yIHN0cm9uZ2VyIHR5cGluZy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBM
YWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBU
LCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==
