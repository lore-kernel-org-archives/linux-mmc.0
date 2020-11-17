Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B39C388F9
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 02:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4497924699
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 02:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbgKQCJ1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Nov 2020 21:09:27 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:59062 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgKQCJ1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Nov 2020 21:09:27 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AH297r44021635, This message is accepted by code: ctloc85258
Received: from RSEXMBS02.realsil.com.cn ([172.29.17.196])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AH297r44021635
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 17 Nov 2020 10:09:08 +0800
Received: from RSEXMBS02.realsil.com.cn (172.29.17.196) by
 RSEXMBS02.realsil.com.cn (172.29.17.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Tue, 17 Nov 2020 10:09:07 +0800
Received: from RSEXMBS02.realsil.com.cn ([fe80::f8fc:93be:88f4:52ef]) by
 RSEXMBS02.realsil.com.cn ([fe80::f8fc:93be:88f4:52ef%7]) with mapi id
 15.01.2044.004; Tue, 17 Nov 2020 10:09:07 +0800
From:   =?utf-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>
To:     Christoph Hellwig <hch@lst.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH 3/3] mmc: rtsx: Add SD Express mode support for RTS5261
Thread-Topic: [PATCH 3/3] mmc: rtsx: Add SD Express mode support for RTS5261
Thread-Index: AQHWkt9BwBVjFlHHd0at7hFkgpI9BamhuQuAgAGMm/CAATQjgIAAFBUAgAAxyYCAH7oJgIAHZ2Vw
Date:   Tue, 17 Nov 2020 02:09:07 +0000
Message-ID: <cc6872ac36d14ddc928ee02acc434cae@realsil.com.cn>
References: <1600999061-13669-1-git-send-email-rui_feng@realsil.com.cn>
 <CAPDyKFrnkF3mU5PJsy0VtEjPSToktSsRRtyMvQF97vymc+rY5A@mail.gmail.com>
 <dd210290eef6467cbffca8cbaddb8b84@realsil.com.cn>
 <CAPDyKFqwsJaYrXMVabR7qui6yqr4FAHfYq1ghfsf0HtRSZpGGw@mail.gmail.com>
 <20201023091408.GA5201@lst.de>
 <CAPDyKFpgEcEv8FH59ntmeQADEyCs6aiS8P0tEaru858DRQup=A@mail.gmail.com>
 <20201112164213.GA16591@lst.de>
