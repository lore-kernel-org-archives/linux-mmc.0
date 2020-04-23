Return-Path: <SRS0=Q/yj=6H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D05C54FCB
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Apr 2020 11:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 192392084D
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Apr 2020 11:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgDWLzZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Apr 2020 07:55:25 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:38274 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728200AbgDWLzZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 23 Apr 2020 07:55:25 -0400
Received: from dggeml405-hub.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 2A6FF4558969E0DB1A54;
        Thu, 23 Apr 2020 19:55:15 +0800 (CST)
Received: from DGGEML424-HUB.china.huawei.com (10.1.199.41) by
 dggeml405-hub.china.huawei.com (10.3.17.49) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 23 Apr 2020 19:55:14 +0800
Received: from DGGEML524-MBX.china.huawei.com ([169.254.1.24]) by
 dggeml424-hub.china.huawei.com ([10.1.199.41]) with mapi id 14.03.0487.000;
 Thu, 23 Apr 2020 19:55:14 +0800
From:   "Zouwei (Samuel)" <zou_wei@huawei.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggLW5leHRdIG1tYzogY29yZTogVXNlIERFRklORV9E?=
 =?utf-8?B?RUJVR0ZTX0FUVFJJQlVURSBpbnN0ZWFkIG9mIERFRklORV9TSU1QTEVfQVRU?=
 =?utf-8?Q?RIBUTE?=
Thread-Topic: [PATCH -next] mmc: core: Use DEFINE_DEBUGFS_ATTRIBUTE instead
 of DEFINE_SIMPLE_ATTRIBUTE
Thread-Index: AQHWGU7bardvAIH3jkC0wIn/00vYgaiGCMMAgACOqtA=
Date:   Thu, 23 Apr 2020 11:55:13 +0000
Message-ID: <C3CD0DF8AD11A84CB25A1426DE537C61E59522ED@dggeml524-mbx.china.huawei.com>
References: <1587633319-19835-1-git-send-email-zou_wei@huawei.com>
 <CAPDyKFogU2BT1vmcovrGvNEOtS+cxWwM09foMfN3bOPXEhhT3g@mail.gmail.com>
