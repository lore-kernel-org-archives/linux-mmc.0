From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH v1 0/4]mmc: enable eMMC4.41 new feature background
 operations and HPI
Date: Wed, 24 Nov 2010 16:44:13 +0800
Message-ID: <5D8008F58939784290FAB48F549751983125B43D44@shsmsx502.ccr.corp.intel.com>
References: <20101123084309.GA17754@intel.com>
 <AANLkTinvfjAZOyuiM2T8Vtj-vxS59P1HNzjKAjPiOzb_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59843 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752377Ab0KXIpS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 24 Nov 2010 03:45:18 -0500
In-Reply-To: <AANLkTinvfjAZOyuiM2T8Vtj-vxS59P1HNzjKAjPiOzb_@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alan@linux.intel.com" <alan@linux.intel.com>, "arjan@linux.intel.com" <arjan@linux.intel.com>, "Yuan, Hang" <hang.yuan@intel.com>, =?utf-8?B?7KCV7J6s7ZuI?= <jh80.chung@samsung.com>

PiANCj4gQmFzaWMgcXVlc3Rpb24uIERvIHlvdSBoYXZlIGFueSBwZXJmb3JtYW5jZSBnYWluIG9y
IGltcHJvdmVtZW50Pw0KPiBJbiBteSB0ZXN0IGVudmlyb25tZW50LiBubyBwZXJmb3JtYW5jZSBn
YWluLiBZZXMgSSBrbm93IGl0J3Mgbm90IGZvcg0KPiBwZXJmb3JtYW5jZSBpbXByb3ZlbWVudC4N
Ck15IHVuZGVyc3RhbmRpbmc6DQpJZiBCS09QUyBmZWF0dXJlIGlzIG5vdCBlbmFibGVkLCB0aGUg
YmFja2dyb3VuZCBvcGVyYXRpb25zIHdpbGwgYmUgc3RhcnRlZCB3aGVuIGNhcmQgaGFuZGxlcyBz
b21lIHJlYWQgb3Igd3JpdGUgY29tbWFuZC4gVGhpcyB3aWxsIGltcGFjdCByZWFkL3dyaXRlIHBl
cmZvcm1hbmNlLiBJZiBCS09QUyBpcyBlbmFibGVkLCBkcml2ZXIgY2FuIGNoZWNrIHdoZXRoZXIg
bmVlZCB0byBkbyBhIEJLT1BTIGVhY2ggdGltZSBhZnRlciBjYXJkIGhhbmRsZWQgYSByZWFkL3dy
aXRlIGNvbW1hbmQuIElmIG5lZWQsIGRyaXZlciBjYW4gc3RhcnQgQktPUFMgYXMgc29vbiBhcyBw
b3NzaWJsZSB3aGVuIHVzZXIgcmVxdWVzdCBpcyBlbXB0eS4gVGhpcyB3aWxsIGNhbiBpbXByb3Zl
IHJlYWQvd3JpdGUgcGVyZm9ybWFuY2UuDQpTbyBJIHRoaW5rLCBhbnlob3cgYmFja2dyb3VuZCBv
cGVyYXRpb25zIGNhbiBpbXByb3ZlIHRoZSBwZXJmb3JtYW5jZSwgYnV0IG9ubHkgY2FuIGJlIHNl
ZW4gd2hlbiB5b3VyIHRlc3QgY2FyZCBuZWVkIHRvIGRvIGEgYmFja2dyb3VuZCBvcGVyYXRpb25z
LiBJZiB5b3VyIGNhcmQgbmVlZG4ndCwgdGhlcmUgd2lsbCBiZSBubyBwZXJmb3JtYW5jZSBnYWlu
IEkgdGhpbmsuIERyaXZlciB3aWxsIHdvcmtzIGFzIG5vcm1hbC4NCkJUVywgdGhlIEJLT1BTIGlz
IGFuIG9wZXJhdGlvbmFsIGZlYXR1cmVzIGZvciBlTU1DNC40MSBjYXJkLCB0byBlbnN1cmUgd2hl
dGhlciB0aGUgY2FyZCBzdXBwb3J0IHRoaXMgZmVhdHVyZSwgY2hlY2sgZXh0X2NzZFs1MDJdLg0K
PiANCj4gSG93IHRvIG1lYXN1cmUgb3IgY2hlY2sgaXQgaGFzIHNvbWUgaW1wcm92ZW1lbnQ/DQo+
IEFueSBpZGVhcz8NCj4gDQpSaWdodCBub3cgSSBkaWRuJ3Qga25vdyBob3cgdG8gZG8gYSBwcmVj
aXNlIG1lYXN1cmVtZW50LiBNYXliZSBrZWVwIG9uIHRyYW5zZmVycmluZyBsYXJnZSBkYXRhIGZv
ciBhIGxvbmcgdGltZSB3aXRoIGEgY2FyZCB3aGljaCBlbmFibGVkL29yIG5vdCB0aGUgQktPUFMg
ZmVhdHVyZSBjYW4gaGVscCB0byBnZXQgc29tZSBtZWFzdXJlbWVudCBkYXRhLg0KDQpUaGFua3MN
CkNodWFueGlhbw0K
