Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9051C433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 22:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 850216134F
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 22:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240792AbhKHWx2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Nov 2021 17:53:28 -0500
Received: from 113.196.136.146.ll.static.sparqnet.net ([113.196.136.146]:39618
        "EHLO mg.sunplus.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233784AbhKHWx1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Nov 2021 17:53:27 -0500
X-Greylist: delayed 52664 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Nov 2021 17:53:26 EST
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg02.sunplus.com with MailGates ESMTP Server V5.0(53148:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Tue, 09 Nov 2021 06:50:43 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 9 Nov 2021 06:50:37 +0800
Received: from sphcmbx02.sunplus.com.tw ([::1]) by sphcmbx02.sunplus.com.tw
 ([fe80::f8bb:bd77:a854:5b9e%14]) with mapi id 15.00.1497.023; Tue, 9 Nov 2021
 06:50:38 +0800
From:   =?big5?B?VG9ueSBIdWFuZyC2wMNoq3A=?= <tony.huang@sunplus.com>
To:     Rob Herring <robh@kernel.org>,
        Tony Huang <tonyhuang.sunplus@gmail.com>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        =?big5?B?V2VsbHMgTHUgp2aq2sTL?= <wells.lu@sunplus.com>
Subject: RE: [PATCH 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus SP7021
Thread-Topic: [PATCH 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus
 SP7021
Thread-Index: AQHX0xnqVbqgnYL/xUqU9M+7PT79mqv5XGeAgADinoA=
Date:   Mon, 8 Nov 2021 22:50:37 +0000
Message-ID: <53c3729b77c442d1a94f99ae39eabd80@sphcmbx02.sunplus.com.tw>
References: <1636208598-18234-1-git-send-email-tony.huang@sunplus.com>
 <1636208598-18234-2-git-send-email-tony.huang@sunplus.com>
 <YYlbaTyAXYMw8A5O@robh.at.kernel.org>
In-Reply-To: <YYlbaTyAXYMw8A5O@robh.at.kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.54]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RGVhciBSb2I6DQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGR0LWJpbmRpbmc6IG1tYzog
QWRkIG1tYyB5YW1sIGZpbGUgZm9yIFN1bnBsdXMNCj4gU1A3MDIxDQo+IA0KPiBPbiBTYXQsIE5v
diAwNiwgMjAyMSBhdCAxMDoyMzoxN1BNICswODAwLCBUb255IEh1YW5nIHdyb3RlOg0KPiA+IEFk
ZCBtbWMgeWFtbCBmaWxlIGZvciBTdW5wbHVzIFNQNzAyMQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogVG9ueSBIdWFuZyA8dG9ueS5odWFuZ0BzdW5wbHVzLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4u
L2RldmljZXRyZWUvYmluZGluZ3MvbW1jL3N1bnBsdXMtbW1jLnlhbWwgICAgICAgfCA2NA0KPiAr
KysrKysrKysrKysrKysrKysrKysrDQo+ID4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgIDUgKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA2OSBp
bnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvc3VucGx1cy1tbWMueWFtbA0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvc3VucGx1cy1tbWMu
eWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9zdW5wbHVz
LW1tYy55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwLi5m
YzVhNWY2DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tbWMvc3VucGx1cy1tbWMueWFtbA0KPiA+IEBAIC0wLDAgKzEsNjQgQEAN
Cj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1D
bGF1c2UpICMgQ29weXJpZ2h0DQo+ID4gKyhDKSBTdW5wbHVzIEx0ZC4gQ28uIDIwMjEgJVlBTUwg
MS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL21t
Yy9zdW5wbHVzLW1tYy55YW1sIw0KPiA+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcv
bWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gPiArDQo+ID4gK3RpdGxlOiBzdW5wbHVzIE1NQyBj
b250cm9sbGVyDQo+ID4gKw0KPiA+ICthbGxPZjoNCj4gPiArICAtICRyZWY6ICJtbWMtY29udHJv
bGxlci55YW1sIg0KPiA+ICsNCj4gPiArbWFpbnRhaW5lcnM6DQo+ID4gKyAgLSB0b255Lmh1YW5n
IDx0b255Lmh1YW5nQHN1bnBsdXMuY29tPg0KPiANCj4gUGxlYXNlIGZpeCB5b3VyIG5hbWUuDQpP
SyxJIHdpbGwgZml4Lg0KDQo+IA0KPiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21w
YXRpYmxlOg0KPiA+ICsgICAgZW51bToNCj4gPiArICAgICAgLSBzdW5wbHVzLHNwNzAyMS1lbW1j
DQo+ID4gKyAgICAgIC0gc3VucGx1cyxpMTQzLWVtbWMNCj4gPiArICAgICAgLSBzdW5wbHVzLHE2
NDUtZW1tYw0KPiANCj4gYmxhbmsgbGluZSBoZXJlLg0KT0ssSSB3aWxsIGFkZCBibGFuayBsaW5l
Lg0KPiANCj4gPiArICByZWc6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBp
bnRlcnJ1cHRzOg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgY2xvY2tzOg0K
PiA+ICsgICAgbWluSXRlbXM6IDENCj4gPiArDQo+ID4gKyAgcmVzZXRzOg0KPiA+ICsgICAgbWF4
SXRlbXM6IDENCj4gPiArDQo+ID4gK3JlcXVpcmVkOg0KPiA+ICsgIC0gY29tcGF0aWJsZQ0KPiA+
ICsgIC0gcmVnDQo+ID4gKyAgLSBpbnRlcnJ1cHRzDQo+ID4gKyAgLSBjbG9ja3MNCj4gPiArICAt
IHJlc2V0cw0KPiA+ICsNCj4gPiArdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ICsN
Cj4gPiArZXhhbXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGlu
Z3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+DQo+ID4gKyAgICAjaW5jbHVkZSA8ZHQtYmlu
ZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXJtLWdpYy5oPg0KPiA+ICsgICAgI2luY2x1ZGUg
PGR0LWJpbmRpbmdzL2Nsb2NrL3NwLXNwNzAyMS5oPg0KPiA+ICsgICAgI2luY2x1ZGUgPGR0LWJp
bmRpbmdzL3Jlc2V0L3NwLXNwNzAyMS5oPg0KPiA+ICsgICAgbW1jMDogbW1jQDljMDAzYjAwIHsN
Cj4gPiArICAgICAgICBjb21wYXRpYmxlID0gInN1bnBsdXMsc3A3MDIxLWVtbWMiOw0KPiA+ICsg
ICAgICAgIHJlZyA9IDwweDljMDAzYjAwIDB4MTgwPjsNCj4gPiArICAgICAgICBpbnRlcnJ1cHRz
ID0gPDIwIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+ICsgICAgICAgIGNsb2NrcyA9IDwmY2xr
YyBDQVJEX0NUTDA+Ow0KPiA+ICsgICAgICAgIHJlc2V0cyA9IDwmcnN0YyBSU1RfQ0FSRF9DVEww
PjsNCj4gPiArICAgICAgICBidXMtd2lkdGggPSA8OD47DQo+ID4gKyAgICAgICAgbWF4LWZyZXF1
ZW5jeSA9IDw1MjAwMDAwMD47DQo+ID4gKyAgICAgICAgbm9uLXJlbW92YWJsZTsNCj4gPiArICAg
ICAgICBkaXNhYmxlLXdwOw0KPiA+ICsgICAgICAgIGNhcC1tbWMtaGlnaHNwZWVkOw0KPiA+ICsg
ICAgICAgIG1tYy1kZHItM18zdjsNCj4gPiArICAgICAgICBuby1zZGlvOw0KPiA+ICsgICAgICAg
IG5vLXNkOw0KPiA+ICsgICAgfTsNCj4gPiArLi4uDQo+ID4gZGlmZiAtLWdpdCBhL01BSU5UQUlO
RVJTIGIvTUFJTlRBSU5FUlMgaW5kZXggM2I3OWZkNC4uMTc5ZTYwYSAxMDA2NDQNCj4gPiAtLS0g
YS9NQUlOVEFJTkVSUw0KPiA+ICsrKyBiL01BSU5UQUlORVJTDQo+ID4gQEAgLTE3OTQ1LDYgKzE3
OTQ1LDExIEBAIEw6CW5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gPiAgUzoJTWFpbnRhaW5lZA0K
PiA+ICBGOglkcml2ZXJzL25ldC9ldGhlcm5ldC9kbGluay9zdW5kYW5jZS5jDQo+ID4NCj4gPiAr
U1VOUExVUyBNTUMgRFJJVkVSDQo+ID4gK006CVRvbnkgSHVhbmcgPHRvbnkuaHVhbmdAc3VucGx1
cy5jb20+DQo+ID4gK1M6CU1haW50YWluZWQNCj4gPiArRjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21tYy9zdW5wbHUtbW1jLnlhbWwNCj4gPiArDQo+ID4gIFNVUEVSSA0KPiA+
ICBNOglZb3NoaW5vcmkgU2F0byA8eXNhdG9AdXNlcnMuc291cmNlZm9yZ2UuanA+DQo+ID4gIE06
CVJpY2ggRmVsa2VyIDxkYWxpYXNAbGliYy5vcmc+DQo+ID4gLS0NCj4gPiAyLjcuNA0KPiA+DQo+
ID4NCg==
