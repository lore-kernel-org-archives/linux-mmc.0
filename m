From: Chris Brandt <Chris.Brandt@renesas.com>
Subject: RE: [PATCH v3 2/3] mmc: tmio-mmc: add support for 32bit data port
Date: Thu, 20 Oct 2016 19:46:22 +0000
Message-ID: <SG2PR06MB1165B756B67D1D101E91A7B38AD50@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20160912141507.6837-1-chris.brandt@renesas.com>
 <20160912141507.6837-3-chris.brandt@renesas.com>
 <20161020132852.GB4177@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:12782 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753865AbcJTTq0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Oct 2016 15:46:26 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

SGVsbG8gV29sZnJhbSwNCg0KPiA+ID4gKwkJLyogaWYgY291bnQgd2FzIG11bHRpcGxlIG9mIDQg
Ki8NCj4gPiA+ICsJCWlmICghKGNvdW50ICYgMHgzKSkNCj4gPiA+ICsJCQlyZXR1cm47DQo+ID4g
PiArCQlidWY4ID0gKHU4ICopKGJ1ZiArIChjb3VudCA+PiAyKSk7DQo+ID4gPiArCQljb3VudCAl
PSA0Ow0KPiA+DQo+ID4gVG8gc2tpcCB0aGUgc2FtZSBvcGVyYXRpb24gZG9uZSBvbiAnY291bnQn
IHR3aWNlLCBtYXliZT8NCj4gPg0KPiA+IAkJYnVmOCA9ICh1OCAqKShidWYgKyAoY291bnQgPj4g
MikpOw0KPiA+IAkJY291bnQgJj0gMzsNCj4gPg0KPiA+IAkJaWYgKCFjb3VudCkNCj4gPiAJCQly
ZXR1cm47DQo+IA0KPiANCj4gVGhhdCBsb29rcyBsaWtlIGl0IHNob3VsZCB3b3JrLg0KPiBJIGNh
biB0cnkgaXQgb3V0IGFuZCBzZWUgaWYgdGhlcmUgaXMgc29tZXRoaW5nIHdlIGFyZSBtaXNzaW5n
Lg0KDQpTZWVtcyB0byB3b3JrIGZpbmUuIEFsdGhvdWdoIEkgYWRtaXQgdGhhdCBiZWNhdXNlIHRo
ZSBkcml2ZXIgaXMgbW9zdGx5IGJlaW5nIHVzZWQgYXMgYSBibG9jayBkZXZpY2UgKFNEIGNhcmQp
LCBhbGwgdGhlIGRhdGEgcmVxdWVzdHMgYXJlIGFuIGV2ZW4gbXVsdGlwbGUgb2YgNCAoSSBwdXQg
YSBwcmludGsgYWZ0ZXIgImlmICghY291bnQpIHJldHVybjsiICkuIE5vdCBzdXJlIGlmIHRoYXQg
d2lsbCBiZSB0aGUgY2FzZSB3aGVuIEkgdGVzdCBTRElPIGRldmljZXMsIGJ1dCBJJ2xsIGZpbmQg
b3V0IG9uY2UgSSBzdGFydCBwb3J0aW5nIFNESU8gZGV2aWNlIGRyaXZlcnMgdG8gNC45Ky4NCg0K
DQpJJ2xsIHN1Ym1pdCBhIHY0IG9mIHRoaXMgcGF0Y2ggc2VyaWVzIHRvbW9ycm93Lg0KDQpUaGFu
ayB5b3UuDQoNCkNocmlzDQoNCg==
