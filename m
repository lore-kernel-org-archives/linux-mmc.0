From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH V4] Powerpc eSDHC Recover from the ADMA error
Date: Tue, 23 Oct 2012 05:49:34 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C1C651F@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1348107563-16545-1-git-send-email-Haijun.Zhang@freescale.com>
 <20120920025702.GA13639@lizard>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:16408 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751713Ab2JWFtn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Oct 2012 01:49:43 -0400
In-Reply-To: <20120920025702.GA13639@lizard>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Zhang Haijun-B42677 <B42677@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>

SEksIENocmlzLA0KVGhpcyBwYXRjaCBoYXMgYmVlbiBBQ0tFRCBieSBBbnRvbiBvbmUgbW9udGgg
YWdvLg0KQ291bGQgeW91IGhhdmUgYW55IGNvbW1lbnQgYWJvdXQgaXQ/DQoNCkJlc3QgUmVnYXJk
cw0KSmVycnkgSHVhbmcNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEFudG9uIFZvcm9udHNvdiBbbWFpbHRvOmNib3VhdG1haWxydUBnbWFpbC5jb21dDQo+IFNlbnQ6
IFRodXJzZGF5LCBTZXB0ZW1iZXIgMjAsIDIwMTIgMTA6NTcgQU0NCj4gVG86IFpoYW5nIEhhaWp1
bi1CNDI2NzcNCj4gQ2M6IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IEh1YW5nIENoYW5nbWlu
Zy1SNjYwOTMNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWNF0gUG93ZXJwYyBlU0RIQyBSZWNvdmVy
IGZyb20gdGhlIEFETUEgZXJyb3INCj4gDQo+IE9uIFRodSwgU2VwIDIwLCAyMDEyIGF0IDEwOjE5
OjIzQU0gKzA4MDAsIEhhaWp1bi5aaGFuZ0BmcmVlc2NhbGUuY29tDQo+IHdyb3RlOg0KPiA+IEZy
b206IEhhaWp1biBaaGFuZyA8SGFpanVuLlpoYW5nQGZyZWVzY2FsZS5jb20+DQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBIYWlqdW4gWmhhbmcgPEhhaWp1bi5aaGFuZ0BmcmVlc2NhbGUuY29tPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEplcnJ5IEh1YW5nIDxDaGFuZy1NaW5nLkh1YW5nQGZyZWVzY2Fs
ZS5jb20+DQo+ID4gQ0M6IEFudG9uIFZvcm9udHNvdiA8Y2JvdWF0bWFpbHJ1QGdtYWlsLmNvbT4N
Cj4gPiAtLS0NCj4gDQo+IFRoaXMgb25lIGxvb2tzIHBlcmZlY3QsIHRoYW5rcyENCj4gDQo+IEFj
a2VkLWJ5OiBBbnRvbiBWb3JvbnRzb3YgPGNib3VhdG1haWxydUBnbWFpbC5jb20+DQo+IA0KPiA+
IGNoYW5nZXMgZm9yIHY0Og0KPiA+IAktIENvcnJlY3QgaW5jb25zaXN0ZW50IGlzc3VlDQo+ID4N
Cj4gPiBjaGFuZ2VzIGZvciB2MzoNCj4gPiAgICAgICAgIC0gQ29ycmVjdCB0aGUgaWYgc3RhdGVt
ZW50IGluIGZ1bmN0aW9uIHdvcmtncm91bmQNCj4gPg0KPiA+IGNoYW5nZXMgZm9yIHYyOg0KPiA+
ICAgICAgICAgLSBJbnZlcnQgdGhlIGNvbmRpdGlvbiBvZiB0aGUgaWYgc3RhdGVtZW50IGluIGZ1
bmN0aW9uDQo+IHdvcmtncm91bmQNCg0K

