From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 3/4 v5] SDHCI: add sdhci_get_cd callback to detect the
 card
Date: Mon, 19 Nov 2012 03:15:53 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C22503C@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1351584769-16662-1-git-send-email-r66093@freescale.com>
 <1351584769-16662-2-git-send-email-r66093@freescale.com>
 <1351584769-16662-3-git-send-email-r66093@freescale.com>
 <110EED8CC96DFC488B7E717A2027A27C224F8F@039-SN1MPN1-004.039d.mgd.msft.net>
 <20121119025816.GB5165@lizard>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe004.messaging.microsoft.com ([216.32.180.187]:44975
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752226Ab2KSDP6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Nov 2012 22:15:58 -0500
In-Reply-To: <20121119025816.GB5165@lizard>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbnRvbiBWb3JvbnRzb3YgW21h
aWx0bzpjYm91YXRtYWlscnVAZ21haWwuY29tXQ0KPiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDE5
LCAyMDEyIDEwOjU4IEFNDQo+IFRvOiBIdWFuZyBDaGFuZ21pbmctUjY2MDkzDQo+IENjOiBDaHJp
cyBCYWxsOyBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
My80IHY1XSBTREhDSTogYWRkIHNkaGNpX2dldF9jZCBjYWxsYmFjayB0byBkZXRlY3QNCj4gdGhl
IGNhcmQNCj4gDQo+IE9uIE1vbiwgTm92IDE5LCAyMDEyIGF0IDAyOjUwOjE4QU0gKzAwMDAsIEh1
YW5nIENoYW5nbWluZy1SNjYwOTMgd3JvdGU6DQo+IFsuLi5dDQo+ID4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jDQo+IGlu
ZGV4DQo+ID4gPiBmMDVhMzc3Li5jYzljOGE2IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9t
bWMvaG9zdC9zZGhjaS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMNCj4g
PiA+IEBAIC0xNTczLDYgKzE1NzMsMjYgQEAgc3RhdGljIGludCBzZGhjaV9nZXRfcm8oc3RydWN0
IG1tY19ob3N0ICptbWMpDQo+ID4gPiAgCXJldHVybiByZXQ7DQo+ID4gPiAgfQ0KPiA+ID4NCj4g
PiA+ICsvKiBSZXR1cm4gdmFsdWVzIGZvciB0aGUgc2RqY29fZ2V0X2NkIGNhbGxiYWNrOg0KPiA+
ID4gKyAqICAgMCBmb3IgYSBhYnNlbnQgY2FyZA0KPiA+ID4gKyAqICAgMSBmb3IgYSBwcmVzZW50
IGNhcmQNCj4gPiA+ICsgKiAgIC1FTk9TWVMgd2hlbiBub3Qgc3VwcG9ydGVkIChlcXVhbCB0byBO
VUxMIGNhbGxiYWNrKQ0KPiA+ID4gKyAqLw0KPiANCj4gSW5jb3JyZWN0IHN0eWxlLg0KSGksIEFu
dG9uLCB5b3UgbWVhbiB0aGUgY29tbWVudCBzdHlsZSBpcyBpbmNyb3JyZWN0Pw0KSXQgc2hvdWxk
IGJlOg0KLyoNCiAqIHh4eHh4DQogKiB4eHh4eHgNCiAqLw0KDQo+ID4gPiArc3RhdGljIGludCBz
ZGhjaV9nZXRfY2Qoc3RydWN0IG1tY19ob3N0ICptbWMpIHsNCj4gDQo+IGRpdHRvDQpJIGRvbid0
IHNlZSB0aGUgaXNzdWUsIGNvdWxkIHlvdSBleHBsYWluIGl0Pw0KDQo+IA0KPiA+ID4gKwlzdHJ1
Y3Qgc2RoY2lfaG9zdCAqaG9zdCA9IG1tY19wcml2KG1tYyk7DQo+ID4gPiArCXVuc2lnbmVkIGxv
bmcgZmxhZ3M7DQo+ID4gPiArCWludCBwcmVzZW50ID0gLUVOT1NZUzsNCj4gDQo+IAlpZiAoIWhv
c3QtPm9wcy0+Z2V0X2NkKQ0KPiAJCXJldHVybiAtRU5PU1lTOw0KPiANCj4gCS4uLg0KPiAJLi4u
DQo+IA0KPiBPdGhlcndpc2UsIGl0IGxvb2tzIGdvb2QuDQo+IA0KPiBSZXZpZXdlZC1ieTogQW50
b24gVm9yb250c292IDxjYm91YXRtYWlscnVAZ21haWwuY29tPg0KDQo=

