From: "Chen, Alvin" <alvin.chen@intel.com>
Subject: RE: [PATCH v2] mmc: sdhci-pci: SDIO host controller support for
 Intel Quark X1000
Date: Mon, 11 Aug 2014 05:15:18 +0000
Message-ID: <4656BEB6164FC34F8171C6538F1A595B2E971A1D@SHSMSX101.ccr.corp.intel.com>
References: <1403618196-7366-1-git-send-email-alvin.chen@intel.com>
	<1403618196-7366-2-git-send-email-alvin.chen@intel.com>
 <CAPDyKFq8cQHhadSAcaMG6XTKKaZ3XjX5PQyxsRteqhbcMaYZ0A@mail.gmail.com>
 <AF233D1473C1364ABD51D28909A1B1B72F81CCA4@pgsmsx105.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:18070 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174AbaHKFPX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Aug 2014 01:15:23 -0400
In-Reply-To: <AF233D1473C1364ABD51D28909A1B1B72F81CCA4@pgsmsx105.gar.corp.intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Ong, Boon Leong" <boon.leong.ong@intel.com>

SGkgVWxmLA0KDQpBbnkgdXBkYXRlIGZvciB0aGlzIHBhdGNoPyBKdXN0IHdhbnQgdG8gZm9sbG93
LXVwLg0KDQoNCg0KQmVzdCByZWdhcmRz77yMQWx2aW4gQ2hlbg0KSUNGUyBQbGF0Zm9ybSBFbmdp
bmVlcmluZyBTb2x1dGlvbg0KRmxleCBTZXJ2aWNlcyAoQ01NSSBMZXZlbCAzLCBJUUEyMDA1LCBJ
UUEyMDA4KSzCoEdyZWF0ZXIgQXNpYSBSZWdpb24gSW50ZWwgSW5mb3JtYXRpb24gVGVjaG5vbG9n
eSBUZWwuIDAxMC04MjE3MTk2MA0KaW5ldC44LTc1ODE5NjANCkVtYWlsLiBhbHZpbi5jaGVuQGlu
dGVsLmNvbSANCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBPbmcsIEJv
b24gTGVvbmcNCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgNiwgMjAxNCAzOjMyIFBNDQo+IFRv
OiBVbGYgSGFuc3Nvbg0KPiBDYzogQ2hyaXMgQmFsbDsgbGludXgtbW1jOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBDaGVuLCBBbHZpbg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHYyXSBt
bWM6IHNkaGNpLXBjaTogU0RJTyBob3N0IGNvbnRyb2xsZXIgc3VwcG9ydCBmb3IgSW50ZWwNCj4g
UXVhcmsgWDEwMDANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9t
OiBVbGYgSGFuc3NvbiBbbWFpbHRvOnVsZi5oYW5zc29uQGxpbmFyby5vcmddDQo+ID4gU2VudDog
V2VkbmVzZGF5LCBKdWx5IDAyLCAyMDE0IDU6MDEgUE0NCj4gPiBUbzogQ2hlbiwgQWx2aW4NCj4g
PiBDYzogQ2hyaXMgQmFsbDsgbGludXgtbW1jOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBPbmcsIEJvb24NCj4gPiBMZW9uZw0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIG1tYzog
c2RoY2ktcGNpOiBTRElPIGhvc3QgY29udHJvbGxlciBzdXBwb3J0DQo+ID4gZm9yIEludGVsIFF1
YXJrIFgxMDAwDQo+ID4NCj4gPiBPbiAyNCBKdW5lIDIwMTQgMTU6NTYsIENoZW4sIEFsdmluIDxh
bHZpbi5jaGVuQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gPiBGcm9tOiBEZXJlayBCcm93bmUgPERl
cmVrLkJyb3duZUBpbnRlbC5jb20+DQo+ID4gPg0KPiA+ID4gVGhpcyBwYXRjaCBpcyB0byBlbmFi
bGUgU0RJTyBob3N0IGNvbnRyb2xsZXIgZm9yIEludGVsIFF1YXJrIFgxMDAwLg0KPiA+ID4NCj4g
PiA+IFNpZ25lZC1vZmYtYnk6IERlcmVrIEJyb3duZSA8RGVyZWsuQnJvd25lQGludGVsLmNvbT4N
Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFsdmluIChXZWlrZSkgQ2hlbiA8YWx2aW4uY2hlbkBpbnRl
bC5jb20+DQo+ID4NCj4gPiBUaGFua3MhIEFwcGxpZWQgZm9yIG5leHQuDQo+ID4NCj4gDQo+IEhp
IFVsZiwNCj4gCUZvciB0aGlzIHBhdGNoLCBhcmUgeW91IGluIHByb2dyZXNzIG9mIGdldHRpbmcg
aXQgaW50byB2My4xNyAgbWVyZ2UNCj4gd2luZG93Pw0KPiAJSnVzdCB3YW50IHRvIGZvbGxvdy11
cC4NCj4gDQo+IE1hbnkgdGhhbmtzDQo+IEJvb24gTGVvbmcNCg0K
