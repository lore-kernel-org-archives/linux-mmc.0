From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH V2] drivers: mmc: host: use devm_ioremap_resource()
Date: Thu, 16 May 2013 08:19:51 +0000 (GMT)
Message-ID: <4876879.136041368692387848.JavaMail.weblogic@epml12>
Reply-To: jg1.han@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
MIME-version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Navet <laurent.navet@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>
Cc: "nico@fluxnic.net" <nico@fluxnic.net>, "andrew@lunn.ch" <andrew@lunn.ch>, "thomas.petazzoni@free-electrons.com" <thomas.petazzoni@free-electrons.com>, "jason@lakedaemon.net" <jason@lakedaemon.net>, Jingoo Han <jg1.han@samsung.com>, "sachin.kamat@linaro.org" <sachin.kamat@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

VGh1cnNkYXksIE1heSAxNiwgMjAxMyA1OjIyIFBNLCBMYXVyZW50IE5hdmV0IHdyb3RlOg0KPiAN
Cj4gUmVwbGFjZSBhIGNhbGwgdG8gZGVwcmVjYXRlZCBkZXZtX3JlcXVlc3RfYW5kX2lvcmVtYXAg
YnkgZGV2bV9pb3JlbWFwX3Jlc291cmNlLg0KPiANCj4gRm91bmQgd2l0aCBjb2NjaWNoZWNrIGFu
ZCB0aGlzIHNlbWFudGljIHBhdGNoOg0KPiAgc2NyaXB0cy9jb2NjaW5lbGxlL2FwaS9kZXZtX2lv
cmVtYXBfcmVzb3VyY2UuY29jY2kNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExhdXJlbnQgTmF2ZXQg
PGxhdXJlbnQubmF2ZXRAZ21haWwuY29tPg0KDQpSZXZpZXdlZC1ieTogSmluZ29vIEhhbiA8amcx
LmhhbkBzYW1zdW5nLmNvbQ0KDQpCZXN0IHJlZ2FyZHMsDQpKaW5nb28gSGFuDQoNCj4gLS0tDQo+
ICBkcml2ZXJzL21tYy9ob3N0L212c2Rpby5jIHwgICAgNiArKystLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9tbWMvaG9zdC9tdnNkaW8uYyBiL2RyaXZlcnMvbW1jL2hvc3QvbXZzZGlvLmMNCj4g
aW5kZXggODk2MGZjOC4uYTY2ZWU0YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9t
dnNkaW8uYw0KPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L212c2Rpby5jDQo+IEBAIC03NTgsOSAr
NzU4LDkgQEAgc3RhdGljIGludCBfX2luaXQgbXZzZF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPiANCj4gIAlzcGluX2xvY2tfaW5pdCgmaG9zdC0+bG9jayk7DQo+IA0KPiAt
CWhvc3QtPmJhc2UgPSBkZXZtX3JlcXVlc3RfYW5kX2lvcmVtYXAoJnBkZXYtPmRldiwgcik7DQo+
IC0JaWYgKCFob3N0LT5iYXNlKSB7DQo+IC0JCXJldCA9IC1FTk9NRU07DQo+ICsJaG9zdC0+YmFz
ZSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZSgmcGRldi0+ZGV2LCByKTsNCj4gKwlpZiAoSVNfRVJS
KGhvc3QtPmJhc2UpKSB7DQo+ICsJCXJldCA9IFBUUl9FUlIoaG9zdC0+YmFzZSk7DQo+ICAJCWdv
dG8gb3V0Ow0KPiAgCX0NCj4gDQo+IC0tDQo+IDEuNy4xMC40DQo=
