Return-Path: <SRS0=r8P+=CL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557A5C433E7
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 11:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 206B2207D3
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 11:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B9U6CBui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIBLZC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Sep 2020 07:25:02 -0400
Received: from mail-vi1eur05on2056.outbound.protection.outlook.com ([40.107.21.56]:44480
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726124AbgIBLY5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 2 Sep 2020 07:24:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVe5Sxjil9oszCDDwQmlKHuzrUrLMKACpR95Qxh5TOBr8MPilP/XHA/XjmqLbyP03CprOfZMpf1e7ClXYIxvu8ibCbYzsYeWcZPpbIO6tMW88gYZRytDNMH2CihMOjkxbHSFv+g6AC4r43kJRDqd6Ly8uR+yUL0iXvajTYIQi6tN2AHb+xiwR+rPP1BClOzTJhppnZTGv/17VZOQWQ3LkTVvEGe3/GrN6J5M5MslYbtXXM9OwK88AJUVAX2Sc+8tQ7rE3+QdL5OphpvXIgOwsln49tg34rvpdL7dFxWGv3+PR/bi99sn6OComCosJZt1dneGgFkddrruav2irFFfcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MFD4EjqcDdAPtaazzNuBPuA1qoDA8fphiqkRY+Gkx0=;
 b=EgJA46gTr1YWAcSvfkuB5Cz6o/0474QDFklE2pvt9WFcMzRIUu+eWOuEn/Tlm1oy576LR4w3IfcdNcqdl1ZarIE0PwGx7wgAWFRm++jW5Xw5TGkguvheCFXMnZ3lLGrJBNVDrFEnodEsVJziGqmljsVyFcCqvIFag/KtMTsLtg0nPgCLwPIotsqi7/X2rchg4UjaeEPRBIZyDfo9G2wsIhLBFmTFSOUHYOZcRshxS4Z85hhICObJiDUCDOUP/sCY8zcYB4eOUjrG6FllH4qS5xQIJbuTcpIt6xhoIeFu4p9ZrT1uEl6Y2cgi/HHHzWNjn0qmM/TZkWbJsgsNvWF8OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MFD4EjqcDdAPtaazzNuBPuA1qoDA8fphiqkRY+Gkx0=;
 b=B9U6CBuiGIzz/C9OvNiphFhrigWttllVxfNaVwelNWoXvEHH7PdqhORw7BRS/KpWdqH5qKWSMH39IqziFywSDYronqzCg/QF412F0GUBzeZBm49NcNgoJgVjVyidb5MpXjk/ssLGMPWuNQ+y+mXhctcHeR4uE5fQNJppwzH8pgY=
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com (2603:10a6:803:5a::22)
 by VI1PR0402MB3616.eurprd04.prod.outlook.com (2603:10a6:803:8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.22; Wed, 2 Sep
 2020 11:24:53 +0000
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::a92f:472b:ffa6:ec21]) by VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::a92f:472b:ffa6:ec21%7]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 11:24:52 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "Baumgartner, Claus (GE Healthcare)" <claus.baumgartner@med.ge.com>
Subject: RE: mmc0: Timeout waiting for hardware cmd interrupt on i.MX535
Thread-Topic: mmc0: Timeout waiting for hardware cmd interrupt on i.MX535
Thread-Index: AdaAMoFCTyezERBOQE2GwxP9opqVdwAIw4cAADEtimA=
Date:   Wed, 2 Sep 2020 11:24:52 +0000
Message-ID: <VI1PR04MB5294C1AE26EA2D0DA163F307902F0@VI1PR04MB5294.eurprd04.prod.outlook.com>
References: <AM0P101MB03060DFCABC4A82C2D40F180D12E0@AM0P101MB0306.NAMP101.PROD.OUTLOOK.COM>
 <20200901114642.vhivtsfrarua6ce4@earth.universe>
In-Reply-To: <20200901114642.vhivtsfrarua6ce4@earth.universe>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: collabora.com; dkim=none (message not signed)
 header.d=none;collabora.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e85681ef-e6bf-486b-023c-08d84f32d002
