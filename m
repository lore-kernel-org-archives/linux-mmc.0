From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH] powerpc/esdhc: enable the card insert/remove interrupt
Date: Mon, 29 Oct 2012 01:40:19 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C1E9664@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1350975677-8195-1-git-send-email-r66093@freescale.com>
 <20121023082648.GA21690@lizard>
 <110EED8CC96DFC488B7E717A2027A27C1C68D9@039-SN1MPN1-003.039d.mgd.msft.net>
 <110EED8CC96DFC488B7E717A2027A27C1D7A42@039-SN1MPN1-003.039d.mgd.msft.net>
 <20121025103038.GA5107@lizard>
 <110EED8CC96DFC488B7E717A2027A27C1DFBFB@039-SN1MPN1-004.039d.mgd.msft.net>
 <20121027011249.GB9152@lizard>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:42412
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751780Ab2J2BkY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 28 Oct 2012 21:40:24 -0400
In-Reply-To: <20121027011249.GB9152@lizard>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kumar Gala <galak@kernel.crashing.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>

PiBIZWxsbyBIdWFuZywNCj4gDQo+IE9uIEZyaSwgT2N0IDI2LCAyMDEyIGF0IDAyOjQyOjM2QU0g
KzAwMDAsIEh1YW5nIENoYW5nbWluZy1SNjYwOTMgd3JvdGU6DQo+ID4gRm9yIHRoZSBjdXJyZW50
IHBvbGxpbmcgbW9kZSwgZHJpdmVyIHdpbGwgc2VuZCBDTUQxMyB0byBwb2xsIHRoZSBjYXJkDQo+
IHN0YXR1cyBwZXJpb2RpY2FsbHkgLCB3aGljaCB3aWxsIGNhdXNlIHRvbyBtYW55IGludGVycnVw
dHMuDQo+ID4gT25jZSBJIHNlbnQgcGF0Y2hlcyB0byBkZXRlY3QgdGhlIGNhcmQgd2hlbiB1c2lu
ZyBwb2xsaW5nIG1vZGUgbGFzdA0KPiB5ZWFyOiByZWFkIHRoZSBzdGF0ZSByZWdpc3RlciwgaW5z
dGVhZCBvZiBzZW5kIENNRDEzLiBCdXQsIHRoZXNlIHBhdGNoZXMNCj4gd2VyZSBub3QgYWNjZXB0
ZWQuIE5vdyBJIGF0dGFjaCB0aGVtIGZvciB5b3UuDQo+IA0KPiBXYXMgdGhlcmUgYW55IHNwZWNp
ZmljIHJlYXNvbiB3aHkgdGhlIHBhdGNoZXMgZGlkbid0IGdldCBhY2NlcHRlZD8NCj4gDQo+IEkg
dmVyeSBicmllZmx5IGxvb2tlZCBhdCB0aGVtLCBhbmQgdGhleSBzZWVtIHRvIGJlIE9LICh0aGVy
ZSBhcmUgYSBmZXcNCj4gY29zbWV0aWMgZGV0YWlscyBJJ2QgY29tbWVudCBvbiwgdGhvIC0tIGJ1
dCBwbGVhc2Ugc2VuZCB0aGVtIGluIGEgbm9ybWFsDQo+IHdheSAoaS5lLiBub3QgYXMgYXR0YWNo
bWVudHMpLg0KPiANCg0KVGhhbmtzLCBBbnRvbi4NCkkgZG9uJ3Qga25vdyB3aHkuDQpJIHdpbGwg
cmVzZW5kIHRoZXNlIHBhdGNoZXMgYmFzZWQgb24gbGF0ZXN0IGtlcm5lbC4NCg0K

