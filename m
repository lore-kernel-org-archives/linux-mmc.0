Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51114C433FE
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Nov 2022 08:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbiKHIgB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Nov 2022 03:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiKHIgB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Nov 2022 03:36:01 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2D85F00A
        for <linux-mmc@vger.kernel.org>; Tue,  8 Nov 2022 00:35:59 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2A88ZFksC013582, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2A88ZFksC013582
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 8 Nov 2022 16:35:15 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 8 Nov 2022 16:35:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 8 Nov 2022 16:35:52 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Tue, 8 Nov 2022 16:35:52 +0800
From:   =?utf-8?B?SnlhbiBDaG91IFvlkajoirflrold?= <jyanchou@realtek.com>
To:     Shawn Lin <shawn.lin@rock-chips.com>
CC:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: RE: Question about EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI) DRIVER
Thread-Topic: Question about EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI)
 DRIVER
Thread-Index: AdjzQ08CVJgRjyAuSMquwM9U5+w9rf//iSAAgAACSYD//3lxEA==
Date:   Tue, 8 Nov 2022 08:35:52 +0000
Message-ID: <d0f6fbc4351748e0bd6f02baef1785ab@realtek.com>
References: <5842d536cb0d4086a225ea0fa2d42e72@realtek.com>
 <c97df3b4-0038-616d-ef10-953eba595638@intel.com>
 <0f8f0d91-9e1f-c71e-86a6-25a6bdb4f6b1@rock-chips.com>
In-Reply-To: <0f8f0d91-9e1f-c71e-86a6-25a6bdb4f6b1@rock-chips.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.236]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzgg5LiK5Y2IIDA2OjAwOjAw?=
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

SGVsbG8sDQoNCkJ1dCB3ZSBmb3VuZCB0aGF0IHRoaXMgY29tbWl0IGI4NWM5OTdkMmNmZWZlN2Qx
ZjcwNmI4NWFlNDZlMzVhNTBlMzEzMWMgKCJtbWM6IHNkaGNpLW9mLWR3Y21zaGM6IHNvbHZlIDEy
OE1CIERNQSBib3VuZGFyeSBsaW1pdGF0aW9uIikNCmlzIHN1cHBvcnRlZCBmb3Igc2RoY2kgaG9z
dCBkcml2ZXIsIG5vdCBmb3IgZU1NQyBkcml2ZXINCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCkZyb206IFNoYXduIExpbiA8c2hhd24ubGluQHJvY2stY2hpcHMuY29tPiANClNlbnQ6IFR1
ZXNkYXksIE5vdmVtYmVyIDgsIDIwMjIgNDoyOCBQTQ0KVG86IEp5YW4gQ2hvdSBb5ZGo6Iq35a6J
XSA8anlhbmNob3VAcmVhbHRlay5jb20+DQpDYzogc2hhd24ubGluQHJvY2stY2hpcHMuY29tOyBs
aW51eC1tbWMgPGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc+OyBBZHJpYW4gSHVudGVyIDxhZHJp
YW4uaHVudGVyQGludGVsLmNvbT4NClN1YmplY3Q6IFJlOiBRdWVzdGlvbiBhYm91dCBFTU1DIENN
RFEgSE9TVCBDT05UUk9MTEVSIElOVEVSRkFDRSAoQ1FIQ0kpIERSSVZFUg0KDQpPbiAyMDIyLzEx
LzggMTY6MjAsIEFkcmlhbiBIdW50ZXIgd3JvdGU6DQo+IE9uIDgvMTEvMjIgMDk6MjUsIEp5YW4g
Q2hvdSBb5ZGo6Iq35a6JXSB3cm90ZToNCj4+IEhlbGxvIEFkcmlhbiBIdW50ZXIsDQo+Pg0KPj4g
V2UgYXJlIG5vdyB1c2luZyB0aGUgdXBzdHJlYW0gY29kZSBvZiBFTU1DIENNRFEgSE9TVCBDT05U
Uk9MTEVSIElOVEVSRkFDRSAoQ1FIQ0kpIERSSVZFUiwgYnV0IHdlIGZvdW5kIHRoYXQgdGhlIGV4
aXN0aW5nIGRyaXZlciBjYW5ub3Qgc3VwcG9ydCB0aGUgbGltaXRhdGlvbiBvZiBTeW5vcHN5cyBJ
UC4NCj4+DQo+PiBTeW5vcHN5cyBJUCBoYXMgYSBkZXNjcmlwdGlvbiBvbiB0aGVpciBkYXRhIGJv
b2sgIiBXaGlsZSB1c2luZyBETUEsIHRoZSBob3N0IG1lbW9yeSBkYXRhIGJ1ZmZlciBzaXplIGFu
ZCBzdGFydCBhZGRyZXNzIG11c3Qgbm90IGV4Y2VlZCAxMjggTUIiLg0KDQpTeW5vcHN5cy1iYXNl
ZCBTREhDSSBJUCBkb2VzIGhhdmUgYSBsaW1pdGF0aW9uIG9mIDEyOE1CIGJvdW5kYXJ5LiBCdXQg
aXQgaGFzIGFscmVhZHkgYmVlbiBzb2x2ZWQgYnkgdXBzdHJlYW0gZHJpdmVyLg0KDQpGWUk6DQoN
CmNvbW1pdCBiODVjOTk3ZDJjZmVmZTdkMWY3MDZiODVhZTQ2ZTM1YTUwZTMxMzFjICgibW1jOiBz
ZGhjaS1vZi1kd2Ntc2hjOiANCnNvbHZlIDEyOE1CIERNQSBib3VuZGFyeSBsaW1pdGF0aW9uIikN
Cg0KDQoNCg0KDQo+Pg0KPj4gSSBhbSB3b25kZXJpbmcgd2hldGhlciB0aGVyZSBpcyBhIG1ldGhv
ZCBvciBwYXRjaCB0aGF0IGNhbiBmaXggdGhpcyBib3VuZGFyeSBsaW1pdGF0aW9uLg0KPj4gVGhh
bmtzLg0KPj4gQmVzdCBSZWdhcmRzLA0KPj4gSnlhbiBDaG91DQo+IA0KPiBIZWxsbyBKeWFuIENo
b3UNCj4gDQo+IEkgYW0gbm90IGNsZWFyIG9uIHdoYXQgdGhlIGV4YWN0IGxpbWl0YXRpb24gaXMu
ICBUaGUgZHJpdmVyIG5ldmVyIHVzZXMgYnVmZmVycyBhcyBiaWcgYXMgMTI4IE1CLg0KPiBUbyBy
ZXN0cmljdCBETUEgdG8gbG93IG1lbW9yeSBhZGRyZXNzZXMgYSBETUEgbWFzayBjYW4gYmUgdXNl
ZC4NCj4gDQo+IEJ1dCBwZXJoYXBzIHlvdSBtZWFuIG5vdCB0byBjcm9zcyBhIDEyOCBNQiBib3Vu
ZGFyeT8NCj4gDQo+IFBsZWFzZSBjYyB5b3VyIHF1ZXN0aW9ucyB0byB0aGUgbGludXgga2VybmVs
IG1tYyBtYWlsaW5nIGxpc3Q6IA0KPiBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIGJlY2F1c2Ug
b3RoZXJzIGNhbiBhbnN3ZXIgdG9vLg0KPiANCj4gUmVnYXJkcw0KPiBBZHJpYW4NCg0KLS0tLS0t
UGxlYXNlIGNvbnNpZGVyIHRoZSBlbnZpcm9ubWVudCBiZWZvcmUgcHJpbnRpbmcgdGhpcyBlLW1h
aWwuDQo=
