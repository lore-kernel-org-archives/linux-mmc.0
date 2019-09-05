From: Avri Altman <Avri.Altman@wdc.com>
Subject: RE: [PATCH 2/2] mmc: block: add CMD13 polling for ioctl() cmd with
 R1B response
Date: Thu, 5 Sep 2019 06:21:07 +0000
Message-ID: <MN2PR04MB6991B08ECDBC4021AEFDD06EFCBB0@MN2PR04MB6991.namprd04.prod.outlook.com>
References: <20190904075444.2163-1-chaotian.jing@mediatek.com>
         <20190904075444.2163-3-chaotian.jing@mediatek.com>
         <MN2PR04MB6991F51F6DDCA28FC23D02FEFCB80@MN2PR04MB6991.namprd04.prod.outlook.com>
 <1567652136.11483.1.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1567652136.11483.1.camel@mhfsdcap03>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>, YueHaibing <yuehaibing@huawei.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ming Lei <ming.lei@redhat.com>, Chris Boot <bootc@bootc.net>, Zachary Hays <zhays@lexmark.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

IA0KPiBPbiBXZWQsIDIwMTktMDktMDQgYXQgMTQ6MTEgKzAwMDAsIEF2cmkgQWx0bWFuIHdyb3Rl
Og0KPiA+ID4gIHN0YXRpYyBpbnQgX19tbWNfYmxrX2lvY3RsX2NtZChzdHJ1Y3QgbW1jX2NhcmQg
KmNhcmQsIHN0cnVjdA0KPiA+ID4gbW1jX2Jsa19kYXRhICptZCwNCj4gPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgbW1jX2Jsa19pb2NfZGF0YSAqaWRhdGEpDQo+ID4g
PiAgew0KPiA+ID4gQEAgLTYyMyw2ICs2NzUsOSBAQCBzdGF0aWMgaW50IF9fbW1jX2Jsa19pb2N0
bF9jbWQoc3RydWN0DQo+IG1tY19jYXJkDQo+ID4gPiAqY2FyZCwgc3RydWN0IG1tY19ibGtfZGF0
YSAqbWQsDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19m
dW5jX18sIHN0YXR1cywgZXJyKTsNCj4gPiA+ICAgICAgICAgfQ0KPiA+ID4NCj4gPiA+ICsgICAg
ICAgaWYgKCFlcnIgJiYgKGNtZC5mbGFncyAmIE1NQ19SU1BfUjFCKSkNCj4gPiA+ICsgICAgICAg
ICAgICAgICBlcnIgPSBjYXJkX2J1c3lfZGV0ZWN0KGNhcmQsIE1NQ19CTEtfVElNRU9VVF9NUywN
Cj4gTlVMTCk7DQo+ID4gPiArDQo+ID4gPiAgICAgICAgIHJldHVybiBlcnI7DQo+ID4gPiAgfQ0K
PiA+IFlvdSBoYXZlIGJvdGggdGhlIFIxQiBmbGFnIGNoZWNrLCBhbmQgc3RhdHVzIHBvbGwgKGZv
ciBycG1iKSBmZXcgbGluZQ0KPiBhYm92ZS4NCj4gPiBNYXliZSB5b3UgY291bGQgcmUtdXNlIGl0
Lg0KPiA+IEl0IHdpbGwgYm90aCBzaW1wbGlmeSB0aGlzIHBhdGNoLCBhbmQgc2F2ZSB0aGUgdGFk
IG9wdGltaXphdGlvbiBvZiB5b3VyDQo+IGZpcnN0IHBhdGNoLg0KPiA+DQo+ID4gVGhhbmtzLA0K
PiA+IEF2cmkNCj4gDQo+IFNvIHRoYXQgd2UgY2FuIGRyb3AgdGhlIGlvY3RsX3JwbWJfY2FyZF9z
dGF0dXNfcG9sbCgpIGFzIGl0IGRvIGFsbW9zdA0KPiB0aGUgc2FtZSB0aGluZyB3aXRoIGNhcmRf
YnVzeV9kZXRlY3QoKS4NCj4gDQpyaWdodA0K
