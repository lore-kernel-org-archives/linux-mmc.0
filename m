Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1ACC433FE
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Nov 2022 09:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbiKHJUi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Nov 2022 04:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbiKHJUc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Nov 2022 04:20:32 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22B84248CA
        for <linux-mmc@vger.kernel.org>; Tue,  8 Nov 2022 01:20:30 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2A89Jg8J2000950, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2A89Jg8J2000950
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 8 Nov 2022 17:19:42 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 8 Nov 2022 17:19:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 8 Nov 2022 17:19:56 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Tue, 8 Nov 2022 17:19:56 +0800
From:   =?utf-8?B?SnlhbiBDaG91IFvlkajoirflrold?= <jyanchou@realtek.com>
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     linux-mmc <linux-mmc@vger.kernel.org>,
        "Jisheng.Zhang@synaptics.com" <Jisheng.Zhang@synaptics.com>
Subject: RE: Question about EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI) DRIVER
Thread-Topic: Question about EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI)
 DRIVER
Thread-Index: AdjzQ08CVJgRjyAuSMquwM9U5+w9rf//iSAAgAACSYCAAAHWgIAACxsA//95HJA=
Date:   Tue, 8 Nov 2022 09:19:55 +0000
Message-ID: <20fda8f718384317a8393baefc553d1b@realtek.com>
References: <5842d536cb0d4086a225ea0fa2d42e72@realtek.com>
 <c97df3b4-0038-616d-ef10-953eba595638@intel.com>
 <0f8f0d91-9e1f-c71e-86a6-25a6bdb4f6b1@rock-chips.com>
 <38161cf2-4e6e-dbb3-4743-a21657b92451@intel.com>
 <dcac1f10-98a7-b831-005c-542b8a0d4337@rock-chips.com>
In-Reply-To: <dcac1f10-98a7-b831-005c-542b8a0d4337@rock-chips.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.236]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzgg5LiK5Y2IIDA4OjA0OjAw?=
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

