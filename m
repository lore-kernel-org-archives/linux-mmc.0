From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: RE: [PATCH v5 1/4] ARM: davinci: mmc: derive version information
 from device name
Date: Thu, 14 Mar 2013 13:51:12 +0000
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA48F34@DBDE01.ent.ti.com>
References: <1363097637-11371-1-git-send-email-prakash.pm@ti.com>
 <1363097637-11371-2-git-send-email-prakash.pm@ti.com>
 <5141AF99.5090608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52888 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757766Ab3CNNve (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Mar 2013 09:51:34 -0400
In-Reply-To: <5141AF99.5090608@ti.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nori, Sekhar" <nsekhar@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "rob@landley.net" <rob@landley.net>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "hs@denx.de" <hs@denx.de>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "cjb@laptop.org" <cjb@laptop.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>

T24gVGh1LCBNYXIgMTQsIDIwMTMgYXQgMTY6Mzg6MDksIE5vcmksIFNla2hhciB3cm90ZToNCj4g
UHJha2FzaCwNCj4gDQo+IFRoZSBzZXJpZXMgbG9va3MgZ29vZCB0byBtZS4gSSB0ZXN0ZWQgaXQg
YWdhaW4gb24gREE4NTAgRVZNICh3aXRoIGFuZA0KPiB3aXRob3V0IERUKS4NCj4gDQo+IE9uIDMv
MTIvMjAxMyA3OjQzIFBNLCBNYW5qdW5hdGhhcHBhLCBQcmFrYXNoIHdyb3RlOg0KPiA+IFJlbW92
ZSBzcGVjaWZ5aW5nIG1tYyBjb250cm9sbGVyIElQIHZlcnNpb24gaW5mb3JtYXRpb24gdmlhIHBs
YXRmb3JtDQo+ID4gZGF0YSwgaW5zdGVhZCBzcGVjaWZ5IGRldmljZSBuYW1lIHNvIHRoYXQgZHJp
dmVyIGRlcml2ZXMgaXQgZnJvbQ0KPiA+IHBsYXRmb3JtX2RldmljZV9pZCB0YWJsZS4gQWxzbyBj
aGFuZ2UgdGhlIGNsb2NrIG5vZGUgbmFtZSB0byBtYXRjaA0KPiA+IHRoZSBjaGFuZ2VkIGRldl9p
ZC4NCj4gPiBUZXN0ZWQgb24gZGE4NTAtZXZtIHRvIG1ha2Ugc3VyZSBkcml2ZXIgbG9hZHMgd2l0
aG91dCBjbGtfZ2V0IGZhaWx1cmVzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hbmp1bmF0
aGFwcGEsIFByYWthc2ggPHByYWthc2gucG1AdGkuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBTZWto
YXIgTm9yaSA8bnNla2hhckB0aS5jb20+DQo+ID4gLS0tDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL21tYy9ob3N0L2RhdmluY2lfbW1jLmMgYi9kcml2ZXJzL21tYy9ob3N0L2RhdmluY2lf
bW1jLmMNCj4gPiBpbmRleCAyNzEyM2Y4Li41MGU5NzgyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvbW1jL2hvc3QvZGF2aW5jaV9tbWMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3QvZGF2
aW5jaV9tbWMuYw0KPiA+IEBAIC0xMTU3LDYgKzExNTcsMTggQEAgc3RhdGljIHZvaWQgX19pbml0
IGluaXRfbW1jc2RfaG9zdChzdHJ1Y3QgbW1jX2RhdmluY2lfaG9zdCAqaG9zdCkNCj4gPiAgCW1t
Y19kYXZpbmNpX3Jlc2V0X2N0cmwoaG9zdCwgMCk7DQo+ID4gIH0NCj4gPiAgDQo+ID4gK3N0YXRp
YyBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlX2lkIGRhdmluY2lfbW1jX2RldnR5cGVbXSA9IHsNCj4g
PiArCXsNCj4gPiArCQkubmFtZQk9ICJkYXZpbmNpLW1tYy1kbTM1NSIsDQo+ID4gKwkJLmRyaXZl
cl9kYXRhID0gTU1DX0NUTFJfVkVSU0lPTl8xLA0KPiA+ICsJfSwgew0KPiA+ICsJCS5uYW1lCT0g
ImRhdmluY2ktbW1jLWRhODMwIiwNCj4gPiArCQkuZHJpdmVyX2RhdGEgPSBNTUNfQ1RMUl9WRVJT
SU9OXzIsDQo+ID4gKwl9LA0KPiA+ICsJe30sDQo+ID4gK307DQo+ID4gK01PRFVMRV9ERVZJQ0Vf
VEFCTEUocGxhdGZvcm0sIGRhdmluY2lfbW1jX2RldnR5cGUpOw0KPiANCj4gSSBzaG91bGQgaGF2
ZSBtZW50aW9uZWQgdGhpcyBwcmV2aW91c2x5LCBidXQgeW91ciBjaG9pY2Ugb2YgbmFtZSBoZXJl
IGlzDQo+IHRvbyBsb25nLiBZb3UgY2FuIHNpbXBseSB1c2UgZG0zNTUtbW1jIChyYXRoZXIgZG02
NDQxLW1tYz8pIGFuZA0KPiBkYTgzMC1tbWMgaW5zdGVhZCBsaWtlIHlvdSBkaWQgZm9yIFNQSS4g
VGhpcyB3b3VsZCBoYXZlIHNhdmVkIHNvbWUgbG9uZw0KPiBsaW5lcy4gU29ycnkgYWJvdXQgbm90
IGFza2luZyBmb3IgdGhpcyBlYXJsaWVyLiBJIGtub3cgaXQgd291bGQgaGF2ZQ0KPiBzYXZlZCB5
b3UgYSBidW5jaCBvZiBlZmZvcnQuDQo+IA0KDQpObyBwcm9ibGVtLCB3aWxsIGNoYW5nZSB0aGUg
bmFtZS4NCg0KVGhhbmtzLA0KUHJha2FzaCANCg0K
