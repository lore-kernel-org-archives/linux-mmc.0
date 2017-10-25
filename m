From: Bernd Edlinger <bernd.edlinger@hotmail.de>
Subject: Re: [PATCH] mmc: dw_mmc: Increase the timeout in mci_send_cmd to 5
 sec
Date: Wed, 25 Oct 2017 12:52:08 +0000
Message-ID: <AM5PR0701MB2657E6DB86B31A2D29F25D19E4440@AM5PR0701MB2657.eurprd07.prod.outlook.com>
References: <AM5PR0701MB2657301FD402EEAA4B83917CE47F0@AM5PR0701MB2657.eurprd07.prod.outlook.com>
 <CAPDyKFojY21yTMu2E9M8tec6QPZfFuVwJMZO0vY8V2kG7=yRCg@mail.gmail.com>
 <3c46c1a6-edd2-698e-3286-e30d04b99103@hotmail.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oln040092069010.outbound.protection.outlook.com ([40.92.69.10]:3328
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750852AbdJYMwL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 25 Oct 2017 08:52:11 -0400
In-Reply-To: <3c46c1a6-edd2-698e-3286-e30d04b99103@hotmail.de>
Content-Language: en-US
Content-ID: <699BE5290C379D4AAEA038883A977D28@eurprd07.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>

T24gMTAvMDIvMTcgMTU6MjksIEJlcm5kIEVkbGluZ2VyIHdyb3RlOg0KPiBPbiAxMC8wMi8xNyAw
OToxMywgVWxmIEhhbnNzb24gd3JvdGU6DQo+PiBPbiAzMCBTZXB0ZW1iZXIgMjAxNyBhdCAxNzoz
OCwgQmVybmQgRWRsaW5nZXIgPGJlcm5kLmVkbGluZ2VyQGhvdG1haWwuZGU+IHdyb3RlOg0KPj4+
DQo+Pj4gU2lnbmVkLW9mZi1ieTogQmVybmQgRWRsaW5nZXIgPGJlcm5kLmVkbGluZ2VyQGhvdG1h
aWwuZGU+DQo+Pg0KPj4gV2h5Pw0KPj4NCj4gDQo+IE9idmlvdXNseSB0aGUgMC41IHNlY29uZHMg
dGltZS1vdXQgd2FzIG5vdCBzdWZmaWNlbnQgZm9yIG1lLg0KPiBJIGV4cGVyaWVuY2VkIGEgdGlt
ZS1vdXQgSSBiZWxpZXZlIGl0IHdhcyB3aXRoIGFuIGVyYXNlIGNvbW1hbmQsDQo+IHRoYXQgdG9v
ayBhcm91bmQgb25lIHNlY29uZCB0byBjb21wbGV0ZS4gIE5vdCBhbGwgYnJhbmRzIG9mIFNEDQo+
IGNhcmQgYmVoYXZlIHRoaXMgd2F5LCBidXQgc29tZSBkby4NCj4gDQo+IEluY2lkZW50YWxseSBJ
IGhhZCBhIHNpbWlsYXIgcHJvYmxlbSB3aXRoIGEgY29tcGxldGVseSBkaWZmZXJlbnQNCj4gaGFy
ZHdhcmUsIHNlZTogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0x
MDc4MTENCj4gU2hvdWxkIEkgc2VuZCBhIHBhdGNoIGZvciB0aGF0IGFzIHdlbGw/DQo+IA0KPiAN
Cg0KUGluZy4uLg0KDQpJcyByYWlzaW5nIHRoZSB0aW1lLW91dCBhbHNvIGNvbnRyb3ZlcnNpYWw/
DQoNCkJlcm5kLg0K