x-ms-traffictypediagnostic: VI1PR0402MB3616:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB361647533DCE3DCFA5C6A583902F0@VI1PR0402MB3616.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dm4NO4Ij01WG+pB0rsCxSa+1tdtQjFVLpDEOu+w45D6aGXUhO1QKQWhCJsmhXmVU4htX6DSz/UVEdqr9dXA6sp8WDNKKyAw9O7+rpMYH2XoXCTghY4rlX72hW5Oe+u5l+YDEZ+kT9o2CInQxAaFbff9R+9YCRWre8kb/39vm7InHox8Gj5gAdXqq8tCV1QkHr8oUSzMUFJQNu0xawWJptVwKbDfH4IruHEAZq4xohEQqDy39uHxmHN8DShBKC8eGqY0vMDAokOInrZBMrYhq7yndL7qdS9zqvzxu+K468RTgFJh7eHZEAEqDDs2xvPbSdp4DPHShDTaBRLd7wI0ZLdJYe7yuIODqbwDRowsbXounxbT4ZqHted8RhDUq0SKpDXhk2Gl8MI782AAQiLuy1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5294.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(9686003)(83380400001)(52536014)(64756008)(76116006)(66556008)(66476007)(66946007)(66446008)(71200400001)(8936002)(5660300002)(55016002)(4326008)(53546011)(86362001)(966005)(498600001)(8676002)(7696005)(26005)(6636002)(54906003)(6506007)(2906002)(110136005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: O1NVXa4Y4O68onWn8EG/toBCf5aa/Ybk4Gy1AjK9qoO0SNlUfXCf1Zdnpd6a2CrzNsVRfPHTKR2/Ho6YjhYTP2ewnuZ4BRdKVKHq4qtjrNPQ/Zu/LNSSL8itQ53b+3onPiM5yroBCWlij0k4u8mx/Y+ouKbcI+4X8hNIg/AtxBPtZ9iJrvzF2ARIEfNLd/FFV5hweanosbmYyukOmxFQjDWi1aqIzoGdBntqnAfXHDbhEkb8RV6MT4vLkOm9Ct3UXMI8TYruwM1Po8WFCWNEoxbX36ZVSvE9bYCZ+7pC4WIkO5k/TDgoG1K706ekqBv95e+1FXxVuFMWLOFm+epf5WKSE0y5eJGf7cpqR3gaNITLCKEFEDpI27hiCeqx0MX0Yz4CqJgSKmuh6F/Cu+0DX5oXhKiZOSu98M0+WJ/5ikrdoXhSWGBPtRtDouWLxIcOTP8ovZsUnaAiZHHhCg5ktUSXZ6W/uysC13BQ59FkVcK9WhO1amX/4ojKKbNsiolzWkACBKf5KjMIcMueqx8X9ENE34CL2kNkeV0eUQgI2iY5cKyG1UZ1VjxmBb8p9PPFeJ4p6bRbnY5v/yuH5pxYjur93ZpFIHHX61m0eU5MWCu9isiHwoAyYL2cq2YRlwkaA/X//acie0AdOhhCxU3WpA==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5294.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e85681ef-e6bf-486b-023c-08d84f32d002
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 11:24:52.9317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G+BnkpXljJrM3n0TuQcoa0ti+N4kl6kRuXVsLbSewdzk8Qzwk/6vuGmhXJZfT2ijoinxzEPMwVql5YpoLy3VbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3616
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNlYmFzdGlhbiBSZWljaGVs
IFttYWlsdG86c2ViYXN0aWFuLnJlaWNoZWxAY29sbGFib3JhLmNvbV0NCj4gU2VudDogMjAyMMTq
OdTCMcjVIDE5OjQ3DQo+IFRvOiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBD
YzogbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAu
Y29tPjsgU2hhd24NCj4gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgU2FzY2hhIEhhdWVyIDxz
LmhhdWVyQHBlbmd1dHJvbml4LmRlPjsNCj4gUGVuZ3V0cm9uaXggS2VybmVsIFRlYW0gPGtlcm5l
bEBwZW5ndXRyb25peC5kZT47IEZhYmlvIEVzdGV2YW0NCj4gPGZlc3RldmFtQGdtYWlsLmNvbT47
IEJhdW1nYXJ0bmVyLCBDbGF1cyAoR0UgSGVhbHRoY2FyZSkNCj4gPGNsYXVzLmJhdW1nYXJ0bmVy
QG1lZC5nZS5jb20+DQo+IFN1YmplY3Q6IFJlOiBtbWMwOiBUaW1lb3V0IHdhaXRpbmcgZm9yIGhh
cmR3YXJlIGNtZCBpbnRlcnJ1cHQgb24gaS5NWDUzNQ0KPiANCj4gSGksDQo+IA0KPiBbYWRkIGku
TVggYXJjaGl0ZWN0dXJlIG1haW50YWluZXJzIHRvIENjXQ0KPiANCj4gT24gVHVlLCBTZXAgMDEs
IDIwMjAgYXQgMDc6Mzc6MzFBTSArMDAwMCwgQmF1bWdhcnRuZXIsIENsYXVzIChHRQ0KPiBIZWFs
dGhjYXJlKSB3cm90ZToNCj4gPiBXZSBoYXZlIGEgYm9hcmQgd2l0aCBhbiBpLk1YNTM1IHVzaW5n
IGEgU2Ftc3VuZyBlTU1DIGFzIHBlcnNpc3RlbnQNCj4gPiBzdG9yYWdlIGNvbm5lY3RlZCB0byBl
U0RIQ3YzLiBFdmVyeSBub3cgYW5kIHRoZW4gd2UgcHJvZHVjZSBhIGJ1aWxkDQo+ID4gdGhhdCBj
YXVzZXMgZW1tYyB0aW1lb3V0czoNCj4gPg0KPiA+IEF1ZyAyOCAwNzozMjoxMiBjc21vbiBrZXJu
ZWw6IG1tYzA6IFRpbWVvdXQgd2FpdGluZyBmb3IgaGFyZHdhcmUgY21kDQo+IGludGVycnVwdC4N
Cj4gPiBBdWcgMjggMDc6MzI6MTIgY3Ntb24ga2VybmVsOiBtbWMwOiBzZGhjaTogPT09PT09PT09
PT09IFNESENJIFJFR0lTVEVSDQo+ID4gRFVNUCA9PT09PT09PT09PSBBdWcgMjggMDc6MzI6MTIg
Y3Ntb24ga2VybmVsOiBtbWMwOiBzZGhjaTogU3lzIGFkZHI6DQo+ID4gMHhlM2YxMjAwMCB8IFZl
cnNpb246ICAweDAwMDAxMjAxIEF1ZyAyOCAwNzozMjoxMiBjc21vbiBrZXJuZWw6IG1tYzA6DQo+
ID4gc2RoY2k6IEJsayBzaXplOiAgMHgwMDAwMDIwMCB8IEJsayBjbnQ6ICAweDAwMDAwMDAxIEF1
ZyAyOCAwNzozMjoxMiBjc21vbg0KPiBrZXJuZWw6IG1tYzA6IHNkaGNpOiBBcmd1bWVudDogIDB4
MDAwMTAwMDAgfCBUcm4gbW9kZTogMHgwMDAwMDAwMA0KPiA+IEF1ZyAyOCAwNzozMjoxMiBjc21v
biBrZXJuZWw6IG1tYzA6IHNkaGNpOiBQcmVzZW50OiAgIDB4MDFmODAwMDggfCBIb3N0DQo+IGN0
bDogMHgwMDAwMDAzMQ0KPiA+IEF1ZyAyOCAwNzozMjoxMiBjc21vbiBrZXJuZWw6IG1tYzA6IHNk
aGNpOiBQb3dlcjogICAgIDB4MDAwMDAwMDIgfCBCbGsNCj4gZ2FwOiAgMHgwMDAwMDAwMA0KPiA+
IEF1ZyAyOCAwNzozMjoxMiBjc21vbiBrZXJuZWw6IG1tYzA6IHNkaGNpOiBXYWtlLXVwOiAgIDB4
MDAwMDAwMDAgfA0KPiBDbG9jazogICAgMHgwMDAwMDExZg0KPiA+IEF1ZyAyOCAwNzozMjoxMiBj
c21vbiBrZXJuZWw6IG1tYzA6IHNkaGNpOiBUaW1lb3V0OiAgIDB4MDAwMDAwOGUgfCBJbnQNCj4g
c3RhdDogMHgwMDAwMDAwMA0KPiA+IEF1ZyAyOCAwNzozMjoxMiBjc21vbiBrZXJuZWw6IG1tYzA6
IHNkaGNpOiBJbnQgZW5hYjogIDB4MTA3ZjAwMGIgfCBTaWcNCj4gPiBlbmFiOiAweDEwN2YwMDBi
IEF1ZyAyOCAwNzozMjoxMiBjc21vbiBrZXJuZWw6IG1tYzA6IHNkaGNpOiBBQ21kIHN0YXQ6DQo+
IDB4MDAwMDAwMDAgfCBTbG90IGludDogMHgwMDAwMTIwMQ0KPiA+IEF1ZyAyOCAwNzozMjoxMiBj
c21vbiBrZXJuZWw6IG1tYzA6IHNkaGNpOiBDYXBzOiAgICAgIDB4MDdlYjAwMDAgfA0KPiBDYXBz
XzE6ICAgMHgwODEwMDgxMA0KPiA+IEF1ZyAyOCAwNzozMjoxMiBjc21vbiBrZXJuZWw6IG1tYzA6
IHNkaGNpOiBDbWQ6ICAgICAgIDB4MDAwMDBkMWEgfA0KPiBNYXggY3VycjogMHgwMDAwMDAwMA0K
PiA+IEF1ZyAyOCAwNzozMjoxMiBjc21vbiBrZXJuZWw6IG1tYzA6IHNkaGNpOiBSZXNwWzBdOiAg
IDB4MDA0MDA5MDAgfA0KPiBSZXNwWzFdOiAgMHgwMDAwMDAwMA0KPiA+IEF1ZyAyOCAwNzozMjox
MiBjc21vbiBrZXJuZWw6IG1tYzA6IHNkaGNpOiBSZXNwWzJdOiAgIDB4MDAwMDAwMDAgfA0KPiBS
ZXNwWzNdOiAgMHgwMDAwMDAwMA0KPiA+IEF1ZyAyOCAwNzozMjoxMiBjc21vbiBrZXJuZWw6IG1t
YzA6IHNkaGNpOiBIb3N0IGN0bDI6IDB4MDAwMDAwMDAgQXVnDQo+ID4gMjggMDc6MzI6MTIgY3Nt
b24ga2VybmVsOiBtbWMwOiBzZGhjaTogQURNQSBFcnI6ICAweDAwMDAwMDAwIHwgQURNQQ0KPiA+
IFB0cjogMHhlZjA0MTIwOCBBdWcgMjggMDc6MzI6MTIgY3Ntb24ga2VybmVsOiBtbWMwOiBzZGhj
aToNCj4gPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiAN
Cj4gU29tZSBleHRyYSBpbmZvcm1hdGlvbjogVGhlIHRpbWVvdXQgYWx3YXlzIGhhcyBjbWQgPSAw
eDAwMDAwZDFhDQo+IChNTUNfU0VORF9TVEFUVVMpIGFuZCByZXNwWzBdID0gMHgwMDQwMDkwMCB3
aXRoIHJlc3BbMF0gdHJhbnNsYXRpbmcgdG8NCj4gdGhpcyBJSVVJQzoNCj4gDQo+IEJpdCA4ID0g
UmVhZHkgZm9yIGRhdGENCj4gQml0IDExID0gQ1VSUkVOVF9TVEFURSBpcyBUUkFODQo+IEJpdCAy
MiA9IElsbGVnYWwgY29tbWFuZA0KDQpBY2NvcmRpbmcgdG8gdGhlIGNvZGUgbG9naWMsIHNpbmNl
IHRoaXMgY21kMTMgZ2V0IGhhcmR3YXJlIGNtZCB0aW1lb3V0LCB3aGljaCBtZWFucyB0aGlzIGNt
ZDEzIGRvIG5vdCBnZXQgYW55IHJlc3BvbnNlLiBIZXJlIHRoZSBSZXNwWzBdIHNob3VsZCBiZSB0
aGUgcHJldmlvdXMgY29tbWFuZCdzIHJlc3BvbnNlLg0KU28gdGhpcyBtZWFucyB0aGUgcHJldmlv
dXMgY29tbWFuZCBpcyBhbiBpbGxlZ2FsIGNvbW1hbmQsIGNhdXNlIHRoZSBlbW1jIGludGVybmFs
IGZpcm13YXJlIHN0dWNrLCBhbmQgY2FuJ3QgcmVzcG9uc2UgdG8gdGhlIG5leHQgY21kMTMuDQpJ
IHRoaW5rIHdlIG5lZWQgdG8gZmlyc3RseSBpZGVudGlmeSB0aGUgc3BlY2lmaWMgcGxhY2UgaW4g
ZW1tYyBkcml2ZXIgd2hpY2ggdHJpZ2dlciB0aGUgbG9nIGR1bXAuIA0KDQoNCkJlc3QgUmVnYXJk
cw0KSGFpYm8gQ2hlbg0KDQo+IA0KPiA+IFRpbWVvdXRzIGRvIG5vdCBvY2N1ciB3aXRoIGV2ZXJ5
IGJ1aWxkLiBBZnRlciBzb21lIGRlYnVnZ2luZyBJIGhhdmUNCj4gPiBmb3VuZCB0aGF0IHRpbWVv
dXRzIHNlZW0gdG8gZGVwZW5kIG9uIGNvZGUgYWxpZ25tZW50IG9mIHRoZQ0KPiA+IGVzZGhjX3Jl
YWRsX2xlIGZ1bmN0aW9uLiBJIGhhdmUgYmlzZWN0ZWQgdGhlIGJlaGF2aW9yIGJ5IHVzaW5nIHRo
ZQ0KPiA+IFN5c3RlbS5tYXAgYW5kIG1vdmluZy9wYWRkaW5nIHRoZSBjb2RlIHdpdGggTk9QIGlu
c3RydWN0aW9ucyAobW92DQo+ID4gcjAscjApLg0KPiA+DQo+ID4gTXkgdGVzdCBjYXNlIGhhcyA1
IHByb2Nlc3NlcyBjb250aW51b3VzbHkgY3JlYXRpbmcgYSBmaWxlLCB3cml0aW5nDQo+ID4gcmFu
ZG9tIGxvbmcgZGF0YSwgcmVhZGluZyBkYXRhIGFuZCBkZWxldGluZyB0aGUgZmlsZS4gSXQgc2Vl
bXMgdGhhdA0KPiA+IHdoZW4gdGhlIGVzZGhjX3dyaXRlbF9sZSBpcyBhbGlnbmVkIG9uIGEgY2Vy
dGFpbiBhZGRyZXNzIHRoZW4gdGhlDQo+ID4gdGltZW91dCB3aWxsIG9jY3VyIGFib3V0IDUgdGlt
ZXMvMTJoIHVzaW5nIG15IHRlc3QgY2FzZS4gSWYgSSBhZGQgb25lDQo+ID4gbW9yZSBOT1AsIHRo
ZSB0aW1lb3V0IHdpbGwgbm90IG9jY3VyIGF0IGFsbC4gSWYgSSBjb250aW51ZSBhZGRpbmcgc29t
ZQ0KPiA+IG1vcmUgTk9QcyB0aGUgdGltZW91dHMgY29tZSBiYWNrLiBTZWVtcyB0aGF0IGl0IGRv
ZXNuJ3QgbWF0dGVyIHdoZXJlDQo+ID4gaW4gdGhlIGNvZGUgSSBhZGQgTk9QcyBhcyBsb25nIGFz
IHRoZSBhZGRyZXNzIGlzIGJlbG93IHRoZSBhZGRyZXNzIG9mDQo+ID4gZXNkaGNfd3JpdGVsX2xl
Lg0KPiA+DQo+ID4gV2UgYWxzbyBydW4gdGhlIHNhbWUgc29mdHdhcmUgb24gYSBkdWFsIGNvcmUg
aS5NWDYgd2l0aG91dCBhbnkgdGltZW91dA0KPiA+IGlzc3Vlcy4NCj4gDQo+IEFuZCB0aGUgc2Ft
ZSBrZXJuZWwgYmluYXJ5IGlzIGFsc28gdXNlZCBvbiBhbiBpLk1YNiBzaW5nbGUgY29yZSAoYWxi
ZWl0IHdpdGgNCj4gZGlmZmVyZW50IFNXKSB3aXRob3QgdHJpZ2dlcmluZyB0aGUgcHJvYmxlbSBz
byBmYXIuDQo+IA0KPiA+IEkgaGF2ZSByZXByb2R1Y2VkIHRoaXMgd2l0aCBrZXJuZWwgdmVyc2lv
biA0LjE5Ljk0IGFuZCA1LjguMyBhbmQgd2UNCj4gPiBoYXZlIGNvbXBpbGVkIHdpdGggYm90aCBn
Y2M4IGFuZCBnY2M5LiBJJ20gc3RpbGwgc2VhcmNoaW5nIGZvciB0aGUNCj4gPiByb290IGNhdXNl
IGFuZCBJIHdvdWxkIGFwcHJlY2lhdGUgYW55IHRob3VnaHRzIGFib3V0IHdoZXJlIHRvIGdvIG5l
eHQuDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4NCj4gPiAtQ2xhdXMtDQo+IA0KPiBUbyBtZSBpdCBs
b29rcyBsaWtlIGl0IG1pZ2h0IGludm9sdmUgYW4gdW5rbm93biBoYXJkd2FyZSBlcnJhdGEgZm9y
IGkuTVg1MywgYnV0DQo+IHRoZXJlIGhhcyBiZWVuIG9uZSBzaW1pbGFyIHJlcG9ydCBiZWZvcmUg
KHVuZm9ydHVuYXRlbHkgd2l0aG91dCB0aGUgZnVsbA0KPiByZWdpc3RlciBkdW1wKSBpbnZvbHZp
bmcgdmlydHVhbGl6YXRpb246DQo+IA0KPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Bh
dGNoLzEwNzA1ODIzLw0KPiANCj4gTm90ZSwgdGhhdCBDbGF1cycga2VybmVsIGhhcyBiZWVuIGJ1
aWx0IHdpdGggQ09ORklHX1BSRUVNUFRfTk9ORT15Lg0KPiANCj4gLS0gU2ViYXN0aWFuDQo=
