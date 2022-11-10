Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CE6C4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Nov 2022 02:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiKJCMH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Nov 2022 21:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbiKJCMG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Nov 2022 21:12:06 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 911C0FD04
        for <linux-mmc@vger.kernel.org>; Wed,  9 Nov 2022 18:12:05 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2AA2BHbT4027456, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2AA2BHbT4027456
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 10 Nov 2022 10:11:17 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Thu, 10 Nov 2022 10:11:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 10 Nov 2022 10:11:55 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Thu, 10 Nov 2022 10:11:55 +0800
From:   =?utf-8?B?SnlhbiBDaG91IFvlkajoirflrold?= <jyanchou@realtek.com>
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     linux-mmc <linux-mmc@vger.kernel.org>,
        "Jisheng.Zhang@synaptics.com" <Jisheng.Zhang@synaptics.com>
Subject: RE: Question about EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI) DRIVER
Thread-Topic: Question about EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI)
 DRIVER
Thread-Index: AdjzQ08CVJgRjyAuSMquwM9U5+w9rf//iSAAgAACSYCAAAHWgIAACxsA//95HJCAAb1NAP/+BgaQ
Date:   Thu, 10 Nov 2022 02:11:55 +0000
Message-ID: <c387c95ea0e9457e822e7ebf3aa98951@realtek.com>
References: <5842d536cb0d4086a225ea0fa2d42e72@realtek.com>
 <c97df3b4-0038-616d-ef10-953eba595638@intel.com>
 <0f8f0d91-9e1f-c71e-86a6-25a6bdb4f6b1@rock-chips.com>
 <38161cf2-4e6e-dbb3-4743-a21657b92451@intel.com>
 <dcac1f10-98a7-b831-005c-542b8a0d4337@rock-chips.com>
 <20fda8f718384317a8393baefc553d1b@realtek.com>
 <82cfb880-4283-047b-c476-c23d06706b06@rock-chips.com>
