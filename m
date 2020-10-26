Return-Path: <SRS0=obPU=EB=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580A0C2D0A3
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Oct 2020 08:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0735223AE
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Oct 2020 08:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1769610AbgJZIWz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 26 Oct 2020 04:22:55 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:35123 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1769480AbgJZIWz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Oct 2020 04:22:55 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 09Q8MXDc8027970, This message is accepted by code: ctloc85258
Received: from RSEXMBS01.realsil.com.cn ([172.29.17.195])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 09Q8MXDc8027970
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 26 Oct 2020 16:22:34 +0800
Received: from RSEXMBS02.realsil.com.cn (172.29.17.196) by
 RSEXMBS01.realsil.com.cn (172.29.17.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Mon, 26 Oct 2020 16:22:33 +0800
Received: from RSEXMBS02.realsil.com.cn ([fe80::f8fc:93be:88f4:52ef]) by
 RSEXMBS02.realsil.com.cn ([fe80::f8fc:93be:88f4:52ef%7]) with mapi id
 15.01.2044.004; Mon, 26 Oct 2020 16:22:33 +0800
From:   =?utf-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Christoph Hellwig <hch@lst.de>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggMy8zXSBtbWM6IHJ0c3g6IEFkZCBTRCBFeHByZXNz?= =?utf-8?Q?_mode_support_for_RTS5261?=
Thread-Topic: [PATCH 3/3] mmc: rtsx: Add SD Express mode support for RTS5261
Thread-Index: AQHWkt9BwBVjFlHHd0at7hFkgpI9BamhuQuAgAGMm/CAATQjgIAAlwdA
Date:   Mon, 26 Oct 2020 08:22:33 +0000
Message-ID: <ba3c68fea4614434838a0a8cbc0e892a@realsil.com.cn>
References: <1600999061-13669-1-git-send-email-rui_feng@realsil.com.cn>
 <CAPDyKFrnkF3mU5PJsy0VtEjPSToktSsRRtyMvQF97vymc+rY5A@mail.gmail.com>
 <dd210290eef6467cbffca8cbaddb8b84@realsil.com.cn>
 <CAPDyKFqwsJaYrXMVabR7qui6yqr4FAHfYq1ghfsf0HtRSZpGGw@mail.gmail.com>
In-Reply-To: <CAPDyKFqwsJaYrXMVabR7qui6yqr4FAHfYq1ghfsf0HtRSZpGGw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.29.40.150]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiANCj4gKyBDaHJpc3RvcGggKHRvIGhlbHAgdXMgdW5kZXJzdGFuZCBpZiBQQ0llL05WTWUgZGV2
aWNlcyBjYW4gYmUgbWFya2VkDQo+ICsgcmVhZC1vbmx5KQ0KPiANCj4gT24gVGh1LCAyMiBPY3Qg
MjAyMCBhdCAwODowNCwg5Yav6ZSQIDxydWlfZmVuZ0ByZWFsc2lsLmNvbS5jbj4gd3JvdGU6DQo+
ID4NCj4gPiA+DQo+ID4gPiBPbiBGcmksIDI1IFNlcCAyMDIwIGF0IDAzOjU3LCA8cnVpX2ZlbmdA
cmVhbHNpbC5jb20uY24+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBGcm9tOiBSdWkgRmVuZyA8
cnVpX2ZlbmdAcmVhbHNpbC5jb20uY24+DQo+ID4gPiA+DQo+ID4gPiA+IFJUUzUyNjEgc3VwcG9y
dCBsZWdhY3kgU0QgbW9kZSBhbmQgU0QgRXhwcmVzcyBtb2RlLg0KPiA+ID4gPiBJbiBTRDcueCwg
U0QgYXNzb2NpYXRpb24gaW50cm9kdWNlIFNEIEV4cHJlc3MgYXMgYSBuZXcgbW9kZS4NCj4gPiA+
ID4gVGhpcyBwYXRjaCBtYWtlcyBSVFM1MjYxIHN1cHBvcnQgU0QgRXhwcmVzcyBtb2RlLg0KPiA+
ID4NCj4gPiA+IEFzIHBlciBwYXRjaCAyLCBjYW4geW91IHBsZWFzZSBhZGQgc29tZSBtb3JlIGlu
Zm9ybWF0aW9uIGFib3V0IHdoYXQNCj4gPiA+IGNoYW5nZXMgYXJlIG5lZWRlZCB0byBzdXBwb3J0
IFNEIEV4cHJlc3M/IFRoaXMganVzdCBzdGF0ZXMgdGhhdCB0aGUNCj4gPiA+IHN1cHBvcnQgaXMg
aW1wbGVtZW50ZWQsIGJ1dCBwbGVhc2UgZWxhYm9yYXRlIGhvdy4NCj4gPiA+DQo+ID4gPiA+DQo+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFJ1aSBGZW5nIDxydWlfZmVuZ0ByZWFsc2lsLmNvbS5jbj4N
Cj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL21tYy9ob3N0L3J0c3hfcGNpX3NkbW1jLmMg
fCA1OQ0KPiA+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ICAx
IGZpbGUgY2hhbmdlZCwgNTkgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tbWMvaG9zdC9ydHN4X3BjaV9zZG1tYy5jDQo+ID4gPiA+IGIvZHJpdmVy
cy9tbWMvaG9zdC9ydHN4X3BjaV9zZG1tYy5jDQo+ID4gPiA+IGluZGV4IDI3NjNhMzc2YjA1NC4u
ZWZkZTM3NGE0YTVlIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3J0c3hf
cGNpX3NkbW1jLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9ydHN4X3BjaV9zZG1t
Yy5jDQo+ID4gPiA+IEBAIC04OTUsNyArODk1LDkgQEAgc3RhdGljIGludCBzZF9zZXRfYnVzX3dp
ZHRoKHN0cnVjdA0KPiA+ID4gPiByZWFsdGVrX3BjaV9zZG1tYyAqaG9zdCwgIHN0YXRpYyBpbnQg
c2RfcG93ZXJfb24oc3RydWN0DQo+ID4gPiA+IHJlYWx0ZWtfcGNpX3NkbW1jICpob3N0KSAgew0K
PiA+ID4gPiAgICAgICAgIHN0cnVjdCBydHN4X3BjciAqcGNyID0gaG9zdC0+cGNyOw0KPiA+ID4g
PiArICAgICAgIHN0cnVjdCBtbWNfaG9zdCAqbW1jID0gaG9zdC0+bW1jOw0KPiA+ID4gPiAgICAg
ICAgIGludCBlcnI7DQo+ID4gPiA+ICsgICAgICAgdTMyIHZhbDsNCj4gPiA+ID4NCj4gPiA+ID4g
ICAgICAgICBpZiAoaG9zdC0+cG93ZXJfc3RhdGUgPT0gU0RNTUNfUE9XRVJfT04pDQo+ID4gPiA+
ICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gPiA+ID4gQEAgLTkyMiw2ICs5MjQsMTQgQEAg
c3RhdGljIGludCBzZF9wb3dlcl9vbihzdHJ1Y3QNCj4gPiA+ID4gcmVhbHRla19wY2lfc2RtbWMN
Cj4gPiA+ICpob3N0KQ0KPiA+ID4gPiAgICAgICAgIGlmIChlcnIgPCAwKQ0KPiA+ID4gPiAgICAg
ICAgICAgICAgICAgcmV0dXJuIGVycjsNCj4gPiA+ID4NCj4gPiA+ID4gKyAgICAgICBpZiAoUENJ
X1BJRChwY3IpID09IFBJRF81MjYxKSB7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICB2YWwgPSBy
dHN4X3BjaV9yZWFkbChwY3IsIFJUU1hfQklQUik7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICBp
ZiAodmFsICYgU0RfV1JJVEVfUFJPVEVDVCkgew0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgICBwY3ItPmV4dHJhX2NhcHMgJj0NCj4gPiA+IH5FWFRSQV9DQVBTX1NEX0VYUFJFU1M7DQo+
ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIG1tYy0+Y2FwczIgJj0gfihNTUNfQ0FQMl9T
RF9FWFAgfA0KPiA+ID4gPiArIE1NQ19DQVAyX1NEX0VYUF8xXzJWKTsNCj4gPiA+DQo+ID4gPiBU
aGlzIGxvb2tzIGEgYml0IHdlaXJkIHRvIG1lLiBGb3IgYSB3cml0ZSBwcm90ZWN0ZWQgY2FyZCB5
b3Ugd2FudCB0bw0KPiA+ID4gZGlzYWJsZSB0aGUgU0RfRVhQUkVTUyBzdXBwb3J0LCByaWdodD8N
Cj4gPiA+DQo+ID4gUmlnaHQuIElmIGVuZCB1c2VyIGluc2VydCBhIHdyaXRlIHByb3RlY3RlZCBT
RCBleHByZXNzIGNhcmQsIEkgd2lsbCBkaXNhYmxlDQo+IFNEX0VYUFJFU1Mgc3VwcG9ydC4NCj4g
PiBJZiBob3N0IHN3aXRjaCB0byBTRCBFWFBSRVNTIG1vZGUsIHRoZSBjYXJkIHdpbGwgYmUgcmVj
b2duaXplZCBhcyBhDQo+ID4gd3JpdGFibGUgUENJZS9OVk1lIGRldmljZSwgSSB0aGluayB0aGlz
IGlzIG5vdCBlbmQgdXNlcidzIHB1cnBvc2UuDQo+IA0KPiBIbW0uDQo+IA0KPiBGYWxsaW5nIGJh
Y2sgdG8gdXNlIHRoZSBsZWdhY3kgU0QgaW50ZXJmYWNlIGlzIHByb2JhYmx5IG5vdCB3aGF0IHRo
ZSB1c2VyDQo+IGV4cGVjdHMgZWl0aGVyLg0KPiANCj4gTm90ZSB0aGF0IHRoZSBwaHlzaWNhbCB3
cml0ZSBwcm90ZWN0IHN3aXRjaC9waW4gaXNuJ3QgbWFuZGF0b3J5IHRvIHN1cHBvcnQgYW5kDQo+
IGl0IGRvZXNuJ3QgZXZlbiBleGlzdCBmb3IgYWxsIGZvcm1hdHMgb2YgU0QgY2FyZHMuIEluIHRo
ZSBtbWMgY29yZSwgd2UgYXJlDQo+IGRlZmF1bHRpbmcgdG8gbWFrZSB0aGUgY2FyZCB3cml0ZSBl
bmFibGVkLCBpZiB0aGUgc3dpdGNoIGlzbid0IHN1cHBvcnRlZCBieSB0aGUNCj4gaG9zdCBkcml2
ZXIuIEFkZGl0aW9uYWxseSwgbm90aGluZyBwcmV2ZW50cyB0aGUgZW5kIHVzZXIgZnJvbSBtb3Vu
dGluZyB0aGUNCj4gZmlsZXN5c3RlbSBpbiByZWFkLW9ubHkgbW9kZSwgaWYgdGhhdCBpcyBwcmVm
ZXJyZWQuDQo+IA0KPiA+DQo+ID4gPiBJcyB0aGVyZSBubyBtZWNoYW5pc20gdG8gc3VwcG9ydCBy
ZWFkLW9ubHkgUENJZS9OVk1lIGJhc2VkIHN0b3JhZ2UNCj4gZGV2aWNlcz8NCj4gPiA+IElmIHRo
YXQgaXMgdGhlIGNhc2UsIG1heWJlIGl0J3Mgc2ltcGx5IGJldHRlciB0byBub3Qgc3VwcG9ydCB0
aGUNCj4gPiA+IHJlYWRvbmx5IG9wdGlvbiBhdCBhbGwgZm9yIFNEIGV4cHJlc3MgY2FyZHM/DQo+
ID4gPg0KPiA+IEkgdGhpbmsgdGhlcmUncyBubyBtZWNoYW5pc20gdG8gc3VwcG9ydCByZWFkLW9u
bHkgUENJZS9OVk1lIGJhc2VkIHN0b3JhZ2UNCj4gZGV2aWNlcy4NCj4gDQo+IEkgaGF2ZSBsb29w
ZWQgaW4gQ2hyaXN0b3BoLCBtYXliZSBoZSBjYW4gZ2l2ZSB1cyBoaXMgb3BpbmlvbiBvbiB0aGlz
Lg0KPiANCj4gPiBCdXQgZGlmZmVyZW50IHZlbmRlcnMgbWF5IGhhdmUgZGlmZmVyZW50IG9waW5p
b25zLiBUaGlzIGlzIG9ubHkgUmVhbHRlaydzDQo+IG9waW5pb24uDQo+IA0KPiBJIHVuZGVyc3Rh
bmQuIEhvd2V2ZXIsIHRoZSBtb3N0IGltcG9ydGFudCBwb2ludCBmb3IgbWUsIGlzIHRoYXQgd2Ug
ZG9uJ3QgZW5kDQo+IHVwIGluIGEgc2l0dWF0aW9uIHdoZXJlIGVhY2ggbW1jIGhvc3QgaGFuZGxl
cyB0aGlzIGRpZmZlcmVudGx5LiBXZSBzaG91bGQgc3RyaXZlDQo+IHRvd2FyZHMgYSBjb25zaXN0
ZW50IGJlaGF2aW9yLg0KPiANCj4gQXQgdGhpcyBwb2ludCBJIHRlbmQgdG8gcHJlZmVyIHRvIGRl
ZmF1bHQgdG8gaWdub3JlIHRoZSB3cml0ZSBwcm90ZWN0IHN3aXRjaCBmb3IgU0QNCj4gZXhwcmVz
cywgdW5sZXNzIHdlIGNhbiBmaW5kIGEgd2F5IHRvIHByb3Blcmx5IHN1cHBvcnQgaXQuDQo+IA0K
Rm9yIGluZm9ybWF0aW9uIHNlY3VyaXR5IHB1cnBvc2UsIHNvbWUgY29tcGFuaWVzIG9yIGJ1c2lu
ZXNzIHVzZXJzIHNldCB0aGVpciBub3RlYm9vayBTRCBhcyAicmVhZCBvbmx5Ii4NCkJlY2F1c2Ug
YSBsb3Qgb2YgInJlYWQgb25seSIgcmVxdWlyZW1lbnRzIGZyb20gdGhvc2UgY29tcGFuaWVzIG9y
IGJ1c2luZXNzIHVzZXJzLCBub3RlYm9vayB2ZW5kb3IgY29udHJvbHMgcmVhZGVyIHdyaXRlIHBy
b3RlY3QgcGluIHRvIGFjaGlldmUgaXQuDQpOb3RlYm9vayBCSU9TIG1pZ2h0IGhhdmUgb3B0aW9u
IHRvIGNob29zZSAicmVhZCBvbmx5IiBvciBub3QuDQpUaGlzIGlzIHdoeSB3ZSB0aGluayB3cml0
ZSBwcm90ZWN0IGlzIG1vcmUgaW1wb3J0YW50IHRoYW4gc3BlZWQuDQpJZiB5b3UgcHJlZmVyIHRv
IGNvbnNpc3RlbnQgYmVoYXZpb3IsIEkgY2FuIGlnbm9yZSB0aGUgd3JpdGUgcHJvdGVjdCBzd2l0
Y2ggZm9yIFNEIGV4cHJlc3MuDQoNCj4gDQo+IEZyb20gdGhpcywgSSBhc3N1bWUgdGhhdCBteSBp
bnRlcnByZXRhdGlvbnMgb2YgdGhlIGJlaGF2aW9yIHdhcyBjb3JyZWN0Lg0KPiANCj4gQWx0aG91
Z2gsIGNhbiB5b3UgcGxlYXNlIGVsYWJvcmF0ZSBvbiB3aGF0IHlvdSBtZWFuIGJ5IHRoYXQgaXQg
d2lsbCAibm90DQo+IHdvcmsiPw0KPiANCj4gRG8geW91IG1lYW4gdGhhdCBydHN4X3BjaV9jYXJk
X2V4Y2x1c2l2ZV9jaGVjaygpIHRoYXQgaXMgY2FsbGVkIGVhcmx5IGluDQo+IHNkbW1jX3NldF9p
b3MoKSB3aWxsIGZhaWwgYW5kIHRoZW4gbWFrZSBpdCBiYWlsIG91dD8gVGhlbiwgY291bGQgeW91
IHBsZWFzZSBhZGQNCj4gYSBjb21tZW50IGFib3V0IHRoYXQgaW4gdGhlIGNvZGU/DQo+IA0KSW4g
aW5pdF9zZF9leHByZXNzKCkgZHJpdmVyIHNldHMgMHhGRjU0IGJpdDA9MSBhbmQgMHhGRjU1IGJp
dDQ9MCwgdGhlbiBSVFM1MjYxIHdpbGwgc3dpdGNoIE1DVSBhbmQgZW50ZXIgU0QgRVhQUkVTUyBt
b2RlLg0KQWZ0ZXIgdGhhdCBSVFM1MjYxIGNhbid0IHJlY2VpdmUgYW55IENNRCBmcm9tIFBDSWUs
IHNvIG1tY19wb3dlcl9vZmYoKSB3aWxsIG5vdCB3b3JrLg0KDQo+IEtpbmQgcmVnYXJkcw0KPiBV
ZmZlDQo+IA0KPiAtLS0tLS1QbGVhc2UgY29uc2lkZXIgdGhlIGVudmlyb25tZW50IGJlZm9yZSBw
cmludGluZyB0aGlzIGUtbWFpbC4NCg==
