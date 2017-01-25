From: Alex Lemberg <Alex.Lemberg@sandisk.com>
Subject: Re: [PATCH 3/3] mmc: Checking BKOPS status prior to Suspend
Date: Wed, 25 Jan 2017 09:48:54 +0000
Message-ID: <939E5C6D-D96B-4EF6-81F2-0DE61499E4B6@sandisk.com>
References: <1484655337-32562-1-git-send-email-uri.yanai@sandisk.com>
 <1484655337-32562-4-git-send-email-uri.yanai@sandisk.com>
 <7a21bfe1-9eef-0f6f-56ce-4fc34d628ac0@intel.com>
 <037111DC0C584A4DB9F38021EA3CBDA506103F51@ULS-OP-MBXIP04.sdcorp.global.sandisk.com>
 <5DA5AA2A-DC61-4CC6-9548-AB648657C732@sandisk.com>
 <650522d8-dd54-6856-d50c-798d97a82001@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-co1nam03on0085.outbound.protection.outlook.com ([104.47.40.85]:59952
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751470AbdAYJtC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 25 Jan 2017 04:49:02 -0500
In-Reply-To: <650522d8-dd54-6856-d50c-798d97a82001@intel.com>
Content-Language: en-US
Content-ID: <06D84F4BC1188545B789B9712A1ED732@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Uri Yanai <Uri.Yanai@sandisk.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

DQoNCk9uIDEvMjQvMTcsIDQ6MzYgUE0sICJBZHJpYW4gSHVudGVyIiA8YWRyaWFuLmh1bnRlckBp
bnRlbC5jb20+IHdyb3RlOg0KDQogICAgT24gMjMvMDEvMTcgMTk6MDcsIEFsZXggTGVtYmVyZyB3
cm90ZToNCiAgICA+IEhpIEFkcmlhbiwNCiAgICA+IA0KICAgID4gSSB3b3VsZCBsaWtlIHRvIGFk
ZCBzZXZlcmFsIG5vdGVzIG9uIHRvcCBvZiBVcmnigJlzIGFuc3dlci4uLg0KICAgID4gSSBhZ3Jl
ZSB3aXRoIHlvdSwgYnkgdGhlIHNwZWMsIFBPTiBTbGVlcF9Ob3RpZmljYXRpb24gc2hvdWxkIGJl
DQogICAgPiBzZXQgYmVmb3JlIGNhbGxpbmcgU2xlZXAgY29tbWFuZC4NCiAgICA+IEFzIHlvdSBw
cm9iYWJseSByZW1lbWJlciwgd2UgaGF2ZSB0cmllZCB0byBpbXBsZW1lbnQgaXQNCiAgICA+IGlu
IHRoZSBwYXN0IGFuZCBldmVuIHN1Ym1pdHRlZCBhIHBhdGNoIOKAkyDigJxbUEFUQ0hdIG1tYzog
c2xlZXAgbm90aWZpY2F0aW9u4oCdDQogICAgPiBodHRwczovL3d3dy5tYWlsLWFyY2hpdmUuY29t
L2xpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmcvbXNnMzA5MDYuaHRtbA0KICAgID4gQXMgeW91IGNh
biBzZWUgZnJvbSB0aGUgdGhyZWFkLCBvbmUgb2YgdGhlIG1haW4gaXNzdWVzIGluIFNsZWVwX05v
dGlmaWNhdGlvbg0KICAgID4gaXMgYSBTTEVFUF9OT1RJRklDQVRJT05fVElNRSAoZGVmaW5lZCBp
biBFWFRfQ1NEIFsyMTZdKSwgd2hpY2ggbmVlZCB0byBiZQ0KICAgID4gY29uc2lkZXJlZCBpbiBp
bXBsZW1lbnRhdGlvbuKApg0KICAgIA0KICAgIERvZXMgaXQ/ICBJIHdvdWxkIHRlbmQgdG8gYXNz
dW1lIFNMRUVQX05PVElGSUNBVElPTl9USU1FIHdpbGwgYmUgYWNjZXB0YWJsZQ0KICAgIGR1cmlu
ZyBfc3VzcGVuZCB1bnRpbCBwcm92ZW4gb3RoZXJ3aXNlLg0KDQpQb3RlbnRpYWxseSwgYnkgdGhl
IHNwZWMsIHRoZSBNYXggdmFsdWUgb2YgU0xFRVBfTk9USUZJQ0FUSU9OX1RJTUUgY2FuIGJlIDgz
Ljg4IHNlY29uZHMuDQpDYW4gd2UgYXNzdW1lIHRoYXQgdGhpcyB0aW1lIGlzIGFjY2VwdGFibGUg
ZHVyaW5nIF9zdXNwZW5kPw0KICAgIA0KICAgID4gVGh1cywgSSB0aGluayBwb3N0cG9uaW5nIFNs
ZWVwIGR1cmluZyBzdXNwZW5kIHJlcXVpcmVzIGEgZGlmZmVyZW50IGZyb20gY3VycmVudA0KICAg
ID4gQVVUT19CS09QUyBpbXBsZW1lbnRhdGlvbiwgYW5kIEkgc3VnZ2VzdCB0byBoYW5kbGUgaXQg
aW4gc2VwYXJhdGUNCiAgICA+IHBhdGNoc2V0LCBpZiBwb3NzaWJsZS4NCiAgICANCiAgICBOb3Qg
YXQgYWxsIHN1cmUgd2hhdCB5b3UgbWVhbiBieSAicG9zdHBvbmluZyBTbGVlcCI/DQoNCkkgbWVh
biBsZXR0aW5nIFNsZWVwX05vdGlmaWNhdGlvbiB0byBiZSBjb21wbGV0ZWQgYmVmb3JlIFNsZWVw
Lg0KIA0KDQo=
