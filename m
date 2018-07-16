From: =?utf-8?B?RmFuZyBIb25namllKOaWuea0quadsCk=?=
        <hongjiefang@asrmicro.com>
Subject: RE: [PATCH V3] mmc: core: improve reasonableness of bus width
 setting for HS400es
Date: Mon, 16 Jul 2018 11:43:37 +0000
Message-ID: <2912293cd9e648dc8a0638debc129228@mail2012.asrmicro.com>
References: <1531739517-23108-1-git-send-email-hongjiefang@asrmicro.com>
 <CAPDyKFqU+_zPFw7f4FGWPe9OPpsDDtdF7JUxMA8ejTB0RyUCCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqU+_zPFw7f4FGWPe9OPpsDDtdF7JUxMA8ejTB0RyUCCw@mail.gmail.com>
Content-Language: zh-CN
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Bastian Stender <bst@pengutronix.de>, Chanho Min <chanho.min@lge.com>, Kyle Roeschley <kyle.roeschley@ni.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

DQo+IE9uIDE2IEp1bHkgMjAxOCBhdCAxMzoxMSwgSG9uZ2ppZSBGYW5nIDxob25namllZmFuZ0Bh
c3JtaWNyby5jb20+IHdyb3RlOg0KPiA+IG1tY19zZWxlY3RfaHM0MDBlcygpIGNhbGxzIG1tY19z
ZWxlY3RfYnVzX3dpZHRoKCkgd2hpY2ggd2lsbCBjb250aW51ZQ0KPiA+IHRvIHNldCA0Yml0IHRy
YW5zZmVyIG1vZGUgaWYgZmFpbCB0byBzZXQgOGJpdCBtb2RlLiBUaGUgYnVzIHdpZHRoDQo+ID4g
c2hvdWxkIG5vdCBiZSBzZXQgdG8gNGJpdCBpbiBIUzQwMGVzLg0KPiA+DQo+ID4gV2hlbiBmYWls
IHRvIHNldCA4Yml0IG1vZGUsIG5lZWQgcmV0dXJuIGVycm9yIGRpcmVjdGx5IGZvciBIUzQwMGVz
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSG9uZ2ppZSBGYW5nIDxob25namllZmFuZ0Bhc3Jt
aWNyby5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbW1jL2NvcmUvbW1jLmMgfCA1ICsrKyst
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL21tYy5jIGIvZHJpdmVycy9tbWMv
Y29yZS9tbWMuYw0KPiA+IGluZGV4IDQ0NjZmNWQuLmIyZTFlYjYgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9tbWMvY29yZS9tbWMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMN
Cj4gPiBAQCAtMTMzOCw4ICsxMzM4LDExIEBAIHN0YXRpYyBpbnQgbW1jX3NlbGVjdF9oczQwMGVz
KHN0cnVjdCBtbWNfY2FyZCAqY2FyZCkNCj4gPiAgICAgICAgICAgICAgICAgZ290byBvdXRfZXJy
Ow0KPiA+DQo+ID4gICAgICAgICBlcnIgPSBtbWNfc2VsZWN0X2J1c193aWR0aChjYXJkKTsNCj4g
PiAtICAgICAgIGlmIChlcnIgPCAwKQ0KPiA+ICsgICAgICAgaWYgKGVyciAhPSBNTUNfQlVTX1dJ
RFRIXzgpIHsNCj4gPiArICAgICAgICAgICAgICAgcHJfZXJyKCIlczogc3dpdGNoIHRvIDhiaXQg
YnVzIHdpZHRoIGZhaWxlZCwgZXJyOiVkXG4iLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IG1tY19ob3N0bmFtZShob3N0KSwgZXJyKTsNCj4gPiAgICAgICAgICAgICAgICAgZ290byBvdXRf
ZXJyOw0KPiANCj4gWW91IG5lZWQgdG8gc2V0IGVyciB0byBhIHByb3BlciBlcnJvciBjb2RlLCBl
bHNlIHlvdSBtYXkgcmV0dXJuIGENCj4gbm9uLWVycm9yIGNvZGUgZnJvbSB0aGUgb3V0X2VyciBs
YWJlbC4NCg0KSG93IGFib3V0IHVzaW5nIHRoZSBFSU8gb3IgRU5PVFNVUFA/DQoNCj4gDQo+IFsu
Li5dDQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0KDQpCJlINCkhvbmdqaWUNCg==
