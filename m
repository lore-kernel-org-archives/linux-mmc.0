From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: RE: [PATCH v2 1/3] ARM: davinci: da850: override mmc DT node device
 name
Date: Tue, 12 Feb 2013 06:20:24 +0000
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA4685E@DBDE01.ent.ti.com>
References: <1360223825-23929-1-git-send-email-prakash.pm@ti.com>
 <1360223825-23929-2-git-send-email-prakash.pm@ti.com>
 <5119D72D.3010605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <5119D72D.3010605@ti.com>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: "Nori, Sekhar" <nsekhar@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "rob@landley.net" <rob@landley.net>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "hs@denx.de" <hs@denx.de>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "cjb@laptop.org" <cjb@laptop.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

T24gVHVlLCBGZWIgMTIsIDIwMTMgYXQgMTE6MTY6MjEsIE5vcmksIFNla2hhciB3cm90ZToNCj4g
T24gMi83LzIwMTMgMToyNyBQTSwgTWFuanVuYXRoYXBwYSwgUHJha2FzaCB3cm90ZToNCj4gPiBQ
b3B1bGF0ZSBPRl9ERVZfQVVYREFUQSB3aXRoIGRlc2lyZWQgZGV2aWNlIG5hbWUgZXhwZWN0ZWQg
YnkNCj4gPiBkYXZpbmNpX21tYyBkcml2ZXIuIFdpdGhvdXQgdGhpcyBjbGtfZ2V0IG9mIGRhdmlu
Y2lfbW1jIERUIGRyaXZlcg0KPiA+IGZhaWxzLg0KPiANCj4gQnV0IHRoZXJlIGlzIG5vIG1tYyBE
VCBzdXBwb3J0IGZvciBEYVZpbmNpIGF0IHRoaXMgdGltZS4gVGhpcyBwYXRjaA0KPiBzaG91bGQg
Y29tZSBhZnRlciB0aGUgZHJpdmVyIERUIHN1cHBvcnQgYW5kIC5kdHMgYWRkaXRpb24gcGF0Y2hl
cy4NCj4gDQoNCkFncmVlZCwgSSB3aWxsIGJyaW5nIGl0IHVwIGluIHRoZSBzZXJpZXMuDQoNCj4g
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1kYXZpbmNpL2RhOHh4LWR0LmMgYi9hcmNoL2Fy
bS9tYWNoLWRhdmluY2kvZGE4eHgtZHQuYw0KPiA+IGluZGV4IDM3YzI3YWYuLjMzNjJjYTQgMTAw
NjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm0vbWFjaC1kYXZpbmNpL2RhOHh4LWR0LmMNCj4gPiArKysg
Yi9hcmNoL2FybS9tYWNoLWRhdmluY2kvZGE4eHgtZHQuYw0KPiA+IEBAIC0zOSw5ICszOSwxNiBA
QCBzdGF0aWMgdm9pZCBfX2luaXQgZGE4eHhfaW5pdF9pcnEodm9pZCkNCj4gPiAgDQo+ID4gICNp
ZmRlZiBDT05GSUdfQVJDSF9EQVZJTkNJX0RBODUwDQo+ID4gIA0KPiA+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IG9mX2Rldl9hdXhkYXRhIGRhOHh4X2F1eGRhdGFbXSBfX2luaXRjb25zdCA9IHsNCj4g
PiArCU9GX0RFVl9BVVhEQVRBKCJ0aSxkYXZpbmNpLW1tYy1kYTgzMCIsIDB4MDFjNDAwMDAsICJk
YXZpbmNpX21tYy4wIiwNCj4gPiArCQkJTlVMTCksDQo+ID4gKwl7fSwNCj4gPiArfTsNCj4gPiAr
DQo+ID4gIHN0YXRpYyB2b2lkIF9faW5pdCBkYTg1MF9pbml0X21hY2hpbmUodm9pZCkNCj4gPiAg
ew0KPiA+IC0Jb2ZfcGxhdGZvcm1fcG9wdWxhdGUoTlVMTCwgb2ZfZGVmYXVsdF9idXNfbWF0Y2hf
dGFibGUsIE5VTEwsIE5VTEwpOw0KPiA+ICsJb2ZfcGxhdGZvcm1fcG9wdWxhdGUoTlVMTCwgb2Zf
ZGVmYXVsdF9idXNfbWF0Y2hfdGFibGUsIGRhOHh4X2F1eGRhdGEsDQo+ID4gKwkJCU5VTEwpOw0K
PiANCj4gVGhpcyBuZWVkcyB0byBiZSByZWJhc2VkIG9uIGJ5IHYzLjkvZHQtMiBicmFuY2guIFRo
ZXJlIGFyZSBjb25mbGljdHMNCj4gd2l0aCB0aGUgY29kZSBhbHJlYWR5IHByZXNlbnQuDQo+IA0K
DQpZZXMsIEkgd2lsbCBzZW5kIGl0IGFmdGVyIHJlYmFzaW5nIG9uIG5ldyBicmFuY2guDQoNClRo
YW5rcywNClByYWthc2gNCg0KPiBUaGFua3MsDQo+IFNla2hhcg0KPiANCg0K
