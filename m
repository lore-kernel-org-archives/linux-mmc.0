From: Alex Lemberg <Alex.Lemberg@sandisk.com>
Subject: Re: [PATCH 1/3] mmc: replacing hardcoded value for runtime PM suspend
Date: Sun, 4 Sep 2016 13:30:22 +0000
Message-ID: <2D82096E-231C-43BA-801D-381F8191F26C@sandisk.com>
References: <1472739890-3384-1-git-send-email-alex.lemberg@sandisk.com>
 <1472739890-3384-2-git-send-email-alex.lemberg@sandisk.com>
 <cc6129e7-5250-8c2e-73e0-1134e2a7146d@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam01on0064.outbound.protection.outlook.com ([104.47.34.64]:11961
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752355AbcIDNaZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 4 Sep 2016 09:30:25 -0400
In-Reply-To: <cc6129e7-5250-8c2e-73e0-1134e2a7146d@rock-chips.com>
Content-Language: en-US
Content-ID: <29A0B6623A25B849AC23F628542F02F3@namprd02.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Avi Shchislowski <Avi.Shchislowski@sandisk.com>

SGkgU2hhd24sDQoNCk9uIDkvMi8xNiwgMTA6MzkgQU0sICJTaGF3biBMaW4iIDxzaGF3bi5saW5A
cm9jay1jaGlwcy5jb20+IHdyb3RlOg0KDQo+SGkNCj4NCj5PbiAyMDE2LzkvMSAyMjoyNCwgYWxl
eCBsZW1iZXJnIHdyb3RlOg0KPj4gQWRkIE1NQ19BVVRPU1VTUEVORF9ERUxBWV9NUyBkZWZpbmUN
Cj4NCj5JJ20gdGhpbmtpbmcgc2hvdWxkIHdlIGV4cG9zZSBpdCB0byB1c2Vyc3BhY2UNCj52aWEg
c3lzZnMsIHNpbmNlIEkgZG9uJ3Qga25vdyB3aHkgaXQgc2hvdWxkIGJlIDNtcywgbm90IDRtcywg
NW1zLCBldGMuDQoNCkFncmVlLCB3ZSBjYW4gY29uc2lkZXIgZXhwb3NpbmcgaXQgdG8gdGhlIHVz
ZXIgc3BhY2UuDQpUaGUgZXhwb3N1cmUgdG8gdGhlIHVzZXIgc3BhY2UgaXMgbGVzcyBjcml0aWNh
bCB0byB0aGUgY3VycmVudA0KcGF0Y2hzZXQsIGJ1dCB3ZSBjYW4gZG8gaXQgYXMgYSDigJxmb2xs
b3ctdXAgY2hhbmdl4oCdIG9uY2UgaXRzIGFwcHJvdmVkLg0KDQo+DQo+DQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogYWxleCBsZW1iZXJnIDxhbGV4LmxlbWJlcmdAc2FuZGlzay5jb20+DQo+PiAtLS0N
Cj4+ICBkcml2ZXJzL21tYy9jYXJkL2Jsb2NrLmMgfCAzICsrLQ0KPj4gIGluY2x1ZGUvbGludXgv
bW1jL2hvc3QuaCB8IDIgKysNCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jYXJkL2Jsb2Nr
LmMgYi9kcml2ZXJzL21tYy9jYXJkL2Jsb2NrLmMNCj4+IGluZGV4IDQ4YTVkZDcuLmY0Mzg2ZWQg
MTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL21tYy9jYXJkL2Jsb2NrLmMNCj4+ICsrKyBiL2RyaXZl
cnMvbW1jL2NhcmQvYmxvY2suYw0KPj4gQEAgLTI2MTAsNyArMjYxMCw4IEBAIHN0YXRpYyBpbnQg
bW1jX2Jsa19wcm9iZShzdHJ1Y3QgbW1jX2NhcmQgKmNhcmQpDQo+PiAgCQkJZ290byBvdXQ7DQo+
PiAgCX0NCj4+DQo+PiAtCXBtX3J1bnRpbWVfc2V0X2F1dG9zdXNwZW5kX2RlbGF5KCZjYXJkLT5k
ZXYsIDMwMDApOw0KPj4gKwlwbV9ydW50aW1lX3NldF9hdXRvc3VzcGVuZF9kZWxheSgmY2FyZC0+
ZGV2LA0KPj4gKwkJTU1DX1JVTlRJTUVfU1VTUEVORF9ERUxBWV9NUyk7DQo+PiAgCXBtX3J1bnRp
bWVfdXNlX2F1dG9zdXNwZW5kKCZjYXJkLT5kZXYpOw0KPj4NCj4+ICAJLyoNCj4+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L21tYy9ob3N0LmggYi9pbmNsdWRlL2xpbnV4L21tYy9ob3N0LmgN
Cj4+IGluZGV4IGFhNGJmYmYuLjhjYjgyMTggMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4
L21tYy9ob3N0LmgNCj4+ICsrKyBiL2luY2x1ZGUvbGludXgvbW1jL2hvc3QuaA0KPj4gQEAgLTIy
LDYgKzIyLDggQEANCj4+ICAjaW5jbHVkZSA8bGludXgvbW1jL21tYy5oPg0KPj4gICNpbmNsdWRl
IDxsaW51eC9tbWMvcG0uaD4NCj4+DQo+PiArI2RlZmluZSBNTUNfUlVOVElNRV9TVVNQRU5EX0RF
TEFZX01TCTMwMDANCj4+ICsNCj4+ICBzdHJ1Y3QgbW1jX2lvcyB7DQo+PiAgCXVuc2lnbmVkIGlu
dAljbG9jazsJCQkvKiBjbG9jayByYXRlICovDQo+PiAgCXVuc2lnbmVkIHNob3J0CXZkZDsNCj4+
DQo+DQo+DQo+LS0gDQo+QmVzdCBSZWdhcmRzDQo+U2hhd24gTGluDQo+DQoNCg==
