Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50A0C4338F
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Aug 2021 03:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FD3A6112D
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Aug 2021 03:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbhHSDbO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Aug 2021 23:31:14 -0400
Received: from mail-eopbgr130074.outbound.protection.outlook.com ([40.107.13.74]:8519
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236181AbhHSDbN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 18 Aug 2021 23:31:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqaJZiJuuGc+RYST+MGgSlcRomCK0iWcYAdBKEpG9jvnCF00Co06AzRo3q374OizUA5N6XxZGFGD5H0lj7B5hDB7fTaqJ66t+al8nKIE86N/sNxV40PRRNIyudAIyGp+ZuityRlDFJUYb+AhgXyF/ozsC9EP06h6QRtyKx1MNQ+YSGAFHshw5dx6DD1hbkCJZARIclDZUDne95gRZcMNitFE3E9H8D8QPCVxJRrdjeQosyQulnh3OPL4v2mx66BJ3m9ts/W2ZcQVPsJ8GBu8I2nGi/ZV1QDqK5SVpX+ePtXbq/mYbNEAbASSN6COJzGdLWQ7OlZByjBXxwK6baRJrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkRqQ/F99GoGV0tVgcTRvrJ9e7IpTfB7W5+d1x6lcPI=;
 b=V+ExmP5ICwuvm7AN7eHRmYD1M+gcx/pdsIzOAAKSwa/K7cjbzdbvgOGPJLln3XyFC1gjSbc2rdJ3MJvTEVWRUdOQ6pSnuAhtjdLw1lMJ357T9lgM/7akEGiE4o0pfDeBgT9ZWqUl46qnLtzirMeWfN1jEweDVOS76mLDYK25NA4ThhrVVmfSrPLqcWQV3BuuORISTmVFl/38P2HCRfIRUY0siZkcvXk7mCxp5odmVU9ZkUFxO+2yVuikKNTdh5QYEIn6pcL6RJW/OiHyXPParZk85N163Fh0fJuCVAcMrRFYIOJjVQGuDIOklHxCSQwDm4XTedsPpyHGFnet2UQwLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkRqQ/F99GoGV0tVgcTRvrJ9e7IpTfB7W5+d1x6lcPI=;
 b=jDxurqJumjrtbLQJaaTBgr3ZB3xHrRdO2VLImtvYZVJcm1dpNChCvuFaHdWpE3bB1d4w+N+I+e0i3iSjwo9u9FCbEOm66qOTjUDzaW/nQ1GQGTqbAEo9OP9wWD4Se9ems2cGPundYQDPMEBVX3tcfqK2WRd2rRFPe8pUlkx4IJY=
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com (2603:10a6:803:5a::22)
 by VI1PR04MB4429.eurprd04.prod.outlook.com (2603:10a6:803:6e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.21; Thu, 19 Aug
 2021 03:30:33 +0000
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::c59c:3e45:7b94:e5b7]) by VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::c59c:3e45:7b94:e5b7%7]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 03:30:33 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: change the pinctrl-names
 rule
Thread-Topic: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: change the
 pinctrl-names rule
Thread-Index: AQHXlBj0H1JVxh3hpke1DpSZl4mdB6t5lt4AgACLkMA=
Date:   Thu, 19 Aug 2021 03:30:33 +0000
Message-ID: <VI1PR04MB5294534C01DD24063937E79290C09@VI1PR04MB5294.eurprd04.prod.outlook.com>
References: <1629279984-7397-1-git-send-email-haibo.chen@nxp.com>
 <YR1SdhfM344Ii7BQ@robh.at.kernel.org>
