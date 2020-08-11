Return-Path: <SRS0=iZb8=BV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7CAC433DF
	for <linux-mmc@archiver.kernel.org>; Tue, 11 Aug 2020 02:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 959E220639
	for <linux-mmc@archiver.kernel.org>; Tue, 11 Aug 2020 02:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d1NxysHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgHKCd4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 10 Aug 2020 22:33:56 -0400
Received: from mail-db8eur05on2050.outbound.protection.outlook.com ([40.107.20.50]:28801
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726958AbgHKCdz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 10 Aug 2020 22:33:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6WK7rbz87dPjI9lRLrtM3nv9DJMHHlx5RDDv1lPhvc0vkj75WoTgGckiLDE9xpj5oVMqDykivnK3fA5lV2i7iihSaEcmovoccbhRJXH72MaTRmDu2UMQkH1BmxVCsdSl3ArCwt5lwrVTuPluUhlueLHkre5uOKornj55gGHG58LGYox45g+xi2XRvLXXucwTkezvWHG7IjXnBPfIYxcccPeaLifwXdzhJkoyiH0hMbsleSKwZX+PMqZ1YSC0aQVTPeTV77oifkCDo2VSFwxZdbh0sZRNWGmUBz9JoawvOaqbKibJ+kyYSyx+ifr6w22uDT7K6j6+CDVAU4vkOZqrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sm7OIKAJTX6TZ+XvfwpZgoJEqg1A5lKg2gyN+bFt+Eg=;
 b=cvvM1gx6JthswNYLwK19YLq0uOYznCALfiGXG2NCVylxPCCNGxJbOzYxfkhAHkRpIo1oTOlqG29yssHSAVI1pRvTmyAO7ekdCcggDyiijmy0BGxWG6lJYw8e8gh1O+1rM08/uxKWvUfSNYEwo7icpLhwF5jezC0R1IdW/9Fm2Qh/nu6D81egB4qvuINnlGQlk2HQYnITFkER7yG6BueayTyk4x4kw+uaKhrw3cez2gzrRhw40SXrdgBTL//0ptRgu8ELr1DB2A4C22i5PrgMyJAnk/KKQ7K6NLiU5F5PIIVOIm75VX/eE56xzELTciq1Trx3Y1+rYrkr9CAkhYdyLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sm7OIKAJTX6TZ+XvfwpZgoJEqg1A5lKg2gyN+bFt+Eg=;
 b=d1NxysHnvVVi+sdIuM7frlSl80Ao7EYGyCkdMu784Vk70fNrlri6FzxFvL8vEa1XWMqH5C6jCGqBCv2rTzrv4OQXBY0CnVBxvuVqCYMaP3ASL212lTBgPw9Q1yZ/OYA8xN2pRMmpASx7/T1SYGCg1nakrEel8Ov0dpLHZ5sGIUM=
Received: from AM0PR04MB5283.eurprd04.prod.outlook.com (2603:10a6:208:c3::26)
 by AM0PR04MB5746.eurprd04.prod.outlook.com (2603:10a6:208:131::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Tue, 11 Aug
 2020 02:33:51 +0000
Received: from AM0PR04MB5283.eurprd04.prod.outlook.com
 ([fe80::f1c9:8c0e:9d8c:5464]) by AM0PR04MB5283.eurprd04.prod.outlook.com
 ([fe80::f1c9:8c0e:9d8c:5464%4]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 02:33:51 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
Subject: RE: [PATCH] mmc: host: sdhci-esdhc-imx: reset usdhc before sending
 tuning command for manual tuning method
Thread-Topic: [PATCH] mmc: host: sdhci-esdhc-imx: reset usdhc before sending
 tuning command for manual tuning method
Thread-Index: AQHWa+grmES3Xq7XDU6TvTpO+ylxM6kq/YQAgADh0KCABVrPAIAA/T5A
Date:   Tue, 11 Aug 2020 02:33:51 +0000
Message-ID: <AM0PR04MB52837A8C92BFE9FDDB5DF94190450@AM0PR04MB5283.eurprd04.prod.outlook.com>
References: <1596714504-16313-1-git-send-email-haibo.chen@nxp.com>
 <d3e56b01-144b-17cf-d414-9e0d558b9bcc@intel.com>
 <VI1PR04MB52945822087D81437FA6CCC590490@VI1PR04MB5294.eurprd04.prod.outlook.com>
 <35ec3920-2ddc-2880-49f8-8d0914c331b5@intel.com>
In-Reply-To: <35ec3920-2ddc-2880-49f8-8d0914c331b5@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f631aeee-e476-471c-cc28-08d83d9efc2c
x-ms-traffictypediagnostic: AM0PR04MB5746:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5746AC348B1EAAB96604297990450@AM0PR04MB5746.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RpnNVV+WREBSr6JKPUKL6b5FuHsURedzsJ7TmhIDHoPCBJCUBz36eX45awddTPiv+MC6ms/QlsskJvs0QyTEqe/YAifDrRNQRj02JwADS+utrQpVFuztfmx88Tg4b4b2CTrWNakLgacKbv7oCvNwYECJXeoirMqX9rfphemmi4JJg4E8aFqnFCPAPGVf4RELG22+XOofa3p5teifDlfwP3jRpUW22tFJFIzJ/q4Fpt0phciHxKbBEOfRy2SOffyDzcfOvSXn3iVaZk9aV4K4n7nqMMBLk7IkceESmZegFF+9I0MOKw9sbSI6RNYKfpGI+OCBLqmwRsJ1MdtNCydhdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5283.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(2906002)(71200400001)(8676002)(83380400001)(52536014)(53546011)(66446008)(66556008)(66476007)(86362001)(6506007)(33656002)(186003)(76116006)(64756008)(26005)(55016002)(66946007)(5660300002)(54906003)(7696005)(316002)(8936002)(9686003)(478600001)(4326008)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: oKrublHGaLowv2XaHuI2pefx4tvf9bGQzHWXfMZrN7QJRe4l6foUL3dLTHuz/4GgIMUK4lm4y6P50cU4WwYm2Y21A9OAwUkihwNa1VpJPySQyeU8KxkseoW/4i1Co2Z0OWQjg65gMaIqJnRVCz05rP2VTdcDsr9Kr3Mj6wp93bps+ThIFwSXj/PAN8QvzmD46GIvj3w88Nlmxnpganp8iU6SmlR2ygc3vr/cMannxdETZasGCFzrKyLgs4VaLSsMJ3JGQnH2c3pCM+zDbTSpv+8Sc78b51K9iyhTJGQI0i8zlAU0DT751DM2pQ+xUxgODeHCDMvhItSc9fI9OKLalzbdS6z/htG3JwyjYWnl8cQ44Kalu2HaTHA60AMpwFcli3nKnGyx726N4pKz230JU6bEmOiDOt22RXhNX0zmy0YnM0KPgh/OaVVw0BqJXJ8T8n/fDjr/Ab2V/1Mw/MZbbZrPfRoNkss2O2AEe5HNQWQkbH1zEpPOCE8K+SqwlDwm/wfuW9kKTYyygt66mfb2lcrLgibpmuhg3SbdvVRW5lQYA/vmdpZZQNzRaAsH33iY4pwI5ZP1XgXqLLsM4UnSOEgIS1SNArbKs3VEL6eaSihqSp6Wp4zhJmikLAxW8uetg5HOdDoheBTto9KCdXUwNw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5283.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f631aeee-e476-471c-cc28-08d83d9efc2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2020 02:33:51.7146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XdMnmt2nCxZ0mApgy0oU+6GlAhyz4vHVld/LllFr4XYnILtBydLq+OqA/aInc9jK4yljIS2G3DA4BlB0EZGIzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5746
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFkcmlhbiBIdW50ZXIgW21h
aWx0bzphZHJpYW4uaHVudGVyQGludGVsLmNvbV0NCj4gU2VudDogMjAyMOW5tDjmnIgxMOaXpSAx
OToyNg0KPiBUbzogQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPjsgdWxmLmhhbnNzb25A
bGluYXJvLm9yZzsNCj4gbGludXgtbW1jQHZnZXIua2VybmVsLm9yZw0KPiBDYzogZGwtbGludXgt
aW14IDxsaW51eC1pbXhAbnhwLmNvbT47IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJA
cGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29t
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG1tYzogaG9zdDogc2RoY2ktZXNkaGMtaW14OiByZXNl
dCB1c2RoYyBiZWZvcmUgc2VuZGluZw0KPiB0dW5pbmcgY29tbWFuZCBmb3IgbWFudWFsIHR1bmlu
ZyBtZXRob2QNCj4gDQo+IE9uIDcvMDgvMjAgNDo1MCBhbSwgQm91Z2ggQ2hlbiB3cm90ZToNCj4g
Pg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBBZHJpYW4gSHVu
dGVyIFttYWlsdG86YWRyaWFuLmh1bnRlckBpbnRlbC5jb21dDQo+ID4+IFNlbnQ6IDIwMjDlubQ4
5pyINuaXpSAyMDoxMQ0KPiA+PiBUbzogQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPjsg
dWxmLmhhbnNzb25AbGluYXJvLm9yZzsNCj4gPj4gbGludXgtbW1jQHZnZXIua2VybmVsLm9yZw0K
PiA+PiBDYzogZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IHNoYXduZ3VvQGtlcm5l
bC5vcmc7DQo+ID4+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5k
ZTsgZmVzdGV2YW1AZ21haWwuY29tDQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG1tYzogaG9z
dDogc2RoY2ktZXNkaGMtaW14OiByZXNldCB1c2RoYyBiZWZvcmUNCj4gPj4gc2VuZGluZyB0dW5p
bmcgY29tbWFuZCBmb3IgbWFudWFsIHR1bmluZyBtZXRob2QNCj4gPj4NCj4gPj4gT24gNi8wOC8y
MCAyOjQ4IHBtLCBoYWliby5jaGVuQG54cC5jb20gd3JvdGU6DQo+ID4+PiBGcm9tOiBIYWlibyBD
aGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+ID4+Pg0KPiA+Pj4gQWNjb3JkaW5nIHRvIElDIHN1
Z2dlc3Rpb24sIGV2ZXJ5dGltZSBiZWZvcmUgc2VuZGluZyB0aGUgdHVuaW5nDQo+ID4+PiBjb21t
YW5kLCBuZWVkIHRvIHJlc2V0IHRoZSB1c2RoYywgc28gdG8gcmVzZXQgdGhlIHR1bmluZyBjaXJj
dWl0LCB0bw0KPiA+Pj4gbGV0IGV2ZXJ5IHR1bmluZyBjb21tYW5kIHdvcmsgd2VsbCBmb3IgdGhl
IG1hbnVhbCB0dW5pbmcgbWV0aG9kLiBGb3INCj4gPj4+IHN0YW5kYXJkIHR1bmluZyBtZXRob2Qs
IElDIGFscmVhZHkgYWRkIHRoZSByZXNldCBvcGVyYXRpb24gaW4gdGhlIGxvZ2ljLg0KPiA+Pj4N
Cj4gPj4+IFNpZ25lZC1vZmYtYnk6IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4g
Pj4+IC0tLQ0KPiA+Pj4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMgfCAxICsN
Cj4gPj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPj4+DQo+ID4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiA+Pj4gYi9kcml2
ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+ID4+PiBpbmRleCBhNzZiNDUxM2ZiZWMu
LmU0Njk0ZWIxYjkxNCAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kt
ZXNkaGMtaW14LmMNCj4gPj4+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14
LmMNCj4gPj4+IEBAIC05OTAsNiArOTkwLDcgQEAgc3RhdGljIHZvaWQgZXNkaGNfcHJlcGFyZV90
dW5pbmcoc3RydWN0DQo+ID4+PiBzZGhjaV9ob3N0ICpob3N0LCB1MzIgdmFsKQ0KPiA+Pj4NCj4g
Pj4+ICAJLyogRklYTUU6IGRlbGF5IGEgYml0IGZvciBjYXJkIHRvIGJlIHJlYWR5IGZvciBuZXh0
IHR1bmluZyBkdWUgdG8gZXJyb3JzDQo+ICovDQo+ID4+PiAgCW1kZWxheSgxKTsNCj4gPj4+ICsJ
c2RoY2lfcmVzZXQoaG9zdCwgU0RIQ0lfUkVTRVRfQUxMKTsNCj4gPj4NCj4gPj4gRG9lc24ndCB0
aGF0IHJlc2V0IGFsbCByZWdpc3RlcnMgaS5lLiB0aGUgZW50aXJlIGlvcyBzdGF0ZT8NCj4gPj4N
Cj4gPg0KPiA+IEhpIEFkcmlhbiwNCj4gPiBGb3IgaS5NWCB1c2RoYywgUkVTRVRfQUxMIG9wZXJh
dGlvbiBkbyBub3QgaW1wYWN0IGFueSByZWdpc3RlciB2YWx1ZSwgaXQganVzdA0KPiByZXNldCB0
aGUgaW50ZXJuYWwgbG9naWMgc2V0dGluZy4gSSBhbHJlYWR5IHZlcmlmaWVkIHRoYXQuDQo+ID4g
SGVyZSBJIGp1c3Qgd2FudCB0byBzZXQgdGhlIFNESENJX1JFU0VUX0FMTCBiaXQsIGJ1dCBJIG5v
dGljZSB0aGF0IHRoZSBBUEkNCj4gc2RoY2lfcmVzZXQoKSB3aWxsIGFsc28gdG91Y2ggdGhlIGhv
c3QtPmNsb2NrLCBzbyBJJ20gbm90IHN1cmUgd2hldGhlciBpdCBpcyBnb29kDQo+IGVub3VnaCB0
byB1c2UgdGhpcyBBUEkgZGlyZWN0bHkuIEFueSBzdWdnZXN0aW9uPyBBdCBsZWFzdCwgY3VycmVu
dCBwYXRjaCBjYW4gZml4DQo+IHRoZSBtYW51YWwgdHVuaW5nIGlzc3VlIG9uIGlteDdkL2lteDhx
eHAuDQo+IA0KPiBJdCBtaWdodCBiZSBzYWZlciB0byB3cml0ZSBTREhDSV9SRVNFVF9BTEwgZGly
ZWN0bHkgYmVjYXVzZSwgZm9yIHlvdXIgY2FzZSwgaXQNCj4gZG9lcyBub3QgaGF2ZSBleGFjdGx5
IHRoZSBzYW1lIHNlbWFudGljcyBhcyBzZGhjaV9yZXNldCgpLg0KPiANCj4gSXQgaXMgdXAgdG8g
eW91LCBidXQgZWl0aGVyIHdheSwgaXQgd291bGQgYmUgd29ydGggYWRkaW5nIGEgY29tbWVudC4N
Cj4gDQoNClRoYW5rcyBBZHJpYW4sIEkgd2lsbCB3cml0ZSB0aGlzIGJpdCBkaXJlY3RseSBhbmQg
YWRkIGEgY29tbWVudCBpbiB0aGUgbmV4dCBWMiBwYXRjaC4NCg0KQmVzdCBSZWdhcmRzDQpIYWli
byBDaGVuDQo+ID4NCj4gPj4+DQo+ID4+PiAgCXJlZyA9IHJlYWRsKGhvc3QtPmlvYWRkciArIEVT
REhDX01JWF9DVFJMKTsNCj4gPj4+ICAJcmVnIHw9IEVTREhDX01JWF9DVFJMX0VYRV9UVU5FIHwN
Cj4gRVNESENfTUlYX0NUUkxfU01QQ0xLX1NFTCB8DQo+ID4+Pg0KPiA+DQoNCg==
