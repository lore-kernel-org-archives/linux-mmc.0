Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03227C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 10:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B07B822B4B
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 10:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbhAMKVc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 05:21:32 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:52241 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbhAMKVb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 05:21:31 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 10DAKhN72023201, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs03.realtek.com.tw[172.21.6.96])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 10DAKhN72023201
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Jan 2021 18:20:43 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 13 Jan 2021 18:20:42 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::5d07:e256:a2a2:81ee]) by
 RTEXMBS01.realtek.com.tw ([fe80::5d07:e256:a2a2:81ee%5]) with mapi id
 15.01.2106.006; Wed, 13 Jan 2021 18:20:42 +0800
From:   =?utf-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rui Feng <rui_feng@realsil.com.cn>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] mmc: rtsx: add delay before power on
Thread-Topic: [PATCH 1/2] mmc: rtsx: add delay before power on
Thread-Index: AQHW3oq7dTZYnibKgUy6H8tXIkxRlaok4hsAgACICwA=
Date:   Wed, 13 Jan 2021 10:20:42 +0000
Message-ID: <d71300e7cf6d4ad8b1e8e3c7430d2c58@realtek.com>
References: <20201230090401.12627-1-ricky_wu@realtek.com>
 <CAPDyKFro-dWCOVx=a1BhEJ=J=Hj_+nU+FmTUZjkeAkCqtML=kA@mail.gmail.com>
In-Reply-To: <CAPDyKFro-dWCOVx=a1BhEJ=J=Hj_+nU+FmTUZjkeAkCqtML=kA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.88.99]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiBPbiBXZWQsIDMwIERlYyAyMDIwIGF0IDEwOjA0LCA8cmlja3lfd3VAcmVhbHRlay5jb20+IHdy
b3RlOg0KPiA+DQo+ID4gRnJvbTogUmlja3kgV3UgPHJpY2t5X3d1QHJlYWx0ZWsuY29tPg0KPiA+
DQo+ID4gTWFrZSBzdXJlIHZvbHRhZ2UgYmVsb3cgMC41ViBiZWZvcmUgcG93ZXIgb24gd2hlbiBk
byBwb3dlciBjeWNsZQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmlja3kgV3UgPHJpY2t5X3d1
QHJlYWx0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9ob3N0L3J0c3hfcGNpX3Nk
bW1jLmMgfCAyICsrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3J0c3hfcGNpX3NkbW1jLmMNCj4gPiBi
L2RyaXZlcnMvbW1jL2hvc3QvcnRzeF9wY2lfc2RtbWMuYw0KPiA+IGluZGV4IGU2ZjViYmNlNTY4
NS4uZDIxYjk5OTYyYjM2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvcnRzeF9w
Y2lfc2RtbWMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3QvcnRzeF9wY2lfc2RtbWMuYw0K
PiA+IEBAIC05MDYsNiArOTA2LDggQEAgc3RhdGljIGludCBzZF9wb3dlcl9vbihzdHJ1Y3QgcmVh
bHRla19wY2lfc2RtbWMNCj4gKmhvc3QpDQo+ID4gICAgICAgICBpZiAoaG9zdC0+cG93ZXJfc3Rh
dGUgPT0gU0RNTUNfUE9XRVJfT04pDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+
DQo+ID4gKyAgICAgICBtZGVsYXkoMTAwKTsNCj4gPiArDQo+IA0KPiBXaHkgZXhhY3RseSAxMDAg
bXM/IENhbiB5b3UgYXQgbGVhc3QgYWRkIGEgY29tbWVudCBhYm91dCB3aHkgaW4gdGhlIGNvZGU/
DQo+IA0KPiBNb3Jlb3ZlciwgSSB0aGluayB5b3Ugc2hvdWxkIGNvbnZlcnQgdG8gdXNlIG1zbGVl
cCgpIHJhdGhlciB0aGFuIG1kZWxheS4NCj4gDQoNCkJlY2F1c2Ugd2UgbmVlZCB0byBtYWtlIHN1
cmUgdm9sdGFnZSBiZWxvdyAwLjVWIGJlZm9yZSBwb3dlciBvbg0KbW1jLWNvcmUgd2lsbCBkbyBx
dWlja2x5IHBvd2VyIGN5Y2xlIGF0IHJlY29nbml0aW9uIGNhcmQgcGhhc2UsIA0Kd2UgbmVlZCBh
dCBsZWFzdCAxMDBtcyB0byBtYWtlIG91ciBkZXZpY2Ugdm9sdGFnZSBiZWxvdyAwLjVWIA0KDQpJ
IHdpbGwgY2hhbmdlIG1kZWxheSgpIHRvIG1zbGVlcCgpDQoNCj4gPiAgICAgICAgIHJ0c3hfcGNp
X2luaXRfY21kKHBjcik7DQo+ID4gICAgICAgICBydHN4X3BjaV9hZGRfY21kKHBjciwgV1JJVEVf
UkVHX0NNRCwgQ0FSRF9TRUxFQ1QsIDB4MDcsDQo+IFNEX01PRF9TRUwpOw0KPiA+ICAgICAgICAg
cnRzeF9wY2lfYWRkX2NtZChwY3IsIFdSSVRFX1JFR19DTUQsIENBUkRfU0hBUkVfTU9ERSwNCj4g
PiAtLQ0KPiA+IDIuMTcuMQ0KPiA+DQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0KPiANCj4g
LS0tLS0tUGxlYXNlIGNvbnNpZGVyIHRoZSBlbnZpcm9ubWVudCBiZWZvcmUgcHJpbnRpbmcgdGhp
cyBlLW1haWwuDQo=
