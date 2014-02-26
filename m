From: Alex Lemberg <Alex.Lemberg@sandisk.com>
Subject: RE: [PATCH v2] mmc-utils: add eMMC 5.0 FFU support
Date: Wed, 26 Feb 2014 23:07:24 +0000
Message-ID: <282CEDFCBC30114F83C499CB8F2ED53337E3BD98@SACMBXIP02.sdcorp.global.sandisk.com>
References: <1390506264-17107-1-git-send-email-grundler@chromium.org>
	<282CEDFCBC30114F83C499CB8F2ED53337DEF464@SACMBXIP02.sdcorp.global.sandisk.com>
	<CANEJEGv_Rb5oFwkKnGGf_eH0gQ0QpaimmmmFLTkN7m=MF-OUcA@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED53337E0247E@SACMBXIP02.sdcorp.global.sandisk.com>
	<CANEJEGv_mQWUC7OTcKWytFBcadkknsmW=Q-fp=34Oan3YLP8VQ@mail.gmail.com>
 <CANEJEGsfxC+HxCmTRF+rkq_3=_SxMaacDAEKwLwT7NMY9R0iGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe005.messaging.microsoft.com ([207.46.163.28]:53528
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752908AbaBZXH3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Feb 2014 18:07:29 -0500
In-Reply-To: <CANEJEGsfxC+HxCmTRF+rkq_3=_SxMaacDAEKwLwT7NMY9R0iGw@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>, Puthikorn Voravootivat <puthik@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Avi Shchislowski <Avi.Shchislowski@sandisk.com>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogZ3J1bmRsZXJAZ29vZ2xl
LmNvbSBbbWFpbHRvOmdydW5kbGVyQGdvb2dsZS5jb21dIE9uIEJlaGFsZiBPZg0KPiBHcmFudCBH
cnVuZGxlcg0KPiBTZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDIxLCAyMDE0IDExOjMxIFBNDQo+IFRv
OiBHcmFudCBHcnVuZGxlcg0KPiBDYzogQWxleCBMZW1iZXJnOyBDaHJpcyBCYWxsOyBsaW51eC1t
bWM7IFB1dGhpa29ybiBWb3Jhdm9vdGl2YXQ7IEd3ZW5kYWwNCj4gR3JpZ25vdTsgQXZpIFNoY2hp
c2xvd3NraQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBtbWMtdXRpbHM6IGFkZCBlTU1DIDUu
MCBGRlUgc3VwcG9ydA0KPiANCj4gT24gRnJpLCBGZWIgMjEsIDIwMTQgYXQgMToyNyBQTSwgR3Jh
bnQgR3J1bmRsZXIgPGdydW5kbGVyQGNocm9taXVtLm9yZz4NCj4gd3JvdGU6DQo+ID4gQ2hyaXMs
DQo+ID4gSSBoYXZlbid0IHNlZW4gYW55dGhpbmcgZWxzZSBnZXQgcHJvcG9zZWQuIElmIG5vdCwg
Y2FuIHlvdSBpbmNsdWRlDQo+ID4gdGhpcyBwYXRjaCBpbiBtbWMtdXRpbHMgVG9UIGFuZCB1c2Ug
aXQgYXMgYSBiYXNpcyB0byBkcml2ZSB0aGUgRkZVDQo+ID4gc3VwcG9ydCBjb252ZXJzYXRpb24g
Zm9yd2FyZD8NCj4gDQo+IA0KPiBOZXZlciBtaW5kLi4uIDopDQo+IA0KPiA+DQo+ID4gT24gU3Vu
LCBGZWIgOSwgMjAxNCBhdCAxOjA2IEFNLCBBbGV4IExlbWJlcmcNCj4gPEFsZXguTGVtYmVyZ0Bz
YW5kaXNrLmNvbT4gd3JvdGU6DQo+ID4+IEhpIEdyYW50LA0KPiA+Pg0KPiA+PiBXZSB3aWxsIGNv
bnRyaWJ1dGUgc2hvcnRseSBvdXIgRkZVIGltcGxlbWVudGF0aW9uIGNvZGUgKFJGQykgLCBpbiB3
aGljaA0KPiB3ZSBhcmUgYWRkcmVzc2luZyBib3RoIGlzc3VlcyBkaXNjdXNzZWQgYmVsb3c6DQo+
ID4+DQo+ID4+IC0gRlcgRmlsZSBzaXplIGxpbWl0YXRpb24NCj4gPj4gLSBBdG9taWMgRkZVIFBy
b2Nlc3MNCj4gPg0KPiA+IERpZCB0aGlzIGdldCBwb3N0ZWQ/IG15IGdtYWlsIGZpbHRlcnMgbWln
aHQgYmUgbWlzY29uZmlndXJlZCBhbmQNCj4gPiBwcmV2ZW50ZWQgbWUgZnJvbSBzZWVpbmcgaXQu
DQo+IA0KPiBZdXAgLSB0aGlzIGhhcHBlbmVkLiBJIGZvdW5kIHRoZSBwb3N0aW5ncyBhbmQgd2ls
bCByZXZpZXcuDQoNCkFwcHJlY2lhdGUgaXQgYW5kIHdhaXRpbmcgZm9yIHlvdXIgY29tbWVudHMh
DQoNClRoYW5rcywNCkFsZXgNCg0KPiANCj4gVGhhbmtzIQ0KPiBncmFudA0KDQoKCg==


