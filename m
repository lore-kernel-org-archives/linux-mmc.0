Return-Path: <SRS0=LU6H=7P=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6242CC433E0
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Jun 2020 07:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47317206A2
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Jun 2020 07:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgFBHNz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Jun 2020 03:13:55 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39560 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgFBHNz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Jun 2020 03:13:55 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 0527DSCS0001740, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 0527DSCS0001740
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 2 Jun 2020 15:13:28 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 2 Jun 2020 15:13:27 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 2 Jun 2020 15:13:27 +0800
Received: from RTEXMB01.realtek.com.tw ([fe80::d53a:d9a5:318:7cd8]) by
 RTEXMB01.realtek.com.tw ([fe80::d53a:d9a5:318:7cd8%5]) with mapi id
 15.01.1779.005; Tue, 2 Jun 2020 15:13:27 +0800
From:   =?utf-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>
To:     Philip Schwartz <philquadra@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Subject: RE: Bug in your kernel since version 5.2
Thread-Topic: Bug in your kernel since version 5.2
Thread-Index: AQHWOHWyfrvx4DwjCUuaFCjruHqHp6jD+PmAgADtNkA=
Date:   Tue, 2 Jun 2020 07:13:26 +0000
Message-ID: <cc342555d3b343d59a7824a7e20d0907@realtek.com>
References: <CACYmiSfM00o864c5pxxWEQNZsgFMkNwJePCGvae6P7o31NXMyw@mail.gmail.com>
 <0fc7c8c2-ac6a-2b66-074b-92b5d03219b6@infradead.org>
 <CACYmiSer8FA+qjh8NHZJ2maxSd-=RwDdZ2F7_-E4uM1NXuZ8gQ@mail.gmail.com>
