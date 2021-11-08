Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFBFC433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 08:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E868C6128B
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 08:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237899AbhKHIZo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Nov 2021 03:25:44 -0500
Received: from mswedge2.sunplus.com ([60.248.182.106]:39328 "EHLO
        mg.sunplus.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237880AbhKHIZo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Nov 2021 03:25:44 -0500
X-Greylist: delayed 1190 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Nov 2021 03:25:43 EST
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 172.17.9.112
        by mg02.sunplus.com with MailGates ESMTP Server V5.0(53126:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Mon, 08 Nov 2021 16:02:57 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 8 Nov 2021 16:02:52 +0800
Received: from sphcmbx02.sunplus.com.tw ([::1]) by sphcmbx02.sunplus.com.tw
 ([fe80::f8bb:bd77:a854:5b9e%14]) with mapi id 15.00.1497.023; Mon, 8 Nov 2021
 16:02:52 +0800
From:   =?utf-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Tony Huang <tonyhuang.sunplus@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC:     =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: RE: [PATCH 2/2] mmc: Add mmc driver for Sunplus SP7021
Thread-Topic: [PATCH 2/2] mmc: Add mmc driver for Sunplus SP7021
Thread-Index: AQHX0xnrVkLZ1EJZzk2i1wkvK0MjAqv2FiQAgAMuw4A=
Date:   Mon, 8 Nov 2021 08:02:52 +0000
Message-ID: <6ac06fbd9280493ea2f34c6b6f7714ef@sphcmbx02.sunplus.com.tw>
References: <1636208598-18234-1-git-send-email-tony.huang@sunplus.com>
 <1636208598-18234-3-git-send-email-tony.huang@sunplus.com>
 <3da7cacf-d5ab-9f08-6d15-a75cf952d43d@infradead.org>
In-Reply-To: <3da7cacf-d5ab-9f08-6d15-a75cf952d43d@infradead.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.54]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RGVhciBSYW5keToNCj4gW3Jlc2VuZGluZywgaGFkIHNvbWUga2luZCBvZiBlbWFpbCBlcnJvciBv
biB0aGUgZmlyc3QgdHJ5XQ0KPiANCj4gT24gMTEvNi8yMSA3OjIzIEFNLCBUb255IEh1YW5nIHdy
b3RlOg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L0tjb25maWcgYi9kcml2ZXJz
L21tYy9ob3N0L0tjb25maWcgaW5kZXgNCj4gPiBjY2MxNDhjLi4yYTc4Y2JjIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvS2NvbmZpZw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2hv
c3QvS2NvbmZpZw0KPiA+IEBAIC0xNCw2ICsxNCwxNSBAQCBjb25maWcgTU1DX0RFQlVHDQo+ID4g
ICAJICBhZGRlZCBob3N0IGRyaXZlcnMgcGxlYXNlIGRvbid0IGludmVudCB0aGVpciBwcml2YXRl
IG1hY3JvIGZvcg0KPiA+ICAgCSAgZGVidWdnaW5nLg0KPiA+DQo+ID4gK2NvbmZpZyBNTUNfU1VO
UExVUw0KPiA+ICsJdHJpc3RhdGUgIlN1bnBsdXMgU1A3MDIxIE1NQyBDb250cm9sbGVyIg0KPiA+
ICsJZGVwZW5kcyBvbiBBUkNIX1NVTlBMVVMgfHwgU09DX0kxNDMgfHwgU09DX1E2NDUNCj4gPiAr
CWRlZmF1bHQgeQ0KPiANCj4gSXMgdGhpcyBuZWVkZWQgdG8gYmUgYWJsZSB0byBib290PyAgVGhh
dCdzIGFib3V0IHRoZSBvbmx5IHJlYXNvbiB0aGF0ICJkZWZhdWx0DQo+IHkiIGNvdWxkIGJlIGp1
c3RpZmllZC4NCg0KWWVzLCBpdCBuZWVkcyB0byBiZSBhYmxlIHRvIGJlIGJvb3QuDQoNCj4gDQo+
ID4gKwloZWxwDQo+ID4gKwkJSWYgeW91IHNheSB5ZXMgaGVyZSwgeW91IHdpbGwgZ2V0IHN1cHBv
cnQgZm9yIGVNTUMgaG9zdCBpbnRlcmZhY2UNCj4gPiArCQlvbiBzdW5wbHVzIFNvY3MuDQo+IA0K
PiAJCSAgIFN1bnBsdXMgU29Dcy4NCg0KSSB3aWxsIG1vZGlmeS4NCg0KPiANCj4gPiArCQlJZiB1
bnN1cmUsIHNheSBOLg0KPiA+ICsJCVN1bnBsdXMgIGVNTUMgSG9zdCBDb250cm9sbGVyIHY0LjUx
IHN1cHBvcnQiDQo+IA0KPiBXaGF0IGlzIHRoYXQgbGFzdCBsaW5lIGZvcj8NCg0KSSB3aWxsIHJl
bW92ZSBsYXN0IGxpbmUuDQoNCj4gDQo+IEFuZCBhbGwgbGluZXMgb2YgdGhlIGhlbHAgdGV4dCBz
aG91bGQgYmUgaW5kZW50ZWQgd2l0aCBvbmUgdGFiICsgMiBzcGFjZXMgcGVyDQo+IGNvZGluZy1z
dHlsZS5yc3QuDQoNCk9rLCBJIHVuZGVyc3RhbmQNCg0KPiANCj4gdGhhbmtzLg0KPiAtLQ0KPiB+
UmFuZHkNCg==
