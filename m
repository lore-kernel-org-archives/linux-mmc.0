Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B41C63697
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Nov 2020 15:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC4FA246AA
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Nov 2020 15:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LNhFzKVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgKSPWD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Nov 2020 10:22:03 -0500
Received: from mail-eopbgr40060.outbound.protection.outlook.com ([40.107.4.60]:10147
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728204AbgKSPWD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Nov 2020 10:22:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZE80+NCtfYJMAmLNz/Jh2VmUp9RXYPtEljvnbn8M8W7FgVluPfQEoEP/E2qhfcRQoh8h2IF/PlfjuhMuRw+aY4oGrvTLldOSWP/MUe8lX5QNiceVXLw916WqlXoivgfXNIpsWq5R3VX5cRRgzC0a8W7kAQhigDW0MFug46L52syYMy4HUzFAiI5C5272kJayhO3U1I9vTa6QvdzWKS3f4hJQ2oWFIIbPnqPXSATi2iqiu6fLgN3zleZLGwd7ooQUj+TCPn3uZ8jFG4LUW+EoYioU9mfgQfTvCFO7YG2eYsHIgnkNMFHBSNlxEdtHiZn+2P6utmvypjTVGZaIlhDwxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R57HrDcG+SbJ5vF+WY+iIDPrFyvwUOXwpWDwQjjmXTs=;
 b=EzQ9+HSTUDqL0bicIB5EW5Kzi4BRJdsbIdOEV+yHV9XwKBXFdvUs2AzNhecBXIOwUoCDTGL0rTzpwAvavYiMYmA2w/HJTWOEBEC94HmfeIwHGS04nLTFrQjjXNLUxI/paD1D+FKInjG2o/j3elipf/oaXyqhWSafpLjVMMpvGNY+1530wHuGll1kDiWtrXoztXoPGoGCTZ6xqkXE5mRHtF6YFqG1p1PAyXxzxMdnM0kvTCVHjFxmh15+DvCXzbRKPpOsLuyLITmV39OqE1fX0Ixwmgiw6z0w6LfmLzewLrpnBzfEsXJgrsCweqa9iAW7zPH4E7J+JlE0/skAtyHlfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R57HrDcG+SbJ5vF+WY+iIDPrFyvwUOXwpWDwQjjmXTs=;
 b=LNhFzKVGOIJhh0XpEiLPbdwAehzR7nUxa/Jyuzce4EVEwI/B6LLJlYB8F9ZPAp9HaeEuzxayhK5zwIo4u4KNFRxebsrnFHuev8LGBMRfPJMOyfFv+u7DVAc8ivSa0ZOs2Pj0RA0gWXNiv2rBh+4TkZ4eFlYOxTL2A4qf7aSu8f8=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM7PR04MB7013.eurprd04.prod.outlook.com (2603:10a6:20b:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Thu, 19 Nov
 2020 15:22:00 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3564.029; Thu, 19 Nov 2020
 15:22:00 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Bough Chen <haibo.chen@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH 1/3] dt-bindings: mmc: imx: fix the wrongly dropped imx8qm
 compatible string
Thread-Topic: [PATCH 1/3] dt-bindings: mmc: imx: fix the wrongly dropped
 imx8qm compatible string
Thread-Index: AQHWvnVQV1Aj3wHjWke7zj9d0oe5panPb7MAgAAikqA=
Date:   Thu, 19 Nov 2020 15:21:59 +0000
Message-ID: <AM6PR04MB49666B9100F4CE87E1AE23D680E00@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <20201119125304.1279-1-aisheng.dong@nxp.com>
 <20201119131720.GA348129@kozik-lap>
In-Reply-To: <20201119131720.GA348129@kozik-lap>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [180.171.84.81]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3e8a4809-dcba-4172-1529-08d88c9edc39
x-ms-traffictypediagnostic: AM7PR04MB7013:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR04MB70135C87518E8903B2EC02CE80E00@AM7PR04MB7013.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A0vZPqWvW3sthnU5DrY5iPEhvM2UhBS+7eoXa1TFVebT4jlrLzy5UEfrq7YArL1LHX1XPme6TZAiwfQ/EtJcGN3TiYP0nN/oTN5+5vNspzvGE+kOiBsF49sUHcGmV5xprxDPPIvRMNfPQKWLwVhEXFm0EzEfJpMUzddWQ70Z+1L+in1WHi5R2gWRxYm3Hty+R9TMriU52GY3JFo5mpYfIjKkw4XRt9MbqfkVgZC5i9npNxxZo1Za55dDUYWMVExDZUej64l9z7pnCegO7zabSh3V8hoZCAgr0rbAxrZ+h2ZODGry8z9wSaAPTeppoaOV+TbVg4g3hL69iBPrTVtX53EKN9pjPAx8O34V2HanSeMl34+u2GDZCkTkmlT5FUmA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(316002)(6506007)(54906003)(52536014)(2906002)(44832011)(26005)(7696005)(186003)(55016002)(86362001)(71200400001)(5660300002)(9686003)(76116006)(33656002)(66446008)(64756008)(66556008)(66476007)(478600001)(66946007)(8676002)(8936002)(4326008)(6916009)(4744005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: agIV6yK/XvES32I6FRDrOUVxlR6VWvMQhNCFqmyKSigxz7kEuXR4Ew60w3nNKhJpInLFHKcg6O0gvHUUwuwvKIO5xCdLxlEpsPuFEQXvMaZVC4NKo9BzlAGxK/RWw0dxmp3zdvqyw9djrltdxnvFwKnOJCCf6LMvbWxJk/Rk+21aEFqljxBWM6JS2yihZAf2IUpJiAmR60ak/jndFFlxsmC61gMtjn5UAtHkh5mG7QLt4+gKFn3jw/QBRsC4xFfviBBR06mrvQRUtD14ETN33YuDuIU19V9SQMZtEAn/rU4XMXJyBY+4oTIoIdcIAjJnV3d3HHQpVNrS1/5EnwmvLKWMRghf9ROLhGnMIQnuVLCTAFZ6jR0RBh0Bd1XVolR9TAWKjmvuvbQgBj5a+Xx/klFGChLERokr6USCMdSUjnqONiC1FRvuYLpvcCDrGuJIz6sEnwjpsEgDy+B1TXslAtnQ1vQYfNlCvSCPMeKWH0WYwhlO5msPvi1N2bSGYwQfbdbISl3dtlQaoORY6Xt0DfkOf1LNWqtTyrl36aoC6t65oDNsvMKUHC+bGEk8wRZq1KwPo1Q6T4/9bCXICS3eJGyiACCSC3hT9cr7rrNuIJnohwsguxB/WHGl/8yUJoIMsbAtMDTpxJ3w43pkwbFxDw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8a4809-dcba-4172-1529-08d88c9edc39
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 15:21:59.9715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PBJoIdV/CUvns9U/CH7sIcz9dCpYhTEgt3etiZq1xi3UcgvGO7vuumtafbW4vv2R88NHjESrcR8czLeot/c+wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7013
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFRo
dXJzZGF5LCBOb3ZlbWJlciAxOSwgMjAyMCA5OjE3IFBNDQo+IA0KPiBPbiBUaHUsIE5vdiAxOSwg
MjAyMCBhdCAwODo1MzowMlBNICswODAwLCBEb25nIEFpc2hlbmcgd3JvdGU6DQo+ID4gVGhlIGNv
bXBhdGlibGUgc3RyaW5nICJmc2wsaW14OHFtLXVzZGhjIiB3YXMgd3JvbmdseSBkcm9wcGVkIGlu
IHBhdGNoOg0KPiA+IDgwZmQzNTBiOTU5MCAoImR0LWJpbmRpbmdzOiBtbWM6IGZzbC1pbXgtZXNk
aGM6IEZpeCBpLk1YIDggY29tcGF0aWJsZQ0KPiA+IG1hdGNoaW5nIikgQWRkIGl0IGJhY2suDQo+
IA0KPiBBbHRob3VnaCB0aGUgY29tcGF0aWJsZSB3YXMgZHJvcHBlZCwgYnkgd2h5IHdyb25nbHk/
IFBsZWFzZSBkZXNjcmliZSBpdC4NCj4gVGhlIGNvbXBhdGlibGUgaXMgbm93aGVyZSB0byBiZSBm
b3VuZCwgaXQgaXMgbm90IHVzZWQuDQoNClRoZSBEVCBwYXRjaCB1c2luZyBpdCBpcyBzdGlsbCB1
bmRlciByZXZpZXcuIFNvIHdlIG5lZWQgaXQuDQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0KPiANCj4g
QmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQo+ID4NCj4gPiBDYzogSGFpYm8gQ2hlbiA8
aGFpYm8uY2hlbkBueHAuY29tPg0KPiA+IENjOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtl
cm5lbC5vcmc+DQo+ID4gQ2M6IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0K
PiA+IENjOiBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnDQo+ID4gRml4ZXM6IDgwZmQzNTBiOTU5
MCAoImR0LWJpbmRpbmdzOiBtbWM6IGZzbC1pbXgtZXNkaGM6IEZpeCBpLk1YIDgNCj4gPiBjb21w
YXRpYmxlIG1hdGNoaW5nIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hl
bmcuZG9uZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbW1jL2ZzbC1pbXgtZXNkaGMueWFtbCB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykNCj4gPg0K
