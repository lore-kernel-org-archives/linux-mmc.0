Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A46BC433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 29 Dec 2021 03:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbhL2DgR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Dec 2021 22:36:17 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:33612 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbhL2DgP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Dec 2021 22:36:15 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1BT3aAciD022338, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1BT3aAciD022338
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 29 Dec 2021 11:36:10 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 29 Dec 2021 11:36:10 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 29 Dec 2021 11:36:09 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::1939:37f0:5383:397d]) by
 RTEXMBS01.realtek.com.tw ([fe80::1939:37f0:5383:397d%5]) with mapi id
 15.01.2308.015; Wed, 29 Dec 2021 11:36:09 +0800
From:   Ricky WU <ricky_wu@realtek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Julian Sikorski <belegdol@gmail.com>,
        Rui Feng <rui_feng@realsil.com.cn>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: nothing happens upon SD card insertion (Asus Zenbook UM425IA, RTS522A)
Thread-Topic: nothing happens upon SD card insertion (Asus Zenbook UM425IA,
 RTS522A)
Thread-Index: AQHX/A1lOxopDN1LD0yNNDh1U/v7f6xI0Gow
Date:   Wed, 29 Dec 2021 03:36:09 +0000
Message-ID: <1355e2bb760448268571554441a51748@realtek.com>
References: <sq6sp6$cs9$1@ciao.gmane.io>
 <CAPDyKFon=yS81Nxyx30s4sgtMT8VdurRNOCSzM3pzZTWTBThyw@mail.gmail.com>
