From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH v6] powerpc/esdhc: disable CMD23 for some Freescale SoCs
Date: Thu, 25 Oct 2012 10:04:13 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C1D7A20@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1351144039-30588-1-git-send-email-r66093@freescale.com>
 <20121025080120.GA23807@lizard>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:26107 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934884Ab2JYKES (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Oct 2012 06:04:18 -0400
In-Reply-To: <20121025080120.GA23807@lizard>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Xie Shaohui-B21989 <B21989@freescale.com>, Chris Ball <cjb@laptop.org>

VGhhbmsgeW91IHZlcnkgbXVjaCwgQW50b24uDQoNCkJlc3QgUmVnYXJkcw0KSmVycnkgSHVhbmcN
Cg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFudG9uIFZvcm9udHNv
diBbbWFpbHRvOmNib3VhdG1haWxydUBnbWFpbC5jb21dDQo+IFNlbnQ6IFRodXJzZGF5LCBPY3Rv
YmVyIDI1LCAyMDEyIDQ6MDEgUE0NCj4gVG86IEh1YW5nIENoYW5nbWluZy1SNjYwOTMNCj4gQ2M6
IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IEh1YW5nIENoYW5nbWluZy1SNjYwOTM7IFhpZSBT
aGFvaHVpLUIyMTk4OTsNCj4gQ2hyaXMgQmFsbA0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2XSBw
b3dlcnBjL2VzZGhjOiBkaXNhYmxlIENNRDIzIGZvciBzb21lIEZyZWVzY2FsZQ0KPiBTb0NzDQo+
IA0KPiBPbiBUaHUsIE9jdCAyNSwgMjAxMiBhdCAwMTo0NzoxOVBNICswODAwLCByNjYwOTNAZnJl
ZXNjYWxlLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBKZXJyeSBIdWFuZyA8Q2hhbmctTWluZy5IdWFu
Z0BmcmVlc2NhbGUuY29tPg0KPiA+DQo+ID4gQ01EMjMgY2F1c2VzIGxvdHMgb2YgZXJyb3JzIGlu
IGtlcm5lbCBvbiBzb21lIGZyZWVzY2FsZSBTb0NzIChQMTAyMCwNCj4gPiBQMTAyMSwgUDEwMjIs
IFAxMDI0LCBQMTAyNSBhbmQgUDQwODApIHdoZW4gTU1DIGNhcmQgdXNlZCwgd2hpY2ggaXMNCj4g
PiBiZWNhdXNlIHRoZXNlIGNvbnRyb2xsZXJzIGRvZXMgbm90IHN1cHBvcnQgQ01EMjMsIGV2ZW4g
b24gdGhlIFNvQ3MNCj4gPiB3aGljaCBkZWNsYXJlcyBDTUQyMyBpcyBzdXBwb3J0ZWQuDQo+ID4g
VGhlcmVmb3JlLCB3ZSdsbCBub3QgdXNlIENNRDIzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
SmVycnkgSHVhbmcgPENoYW5nLU1pbmcuSHVhbmdAZnJlZXNjYWxlLmNvbT4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBTaGFvaHVpIFhpZSA8U2hhb2h1aS5YaWVAZnJlZXNjYWxlLmNvbT4NCj4gPiBDQzog
Q2hyaXMgQmFsbCA8Y2piQGxhcHRvcC5vcmc+DQo+ID4gLS0tDQo+IA0KPiBMb29rcyBwZXJmZWN0
LCB0aGFua3MgYSBsb3QhDQo+IA0KPiBBY2tlZC1ieTogQW50b24gVm9yb250c292IDxjYm91YXRt
YWlscnVAZ21haWwuY29tPg0KDQo=

