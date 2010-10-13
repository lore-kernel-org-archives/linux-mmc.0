From: Zhu Richard-R65037 <r65037@freescale.com>
Subject: RE: [PATCH 0/6] SD/MMC driver for MX25/35/51
Date: Wed, 13 Oct 2010 17:53:10 +0800
Message-ID: <A88EF4D64D8447468743DC1503C0B6CA0D557C@zch01exm22.fsl.freescale.net>
References: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de><87aamjxe00.fsf@lechat.rtp-net.org> <4CB56A88.2040101@eukrea.com><20101013082930.GA11286@pengutronix.de> <8762x6xx00.fsf@lechat.rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:1238
	"EHLO AM1EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751078Ab0JMJxO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Oct 2010 05:53:14 -0400
Received: from mail47-am1 (localhost.localdomain [127.0.0.1])	by
 mail47-am1-R.bigfish.com (Postfix) with ESMTP id 9AA8C19B8134	for
 <linux-mmc@vger.kernel.org>; Wed, 13 Oct 2010 09:53:12 +0000 (UTC)
Received: from am1ehsmhs003.bigfish.com (unknown [10.3.201.251])	by
 mail47-am1.bigfish.com (Postfix) with ESMTP id E6846E68046	for
 <linux-mmc@vger.kernel.org>; Wed, 13 Oct 2010 09:53:11 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
 [10.64.34.199])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
 o9D9r3Ts021806	for <linux-mmc@vger.kernel.org>; Wed, 13 Oct 2010 02:53:03
 -0700 (MST)
Received: from zch01exm22.fsl.freescale.net (zch01exm22.ap.freescale.net
 [10.192.129.206])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
 o9D9r1S4010875	for <linux-mmc@vger.kernel.org>; Wed, 13 Oct 2010 04:53:03
 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <8762x6xx00.fsf@lechat.rtp-net.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>, Wolfram Sang <w.sang@pengutronix.de>
Cc: =?utf-8?B?RXJpYyBCw6luYXJk?= <eric@eukrea.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