In-Reply-To: <CAPDyKFogU2BT1vmcovrGvNEOtS+cxWwM09foMfN3bOPXEhhT3g@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.166.212.180]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgVWxmLA0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3IGFuZCByZXBseS4NCg0KMS4gREVGSU5F
X1NJTVBMRV9BVFRSSUJVVEUgKyBkZWJ1Z2ZzX2NyZWF0ZV9maWxlKCkgaW1wb3NlcyBzb21lIHNp
Z25pZmljYW50IG92ZXJoZWFkIGFzIGNvbXBhcmVkIHRvIERFRklORV9ERUJVR0ZTX0FUVFJJQlVU
RSArIGRlYnVnZnNfY3JlYXRlX2ZpbGVfdW5zYWZlKCkuDQogIFlvdSBjYW4gcmVmZXIgdG8gdGhl
IHBhdGNoIG9mIDFhMmIzNjY2ZGE1OCAoIm10NzY6IGZpeCBkZWJ1Z2ZzX3NpbXBsZV9hdHRyLmNv
Y2NpIHdhcm5pbmdzIikNCjIuIGRlYnVnZnNfY3JlYXRlX2ZpbGVfdW5zYWZlKC4uLiZtbWNfY2xv
Y2tfZm9wcykgaXMgY29ycmVzcG9uZHMgdG8gREVGSU5FX0RFQlVHRlNfQVRUUklCVVRFKG1tY19j
bG9ja19mb3BzLi4uKSwgc28gSSBvbmx5IG1vZGlmaWVkIHRoaXMgb25lLg0KDQotLS0tLemCruS7
tuWOn+S7ti0tLS0tDQrlj5Hku7bkuro6IFVsZiBIYW5zc29uIFttYWlsdG86dWxmLmhhbnNzb25A
bGluYXJvLm9yZ10gDQrlj5HpgIHml7bpl7Q6IDIwMjDlubQ05pyIMjPml6UgMTk6MTcNCuaUtuS7
tuS6ujogWm91d2VpIChTYW11ZWwpIDx6b3Vfd2VpQGh1YXdlaS5jb20+DQrmioTpgIE6IGxpbnV4
LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQrkuLvpopg6IFJlOiBbUEFUQ0ggLW5leHRdIG1tYzogY29y
ZTogVXNlIERFRklORV9ERUJVR0ZTX0FUVFJJQlVURSBpbnN0ZWFkIG9mIERFRklORV9TSU1QTEVf
QVRUUklCVVRFDQoNCk9uIFRodSwgMjMgQXByIDIwMjAgYXQgMTE6MDksIFpvdSBXZWkgPHpvdV93
ZWlAaHVhd2VpLmNvbT4gd3JvdGU6DQo+DQo+IEZpeGVzIGNvY2NpY2hlY2sgd2FybmluZzoNCj4N
Cj4gZHJpdmVycy9tbWMvY29yZS9kZWJ1Z2ZzLmM6MjIyOjAtMjM6IFdBUk5JTkc6IG1tY19jbG9j
a19mb3BzIHNob3VsZCBiZSANCj4gZGVmaW5lZCB3aXRoIERFRklORV9ERUJVR0ZTX0FUVFJJQlVU
RQ0KPg0KPiBVc2UgREVGSU5FX0RFQlVHRlNfQVRUUklCVVRFIHJhdGhlciB0aGFuIERFRklORV9T
SU1QTEVfQVRUUklCVVRFIGZvciANCj4gZGVidWdmcyBmaWxlcw0KPg0KPiBGaXhlczogNzAzYWFl
M2QwOWE0YiAoIm1tYzogYWRkIGEgZmlsZSB0byBkZWJ1Z2ZzIGZvciBjaGFuZ2luZyBob3N0IA0K
PiBjbG9jayBhdCBydW50aW1lIikNCj4gRml4ZXM6IGEwNGM1MGFhYTkxNmYgKCJtbWM6IGNvcmU6
IG5vIG5lZWQgdG8gY2hlY2sgcmV0dXJuIHZhbHVlIG9mIA0KPiBkZWJ1Z2ZzX2NyZWF0ZSBmdW5j
dGlvbnMiKQ0KPiBSZXBvcnRlZC1ieTogSHVsayBSb2JvdCA8aHVsa2NpQGh1YXdlaS5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IFpvdSBXZWkgPHpvdV93ZWlAaHVhd2VpLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL21tYy9jb3JlL2RlYnVnZnMuYyB8IDYgKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tbWMvY29yZS9kZWJ1Z2ZzLmMgYi9kcml2ZXJzL21tYy9jb3JlL2RlYnVnZnMuYyANCj4gaW5k
ZXggMDllMGM3Ni4uOWVjODRjOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tbWMvY29yZS9kZWJ1
Z2ZzLmMNCj4gKysrIGIvZHJpdmVycy9tbWMvY29yZS9kZWJ1Z2ZzLmMNCj4gQEAgLTIxOSw3ICsy
MTksNyBAQCBzdGF0aWMgaW50IG1tY19jbG9ja19vcHRfc2V0KHZvaWQgKmRhdGEsIHU2NCB2YWwp
DQo+ICAgICAgICAgcmV0dXJuIDA7DQo+ICB9DQo+DQo+IC1ERUZJTkVfU0lNUExFX0FUVFJJQlVU
RShtbWNfY2xvY2tfZm9wcywgbW1jX2Nsb2NrX29wdF9nZXQsIA0KPiBtbWNfY2xvY2tfb3B0X3Nl
dCwNCj4gK0RFRklORV9ERUJVR0ZTX0FUVFJJQlVURShtbWNfY2xvY2tfZm9wcywgbW1jX2Nsb2Nr
X29wdF9nZXQsIA0KPiArbW1jX2Nsb2NrX29wdF9zZXQsDQo+ICAgICAgICAgIiVsbHVcbiIpOw0K
Pg0KPiAgdm9pZCBtbWNfYWRkX2hvc3RfZGVidWdmcyhzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QpIEBA
IC0yMzIsOCArMjMyLDggQEAgDQo+IHZvaWQgbW1jX2FkZF9ob3N0X2RlYnVnZnMoc3RydWN0IG1t
Y19ob3N0ICpob3N0KQ0KPiAgICAgICAgIGRlYnVnZnNfY3JlYXRlX2ZpbGUoImlvcyIsIFNfSVJV
U1IsIHJvb3QsIGhvc3QsICZtbWNfaW9zX2ZvcHMpOw0KPiAgICAgICAgIGRlYnVnZnNfY3JlYXRl
X3gzMigiY2FwcyIsIFNfSVJVU1IsIHJvb3QsICZob3N0LT5jYXBzKTsNCj4gICAgICAgICBkZWJ1
Z2ZzX2NyZWF0ZV94MzIoImNhcHMyIiwgU19JUlVTUiwgcm9vdCwgJmhvc3QtPmNhcHMyKTsNCj4g
LSAgICAgICBkZWJ1Z2ZzX2NyZWF0ZV9maWxlKCJjbG9jayIsIFNfSVJVU1IgfCBTX0lXVVNSLCBy
b290LCBob3N0LA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgJm1tY19jbG9ja19mb3Bz
KTsNCj4gKyAgICAgICBkZWJ1Z2ZzX2NyZWF0ZV9maWxlX3Vuc2FmZSgiY2xvY2siLCBTX0lSVVNS
IHwgU19JV1VTUiwgcm9vdCwgaG9zdCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAmbW1jX2Nsb2NrX2ZvcHMpOw0KDQpBcG9sb2dpemUgZm9yIG15IGlnbm9yYW5jZSwgYnV0
IHdoeSBjb252ZXJ0IHRvIHRoZSAqX3Vuc2FmZSBvcHRpb24gZm9yIHRoaXMgb25lLCBidXQgbm90
IGZvciB0aGUgb3RoZXJzPw0KDQpbLi4uXQ0KDQpLaW5kIHJlZ2FyZHMNClVmZmUNCg==