In-Reply-To: <20201112164213.GA16591@lst.de>
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENocmlzdG9waCBIZWxsd2ln
IFttYWlsdG86aGNoQGxzdC5kZV0NCj4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciAxMywgMjAyMCAx
Mjo0MiBBTQ0KPiBUbzogVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IENj
OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT47IOWGr+mUkCA8cnVpX2ZlbmdAcmVhbHNp
bC5jb20uY24+OyBBcm5kDQo+IEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPjsgR3JlZyBLcm9haC1I
YXJ0bWFuDQo+IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IExpbnV4IEtlcm5lbCBNYWls
aW5nIExpc3QNCj4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC1tbWNAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy8zXSBtbWM6IHJ0c3g6IEFkZCBT
RCBFeHByZXNzIG1vZGUgc3VwcG9ydCBmb3IgUlRTNTI2MQ0KPiANCj4gT24gRnJpLCBPY3QgMjMs
IDIwMjAgYXQgMDI6MTI6MTlQTSArMDIwMCwgVWxmIEhhbnNzb24gd3JvdGU6DQo+ID4gU0Qgc3Bl
YyBtZW50aW9ucyB0aGUgd3JpdGUtcHJvdGVjdCBzd2l0Y2ggb24gU0QgY2FyZHMsIHdoaWxlIHVT
RCBjYXJkcw0KPiA+IGRvZXNuJ3QgaGF2ZSBvbmUuIEluIGdlbmVyYWwsIGhvc3QgZHJpdmVycyBp
bXBsZW1lbnQgc3VwcG9ydCBmb3IgaXQNCj4gPiB2aWEgYSBkZWRpY2F0ZWQgR1BJTyBsaW5lIHJv
dXRlZCB0byBvbmUgb2YgdGhlIHBpbnMgaW4gdGhlIFNEIHNsb3QuDQo+ID4NCj4gPiBJbiB0aGlz
IFNEIGNvbnRyb2xsZXIgY2FzZSwgd2hpY2ggaXMgYmFzZWQgdXBvbiBQQ0ksIGl0IHdvcmtzIGEg
Yml0DQo+ID4gZGlmZmVyZW50bHksIGFzIHRoZSBzdGF0ZSBvZiB0aGUgd3JpdGUgcHJvdGVjdCBw
aW4gaXMgbWFuYWdlZCB0aHJvdWdoDQo+ID4gdGhlIFBDSSBpbnRlcmZhY2UuDQo+ID4NCj4gPiBJ
ZiBJIHVuZGVyc3RhbmQgeW91IGNvcnJlY3RseSwgeW91IGFyZSBzYXlpbmcgdGhhdCB0aGUgY29u
dHJvbGxlcg0KPiA+IHNob3VsZCBiZSBhYmxlIHRvIGNvbW11bmljYXRlICh1cHdhcmRzIHRvIHRo
ZSBibG9jayBsYXllcikgaXRzIGtub3duDQo+ID4gd3JpdGUgcHJvdGVjdCBzdGF0ZSBmb3IgdGhl
IGNvcnJlc3BvbmRpbmcgTlZNZSBkZXZpY2UsIGR1cmluZw0KPiA+IGluaXRpYWxpemF0aW9uPw0K
PiANCj4gSSBnb3QgYW4gYW5zd2VyIGZvcm0gYSBtZW1iZXIgb2YgdGhlIFNEIGNvbW1pdGVlLCBh
bmQgdGhlIGFuc3dlciBpczoNCj4gDQo+ICJUaGUgU0Qgc3BlY2lmaWNhdGlvbiBkZWZpbmUgdGhh
dCBjYXNlIHZlcnkgY2xlYXJseSBhcyBmb2xsb3dpbmcuDQo+IElmIGNhcmTigJlzIGFjY2VzcyBp
cyByZXN0cmljdGVkIHRocm91Z2ggb25lIG9mIHRoZSBTRCB1bmlxdWUgZmVhdHVyZXMg4oCTIFBT
V0QNCj4gTG9jay9VbmxvY2ssICBUZW1wb3Jhcnkgb3IgUGVybWFuZW50IFdQIChUV1Agb3IgUFdQ
KSBvciBDUFJNICB0aGVuIGlmDQo+IGFjY2VzcyBhdHRlbXB0IGlzIGRvbmUgdGhyb3VnaCBpdHMg
TlZNZSBpbnRlcmZhY2UgdGhlIGNhcmQgd2lsbCByZXN0cmljdCB0aGUNCj4gYWNjZXNzDQo+IGFu
ZCByZXNwb25kIHdpdGggQWNjZXNzIGRlbmllZC4gICAgVGhlIGFjY2VzcyByZXN0cmljdGlvbiBz
aGFsbCBiZSByZW1vdmVkDQo+IHRocm91Z2ggdGhlIFNEIHByb3RvY29sL2ludGVyZmFjZSBiZWZv
cmUgYmVpbmcgYWJsZSB0byBhY2Nlc3MgdGhlIGNhcmQgdGhyb3VnaA0KPiB0aGUgTlZNZS4NCj4g
VGhhdCBpcyBkZWZpbmVkIGFzIGZvbGxvd2luZyBpbiB0aGUgc2VjdGlvbiA4LjEuNiAgb2YgdGhl
IFNENy4wIG9ud2FyZC4iDQo+IA0KPiBOb3RlIHRoYXQgaWYgeW91IGxvb2sgYXQgdGhlIHNwZWMg
dGhpcyBtZWFucyBvbmx5IHJlamVjdGluZyBOVk1lIGNvbW1hbmRzDQo+IHRoYXQgd3JpdGUgZHRh
IGZvciB0aGUgd3JpdGUgcHJvdGVjdCBwaW4uDQo+IA0KWW91IG1heSBtaXN1bmRlcnN0YW5kIG15
IG1lYW5pbmcuIFRoZSAiV1AiIEkgbWVhbiBpcyB0aGUgIk1lY2hhbmljYWwgV3JpdGUgUHJvdGVj
dCBTd2l0Y2giIGFuZA0KaXQncyBkZWZpbmVkIGluIHNlY3Rpb24gNC4zLjYgb2YgVGhlIFNEIHNw
ZWNpZmljYXRpb24uIFRoZSAiV1AiIHlvdSBtZW50aW9uZWQgaXMgIkNhcmQgSW50ZXJuYWwgV3Jp
dGUgUHJvdGVjdCIuDQpUaGV5IGFyZSB0d28gZGlmZmVyZW50ICJXUCIuIEZvciAiTWVjaGFuaWNh
bCBXcml0ZSBQcm90ZWN0IFN3aXRjaCIgLCBUaGUgU0Qgc3BlY2lmaWNhdGlvbiBkZWZpbmUgYXMg
Zm9sbG93aW5nLg0KIkl0IGlzIHRoZSByZXNwb25zaWJpbGl0eSBvZiB0aGUgaG9zdCB0byBwcm90
ZWN0IHRoZSBjYXJkLiBUaGUgcG9zaXRpb24gb2YgdGhlIHdyaXRlIHByb3RlY3Qgc3dpdGNoIGlz
IHVua25vd24gdG8gdGhlDQpJbnRlcm5hbCBjaXJjdWl0cnkgb2YgdGhlIGNhcmQuIg0KU28gd2Ug
dXNlIGxlZ2FjeSBTRCBpbnRlcmZhY2UgdG8gaGFuZGxlIHRoZSBjYXJkIHdoaWNoIGlzICJXUCIg
YnkgIk1lY2hhbmljYWwgV3JpdGUgUHJvdGVjdCBTd2l0Y2giLg0K