In-Reply-To: <YR1SdhfM344Ii7BQ@robh.at.kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7493e3d8-d917-491b-75f2-08d962c1b3ee
x-ms-traffictypediagnostic: VI1PR04MB4429:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4429816ADC8CC25308FF065290C09@VI1PR04MB4429.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yp9If3xFypeISywOgww0NJhCFBgDbwHz3ec2vr8L6fcLlHqDpJSr6ne3/s/oFzIdUVAkp6O4dZkzqtn+BjZwU/QfDvFAkiNPgyDzwdim+lZHwnQIKljU99vpDWTR+QZHaE3A23UwSCDIu2yG1Cbsn0yhWmoaICpEONPq7PbE1EipTVaQjO5jYdcLbr7PIt1XIw2uBHE9QERJpDjXrkTkXsT4SCI5EWPFB3zkekUFrnCcmZJXwBcI99I+LmKLEZ+0/ir/SYt4dCp2ku815l0iPgvCcBiWZNNsZAsCcG5itE215lbEUNWzEfXyFeD1rR76bHd9cMIE79p/ARJ7qFVduT3FicaktYBZQF4451m9+NzfMA7iTNbLf48dbuTZE4SlFoDxnRasI88w2luyDgcApiD7tuXwuQ3GgJIxJ1hZkszK2SOMSeZ/SE0K+wTOgajdl+o83VdcSvFcdQpGcx4C9JGvuqeAH6omVhb8C6aDR2xoHFIgr9xvelTDwi5U/sVawScGG8ovAR56Y3r7d3T7Wd1U9FgzWnNdjKs5IyVtXMu/OoIq+fC2MjilQKpqMktbQoq2FO+YcbKzzoGfhiLwrGWnFqeadCI1E3VaULO48gh1R/Tx98aHrmKml1MkeAmQBgzsytSTY/nHnfpYN8yM2WTcX+zWsWhzvM5X/bAkEdA4qyM6E4YCvpn86vmDbob7k4Zjyfp+a1VnGIPlYe7lNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5294.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39850400004)(396003)(366004)(136003)(86362001)(66556008)(6916009)(122000001)(66446008)(186003)(54906003)(8676002)(38100700002)(38070700005)(53546011)(33656002)(8936002)(6506007)(71200400001)(7696005)(64756008)(316002)(76116006)(2906002)(83380400001)(4326008)(9686003)(478600001)(55016002)(66946007)(26005)(66476007)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?OWR5VWFkWW1aWVVYOWZKTmFodThxYmRCait4cERocXI5Vkcwd1NWMW8zbzlO?=
 =?gb2312?B?NE9JQngvN3V6cWxsTWx6N25rdVJ3SFJlMmdVWlVzYldPU2FKNGloTzZvRVVG?=
 =?gb2312?B?ZFA0ejB2RW9LN3BOK0hZb0UzUnZ5MlJXMlJiUlpVUUQvM3I5Uy9hQW5ocXBX?=
 =?gb2312?B?eGRsSHZmZ3A4ZGZ6U3c5TEpPQWlGajZjbnBXWENsZ3kwditHMWp6M2x2WkRr?=
 =?gb2312?B?ZjVESGhEbm1kazNYVTV0Z0t0VXpDVTA2Y2J0S2cyK2F1eW9aQ1lORTFadTFk?=
 =?gb2312?B?MU9sSWRPemV3bk1HdFRYNGY3cUxHb1VVSXJNVVpTWUVqeGlWNERGYjJPNkc4?=
 =?gb2312?B?SnNscTJZRVFMeVk1QjhaZjdKdzhHTVI0ajUrWElvL3F2NWZVbkwxeGR3Q3Rn?=
 =?gb2312?B?RURKaDN5cVNqdzdHMFVzWk9GQklId1kvdlJnY09KOXpTV2h5ZVRpcWdQdWUw?=
 =?gb2312?B?cFJma2RoOGhYUVhWVGJISE1CT3I0aDFOWGpRQzZYbm5UVTlPc3NxL1FkWitp?=
 =?gb2312?B?TjViaEcraS9YS0tCclVpaFJPOXIvcmQydjZ4czUrSW1NR3AzYVlFbDIwNWdU?=
 =?gb2312?B?SitJOXhXTGlpS0k0NE9iK05Xc1lIMXRBR29lRDZLSHpBcGZreGZ1RnlwY0lj?=
 =?gb2312?B?ckVuWS90aVZPSmdPMGk4QUE0MkhmRndFdk4zYk9UN3g0R2lxUlVzcUtEclhE?=
 =?gb2312?B?ZnF3WGxhMW91QkluWWVOWTBlNmRmR0NiZWgzMkkrUENBRUh4N0xtRTRRMEhj?=
 =?gb2312?B?V1cxN3hKM2xQajZRdTJEM24zbGZ3Y2lLMjg3UGJIR3BzK3hQanp2L3M0ajZV?=
 =?gb2312?B?LzdZcEE5QVhGYldFelpNV1hrbnZSczhEL0lBT01nOVhvRmhvSUF5RkNlOFV3?=
 =?gb2312?B?Wkw1cVltTy9wWTlKZ1JBWGVHNTFady9EL0cvY0Z6UG01eVZjTHJ2dlQzbUJz?=
 =?gb2312?B?dmJyUVV2b0FmOXpKR0t2VTRVMERUcTI5NTltaUdiTnVwRlF2ZzFJN1ViRy9L?=
 =?gb2312?B?RUtWUFRFR092Z0VodTlvQ3hWaHFJT3ZpTncwdEIyMVJuak5vSG1DaUpZQ2FQ?=
 =?gb2312?B?TjZKRGEvdWhKckVQdGlZVXpCb1NsaXcrTFRxNlA3VWowNEdMK1M1aTNYN1lx?=
 =?gb2312?B?Zy9HNUNoZ1hXRUxNMXhNc1labDJRVEt5SjZMRlZ4d2pFVFRuUC9VZFNqd0pO?=
 =?gb2312?B?bU1KZjJMRjdmNUJQalpyN0FkbjNLNG02MWdpcmRLZUxnMjJtUkV5Y2FwT2hu?=
 =?gb2312?B?SnhNVXdpSVBpeXFELy9ISzlBWS9EY3k3bkpVNjhmaUJQM3VudVNXeXRseVNa?=
 =?gb2312?B?K29LZ1U3WHB6UkFWRUZ6Y3lpVjltMmRtSWRtd1REZXBxYTNyeW13djZSMTNi?=
 =?gb2312?B?aXBGYU5tcFhqTjJ3VEJNcU5oVjhsaGRFQkVRUHVvMnp5OXo4WkovQk1yVjdx?=
 =?gb2312?B?MW1PSFh5U2Q2REczYUQzRy8vTEg5Z1BxYlk2S1B6SzE5UzNla29hNDNMb2NB?=
 =?gb2312?B?V3dGTDJDY1BsbzMyWmgrZkdyWnhRL0hyRWM0MjJEc01SK1MyM3lIdVBtOWZj?=
 =?gb2312?B?OGpGeFQyYUF0U1BUU0xUcnZaODBqYW94NGduN2t6czR6YlE3Zy9pMmR0YlJY?=
 =?gb2312?B?blA0Ni9vVHI4dWFkaVJNTWw1S2gxbU9wcmtwM2xCTER2cm4wNll2czJuWE82?=
 =?gb2312?B?Y3kwbFhqd21QMWZaRktHTGV1VmJqVm9KcW10cDdEcWM1RkJMTzM2ZmN5QlIx?=
 =?gb2312?Q?IYqd0jwVv1sv8mVGwmxuSfpPJFKYeIYhIr79mj0?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5294.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7493e3d8-d917-491b-75f2-08d962c1b3ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 03:30:33.4916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eGXn9w03GoOl/gbI5w5Z3z3qqx2/hrO6dz1Vl6pSwdQkkLXE8tTAZme5Ez7iD6aVpu9ZB9GrH3nOzZOAad8EWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4429
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyBbbWFpbHRv
OnJvYmhAa2VybmVsLm9yZ10NCj4gU2VudDogMjAyMcTqONTCMTnI1SAyOjMzDQo+IFRvOiBCb3Vn
aCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+IENjOiBzaGF3bmd1b0BrZXJuZWwub3JnOyBz
LmhhdWVyQHBlbmd1dHJvbml4LmRlOyB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOw0KPiBrZXJuZWxA
cGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwtbGludXgtaW14DQo+IDxsaW51
eC1pbXhAbnhwLmNvbT47IEFpc2hlbmcgRG9uZyA8YWlzaGVuZy5kb25nQG54cC5jb20+Ow0KPiBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOw0KPiBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0hdIGR0LWJpbmRpbmdzOiBtbWM6IGZzbC1pbXgtZXNkaGM6IGNoYW5nZSB0aGUNCj4gcGluY3Ry
bC1uYW1lcyBydWxlDQo+IA0KPiBPbiBXZWQsIEF1ZyAxOCwgMjAyMSBhdCAwNTo0NjoyNFBNICsw
ODAwLCBoYWliby5jaGVuQG54cC5jb20gd3JvdGU6DQo+ID4gRnJvbTogSGFpYm8gQ2hlbiA8aGFp
Ym8uY2hlbkBueHAuY29tPg0KPiA+DQo+ID4gQ2hhbmdlIHRoZSBwaW5jdHJsLW5hbWVzIHJ1bGUg
dG8gY292ZXIgYWxsIGNhc2VzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSGFpYm8gQ2hlbiA8
aGFpYm8uY2hlbkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3MvbW1jL2ZzbC1p
bXgtZXNkaGMueWFtbCAgICAgICAgICAgfCAyMSArKysrKysrKysrKysrLS0tLS0tDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvZnNsLWlt
eC1lc2RoYy55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1j
L2ZzbC1pbXgtZXNkaGMueWFtbA0KPiA+IGluZGV4IDE3MDg2ZjYwZjhhMy4uZDMyNDYwNmE0ZjBh
IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMv
ZnNsLWlteC1lc2RoYy55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21tYy9mc2wtaW14LWVzZGhjLnlhbWwNCj4gPiBAQCAtMTE2LDEyICsxMTYsMjEgQEAg
cHJvcGVydGllczoNCj4gPiAgICAgICAgLSBjb25zdDogcGVyDQo+ID4NCj4gPiAgICBwaW5jdHJs
LW5hbWVzOg0KPiA+IC0gICAgbWluSXRlbXM6IDENCj4gPiAtICAgIGl0ZW1zOg0KPiA+IC0gICAg
ICAtIGNvbnN0OiBkZWZhdWx0DQo+ID4gLSAgICAgIC0gY29uc3Q6IHN0YXRlXzEwMG1oeg0KPiA+
IC0gICAgICAtIGNvbnN0OiBzdGF0ZV8yMDBtaHoNCj4gPiAtICAgICAgLSBjb25zdDogc2xlZXAN
Cj4gPiArICAgIG9uZU9mOg0KPiA+ICsgICAgICAtIGl0ZW1zOg0KPiA+ICsgICAgICAgICAgLSBj
b25zdDogZGVmYXVsdA0KPiA+ICsgICAgICAgICAgLSBjb25zdDogc3RhdGVfMTAwbWh6DQo+ID4g
KyAgICAgICAgICAtIGNvbnN0OiBzdGF0ZV8yMDBtaHoNCj4gPiArICAgICAgICAgIC0gY29uc3Q6
IHNsZWVwDQo+ID4gKyAgICAgIC0gaXRlbXM6DQo+ID4gKyAgICAgICAgICAtIGNvbnN0OiBkZWZh
dWx0DQo+ID4gKyAgICAgICAgICAtIGNvbnN0OiBzdGF0ZV8xMDBtaHoNCj4gPiArICAgICAgICAg
IC0gY29uc3Q6IHN0YXRlXzIwMG1oeg0KPiANCj4gWW91IGNhbiBkcm9wIHRoaXMgb25lIGFuZCBh
ZGQgJ21pbkl0ZW1zOiAzJyB0byB0aGUgZmlyc3QgY2FzZS4NCg0KT2theSwgSSB3aWxsIGRvIHRo
YXQuDQoNCj4gDQo+ID4gKyAgICAgIC0gaXRlbXM6DQo+ID4gKyAgICAgICAgICAtIGNvbnN0OiBk
ZWZhdWx0DQo+ID4gKyAgICAgICAgICAtIGNvbnN0OiBzbGVlcA0KPiA+ICsgICAgICAtIGl0ZW1z
Og0KPiA+ICsgICAgICAgICAgLSBjb25zdDogZGVmYXVsdA0KPiANCj4gU2ltaWxhciBoZXJlIHRv
byB3aXRoIHRoZSBwcmlvciBjYXNlLiBPciB1c2UgJ21pbkl0ZW1zOiAxJyBpbiB0aGUgZmlyc3Qg
Y2FzZS4gVGhhdA0KPiBhZGRpdGlvbmFsIGFsbG93cyB0aGUgMiBlbnRyeSBjYXNlLCBidXQgd2h5
IGlzbid0IHRoYXQgdmFsaWQ/DQo+IENvdWxkbid0IGEgYm9hcmQgb25seSBzdXBwb3J0IGRlZmF1
bHQrc3RhdGVfMTAwbWh6Pw0KDQpMb2dpY2FsbHkgbm90LCBmb3IgYm9hcmQsIGlmIHN1cHBvcnQg
U0QzLjAgbW9kZSwgdGhpcyBtZWFucyBpdCBzdXBwb3J0IGJvdGggU0RSMTA0L1NEUjUwL0REUjUw
L0hTMjAwL0hTNDAwDQpTdGF0ZV8xMDBtaHogaXMgdXNlZCBmb3IgU0RSNTAgYW5kIEREUjUwLCBz
dGF0ZV8yMDBtaHogaXMgdXNlZCBmb3IgU0RSMTA0L0hTMjAwL0hTNDAwLg0KDQpTbywgaWYgdGhl
cmUgaXMgc3RhdGVfMTAwbWh6LCB0aGVyZSBzaG91bGQgYmUgc3RhdGVfMjAwbWh6Lg0KDQpSZXN0
IFJlZ2FyZHMNCkhhaWJvIENoZW4NCj4gDQo+IFJvYg0K