SGkgQXJuYXVkOg0KVGhlIG1lY2hhbmlzbSBvZiB0aGUgR1BJTyB1c2VkIGFzIHdyaXRlIHByb3Rl
Y3Rpb24gcGluIGlzIGltcGxlbWVudGVkIGV2ZXIsIHlvdSBjYW4gbWFrZSBhIHJlZmVyZW5jZSB0
byB0aGUgZm9sbG93aW5nIHN1Z2dlc3Rpb25zLg0KVGhlIGRldGFpbHMgcGxzIHJlZmVyIHRvIHRo
ZSBbUEFUQ0ggMy82XSBtbWM6IHNkaGNpOiBpbnRyb2R1Y2UgcHJpdmF0ZSBnZXRfcm8gc2VudCBi
eSB3b2xmcmFtLg0KYW5kIA0KaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xp
bnV4LWFybS1rZXJuZWwvMjAxMC1TZXB0ZW1iZXIvMDI3MjY5Lmh0bWwNCg0KVGhlIEdQSU8gQ2Fy
ZCBEZXRlY3Rpb24gc29sdXRpb24gbWF5YmUgYSBsaXR0bGUgY29tcGxleCByZWZlciB0byB0aGUg
R1BJTyBXcml0ZSBQcm90ZWN0aW9uLA0KIHNpbmNlIHRoZSBDRCBpcnEgc2hvdWxkIGJlIGNvbmZp
Z3VyZWQsIGFuZCB0aGUgcG9sbCBPZiBjYXJkIGRldGVjdGlvbiBzaG91bGQgYmUgZGlzYWJsZWQg
YXQgdGhlIHNhbWUgdGltZS4NClNvIHRoZSBzZGhjLXBsdGZtLmMgbWF5YmUgc2hvdWxkIGJlIGNo
YW5nZWQgdG9vLg0KDQpIaSBFcmljOg0KQ2FuIHlvdSBhZGQgdGhpcyBHUElPIFdQIG1lY2hhbmlz
bSBpbnRvIHlvdXIgc2VyaWFsIHBhdGNoZXM/DQpJIGNhbid0IGFjY2VzcyB0aGUgZXh0ZXJuYWwg
Z2l0IHJlcG9zIGJlY2F1c2Ugb2YgdGhlIGZpcmV3YWxsLjooLg0KVGhlIEdQSU8gV1Agc29sdXRp
b24gaGFkIGJlZW4gaW1wbGVtZW50ZWQgaW4gbXkgcGF0Y2hlcyBiZWZvcmUsIHRoZSBkZXRhaWxz
IHBscyByZWZlciB0byB0aGUgVVJMIGxpc3RlZCBhYm92ZS4NCg0KVGhlIGNvZGVzIGFyZSBzaW1w
bGUsIG1heWJlIHRoZSBkZWZpbml0aW9uIG9mIHRoZSBwbGF0Zm9ybSBkYXRhIHNob3VsZCBiZSBj
b25zaWRlcmVkLg0KDQoNCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQoNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBcm5hdWQgUGF0YXJkIFttYWlsdG86YXJu
YXVkLnBhdGFyZEBydHAtbmV0Lm9yZ10NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDEzLCAy
MDEwIDU6MjggUE0NCj4gVG86IFdvbGZyYW0gU2FuZw0KPiBDYzogRXJpYyBCw6luYXJkOyBaaHUg
UmljaGFyZC1SNjUwMzc7IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBhcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwLzZdIFNE
L01NQyBkcml2ZXIgZm9yIE1YMjUvMzUvNTENCj4gDQo+IFdvbGZyYW0gU2FuZyA8dy5zYW5nQHBl
bmd1dHJvbml4LmRlPiB3cml0ZXM6DQo+IA0KPiBIaSwNCj4gDQo+ID4gT24gV2VkLCBPY3QgMTMs
IDIwMTAgYXQgMTA6MTU6MDRBTSArMDIwMCwgRXJpYyBCw6luYXJkIHdyb3RlOg0KPiA+DQo+ID4+
ID5JJ3ZlIHRyaWVkIGl0IG9uIGEgZWZpa2EgbXggKHRvMiB2ZXJzaW9uKSBhbmQgSSd2ZSBhIHBy
b2JsZW0gd2l0aA0KPiA+PiA+dGhlIHdyaXRlLXByb3RlY3QuIEl0J3Mgb24gYSBHUElPIGFuZCBJ
IGRvbid0IHNlZSBhbnkgd2F5IHRvDQo+ID4+ID5jb25maWd1cmUgdGhlIGVzZGhjLWlteCBkcml2
ZXIgdG8gdXNlIGl0LiBBbnkgaWRlYSBvbiBob3cgaXQgc2hvdWxkDQo+IGJlIGRvbmUgPw0KPiA+
PiA+DQo+ID4+IGl0J3MgYWN0dWFsbHkgbm90IHlldCBzdXBwb3J0ZWQgYnkgdGhlIGRyaXZlci4g
VGhlcmUgaXMgYSB3cF9ncGlvIGluDQo+ID4+IHN0cnVjdCBlc2RoY19wbGF0Zm9ybV9kYXRhIChh
cmNoL2FybS9wbGF0LW14Yy9pbmNsdWRlL21hY2gvZXNkaGMuaCkNCj4gPj4gYnV0IGl0J3Mgbm90
IHlldCB1c2VkIGJ5IHRoZSBkcml2ZXIuDQo+ID4NCj4gPiBJdCdzIGFsbCBwcmVwYXJlZC4gSSBm
aW5hbGx5IHdpbGwgaGF2ZSBhIGxvb2sgaW50byBpdCB0b2RheS4NCj4gDQo+IG9oLCBncmVhdC4g
SSB3YXMgdGhpbmtpbmcgYWJvdXQgZG9pbmcgaXQgYnV0IEknbGwgd2FpdCBmb3IgeW91ciBwYXRj
aGVzDQo+IHRoZW4uIEknbSBzdXJlIEkgbmVlZCBzdXBwb3J0IGZvciBXUCBvbiBHUElPIGJ1dCBJ
IG1heSBhbHNvIG5lZWQgc3VwcG9ydA0KPiBmb3IgQ0Qgb24gR1BJTyBzbyBJJ2xsIGJlIGhhcHB5
IHRvIHRlc3QgYW55IHBhdGNoIHlvdSBoYXZlLg0KPiANCj4gDQo+IFRoYW5rcywNCj4gQXJuYXVk
DQoNCg==

