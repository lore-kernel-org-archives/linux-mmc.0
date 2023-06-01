Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58294C77B7E
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Jun 2023 07:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjFAH5Z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Jun 2023 03:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjFAHzX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Jun 2023 03:55:23 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC19E4E;
        Thu,  1 Jun 2023 00:50:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lb+ZOEJENypvHtmLS/JyFSb9ihiqvlLIw0mD+WTl1RlWdz6Fk1d+41BlPo1TjBShi+i13rhUPoVejRnCc8LLTS0/5gu2JpDOZeJp5OyO/sG3D1BUBXBoI+D+A4ap7heIxVFhAFgqa+XxSgw+uSxR2xrKn18GjqlB3VSl7f2ZeQBZjiAnGk4wO/3JN4CMu5D+HLHiuZ/EjqMoQkEumAreqmRib9M2+qUYCh/gTSTpvZuaEcn4SycdaqO66ZA+8k7g6FxJAr0+bmOL/sj69favQ7EGa4B75C6uFUMpfBzrCKirOnzG/7GDBAsTSyCySfelbMwKpBjaUed97EdBBM7RGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/fhzWcPm4add01x4HQdgtaa3RJxjtYiFxLD+4PhiVA=;
 b=WA1L4P28ZQtbewQObcGDMeaGRkCh2JWe5m+PgHzIIlgXk94pn8IzuuEIF6i3VZbnflggRMSzQenF2jsFx6zepc/ywCdIchCMIMQ+njKK0/03rRirm2wAj6TLQA6J6tqKKIv20rS5bxZwqXhfOxBw9v9i9BzbJYRRAfRl7/IsR8dgzhCsdLXND/QvcfgF+wBWAjwtP+W/Bv6P5kHjJF8qmAFoJow1nlMO0JboVMYiuwfTZ5LjbwPiuyDV1UpMn8h27Li67g/O388BDaJSLU0tBdDlUWlHKTro7o+n5stK2770U8X9zk1KOj++LhIm9kkxwACfHLvXfroo3EEvPt/Bbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/fhzWcPm4add01x4HQdgtaa3RJxjtYiFxLD+4PhiVA=;
 b=GrLabROOP2LqjBy8tAjeC+dlB6ApV43/QUHEzyJl+ROHcNNUMmsw/mGddgGdqlplushs/zxoy5WAlFxYlGPW+WLIdw+1QgBFDk5YabBK8rBFTgfKz8X4LSaUYLwMgrRj7Td14wkJCBPU/0uiARn15SYkmmGlMim40tHXL+OSF1s=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AS8PR04MB9128.eurprd04.prod.outlook.com (2603:10a6:20b:44b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 07:50:26 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::f541:e455:e548:14a9]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::f541:e455:e548:14a9%5]) with mapi id 15.20.6433.022; Thu, 1 Jun 2023
 07:50:26 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "cniedermaier@dh-electronics.com" <cniedermaier@dh-electronics.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@dh-electronics.com" <kernel@dh-electronics.com>
Subject: RE: [PATCH v2 2/4] mmc: sdhci-esdhc-imx: remove redundant write
 protect code
Thread-Topic: [PATCH v2 2/4] mmc: sdhci-esdhc-imx: remove redundant write
 protect code
Thread-Index: AQHZf+3BDXJHtGHPs0yGrHBDPYoR8K9he8oAgBQ/pnA=
Date:   Thu, 1 Jun 2023 07:50:25 +0000
Message-ID: <DB7PR04MB4010759E7F1D2C342881A25C90499@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20230506074037.522961-1-haibo.chen@nxp.com>
 <20230506074037.522961-3-haibo.chen@nxp.com>
 <249e1058-790d-8e5b-663a-5ae0ceef3fe8@intel.com>
