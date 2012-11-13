From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH V4] Powerpc eSDHC Recover from the ADMA error
Date: Tue, 13 Nov 2012 07:51:38 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C21CCE3@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1348107563-16545-1-git-send-email-Haijun.Zhang@freescale.com>
 <20120920025702.GA13639@lizard>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [216.32.181.183] ([216.32.181.183]:17321 "EHLO
	ch1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753134Ab2KMHws (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Nov 2012 02:52:48 -0500
In-Reply-To: <20120920025702.GA13639@lizard>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Anton Vorontsov <cbouatmailru@gmail.com>, Zhang Haijun-B42677 <B42677@freescale.com>

SGksIENocmlzLA0KVGhpcyBwYXRjaCBoYXMgYmVlbiBBQ0tlZCBieSBBbnRvbiAgb24gU2VwIDIw
Lg0KSGF2ZSB5b3UgYW55IGNvbW1lbnQgYWJvdXQgaXQ/DQoNCkJlc3QgUmVnYXJkcw0KSmVycnkg
SHVhbmcNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFudG9uIFZv
cm9udHNvdiBbbWFpbHRvOmNib3VhdG1haWxydUBnbWFpbC5jb21dDQo+IFNlbnQ6IFRodXJzZGF5
LCBTZXB0ZW1iZXIgMjAsIDIwMTIgMTA6NTcgQU0NCj4gVG86IFpoYW5nIEhhaWp1bi1CNDI2NzcN
Cj4gQ2M6IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IEh1YW5nIENoYW5nbWluZy1SNjYwOTMN
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCBWNF0gUG93ZXJwYyBlU0RIQyBSZWNvdmVyIGZyb20gdGhl
IEFETUEgZXJyb3INCj4gDQo+IE9uIFRodSwgU2VwIDIwLCAyMDEyIGF0IDEwOjE5OjIzQU0gKzA4
MDAsIEhhaWp1bi5aaGFuZ0BmcmVlc2NhbGUuY29tDQo+IHdyb3RlOg0KPiA+IEZyb206IEhhaWp1
biBaaGFuZyA8SGFpanVuLlpoYW5nQGZyZWVzY2FsZS5jb20+DQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBIYWlqdW4gWmhhbmcgPEhhaWp1bi5aaGFuZ0BmcmVlc2NhbGUuY29tPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEplcnJ5IEh1YW5nIDxDaGFuZy1NaW5nLkh1YW5nQGZyZWVzY2FsZS5jb20+DQo+
ID4gQ0M6IEFudG9uIFZvcm9udHNvdiA8Y2JvdWF0bWFpbHJ1QGdtYWlsLmNvbT4NCj4gPiAtLS0N
Cj4gDQo+IFRoaXMgb25lIGxvb2tzIHBlcmZlY3QsIHRoYW5rcyENCj4gDQo+IEFja2VkLWJ5OiBB
bnRvbiBWb3JvbnRzb3YgPGNib3VhdG1haWxydUBnbWFpbC5jb20+DQo+IA0KPiA+IGNoYW5nZXMg
Zm9yIHY0Og0KPiA+IAktIENvcnJlY3QgaW5jb25zaXN0ZW50IGlzc3VlDQo+ID4NCj4gPiBjaGFu
Z2VzIGZvciB2MzoNCj4gPiAgICAgICAgIC0gQ29ycmVjdCB0aGUgaWYgc3RhdGVtZW50IGluIGZ1
bmN0aW9uIHdvcmtncm91bmQNCj4gPg0KPiA+IGNoYW5nZXMgZm9yIHYyOg0KPiA+ICAgICAgICAg
LSBJbnZlcnQgdGhlIGNvbmRpdGlvbiBvZiB0aGUgaWYgc3RhdGVtZW50IGluIGZ1bmN0aW9uDQo+
IHdvcmtncm91bmQNCg0K

