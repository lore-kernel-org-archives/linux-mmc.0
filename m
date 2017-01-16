From: Bough Chen <haibo.chen@nxp.com>
Subject: RE: eMMC boot problem: switch to bus width 8 ddr failed
Date: Mon, 16 Jan 2017 03:12:16 +0000
Message-ID: <AM4PR0401MB2324085C8FC8BCE5B999C949907D0@AM4PR0401MB2324.eurprd04.prod.outlook.com>
References: <20170106004114.GA22893@archie.localdomain>
 <1754f0ae-fe6f-00a2-a0d6-9fd55c2b866f@rock-chips.com>
 <20170106155618.GA10105@archie.localdomain>
 <CAPDyKFoUeYrE7nC2Ds8XHBYXtQpLHkRXKp_hFyD0m6fuuFM==w@mail.gmail.com>
 <103b3045-c17d-ef14-c843-471fcb6e537f@rock-chips.com>
 <AM4PR0401MB232420E07E9DA5FE18E8B38790780@AM4PR0401MB2324.eurprd04.prod.outlook.com>
 <CAPDyKFpAYY6grArvLGMr7X577uLEXjnv479ML52CKfkMXxyqUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpAYY6grArvLGMr7X577uLEXjnv479ML52CKfkMXxyqUw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Clemens Gruber <clemens.gruber@pqgruber.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, "A.S. Dong" <aisheng.dong@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Gary Bisson <gary.bisson@boundarydevices.com>, Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>
List-Id: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVbGYgSGFuc3NvbiBbbWFpbHRv
OnVsZi5oYW5zc29uQGxpbmFyby5vcmddDQo+IFNlbnQ6IEZyaWRheSwgSmFudWFyeSAxMywgMjAx
NyA3OjIzIFBNDQo+IFRvOiBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+IENjOiBT
aGF3biBMaW4gPHNoYXduLmxpbkByb2NrLWNoaXBzLmNvbT47IENsZW1lbnMgR3J1YmVyDQo+IDxj
bGVtZW5zLmdydWJlckBwcWdydWJlci5jb20+OyBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBM
aW51cyBXYWxsZWlqDQo+IDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+OyBBZHJpYW4gSHVudGVy
IDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47IEEuUy4NCj4gRG9uZyA8YWlzaGVuZy5kb25nQG54
cC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBHYXJ5IEJpc3Nvbg0KPiA8Z2Fy
eS5iaXNzb25AYm91bmRhcnlkZXZpY2VzLmNvbT47IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdt
YWlsLmNvbT47DQo+IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4NCj4gU3ViamVjdDog
UmU6IGVNTUMgYm9vdCBwcm9ibGVtOiBzd2l0Y2ggdG8gYnVzIHdpZHRoIDggZGRyIGZhaWxlZA0K
PiANCj4gWy4uLl0NCj4gDQo+ID4gSGkgVWxmIGFuZCBTaGF3biwNCj4gPg0KPiA+IEFpc2hlbmcg
YW5kIEkgZGVidWcgdGhpcyBpc3N1ZSB0aGVzZSBkYXlzLCBhbmQgd2UgZmluZCB0aGUgcm9vdCBj
YXVzZS4NCj4gPiBUaGVyZSBhcmUgdHdvIHRoaW5ncyB0byBkZXNjcmliZS4NCj4gPg0KPiA+IDEp
IHZvbHRhZ2Ugc3dpdGNoIGlzc3VlLiAgVGhlIHByb3Blcml0eSAibm8tMS04LXYiIGRvIG5vdCB3
b3JrIGZvcg0KPiBNTUNfVElNSU5HX01NQ19ERFI1Mi4NCj4gPiBUaGlzIGlzIGFub3RoZXIgYnVn
LCB3ZSBuZWVkIHRvIGZpeCwgYnV0IGhhcyBubyByZWxhdGlvbiB3aXRoIHRoZSBjdXJyZW50IGJ1
Zy4NCj4gDQo+IEkgYW0gd29ya2luZyBvbiBhIHBhdGNoIHdoaWNoIGludmVudHMgTU1DX0NBUF8z
XzNWX0REUiBhbmQgd2hpY2ggaGFzIGENCj4gY29ycmVzcG9uZGluZyBEVCBiaW5kaW5nICJtbWMt
ZGRyLTNfM3YiLg0KPiBHaXZlIG1lIGEgZGF5IG9yIHNvLCB0aGVuIEkgd2lsbCBwb3N0IGl0Lg0K
PiANCj4gTGlrZWx5IGl0IHNob3VsZCBoZWxwIHRvIHJlc29sdmUgeW91ciBpc3N1ZSwgZG9uJ3Qg
eW91IHRoaW5rPw0KDQpTZWVtcyBZZXMsIEkgd2lsbCB0ZXN0IHRoZSBwYXRjaCB3aGVuIHlvdSBw
b3N0Lg0KDQpCZXN0IFJlZ2FyZHMsDQpIYWlibyBDaGVuDQoNCj4gDQo+IFsuLi5dDQo+IA0KPiBL
aW5kIHJlZ2FyZHMNCj4gVWZmZQ0K