In-Reply-To: <249e1058-790d-8e5b-663a-5ae0ceef3fe8@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|AS8PR04MB9128:EE_
x-ms-office365-filtering-correlation-id: c63a2165-69e1-437f-358d-08db6274dc92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Z1SzqvX5mfBCL6V+3GDAirElM8cjYqk8jqDks6nvqGYtAUEHTYoJ65R9y+SZfa25JH5t9kQAeKcD7clYa7uZcHeebXATnulF+IQ/lKGujCm6tEFhlMx0knKnyadedQxq+2BC0xyYOGsqVb61DGikdsvzxuxHhRISN+eTO+X0iybqHGw/SL/gKvpShrCclyn0aHdeJoQayyJvksB+Wv2TGq6TXmLReI26snETe2qIRIV0f58NMouizBwDYitbzbsLPLP/N7HV06Ewml6GtHVdZ1yx9JVUgK2n/48CUCAs8TzJ/0k+CnjtQRPJyDir9Tx1P9yCY+wAKQ8yMe03JgE1SjLtZdMozNxNhkxJtEOfXXi2CUmjHpgfTI7Ei/7xc9Dklr+Nwn1mH/hR9Fcz90eRwArfo3OUhMGOVsPtjGxSi+WMOC0CzmJRTOrKTUvHRp0ry8w7dc30YHDr90mxI6a5y1dn0LPSueHDzXqzifqhbcHY24JYkiSh3HsHIly81EIrwD/QiQhWwh5qkSNxYYzxhV5kDD7kkf1WxJ5dvFtQ5QCQZctSIPBVJxU5VcwHwCSsrJx3inc45WQ6gTjLhkDAM2PJMoVeRjijiCMDJync2MrimI4nxxhkTfN8W1p00dP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199021)(2906002)(8676002)(38070700005)(52536014)(5660300002)(8936002)(7416002)(38100700002)(33656002)(41300700001)(86362001)(66556008)(66446008)(64756008)(66946007)(26005)(66476007)(4326008)(6506007)(186003)(122000001)(316002)(76116006)(83380400001)(53546011)(9686003)(110136005)(54906003)(478600001)(7696005)(71200400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHdwYzZuUHBUa2xCbjVOK1N1djNlcWNINzVJNW14NHFiQ0I5N1FUU0xNSUI3?=
 =?utf-8?B?U3A1MmZiaWEwYm9TdDBNa2lsODJENmJPMHpBNDQvcC91dURSc1JGMm9JOWYy?=
 =?utf-8?B?cU1IZ3luQWpWa3UrR3Y1cis4YXZ0OHpEVDN4SDF1V0hoS3M3MlN5YmlpKzVm?=
 =?utf-8?B?T3JrSFNkMktXL0tYRVo2MVB6WGVuNFFsZ1ByenRlNGVuV3VXeThPRTVtejNH?=
 =?utf-8?B?ZjZ6czUvbEJWYWZITndrOHY0NHFBYVBZS0lYNHVqT2VXVXppT3FOQmNBZ2NS?=
 =?utf-8?B?TFNvN08vaFYvdFZUZHQ5MC9PSGhXbGFlTWF2VDNzTlhZOVBTMWRPN0pZRmVP?=
 =?utf-8?B?Mnp3MDcrdGllV2xPM3RKb3VkcWdVSFlHSC9Mc3daT3dQMHhEelRkYUM2N3Jv?=
 =?utf-8?B?MXNZdExsNGQvWWRZWmVjckhNaiszengveGJMK2FMSTZIWCtFZ0NmU29DTGxr?=
 =?utf-8?B?aHVlOHNNZExKSGJRYXZqdTRGUFptVHpIR2ZyUzAwQmhhS3JSaU0zWjcxVC9h?=
 =?utf-8?B?OWdyU0RqbzZoMEt6SkpIWnBZajJuODA3Ukd4cHhKVTlnMzZhWTgrczJKczVU?=
 =?utf-8?B?U0VSRVR6cmxxdVRaUlpJZ2tpbjNybTRkVXZWeTk2azVlQUtYZ2tsMnBQK1pL?=
 =?utf-8?B?UWZlbys1RjRxc3Uya2ljOVZVSUNWNFF3a1kwRjJZeEZ3UzA2NUYvUmtCdlhn?=
 =?utf-8?B?Nlk2WVk4b2JyYjE2ZVZUUGRJWmNpbXRFMVFNK2JISUQ3S1RBcTdQSElxanpU?=
 =?utf-8?B?VXU2dmZiZmQ2QXNlTU5BaklMaS9teTRHMFAwUUxIdlpNVm50amhqUDN5MnBp?=
 =?utf-8?B?ODRteWVIbVROekQrdytWeWpDLzNPcjZjMXNUM2Rwc2hLcFF0YXlpZm5yY0FT?=
 =?utf-8?B?TThUSDRNUFB0NzFBYk5yZnZOUDRuUk9CNUJCUEY2eFdoRUVtZ2d4bllLaDBO?=
 =?utf-8?B?RWtUMEF0SlhNNlQ0Zk01U21WUGp5VmI1OHhkRlpndlUzd3RMRHBMUXdmWFFj?=
 =?utf-8?B?ZmRHN2x0UzhsRGpMMGpvYWJ5WVhPbzJBS2JpMnNqSytJZi9mSnlwYzZFdXc1?=
 =?utf-8?B?dTNBTEpPN3NHQnZDYjQvZUlMeE5OY2VUR1J6R3JtSWJrZEU3UjBhT040Qjlx?=
 =?utf-8?B?UW0rUkxuZTU5M3NGV1JYRlFuVDVGVGR0LzlyK2Q0SlJyZjFkbHJGVklBOEVt?=
 =?utf-8?B?cnBQeHBBZml1aVFoK0Uwa0Vadyt3VVE1SWhaajA1VXU5V3FZcDVOcjBwRWJM?=
 =?utf-8?B?YVMxT0VYSnFWcnpEL1RCNFRnOE15TWxJSjJqTVM4ZXM2Q2tBNkwwY1hNSm4w?=
 =?utf-8?B?YXhMQVZEWkhNdFc2eGZRWjMyQjZURHBlNWZTS3I3R050Uk1zdUNCWEJIRkI0?=
 =?utf-8?B?MWc2MXdXWHhxM2Z0S01YNVVjdFlTZlVkaHduVmVVeG9zVHNxbDJMUGdsVXYr?=
 =?utf-8?B?Q0VGYmtoc1UxQTdjdFFPaHp1dGIxWDhWMnM3YW9CbTRTd2hUcnJhMnJya2RD?=
 =?utf-8?B?M0xJT3k1UjVDZWg0V2YwRUI1VlVPVGVLWFlxdVhFWkNpWCtwMmo0ZFkxQS9J?=
 =?utf-8?B?UmJtMWhOUnYvWS9RMXZ2NFFDSU8yTCszRENGU0VNalhKZHVDVzN2akhkaU1K?=
 =?utf-8?B?d1VreDhOUGNBWDR6bFM2Um1uVTBPL2tibkpHUG9WeFdyemw0SHVEVXhWdEFQ?=
 =?utf-8?B?WnA1cENUN2hXQUh5eXI1aHd4VDhDd0R5NFJ6WkhtUWdNUDlIRnd4L29nL0Qx?=
 =?utf-8?B?RXVqQ1lQTG9WalEzTmJBYlZaTjk2eHREdGx5N3BuUVMxd0lEKzM2cFlmcXdZ?=
 =?utf-8?B?RUxsZ05jcHNhU1Y4SGhxc1pPKzRzcXYxTnkwSDVEanpjTks3QjB3Z1M5ZDNH?=
 =?utf-8?B?SzZROTJLYm9uOWtvbXh0RFYwYmFjUnlXRHZEK1JIdzIvSEIxSWpnZ2xMOVNU?=
 =?utf-8?B?WWF5SFd1Tmg5SFNGWXhBdHFaYWZzaWQ0M1FYbngwOU9vTHZySlNkVlRQMGkw?=
 =?utf-8?B?UmNsbUYrOXppaHNRQWhDSVo0YnZEUE9UcTJCYUhGcDZpR2xuMm1oWkh4d3M3?=
 =?utf-8?B?NHhEU1Evclo0QTdTOWlxUkFpUlVuL3V5R3VDUCtDQ3d3TmpPRDJ4SzB0R2VJ?=
 =?utf-8?Q?dPQU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63a2165-69e1-437f-358d-08db6274dc92
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 07:50:25.8894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xv9nDVN9eK1B3pjVHXjZYYWiuQ5OQFNybv92XAxPGz1JA37hthx+AXEjsYYUoM6JUmnBZyzeREd3rtjamQmm0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9128
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBZHJpYW4gSHVudGVyIDxhZHJp
YW4uaHVudGVyQGludGVsLmNvbT4NCj4gU2VudDogMjAyM+W5tDXmnIgxOeaXpSAxODozNw0KPiBU
bzogQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPjsgdWxmLmhhbnNzb25AbGluYXJvLm9y
ZzsNCj4gbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBr
cnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+
IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGUNCj4gQ2M6IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54
cC5jb20+OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGZlc3RldmFtQGdtYWlsLmNvbTsgY25p
ZWRlcm1haWVyQGRoLWVsZWN0cm9uaWNzLmNvbTsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7IGtlcm5lbEBkaC1lbGVjdHJvbmljcy5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAy
LzRdIG1tYzogc2RoY2ktZXNkaGMtaW14OiByZW1vdmUgcmVkdW5kYW50IHdyaXRlDQo+IHByb3Rl
Y3QgY29kZQ0KPiANCj4gT24gNi8wNS8yMyAxMDo0MCwgaGFpYm8uY2hlbkBueHAuY29tIHdyb3Rl
Og0KPiA+IEZyb206IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gPg0KPiA+IFRo
ZSBsb2dpYyBvZiB0aGUgZXNkaGNfcGx0Zm1fZ2V0X3JvKCkgaXMganVzdCB0aGUgc2FtZSB3aXRo
IGNvbW1vbg0KPiA+IGNvZGUgc2RoY2lfY2hlY2tfcm8oKS4gU28gcmVtb3ZlIHRoaXMgcmVkdW5k
YW50IGNvZGUsIGRlcGVuZHMgb24NCj4gPiBtbWNfb2ZfcGFyc2UoKSBhbmQgc2RoY2lfY2hlY2tf
cm8oKSB0byBjb3ZlciB0aGUgd3JpdGUgcHJvdGVjdCBsb2dpYy4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJp
dmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYyB8IDQ3DQo+ID4gKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNDYg
ZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhj
aS1lc2RoYy1pbXguYw0KPiA+IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0K
PiA+IGluZGV4IGM3ZGI3NDJmNzI5Yy4uNTQ1MzFhYWI3MGYwIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gPiArKysgYi9kcml2ZXJzL21tYy9o
b3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+ID4gQEAgLTIwMSwyMiArMjAxLDggQEANCj4gPiAgLyog
RVJSMDA0NTM2IGlzIG5vdCBhcHBsaWNhYmxlIGZvciB0aGUgSVAgICovDQo+ID4gICNkZWZpbmUg
RVNESENfRkxBR19TS0lQX0VSUjAwNDUzNglCSVQoMTcpDQo+ID4NCj4gPiAtZW51bSB3cF90eXBl
cyB7DQo+ID4gLQlFU0RIQ19XUF9OT05FLAkJLyogbm8gV1AsIG5laXRoZXIgY29udHJvbGxlciBu
b3IgZ3BpbyAqLw0KPiA+IC0JRVNESENfV1BfQ09OVFJPTExFUiwJLyogbW1jIGNvbnRyb2xsZXIg
aW50ZXJuYWwgV1AgKi8NCj4gPiAtCUVTREhDX1dQX0dQSU8sCQkvKiBleHRlcm5hbCBncGlvIHBp
biBmb3IgV1AgKi8NCj4gPiAtfTsNCj4gPiAtDQo+ID4gLS8qDQo+ID4gLSAqIHN0cnVjdCBlc2Ro
Y19wbGF0Zm9ybV9kYXRhIC0gcGxhdGZvcm0gZGF0YSBmb3IgZXNkaGMgb24gaS5NWA0KPiA+IC0g
Kg0KPiA+IC0gKiBFU0RIQ19XUChDRClfQ09OVFJPTExFUiB0eXBlIGlzIG5vdCBhdmFpbGFibGUg
b24gaS5NWDI1LzM1Lg0KPiA+IC0gKg0KPiA+IC0gKiBAd3BfdHlwZToJdHlwZSBvZiB3cml0ZV9w
cm90ZWN0IG1ldGhvZCAoc2VlIHdwX3R5cGVzIGVudW0gYWJvdmUpDQo+ID4gLSAqLw0KPiA+IC0N
Cj4gPiArLyogc3RydWN0IGVzZGhjX3BsYXRmb3JtX2RhdGEgLSBwbGF0Zm9ybSBkYXRhIGZvciBl
c2RoYyBvbiBpLk1YICovDQo+ID4gIHN0cnVjdCBlc2RoY19wbGF0Zm9ybV9kYXRhIHsNCj4gPiAt
CWVudW0gd3BfdHlwZXMgd3BfdHlwZTsNCj4gPiAgCWludCBtYXhfYnVzX3dpZHRoOw0KPiA+ICAJ
dW5zaWduZWQgaW50IGRlbGF5X2xpbmU7DQo+ID4gIAl1bnNpZ25lZCBpbnQgdHVuaW5nX3N0ZXA7
ICAgICAgIC8qIFRoZSBkZWxheSBjZWxsIHN0ZXBzIGluIHR1bmluZw0KPiBwcm9jZWR1cmUgKi8N
Cj4gPiBAQCAtOTk0LDI1ICs5ODAsNiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZXNkaGNfcGx0Zm1f
c2V0X2Nsb2NrKHN0cnVjdA0KPiA+IHNkaGNpX2hvc3QgKmhvc3QsDQo+ID4NCj4gPiAgfQ0KPiA+
DQo+ID4gLXN0YXRpYyB1bnNpZ25lZCBpbnQgZXNkaGNfcGx0Zm1fZ2V0X3JvKHN0cnVjdCBzZGhj
aV9ob3N0ICpob3N0KSAtew0KPiA+IC0Jc3RydWN0IHNkaGNpX3BsdGZtX2hvc3QgKnBsdGZtX2hv
c3QgPSBzZGhjaV9wcml2KGhvc3QpOw0KPiA+IC0Jc3RydWN0IHBsdGZtX2lteF9kYXRhICppbXhf
ZGF0YSA9IHNkaGNpX3BsdGZtX3ByaXYocGx0Zm1faG9zdCk7DQo+ID4gLQlzdHJ1Y3QgZXNkaGNf
cGxhdGZvcm1fZGF0YSAqYm9hcmRkYXRhID0gJmlteF9kYXRhLT5ib2FyZGRhdGE7DQo+ID4gLQ0K
PiA+IC0Jc3dpdGNoIChib2FyZGRhdGEtPndwX3R5cGUpIHsNCj4gPiAtCWNhc2UgRVNESENfV1Bf
R1BJTzoNCj4gPiAtCQlyZXR1cm4gbW1jX2dwaW9fZ2V0X3JvKGhvc3QtPm1tYyk7DQo+ID4gLQlj
YXNlIEVTREhDX1dQX0NPTlRST0xMRVI6DQo+ID4gLQkJcmV0dXJuICEocmVhZGwoaG9zdC0+aW9h
ZGRyICsgU0RIQ0lfUFJFU0VOVF9TVEFURSkgJg0KPiA+IC0JCQkgICAgICAgU0RIQ0lfV1JJVEVf
UFJPVEVDVCk7DQo+ID4gLQljYXNlIEVTREhDX1dQX05PTkU6DQo+ID4gLQkJYnJlYWs7DQo+ID4g
LQl9DQo+ID4gLQ0KPiA+IC0JcmV0dXJuIC1FTk9TWVM7DQo+ID4gLX0NCj4gPiAtDQo+ID4gIHN0
YXRpYyB2b2lkIGVzZGhjX3BsdGZtX3NldF9idXNfd2lkdGgoc3RydWN0IHNkaGNpX2hvc3QgKmhv
c3QsIGludA0KPiA+IHdpZHRoKSAgew0KPiA+ICAJdTMyIGN0cmw7DQo+ID4gQEAgLTEzODAsNyAr
MTM0Nyw2IEBAIHN0YXRpYyBzdHJ1Y3Qgc2RoY2lfb3BzIHNkaGNpX2VzZGhjX29wcyA9IHsNCj4g
PiAgCS5nZXRfbWF4X2Nsb2NrID0gZXNkaGNfcGx0Zm1fZ2V0X21heF9jbG9jaywNCj4gPiAgCS5n
ZXRfbWluX2Nsb2NrID0gZXNkaGNfcGx0Zm1fZ2V0X21pbl9jbG9jaywNCj4gPiAgCS5nZXRfbWF4
X3RpbWVvdXRfY291bnQgPSBlc2RoY19nZXRfbWF4X3RpbWVvdXRfY291bnQsDQo+ID4gLQkuZ2V0
X3JvID0gZXNkaGNfcGx0Zm1fZ2V0X3JvLA0KPiA+ICAJLnNldF90aW1lb3V0ID0gZXNkaGNfc2V0
X3RpbWVvdXQsDQo+ID4gIAkuc2V0X2J1c193aWR0aCA9IGVzZGhjX3BsdGZtX3NldF9idXNfd2lk
dGgsDQo+ID4gIAkuc2V0X3Voc19zaWduYWxpbmcgPSBlc2RoY19zZXRfdWhzX3NpZ25hbGluZywg
QEAgLTE1ODgsMTcgKzE1NTQsNiBAQA0KPiA+IHNkaGNpX2VzZGhjX2lteF9wcm9iZV9kdChzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiA+ICAJc3RydWN0IGVzZGhjX3BsYXRmb3JtX2Rh
dGEgKmJvYXJkZGF0YSA9ICZpbXhfZGF0YS0+Ym9hcmRkYXRhOw0KPiA+ICAJaW50IHJldDsNCj4g
Pg0KPiA+IC0JaWYgKG9mX3Byb3BlcnR5X3JlYWRfYm9vbChucCwgImZzbCx3cC1jb250cm9sbGVy
IikpDQo+ID4gLQkJYm9hcmRkYXRhLT53cF90eXBlID0gRVNESENfV1BfQ09OVFJPTExFUjsNCj4g
DQo+IGVzZGhjX3BsdGZtX2dldF9ybygpIGRpZmZlcnMgZnJvbSBzZGhjaV9jaGVja19ybygpIGJ5
IGRlZmF1bHRpbmcgdG8gLUVOT1NZUyBpZg0KPiB0aGVyZSBpcyBuZWl0aGVyICJmc2wsd3AtY29u
dHJvbGxlciIgbm9yICJ3cC1ncGlvcyIsIHdoaWNoIHdvdWxkIHJlc3VsdCBpbg0KPiB3cml0ZS1w
cm90ZWN0IG9mZiAobm90IHN1cHBvcnRlZCwgZS5nLiBtaWNyb3NkKS4NCj4gU28gbW9yZSBleHBs
YW5hdGlvbiBpcyBuZWVkZWQgZm9yIHdoeSByZW1vdmluZyAiZnNsLHdwLWNvbnRyb2xsZXIiDQo+
IHdpbGwgZ2l2ZSB0aGUgc2FtZSByZXN1bHQuDQoNCk9rYXksIHdpbGwgYWRkLiBUaGFua3MuDQoN
CkJlc3QgUmVnYXJkcw0KSGFpYm8gQ2hlbg0KPiANCj4gPiAtDQo+ID4gLQkvKg0KPiA+IC0JICog
SWYgd2UgaGF2ZSB0aGlzIHByb3BlcnR5LCB0aGVuIGFjdGl2YXRlIFdQIGNoZWNrLg0KPiA+IC0J
ICogUmV0cmlldmVpbmcgYW5kIHJlcXVlc3RpbmcgdGhlIGFjdHVhbCBXUCBHUElPIHdpbGwgaGFw
cGVuDQo+ID4gLQkgKiBpbiB0aGUgY2FsbCB0byBtbWNfb2ZfcGFyc2UoKS4NCj4gPiAtCSAqLw0K
PiA+IC0JaWYgKG9mX3Byb3BlcnR5X3JlYWRfYm9vbChucCwgIndwLWdwaW9zIikpDQo+ID4gLQkJ
Ym9hcmRkYXRhLT53cF90eXBlID0gRVNESENfV1BfR1BJTzsNCj4gPiAtDQo+ID4gIAlvZl9wcm9w
ZXJ0eV9yZWFkX3UzMihucCwgImZzbCx0dW5pbmctc3RlcCIsICZib2FyZGRhdGEtPnR1bmluZ19z
dGVwKTsNCj4gPiAgCW9mX3Byb3BlcnR5X3JlYWRfdTMyKG5wLCAiZnNsLHR1bmluZy1zdGFydC10
YXAiLA0KPiA+ICAJCQkgICAgICZib2FyZGRhdGEtPnR1bmluZ19zdGFydF90YXApOw0KDQo=