In-Reply-To: <CAPDyKFon=yS81Nxyx30s4sgtMT8VdurRNOCSzM3pzZTWTBThyw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.88.113]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzEyLzI5IOS4iuWNiCAwMTo1MTowMA==?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgSnVsaWFu77yMDQoNCldlIGNhbid0IHJlcHJvZHVjZSB0aGlzIGlzc3VlIG9uIG91ciBzaWRl
DQpDYW4geW91IGNoZWNrIHlvdXIgc29ja2V0IGlzIHdlbGwgYW5kIHByaW50IG1vcmUgZHJpdmVy
IGRlYnVnIG1lc3NhZ2U/DQoNCkJSLA0KUmlja3kNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6
IFdlZG5lc2RheSwgRGVjZW1iZXIgMjksIDIwMjEgMTowNyBBTQ0KPiBUbzogSnVsaWFuIFNpa29y
c2tpIDxiZWxlZ2RvbEBnbWFpbC5jb20+OyBSaWNreSBXVSA8cmlja3lfd3VAcmVhbHRlay5jb20+
Ow0KPiBSdWkgRmVuZyA8cnVpX2ZlbmdAcmVhbHNpbC5jb20uY24+DQo+IENjOiBsaW51eC1tbWNA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBub3RoaW5nIGhhcHBlbnMgdXBvbiBTRCBj
YXJkIGluc2VydGlvbiAoQXN1cyBaZW5ib29rIFVNNDI1SUEsDQo+IFJUUzUyMkEpDQo+IA0KPiAr
IFJpY2t5IGFuZCBSdWksDQo+IA0KPiBPbiBTYXQsIDI1IERlYyAyMDIxIGF0IDExOjUwLCBKdWxp
YW4gU2lrb3Jza2kgPGJlbGVnZG9sQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBIZWxsbywN
Cj4gPg0KPiA+IEkgaGF2ZSBhbiBBc3VzIFplbmJvb2sgVU00MjVJQSBsYXB0b3Agd2l0aCBSZWFs
dGVrIFJUUzUyMkEgY2FyZCByZWFkZXI6DQo+ID4NCj4gPiAwMjowMC4wIFVuYXNzaWduZWQgY2xh
c3MgW2ZmMDBdOiBSZWFsdGVrIFNlbWljb25kdWN0b3IgQ28uLCBMdGQuDQo+ID4gUlRTNTIyQSBQ
Q0kgRXhwcmVzcyBDYXJkIFJlYWRlciAocmV2IDAxKQ0KPiANCj4gSGkgSnVsaWFuLA0KPiANCj4g
SSBhc3N1bWUgdGhhdCBtZWFucyB5b3UgYXJlIHVzaW5nIHRoZQ0KPiBkcml2ZXJzL21tYy9ob3N0
L3J0c3hfcGNpX3NkbW1jLmMuIFNvLCBJIGhhdmUgbG9vcGVkIGluIHNvbWUgb2YgdGhlIG1haW4N
Cj4gYXV0aG9ycyB0byB0aGlzIG1tYy9zZCBkcml2ZXIuIExldCdzIHNlZSBpZiB0aGV5IGNhbiBo
ZWxwIGluIHNvbWUgd2F5Lg0KPiANCj4gS2luZCByZWdhcmRzDQo+IFVmZmUNCj4gDQo+ID4NCj4g
Pg0KPiA+IEFsbW9zdCBldmVyeSB0aW1lIHdoZW4gSSBpbnNlcnQgYSBjYXJkIGludG8gaXQsIG5v
dGhpbmcgaGFwcGVucyAtIG5vDQo+ID4gZG1lc2cgbWVzc2FnZSBvciBhbnl0aGluZy4NCj4gPg0K
PiA+IGVjaG8gMSB8IHN1ZG8gdGVlIC1hIC9zeXMva2VybmVsL2RlYnVnL3RyYWNpbmcvZXZlbnRz
L21tYy9lbmFibGUNCj4gPg0KPiA+IHN1ZG8gY2F0IC9zeXMva2VybmVsL2RlYnVnL3RyYWNpbmcv
dHJhY2VfcGlwZSA+IG1tY190cmFjZS50eHQNCj4gPg0KPiA+IGFsc28gcmVzdWx0cyBpbiBhbiBl
bXB0eSBmaWxlLiBJZiBJIGFtIGx1Y2t5LCB0aGUgY2FyZCB3aWxsIGJlDQo+ID4gZGV0ZWN0ZWQg
YWZ0ZXIgc29tZSBkZWxheSBhbmQgdGhlIGZvbGxvd2luZyB3aWxsIGFwcGVhciBpbiB0aGUgbG9n
Og0KPiA+DQo+ID4gRGV6IDI1IDExOjM0OjQxIHNub3diYWxsMyBrZXJuZWw6IG1tYzA6IGNhbm5v
dCB2ZXJpZnkgc2lnbmFsIHZvbHRhZ2UNCj4gPiBzd2l0Y2gNCj4gPg0KPiA+IERleiAyNSAxMToz
NDo0MSBzbm93YmFsbDMga2VybmVsOiBtbWMwOiBuZXcgdWx0cmEgaGlnaCBzcGVlZCBTRFI1MA0K
PiA+IFNESEMgY2FyZCBhdCBhZGRyZXNzIGFhYWENCj4gPg0KPiA+IERleiAyNSAxMTozNDo0MSBz
bm93YmFsbDMga2VybmVsOiBtbWNibGswOiBtbWMwOmFhYWEgU0wzMkcgMjkuNyBHaUINCj4gPg0K
PiA+IERleiAyNSAxMTozNDo0MSBzbm93YmFsbDMga2VybmVsOiAgbW1jYmxrMDogcDENCj4gPg0K
PiA+DQo+ID4gSG93IGNhbiBJIGludmVzdGlnYXRlIHRoaXMgZnVydGhlcj8gQXMgdGhpbmdzIHN0
YW5kIG5vdywgdGhlIHJlYWRlciBpcw0KPiA+IGFsbW9zdCB1bnVzYWJsZS4gSSBhbSB1c2luZyA1
LjE1LjExLTIwMC5zMGl4MDEuZmMzNS54ODZfNjQga2VybmVsLg0KPiA+IFRoYW5rIHlvdSBpbiBh
ZHZhbmNlLg0KPiA+DQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+IEp1bGlhbg0KPiA+DQo+IC0tLS0t
LVBsZWFzZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50aW5nIHRoaXMgZS1t
YWlsLg0K
