From: "Y.B. Lu" <yangbo.lu@nxp.com>
Subject: RE: [v3, 0/7] Add SD UHS-I and eMMC HS200 support for eSDHC
Date: Tue, 11 Apr 2017 05:24:13 +0000
Message-ID: <DB6PR0401MB2536E5DEA75B7A1330D0FC39F8000@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <1490600982-5410-1-git-send-email-yangbo.lu@nxp.com>
 <DB6PR0401MB253627A0ABBF6DA9EC063A84F8010@DB6PR0401MB2536.eurprd04.prod.outlook.com>
 <CAPDyKFpN-+7mxxeBHEELROWsn275Mec6unDHdnY3Gsz3oKT9pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db5eur01on0062.outbound.protection.outlook.com ([104.47.2.62]:7896
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752626AbdDKFYR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 11 Apr 2017 01:24:17 -0400
In-Reply-To: <CAPDyKFpN-+7mxxeBHEELROWsn275Mec6unDHdnY3Gsz3oKT9pw@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Xiaobo Xie <xiaobo.xie@nxp.com>

SGkgVWZmZSBhbmQgQWRyaWFuLA0KDQpUaGFua3MgZm9yIHlvdXIgcXVpY2sgcmVzcG9uc2UuDQpJ
IGRyb3BwZWQgdGhlIGR0cyBwYXRjaGVzIGFuZCB3b3VsZCBzZW5kIHRoZSBuZXcgdmVyc2lvbiBt
bWMgcGF0Y2hzZXQgd2hpY2ggYWRkcmVzc2VkIEFkcmlhbidzIGNvbW1lbnRzLg0KVGhlIGR0cyBw
YXRjaGVzIHdvdWxkIGJlIHNlbnQgc2VwYXJhdGVseSB0byBhcm0gc29jIGFuZCB3aWxsIG5vdCBo
YXZlIG5ldyBiaW5kaW5ncy9jb21wYXRpYmxlcyB0byBkaXNjdXNzLg0KDQpUaGFua3MuDQoNCg0K
QmVzdCByZWdhcmRzLA0KWWFuZ2JvIEx1DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogVWxmIEhhbnNzb24gW21haWx0bzp1bGYuaGFuc3NvbkBsaW5hcm8ub3JnXQ0KPiBT
ZW50OiBNb25kYXksIEFwcmlsIDEwLCAyMDE3IDY6NDkgUE0NCj4gVG86IFkuQi4gTHUNCj4gQ2M6
IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBBZHJpYW4gSHVudGVyOyBS
b2IgSGVycmluZzsgTWFyayBSdXRsYW5kOw0KPiBDYXRhbGluIE1hcmluYXM7IFdpbGwgRGVhY29u
OyBYaWFvYm8gWGllDQo+IFN1YmplY3Q6IFJlOiBbdjMsIDAvN10gQWRkIFNEIFVIUy1JIGFuZCBl
TU1DIEhTMjAwIHN1cHBvcnQgZm9yIGVTREhDDQo+IA0KPiBPbiAxMCBBcHJpbCAyMDE3IGF0IDEw
OjIwLCBZLkIuIEx1IDx5YW5nYm8ubHVAbnhwLmNvbT4gd3JvdGU6DQo+ID4gSGkgQW5kcmlhbiBh
bmQgVWZmZSwNCj4gPg0KPiA+IERvIHlvdSBoYXZlIGFueSBjb21tZW50cyBvbiBNTUMgcGF0Y2hl
cz8NCj4gPiBDb3VsZCB5b3UgaGVscCB0byBtZXJnZSB0aGUgbW1jIHBhdGNoZXMgaWYgdGhlcmUg
aXMgbm8gY2hhbmdlcw0KPiByZXF1ZXN0ZWQ/DQo+IA0KPiBJIGFtIHdhaXRpbmcgZm9yIEFkcmlh
bidzIGFja3MuDQo+IA0KPiA+DQo+ID4gUmVnYXJkaW5nIHRvIHRoZSBkdHMgcGF0Y2hlcywgSSBo
YXZlIHNvbWUgbW9yZSBwbGF0Zm9ybXMgdG8gc3VwcG9ydC4NCj4gPiBTbyBJJ2QgbGlrZSB0byBk
cm9wIHRoZW0gY3VycmVudGx5LCBhbmQgc2VuZCB0aGVtIGFsbCB0byBhcm0gbWFpbGluZw0KPiBs
aXN0IGZvciByZXZpZXdpbmcuDQo+IA0KPiBJZiBpdCdzIG5ldyBiaW5kaW5ncy9jb21wYXRpYmxl
cywgdGhlIERUIGRvYyBjaGFuZ2VzIG5lZWRzIHRvIGJlDQo+IGRpc2N1c3NlZCBhbmQgYWdyZWVk
IHVwb24gZmlyc3QuIEFjdHVhbCBjaGFuZ2VzIHRvIHRoZSBEVFMgZmlsZXMsIHNob3VsZA0KPiBw
cmVmZXJhYmx5IGdvIHZpYSB0aGUgYXJtIHNvYyB0cmVlLg0KPiANCj4gS2luZCByZWdhcmRzDQo+
IFVmZmUNCg==
