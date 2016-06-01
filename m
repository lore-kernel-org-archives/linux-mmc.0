From: "Baranowska, BeataX" <beatax.baranowska@intel.com>
Subject: RE: [PATCH] mmc: host: use pr_err for sdhci_dumpregs
Date: Wed, 1 Jun 2016 05:12:59 +0000
Message-ID: <CC22646CC0522A488A20F7A66BFD619308D8DB@irsmsx105.ger.corp.intel.com>
References: <CC22646CC0522A488A20F7A66BFD619308D491@irsmsx105.ger.corp.intel.com>
 <CAHp75Veem2Dkrni8nYq7q-8h2GPUVQ-q7JOF_0OxDO6GGpSxCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Veem2Dkrni8nYq7q-8h2GPUVQ-q7JOF_0OxDO6GGpSxCg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Hunter, Adrian" <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "Jarosz, SebastianX" <sebastianx.jarosz@intel.com>
List-Id: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gW21h
aWx0bzphbmR5LnNoZXZjaGVua29AZ21haWwuY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBNYXkgMzEs
IDIwMTYgNTo0NyBQTQ0KPiBUbzogQmFyYW5vd3NrYSwgQmVhdGFYIDxiZWF0YXguYmFyYW5vd3Nr
YUBpbnRlbC5jb20+DQo+IENjOiBIdW50ZXIsIEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRlbC5j
b20+OyBVbGYgSGFuc3Nvbg0KPiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz47IGxpbnV4LW1tY0B2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBEb25nLCBD
aHVhbnhpYW8gPGNodWFueGlhby5kb25nQGludGVsLmNvbT47DQo+IEphcm9zeiwgU2ViYXN0aWFu
WCA8c2ViYXN0aWFueC5qYXJvc3pAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBt
bWM6IGhvc3Q6IHVzZSBwcl9lcnIgZm9yIHNkaGNpX2R1bXByZWdzDQo+IA0KPiBPbiBNb24sIE1h
eSAzMCwgMjAxNiBhdCAxMDo1OSBBTSwgQmFyYW5vd3NrYSwgQmVhdGFYDQo+IDxiZWF0YXguYmFy
YW5vd3NrYUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+IEZyb206IENodWFueGlhbyBEb25nIDxjaHVh
bnhpYW8uZG9uZ0BpbnRlbC5jb20+DQo+ID4NCj4gPiBzZGhjaV9kdW1wcmVncyBpcyB1c2VkIHRv
IGR1bXAgcmVnaXN0ZXJzIHdoZW4gZXJyb3IgaGFwcGVucy4gVGh1cyBpdA0KPiA+IHNob3VsZCB1
c2UgcHJfZXJyIGluc3RlYWQgb2YgcHJfZGVidWcgdG8gc2hvdyBtb3JlIGluZm9ybWF0aW9uIGFi
b3V0DQo+IHRoZSBoYXJkd2FyZS4NCj4gPg0KPiANCj4gV291bGRuJ3QgYmUgdG9vIG5vaXN5Pw0K
PiANCj4gLS0NCj4gV2l0aCBCZXN0IFJlZ2FyZHMsDQo+IEFuZHkgU2hldmNoZW5rbw0KDQpJdCBp
cyB3aGVuIGVycm9yIGhhcHBlbnMgc28gSU1ITyBpdCBzaG91bGQgYmUgd2VsbCB2aXNpYmxlLg0K
DQpSZWdhcmRzLA0KQmVhdGEgQmFyYW5vd3NrYQ0KDQo=
