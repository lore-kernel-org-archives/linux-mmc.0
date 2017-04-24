From: Bough Chen <haibo.chen@nxp.com>
Subject: RE: [PATCH] mmc: debugfs: add runtime pm when cat ios or clock file
 node
Date: Mon, 24 Apr 2017 09:06:28 +0000
Message-ID: <AM4PR0401MB2324F931188A9FA2A144623D901F0@AM4PR0401MB2324.eurprd04.prod.outlook.com>
References: <1493017393-13785-1-git-send-email-haibo.chen@nxp.com>
 <d3a75424-1ae6-cbc6-ca1e-72a2768bf2ad@intel.com>
 <CAPDyKFpgVCX3+Xz=1264m2bL9=GOndzfY3N=21y8tErbWuv6pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve1eur01on0075.outbound.protection.outlook.com ([104.47.1.75]:7392
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1167405AbdDXJGd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Apr 2017 05:06:33 -0400
In-Reply-To: <CAPDyKFpgVCX3+Xz=1264m2bL9=GOndzfY3N=21y8tErbWuv6pw@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "A.S. Dong" <aisheng.dong@nxp.com>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVbGYgSGFuc3NvbiBbbWFpbHRv
OnVsZi5oYW5zc29uQGxpbmFyby5vcmddDQo+IFNlbnQ6IE1vbmRheSwgQXByaWwgMjQsIDIwMTcg
NDoxMiBQTQ0KPiBUbzogQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBC
b3VnaCBDaGVuDQo+IDxoYWliby5jaGVuQG54cC5jb20+DQo+IENjOiBsaW51eC1tbWNAdmdlci5r
ZXJuZWwub3JnOyBBLlMuIERvbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIXSBtbWM6IGRlYnVnZnM6IGFkZCBydW50aW1lIHBtIHdoZW4gY2F0IGlvcyBvciBj
bG9jayBmaWxlDQo+IG5vZGUNCj4gDQo+IE9uIDI0IEFwcmlsIDIwMTcgYXQgMDk6MTYsIEFkcmlh
biBIdW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPiB3cm90ZToNCj4gPiBPbiAyNC8wNC8x
NyAxMDowMywgSGFpYm8gQ2hlbiB3cm90ZToNCj4gPj4gTU1DIGNvcmUgY29kZSBhZGQgJ01NQ19D
QVBfUlVOVElNRV9SRVNVTUUnLCBwb3N0cG9uZSB0aGUgcmVhbA0KPiBjYXJkDQo+ID4+IHJlc3Vt
ZSBvcGVyYXRpb24gZnJvbSBidXNfcmVzdW1lIHRvIGJ1c19ydW50aW1lX3Jlc3VtZS4gU28gYWZ0
ZXINCj4gPj4gc3lzdGVtIHJlc3VtZSwgZm9yIG5vbi1yZW1vdmFibGUtY2FyZCwgaXQgc3RpbGwg
bm90IHJlYWxseSByZXN1bWUuDQo+ID4+IEF0IHRoaXMgcG9pbnQsIGlmIHVzZXIgY2F0IHRoZSBp
b3Mgb3IgY2xvY2sgbm9kZSwgb25seSBjYW4gZ2V0IHplcm8NCj4gPj4gZGF0YSBhbHRob3VnaCB0
aGUgbW1jL3NkIGNhcmQgaXMgc3RpbGwgcHJlc2VudC4NCj4gPg0KPiA+IElmIHlvdSBhc2sgbWUs
IGdldHRpbmcgemVybyBpcyBjb3JyZWN0Lg0KPiANCj4gSSBmdWxseSBhZ3JlZSENCj4gDQo+IFRo
ZSBqb2IgZm9yIHRoZSBkZWJ1Z2ZzIGlvcyBub2RlLCBpcyB0byByZXBvcnQgdGhlIGN1cnJlbnQg
c3RhdGUsIG5vdCB0byBjaGFuZ2UgaXQuDQoNCkdvdCBpdC4gIA0KDQpJIGhhdmUgb25lIG1vcmUg
cXVlc3Rpb246IHRha2Ugc2RoY2kgYW5kIHNkaGNpLWVzZGhjLWlteCBhcyBleGFtcGxlLCBpZiBj
b250cm9sbGVyIGluIHJ1bnRpbWUgc3VzcGVuZCwgIHRoZW4gY2F0IHRoZSBpb3MsIHdlIHdpbGwg
c2VlIHRoZSB2YWx1ZSBpbmNsdWRpbmcgY2xvY2ssIGJ1dCBpbiBzZGhjaS1lc2RoYy1pbXgsIHdl
IGFscmVhZHkgZGlzYWJsZSB0aGUgdXNkaGMgY2xvY2sgaW4gcnVudGltZSBzdXNwZW5kLCB0aGUg
dHdvIGFyZSBub3QgbWF0Y2gsIEknbSBjb25mdXNlZCBvZiB0aGlzLg0KDQpCUg0KSGFpYm8NCj4g
DQo+IFsuLi5dDQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0K