In-Reply-To: <82cfb880-4283-047b-c476-c23d06706b06@rock-chips.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.236]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzkg5LiL5Y2IIDExOjQ0OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiBDUUhDSSBoYXMgaXRzIG93biBETUEgZGVzY3JpcHRvcnMsIHNvIG1heWJlIGEgc2ltaWxhciBj
aGFuZ2UgaXMgbmVlZGVkIGZvciBDUUhDST8NCj4gU28geW91IGRvIG5lZWQgYSBzaW1pbGFyIGNo
YW5nZSBmb3IgQ1FIQ0kNCg0KPj4gQWNjb3JkaW5nIHRvIHRoZXNlIGNvbW1lbnRzLCBpdCBpcyBh
Y2NlcHRhYmxlIGZvciB1cyB0byB1cGRhdGUgYSBwYXRjaCB0byBzb2x2ZSB0aGUgbGltaXRhdGlv
biBvZiAxMjhNQiBib3VuZGFyeSA/DQoJV2UgaGF2ZSBhIHBhdGNoIGFuZCBpdCB3b3JrcyB3ZWxs
IG9uIGNtZHEgY2FzZS4NCglUaGFua3MuIA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogU2hhd24gTGluIDxzaGF3bi5saW5Acm9jay1jaGlwcy5jb20+IA0KU2VudDogV2VkbmVz
ZGF5LCBOb3ZlbWJlciA5LCAyMDIyIDExOjQ2IEFNDQpUbzogSnlhbiBDaG91IFvlkajoirflrold
IDxqeWFuY2hvdUByZWFsdGVrLmNvbT4NCkNjOiBzaGF3bi5saW5Acm9jay1jaGlwcy5jb207IGxp
bnV4LW1tYyA8bGludXgtbW1jQHZnZXIua2VybmVsLm9yZz47IEppc2hlbmcuWmhhbmdAc3luYXB0
aWNzLmNvbTsgQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQpTdWJqZWN0
OiBSZTogUXVlc3Rpb24gYWJvdXQgRU1NQyBDTURRIEhPU1QgQ09OVFJPTExFUiBJTlRFUkZBQ0Ug
KENRSENJKSBEUklWRVINCg0KDQpPbiAyMDIyLzExLzggMTc6MTksIEp5YW4gQ2hvdSBb5ZGo6Iq3
5a6JXSB3cm90ZToNCj4+IENRSENJIGhhcyBpdHMgb3duIERNQSBkZXNjcmlwdG9ycywgc28gbWF5
YmUgYSBzaW1pbGFyIGNoYW5nZSBpcyBuZWVkZWQgZm9yIENRSENJPw0KPiANCj4gSSBkaWRuJ3Qg
ZmluZCB0aGlzIGxpbWl0YXRpb24gaW4gc3lub3BzeXMgRFcgSVAgZGF0YWJvb2suDQo+Pj4gSSBm
b3VuZCBpdCBvbiBwYWdlIDg0DQoNCkkgc2VlLCBidXQgaXQgd2Fzbid0IGNsZWFyIHRvIG1lIGlm
IHRoaXMgZGVzY3JpcHRpb24gb24gUDg0IGlzIGZvciBDUSBlbmdpbmUgcGFydCBhcyB3ZWxsLiAg
QnV0IHNlZW1zIHllcyBhZnRlciBjaGVja2luZyB3aXRoIHRoZSBJUCB2ZW5kb3IuDQpTbyB5b3Ug
ZG8gbmVlZCBhIHNpbWlsYXIgY2hhbmdlIGZvciBDUUhDSSBpbiBjcWhjaV9ob3N0X2FsbG9jX3Rk
bC4NCg0KPiANCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhd24gTGlu
IDxzaGF3bi5saW5Acm9jay1jaGlwcy5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDgs
IDIwMjIgNToxNSBQTQ0KPiBUbzogQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5j
b20+DQo+IENjOiBzaGF3bi5saW5Acm9jay1jaGlwcy5jb207IGxpbnV4LW1tYyA8bGludXgtbW1j
QHZnZXIua2VybmVsLm9yZz47IA0KPiBKeWFuIENob3UgW+WRqOiKt+WuiV0gPGp5YW5jaG91QHJl
YWx0ZWsuY29tPjsgSmlzaGVuZy5aaGFuZ0BzeW5hcHRpY3MuY29tDQo+IFN1YmplY3Q6IFJlOiBR
dWVzdGlvbiBhYm91dCBFTU1DIENNRFEgSE9TVCBDT05UUk9MTEVSIElOVEVSRkFDRSANCj4gKENR
SENJKSBEUklWRVINCj4gDQo+ICsgSmlzaGVuZyBaaGFuZw0KPiANCj4gT24gMjAyMi8xMS84IDE2
OjM0LCBBZHJpYW4gSHVudGVyIHdyb3RlOg0KPj4gT24gOC8xMS8yMiAxMDoyOCwgU2hhd24gTGlu
IHdyb3RlOg0KPj4+IE9uIDIwMjIvMTEvOCAxNjoyMCwgQWRyaWFuIEh1bnRlciB3cm90ZToNCj4+
Pj4gT24gOC8xMS8yMiAwOToyNSwgSnlhbiBDaG91IFvlkajoirflroldIHdyb3RlOg0KPj4+Pj4g
SGVsbG8gQWRyaWFuIEh1bnRlciwNCj4+Pj4+DQo+Pj4+PiBXZSBhcmUgbm93IHVzaW5nIHRoZSB1
cHN0cmVhbSBjb2RlIG9mIEVNTUMgQ01EUSBIT1NUIENPTlRST0xMRVIgSU5URVJGQUNFIChDUUhD
SSkgRFJJVkVSLCBidXQgd2UgZm91bmQgdGhhdCB0aGUgZXhpc3RpbmcgZHJpdmVyIGNhbm5vdCBz
dXBwb3J0IHRoZSBsaW1pdGF0aW9uIG9mIFN5bm9wc3lzIElQLg0KPj4+Pj4NCj4+Pj4+IFN5bm9w
c3lzIElQIGhhcyBhIGRlc2NyaXB0aW9uIG9uIHRoZWlyIGRhdGEgYm9vayAiIFdoaWxlIHVzaW5n
IERNQSwgdGhlIGhvc3QgbWVtb3J5IGRhdGEgYnVmZmVyIHNpemUgYW5kIHN0YXJ0IGFkZHJlc3Mg
bXVzdCBub3QgZXhjZWVkIDEyOCBNQiIuDQo+Pj4NCj4+PiBTeW5vcHN5cy1iYXNlZCBTREhDSSBJ
UCBkb2VzIGhhdmUgYSBsaW1pdGF0aW9uIG9mIDEyOE1CIGJvdW5kYXJ5LiANCj4+PiBCdXQgaXQg
aGFzIGFscmVhZHkgYmVlbiBzb2x2ZWQgYnkgdXBzdHJlYW0gZHJpdmVyLg0KPj4+DQo+Pj4gRllJ
Og0KPj4+DQo+Pj4gY29tbWl0IGI4NWM5OTdkMmNmZWZlN2QxZjcwNmI4NWFlNDZlMzVhNTBlMzEz
MWMgKCJtbWM6DQo+Pj4gc2RoY2ktb2YtZHdjbXNoYzogc29sdmUgMTI4TUIgRE1BIGJvdW5kYXJ5
IGxpbWl0YXRpb24iKQ0KPj4NCj4+IENRSENJIGhhcyBpdHMgb3duIERNQSBkZXNjcmlwdG9ycywg
c28gbWF5YmUgYSBzaW1pbGFyIGNoYW5nZSBpcyBuZWVkZWQgZm9yIENRSENJPw0KPiANCj4gSSBk
aWRuJ3QgZmluZCB0aGlzIGxpbWl0YXRpb24gaW4gc3lub3BzeXMgRFcgSVAgZGF0YWJvb2suDQo+
IA0KPj4NCj4+Pg0KPj4+Pj4NCj4+Pj4+IEkgYW0gd29uZGVyaW5nIHdoZXRoZXIgdGhlcmUgaXMg
YSBtZXRob2Qgb3IgcGF0Y2ggdGhhdCBjYW4gZml4IHRoaXMgYm91bmRhcnkgbGltaXRhdGlvbi4N
Cj4+Pj4+IFRoYW5rcy4NCj4+Pj4+IEJlc3QgUmVnYXJkcywNCj4+Pj4+IEp5YW4gQ2hvdQ0KPj4+
Pg0KPj4+PiBIZWxsbyBKeWFuIENob3UNCj4+Pj4NCj4+Pj4gSSBhbSBub3QgY2xlYXIgb24gd2hh
dCB0aGUgZXhhY3QgbGltaXRhdGlvbiBpcy7CoCBUaGUgZHJpdmVyIG5ldmVyIHVzZXMgYnVmZmVy
cyBhcyBiaWcgYXMgMTI4IE1CLg0KPj4+PiBUbyByZXN0cmljdCBETUEgdG8gbG93IG1lbW9yeSBh
ZGRyZXNzZXMgYSBETUEgbWFzayBjYW4gYmUgdXNlZC4NCj4+Pj4NCj4+Pj4gQnV0IHBlcmhhcHMg
eW91IG1lYW4gbm90IHRvIGNyb3NzIGEgMTI4IE1CIGJvdW5kYXJ5Pw0KPj4+Pg0KPj4+PiBQbGVh
c2UgY2MgeW91ciBxdWVzdGlvbnMgdG8gdGhlIGxpbnV4IGtlcm5lbCBtbWMgbWFpbGluZyBsaXN0
Og0KPj4+PiBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIGJlY2F1c2Ugb3RoZXJzIGNhbiBhbnN3
ZXIgdG9vLg0KPj4+Pg0KPj4+PiBSZWdhcmRzDQo+Pj4+IEFkcmlhbg0KPj4NCj4gDQo+IC0tLS0t
LVBsZWFzZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50aW5nIHRoaXMgZS1t
YWlsLg0K
