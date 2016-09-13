From: Chris Brandt <Chris.Brandt@renesas.com>
Subject: RE: [PATCH v3 1/3] mmc: sh_mobile_sdhi: add ocr_mask option
Date: Tue, 13 Sep 2016 13:28:16 +0000
Message-ID: <SG2PR06MB1165E2C194CFFBB44B159DFF8AFE0@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20160912141507.6837-1-chris.brandt@renesas.com>
 <20160912141507.6837-2-chris.brandt@renesas.com>
 <CAPDyKFqdznJ4xr5=L862uOfvqjsRpR3d+yRWtN1-8H5ZvP9GeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:62511 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754866AbcIMN2V (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Sep 2016 09:28:21 -0400
In-Reply-To: <CAPDyKFqdznJ4xr5=L862uOfvqjsRpR3d+yRWtN1-8H5ZvP9GeQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

T24gOS8xMy8yMDE2LCBVbGYgSGFuc3NvbiB3cm90ZToNCj4gUmVnYXJkaW5nIHRoZSBvY3JfbWFz
azsgSG93IGRvIHRoZXNlIFNvQ3MgcHJvdmlkZXMgdGhlIHBvd2VyIHRvIHRoZSBtbWMvc2QNCj4g
Y2FyZD8NCj4gDQo+IERvIG5vdGUsIEkgYW0gKm5vdCogdGFsa2luZyBhYm91dCB0aGUgSS9PIHZv
bHRhZ2UgYnV0IHRoZSBjb3JlIHBvd2VyIHRvDQo+IHRoZSBjYXJkLg0KDQpUaGUgU29DIGRvZXMg
bm90ICpwcm92aWRlKiBwb3dlciB0byB0aGUgY2FyZC4gSXQncyBub3QgdGhhdCBmYW5jeS4gSG93
IHRoZSAzLjN2IGlzIHN1cHBsaWVkIHRvIHRoZSBjYXJkIHNsb3QgaXMgdXAgdG8gdGhlIGJvYXJk
IGRlc2lnbmVyLiBCdXQsIHRoZSBTb0Mgc3BlYyBzYXlzIHRoZSBJL08gc2hvdWxkIGJlIDMuM3Ys
IHNvIHdlIG1pZ2h0IGFzIHdlbGwgZml4IHRoZSBPQ1IgYXMgMy4zdiBiZWNhdXNlIHRoZXkgZG9u
J3QgaGF2ZSBhIGNob2ljZS4NCg0KSSBkaWQgc2VlIGFsbCB0aGUgRFQgcmVndWxhdG9yIHN0dWZm
IGZvciB0aGUgb3RoZXIgUmVuZXNhcyBTb0MsIGJ1dCBhbGwgdGhhdCBpcyBiZXlvbmQgaG93IHRo
aXMgY2hpcCBpcyBiZWluZyB1c2VkLg0KDQpBbHNvIG5vdGUgdGhhdCB0aGlzIFNvQyAoUmVuZXNh
cyBSWi9BMSksIHVubGlrZSB0aGUgb3RoZXJzLCBpcyBiZWluZyB1c2VkIHdpdGggWElQX0tFUk5F
TCBiZWNhdXNlIGl0J3MgcG9zc2libGUgdG8gcnVuIGEgZnVsbCBrZXJuZWwgd2l0aG91dCBhbnkg
ZXh0ZXJuYWwgbWVtb3J5IChpdCBjb21lcyBpbiBhIDNNQiwgNU1CLCBvciAxMFJNIGludGVybmFs
IFJBTSB2ZXJzaW9ucykuIFNvLCBJJ20gdHJ5aW5nIHRvIGF2b2lkIGFkZGluZyBleHRyYSBEVCAi
c3R1ZmYiIHRoYXQganVzdCB0YWtlcyB1cCBtb3JlIFJBTSByZXNvdXJjZXMgYW5kIGhhcyBubyB2
YWx1ZSBmb3IgdGhlc2Ugc2ltcGxlIGVtYmVkZGVkIHN5c3RlbXMuIEkga25vdyBpbiBvdGhlciBE
RFIgYmFzZWQgc3lzdGVtIHdpdGggTWVncyBhbmQgTWVncyBvZiBSQU0gdG8gc3BhcmUgdGhpcyBp
c24ndCBhIHByb2JsZW0sIGJ1dCBpbiBhbiBYSVBfS0VSTkVMIGVudmlyb25tZW50LCBpdCBhbGwg
YWRkcyB1cC4NCg0KT25lIG9mIHRoZSByZWFzb25zIHdoeSBJIGhhdmVuJ3QgYmVlbiB0cnlpbmcg
dG8gcHVzaCBvdXIgQlNQIHVwc3RyZWFtIGFuZCBtb3ZlIGV2ZXJ5b25lIGlzIGJlY2F1c2UgSSdt
IGFmcmFpZCBvZiB3aGF0IGFsbCB0aGUgbmV3IERUIGJsb2F0IGlzIGdvaW5nIHRvIGRvIHRvIHRo
ZSBrZXJuZWwgUkFNIHVzYWdlLg0KDQpDaHJpcw0KDQo=
