From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 3/4 v5] SDHCI: add sdhci_get_cd callback to detect the
 card
Date: Mon, 19 Nov 2012 03:38:32 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C225076@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1351584769-16662-1-git-send-email-r66093@freescale.com>
 <1351584769-16662-2-git-send-email-r66093@freescale.com>
 <1351584769-16662-3-git-send-email-r66093@freescale.com>
 <110EED8CC96DFC488B7E717A2027A27C224F8F@039-SN1MPN1-004.039d.mgd.msft.net>
 <20121119025816.GB5165@lizard>
 <110EED8CC96DFC488B7E717A2027A27C22503C@039-SN1MPN1-004.039d.mgd.msft.net>
 <20121119033101.GA17901@lizard>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe006.messaging.microsoft.com ([213.199.154.209]:57123
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752556Ab2KSDij (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Nov 2012 22:38:39 -0500
In-Reply-To: <20121119033101.GA17901@lizard>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

DQoNCkJlc3QgUmVnYXJkcw0KSmVycnkgSHVhbmcNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IGxpbnV4LW1tYy1vd25lckB2Z2VyLmtlcm5lbC5vcmcgW21haWx0bzps
aW51eC1tbWMtDQo+IG93bmVyQHZnZXIua2VybmVsLm9yZ10gT24gQmVoYWxmIE9mIEFudG9uIFZv
cm9udHNvdg0KPiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDE5LCAyMDEyIDExOjMxIEFNDQo+IFRv
OiBIdWFuZyBDaGFuZ21pbmctUjY2MDkzDQo+IENjOiBDaHJpcyBCYWxsOyBsaW51eC1tbWNAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy80IHY1XSBTREhDSTogYWRkIHNk
aGNpX2dldF9jZCBjYWxsYmFjayB0byBkZXRlY3QNCj4gdGhlIGNhcmQNCj4gDQo+IE9uIE1vbiwg
Tm92IDE5LCAyMDEyIGF0IDAzOjE1OjUzQU0gKzAwMDAsIEh1YW5nIENoYW5nbWluZy1SNjYwOTMg
d3JvdGU6DQo+IFsuLi5dDQo+ID4gPiA+ID4gQEAgLTE1NzMsNiArMTU3MywyNiBAQCBzdGF0aWMg
aW50IHNkaGNpX2dldF9ybyhzdHJ1Y3QgbW1jX2hvc3QNCj4gKm1tYykNCj4gPiA+ID4gPiAgCXJl
dHVybiByZXQ7DQo+ID4gPiA+ID4gIH0NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICsvKiBSZXR1cm4g
dmFsdWVzIGZvciB0aGUgc2RqY29fZ2V0X2NkIGNhbGxiYWNrOg0KPiA+ID4gPiA+ICsgKiAgIDAg
Zm9yIGEgYWJzZW50IGNhcmQNCj4gPiA+ID4gPiArICogICAxIGZvciBhIHByZXNlbnQgY2FyZA0K
PiA+ID4gPiA+ICsgKiAgIC1FTk9TWVMgd2hlbiBub3Qgc3VwcG9ydGVkIChlcXVhbCB0byBOVUxM
IGNhbGxiYWNrKQ0KPiA+ID4gPiA+ICsgKi8NCj4gPiA+DQo+ID4gPiBJbmNvcnJlY3Qgc3R5bGUu
DQo+ID4gSGksIEFudG9uLCB5b3UgbWVhbiB0aGUgY29tbWVudCBzdHlsZSBpcyBpbmNyb3JyZWN0
Pw0KPiA+IEl0IHNob3VsZCBiZToNCj4gPiAvKg0KPiA+ICAqIHh4eHh4DQo+ID4gICogeHh4eHh4
DQo+ID4gICovDQo+IA0KPiBZdXAuDQoNClRoYW5rcywgQW50b24sIEkgc2VlLg0KDQo+ID4NCj4g
PiA+ID4gPiArc3RhdGljIGludCBzZGhjaV9nZXRfY2Qoc3RydWN0IG1tY19ob3N0ICptbWMpIHsN
Cj4gPiA+DQo+ID4gPiBkaXR0bw0KPiA+IEkgZG9uJ3Qgc2VlIHRoZSBpc3N1ZSwgY291bGQgeW91
IGV4cGxhaW4gaXQ/DQo+IA0KPiBUaGUgaXNzdWUgaXMgaW4gdGhlIGJyYWNlIHBsYWNlbWVudC4g
SXQgc2hvdWxkIGJlDQo+IA0KPiBzdGF0aWMgaW50IHNkaGNpX2dldF9jZChzdHJ1Y3QgbW1jX2hv
c3QgKm1tYykNCj4gew0KPiAJLi4uDQo+IH0NCj4gDQo+IFBsZWFzZSByZWZlciB0byBEb2N1bWVu
dGF0aW9uL0NvZGluZ1N0eWxlIC0tIGl0J3MgYSBncmVhdCBkb2N1bWVudC4NCj4gDQpZZXMsIG15
IGZpcnN0IHBvc3QgaXMgdGhhdCB5b3Ugc2F5LA0KTWF5YmUgdGhlIGV4dHJhIGxpbmVzIGJyZWFr
cyBoYXMgYmVlbiByZW1vdmVkIGluIHlvdSBtZXNzYWdlLCBzbyB5b3Ugc2VlIHRoZSBpbmNvcnJl
Y3Qgc3R5bGUuDQoNCkFueXdheSwgVGhhbmsgeW91IHZlcnkgbXVjaC4NCkkgd2lsbCBwb3N0IG5l
dyB2ZXJzaW9uIHdpdGggeW91ciBSZXZpZXdlZC4NCg0K