In-Reply-To: <CACYmiSer8FA+qjh8NHZJ2maxSd-=RwDdZ2F7_-E4uM1NXuZ8gQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.88.99]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgUGhpbGlw77yMDQoNCldlIGNhbid0IHJlcHJvZHVjZSB0aGlzIHByb2JsZW0gb24gZ2VuZXJh
bCBwbGF0Zm9ybSBvbiBvdXIgc2lkZSwgaXQgd29ya3Mgd2VsbCBvbiBvdXIgcGxhdGZvcm1zIHRo
YXQgd2UgaGF2ZSwgDQpidXQgd2UgZG9u4oCZdCBoYXZlIE5VQzdQSllIIHBsYXRmb3JtIHRvIGNo
ZWNrIHRoaXMuDQoNClRoaXMgcGF0Y2ggKGJlZGUwM2E1NzliM2I0YTAzNjAwM2M0ODYyY2MxYmFh
NGRkYzM1MWYpIHNob3VsZCBub3QgYWZmZWN0IHJ0czUyMjksIHdlIGRpZG7igJl0IGRvIGFueXRo
aW5nIG9uIHJ0czUyMjkNCg0KUmlja3kgICAgDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogUGhpbGlwIFNjaHdhcnR6IFttYWlsdG86cGhpbHF1YWRyYUBnbWFpbC5jb21d
DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMDIsIDIwMjAgODo1MiBBTQ0KPiBUbzogUmFuZHkgRHVu
bGFwDQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyDlkLPmmIrmvoQgUmlja3k7
IEdyZWcgS3JvYWgtSGFydG1hbjsgVWxmDQo+IEhhbnNzb247IGxpbnV4LW1tYw0KPiBTdWJqZWN0
OiBSZTogQnVnIGluIHlvdXIga2VybmVsIHNpbmNlIHZlcnNpb24gNS4yDQo+IA0KPiBUaGFua3Ms
IEknbGwgY2hlY2sgaXQgb3V0Lg0KPiANCj4gT24gTW9uLCBKdW4gMSwgMjAyMCBhdCA3OjM1IFBN
IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPiB3cm90ZToNCj4gPg0KPiA+IFth
ZGRpbmcgQ2M6cyBhbmQgY29tbWVudHNdDQo+ID4NCj4gPg0KPiA+IE9uIDYvMS8yMCAzOjUyIFBN
LCBQaGlsaXAgU2Nod2FydHogd3JvdGU6DQo+ID4gPiBUaGlzIGlzIG15IHNpeHRoIGF0dGVtcHQg
dG8gc2VuZCBhIGJ1ZyByZXBvcnQuDQo+ID4gPg0KPiA+ID4gVGhlIGZpcnN0IHRpbWUgeW91IGRp
ZG4ndCBsaWtlIG15IGVtYWlsIGFkZHJlc3MuDQo+ID4gPiBUaGUgc2Vjb25kIHRpbWUgeW91IGRp
ZG4ndCBsaWtlIHRoYXQgSSBjb3BpZWQgdGhlIHdob2xlIHVybC4NCj4gPiA+IFRoZSB0aGlyZCB0
aW1lIHlvdSBkaWRuJ3QgbGlrZSB0aGF0IHRoZSBwYXJ0IG9mIHRoZSB1cmwgdGhhdCBJIGNvcGll
ZA0KPiA+ID4gbG9va2VkIGEgYml0IGxpa2UgYSB1cmwuDQo+ID4gPiBUaGUgZm91cnRoIHRpbWUg
eW91IGNvbXBsYWluZWQgdGhhdCAiVGhlIG1lc3NhZ2UgY29udGFpbnMgSFRNTA0KPiA+ID4gc3Vi
cGFydCx0aGVyZWZvcmUgd2UgY29uc2lkZXIgaXQgU1BBTSINCj4gPg0KPiA+IFllcy4NCj4gPg0K
PiA+ID4gVGhlIGZpZnRoIHRpbWUgeW91IGRpZG4ndCBsaWtlID8/Pz8/Pz8/Py4NCj4gPiA+DQo+
ID4gPiBLZXJuZWwgZG90IG9yZyBCdWd6aWxsYSAgICAgICBJIEQgZXF1YWxzICAyMDQwMDMNCj4g
PiA+DQo+ID4gPg0KPiA+ID4gSSBsb29rIGZvcndhcmQgdG8geW91ciBlbWFpbCByZWplY3Rpb24g
bWVzc2FnZS4NCj4gPg0KPiA+DQo+ID4gUGxlYXNlIHNlZSBodHRwczovL2J1Z3ppbGxhLmtlcm5l
bC5vcmcvc2hvd19idWcuY2dpP2lkPTIwNDAwMw0KPiA+DQo+ID4gU2V2ZXJhbCBwZW9wbGUgYXJl
IGhhdmluZyBwcm9ibGVtcyB3aXRoIEludGVsIE5VQ3MgYW5kL29yDQo+ID4gdGhlIFJUUzUyMjkg
UENJIEV4cHJlc3MgQ2FyZCBSZWFkZXIvZHJpdmVyLCBiZWdpbm5pbmcgd2l0aA0KPiA+IDUuMS1y
YzEuDQo+ID4NCj4gPiBIZXJlIGlzIG9uZSBidWd6aWxsYSBjb21tZW50Og0KPiA+IERpZCBhIGdp
dCBiaXNlY3QgYW5kIGZvdW5kIHRoZSBjdWxwcml0Lg0KPiA+DQo+ID4gYmVkZTAzYTU3OWIzYjRh
MDM2MDAzYzQ4NjJjYzFiYWE0ZGRjMzUxZiBpcyB0aGUgZmlyc3QgYmFkIGNvbW1pdA0KPiA+IGNv
bW1pdCBiZWRlMDNhNTc5YjNiNGEwMzYwMDNjNDg2MmNjMWJhYTRkZGMzNTFmDQo+ID4gQXV0aG9y
OiBSaWNreVd1IDxyaWNreV93dUByZWFsdGVrLmNvbT4NCj4gPiBEYXRlOiAgIFR1ZSBGZWIgMTkg
MjA6NDk6NTggMjAxOSArMDgwMA0KPiA+DQo+ID4gICAgIG1pc2M6IHJ0c3g6IEVuYWJsZSBPQ1Ag
Zm9yIHJ0czUyMmEgcnRzNTI0YSBydHM1MjVhIHJ0czUyNjANCj4gPg0KPiA+ICAgICB0aGlzIGVu
YWJsZXMgYW5kIGFkZHMgT0NQIGZ1bmN0aW9uIGZvciBSZWFsdGVrIEEgc2VyaWVzIGNhcmRyZWFk
ZXIgY2hpcHMNCj4gPiAgICAgYW5kIGZpeGVzIHNvbWUgT0NQIGZsb3cgaW4gcnRzNTI2MC5jDQo+
ID4NCj4gPiAgICAgU2lnbmVkLW9mZi1ieTogUmlja3lXdSA8cmlja3lfd3VAcmVhbHRlay5jb20+
DQo+ID4gICAgIFNpZ25lZC1vZmYtYnk6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+DQo+ID4NCj4gPiA6MDQwMDAwIDA0MDAwMCA2NWJmZGM0NzNiN2I4NWNi
NDIzZmY1MjgzMDlmYzkyZDczZWFlNWI0DQo+IDEyOTJkODU2NGY2NzgwMjdkMGU1Yzc3NTUwZTM3
ZDY5NmIxMzRiMjggTSAgICAgIGRyaXZlcnMNCj4gPg0KPiA+IEp1c3QgcmV2ZXJ0IHRoYXQgYW5k
IHlvdSdsbCBiZSBnb2xkZW4uDQo+ID4NCj4gPiBydHM1MjJhLHJ0czUyNGEscnRzNTI1YSxydHM1
MjYwDQo+ID4gU28gc29tZWhvdyBPQ1AgZ290IGVuYWJsZWQgZm9yIHJ0czUyMjkgdW5sZXNzIGEg
bWVhbnMgcnRzNTIyeC4gSSBndWVzcyB0aGV5DQo+IG5lZWQgdG8gbWFrZSBzdXJlIGl0cyBub3Qg
ZW5hYmxlZCBmb3IgNTIyOS4NCj4gPiB7ZW5kIG9mIGJ1Z3ppbGxhIGNvbW1lbnR9DQo+ID4NCj4g
Pg0KPiA+DQo+ID4gLS0NCj4gPiB+UmFuZHkNCj4gPg0KPiANCj4gLS0tLS0tUGxlYXNlIGNvbnNp
ZGVyIHRoZSBlbnZpcm9ubWVudCBiZWZvcmUgcHJpbnRpbmcgdGhpcyBlLW1haWwuDQo=