PiBDUUhDSSBoYXMgaXRzIG93biBETUEgZGVzY3JpcHRvcnMsIHNvIG1heWJlIGEgc2ltaWxhciBj
aGFuZ2UgaXMgbmVlZGVkIGZvciBDUUhDST8NCg0KSSBkaWRuJ3QgZmluZCB0aGlzIGxpbWl0YXRp
b24gaW4gc3lub3BzeXMgRFcgSVAgZGF0YWJvb2suDQo+PiBJIGZvdW5kIGl0IG9uIHBhZ2UgODQg
DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTaGF3biBMaW4gPHNoYXduLmxp
bkByb2NrLWNoaXBzLmNvbT4gDQpTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciA4LCAyMDIyIDU6MTUg
UE0NClRvOiBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT4NCkNjOiBzaGF3
bi5saW5Acm9jay1jaGlwcy5jb207IGxpbnV4LW1tYyA8bGludXgtbW1jQHZnZXIua2VybmVsLm9y
Zz47IEp5YW4gQ2hvdSBb5ZGo6Iq35a6JXSA8anlhbmNob3VAcmVhbHRlay5jb20+OyBKaXNoZW5n
LlpoYW5nQHN5bmFwdGljcy5jb20NClN1YmplY3Q6IFJlOiBRdWVzdGlvbiBhYm91dCBFTU1DIENN
RFEgSE9TVCBDT05UUk9MTEVSIElOVEVSRkFDRSAoQ1FIQ0kpIERSSVZFUg0KDQorIEppc2hlbmcg
WmhhbmcNCg0KT24gMjAyMi8xMS84IDE2OjM0LCBBZHJpYW4gSHVudGVyIHdyb3RlOg0KPiBPbiA4
LzExLzIyIDEwOjI4LCBTaGF3biBMaW4gd3JvdGU6DQo+PiBPbiAyMDIyLzExLzggMTY6MjAsIEFk
cmlhbiBIdW50ZXIgd3JvdGU6DQo+Pj4gT24gOC8xMS8yMiAwOToyNSwgSnlhbiBDaG91IFvlkajo
irflroldIHdyb3RlOg0KPj4+PiBIZWxsbyBBZHJpYW4gSHVudGVyLA0KPj4+Pg0KPj4+PiBXZSBh
cmUgbm93IHVzaW5nIHRoZSB1cHN0cmVhbSBjb2RlIG9mIEVNTUMgQ01EUSBIT1NUIENPTlRST0xM
RVIgSU5URVJGQUNFIChDUUhDSSkgRFJJVkVSLCBidXQgd2UgZm91bmQgdGhhdCB0aGUgZXhpc3Rp
bmcgZHJpdmVyIGNhbm5vdCBzdXBwb3J0IHRoZSBsaW1pdGF0aW9uIG9mIFN5bm9wc3lzIElQLg0K
Pj4+Pg0KPj4+PiBTeW5vcHN5cyBJUCBoYXMgYSBkZXNjcmlwdGlvbiBvbiB0aGVpciBkYXRhIGJv
b2sgIiBXaGlsZSB1c2luZyBETUEsIHRoZSBob3N0IG1lbW9yeSBkYXRhIGJ1ZmZlciBzaXplIGFu
ZCBzdGFydCBhZGRyZXNzIG11c3Qgbm90IGV4Y2VlZCAxMjggTUIiLg0KPj4NCj4+IFN5bm9wc3lz
LWJhc2VkIFNESENJIElQIGRvZXMgaGF2ZSBhIGxpbWl0YXRpb24gb2YgMTI4TUIgYm91bmRhcnku
IEJ1dCANCj4+IGl0IGhhcyBhbHJlYWR5IGJlZW4gc29sdmVkIGJ5IHVwc3RyZWFtIGRyaXZlci4N
Cj4+DQo+PiBGWUk6DQo+Pg0KPj4gY29tbWl0IGI4NWM5OTdkMmNmZWZlN2QxZjcwNmI4NWFlNDZl
MzVhNTBlMzEzMWMgKCJtbWM6IA0KPj4gc2RoY2ktb2YtZHdjbXNoYzogc29sdmUgMTI4TUIgRE1B
IGJvdW5kYXJ5IGxpbWl0YXRpb24iKQ0KPiANCj4gQ1FIQ0kgaGFzIGl0cyBvd24gRE1BIGRlc2Ny
aXB0b3JzLCBzbyBtYXliZSBhIHNpbWlsYXIgY2hhbmdlIGlzIG5lZWRlZCBmb3IgQ1FIQ0k/DQoN
CkkgZGlkbid0IGZpbmQgdGhpcyBsaW1pdGF0aW9uIGluIHN5bm9wc3lzIERXIElQIGRhdGFib29r
Lg0KDQo+IA0KPj4NCj4+Pj4NCj4+Pj4gSSBhbSB3b25kZXJpbmcgd2hldGhlciB0aGVyZSBpcyBh
IG1ldGhvZCBvciBwYXRjaCB0aGF0IGNhbiBmaXggdGhpcyBib3VuZGFyeSBsaW1pdGF0aW9uLg0K
Pj4+PiBUaGFua3MuDQo+Pj4+IEJlc3QgUmVnYXJkcywNCj4+Pj4gSnlhbiBDaG91DQo+Pj4NCj4+
PiBIZWxsbyBKeWFuIENob3UNCj4+Pg0KPj4+IEkgYW0gbm90IGNsZWFyIG9uIHdoYXQgdGhlIGV4
YWN0IGxpbWl0YXRpb24gaXMuwqAgVGhlIGRyaXZlciBuZXZlciB1c2VzIGJ1ZmZlcnMgYXMgYmln
IGFzIDEyOCBNQi4NCj4+PiBUbyByZXN0cmljdCBETUEgdG8gbG93IG1lbW9yeSBhZGRyZXNzZXMg
YSBETUEgbWFzayBjYW4gYmUgdXNlZC4NCj4+Pg0KPj4+IEJ1dCBwZXJoYXBzIHlvdSBtZWFuIG5v
dCB0byBjcm9zcyBhIDEyOCBNQiBib3VuZGFyeT8NCj4+Pg0KPj4+IFBsZWFzZSBjYyB5b3VyIHF1
ZXN0aW9ucyB0byB0aGUgbGludXgga2VybmVsIG1tYyBtYWlsaW5nIGxpc3Q6IA0KPj4+IGxpbnV4
LW1tY0B2Z2VyLmtlcm5lbC5vcmcgYmVjYXVzZSBvdGhlcnMgY2FuIGFuc3dlciB0b28uDQo+Pj4N
Cj4+PiBSZWdhcmRzDQo+Pj4gQWRyaWFuDQo+IA0KDQotLS0tLS1QbGVhc2UgY29uc2lkZXIgdGhl
IGVudmlyb25tZW50IGJlZm9yZSBwcmludGluZyB0aGlzIGUtbWFpbC4NCg==
