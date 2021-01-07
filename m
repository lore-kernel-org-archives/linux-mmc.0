Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF88C433DB
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Jan 2021 01:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1197620702
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Jan 2021 01:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbhAGBb1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 6 Jan 2021 20:31:27 -0500
Received: from mail-eopbgr150041.outbound.protection.outlook.com ([40.107.15.41]:13675
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbhAGBb1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 6 Jan 2021 20:31:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kA08j6F3p5bkROsI9p+WMgUA0vte08dcKo67JjE6k8TgxtsR5944Nb3+utsNo0EOzZmYq35tiHukol1TSqmyAL4p1Hc5QKnuZ6Uf1kZtthw8fxwhD0q9CiRz79f3Hg8yCKZR6wPSyifJh2/qlz/RdRIw7x7+sKVo5WtifTgfTmonEJeMhtWuvvHjrbYneQU3aPXTGOsqx3gZFG61wJkO0n31bgIqeTyioBBs0KTo50VfC8rF1jujQjbx7CRKnYN0Rj7TNNdRRTJgVvwp/qduK3ObvqUf4r9vOsdP8kYBPm6QComZIDRbwoWxoDvtPuQraVg8g9ebZo+G3fxkGR+52A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7C0SW7zRRfQKN6z5jRE2otf+jwjUhpBy+oy5bO/zEtQ=;
 b=WUj21FdvqiZ2HaTGkh8rswREKd0FdV2J/hdLJmw/W6dYUFSU+1/eUEN2lz05WK4VkFfyTYVue163SdYYhSB99IPxLPFOW1N/PChnDIvqs62HoY93J12c4bzqcOaX1J9HqGChc6/WbYQP4tK+ONhKR/6iLdfdiKU0QwndCKrXgM02sKdHM7tNkSX7gMjvJbpcqSrD1YJaDOgxXeLnnbuG57ERdIRV3dbwUf6KSp2dcIhvedy1dqg6KQ6ALrkwYXLY3JP9sEy+wlUhyblh6gFNeOlhPkaRqAwWweVl8LkWSC0SW3hKIkwoHxrU8SbEES6Ajm4s2x8Y4LY7cImPt4unLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7C0SW7zRRfQKN6z5jRE2otf+jwjUhpBy+oy5bO/zEtQ=;
 b=ehsDgP4fsYjy6YGTe7riMmL9Tu6Wdw4crujD3TnWwePTR5Mn0rHdejkjC8wAW7oNOIylSCcDMqxPQ6JxbR/AEC+mEWjpBub+xB0lTDlvA5rT4PxY5Rz0aciw6UIor1ITgXpxZPXgNs8OY5fB+kMhCmJuOPeqUehaMIU+M36206Y=
Received: from DBBPR04MB7930.eurprd04.prod.outlook.com (2603:10a6:10:1ea::12)
 by DB6PR04MB3127.eurprd04.prod.outlook.com (2603:10a6:6:c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.21; Thu, 7 Jan 2021 01:30:36 +0000
Received: from DBBPR04MB7930.eurprd04.prod.outlook.com
 ([fe80::b9a4:10d0:2535:d481]) by DBBPR04MB7930.eurprd04.prod.outlook.com
 ([fe80::b9a4:10d0:2535:d481%6]) with mapi id 15.20.3742.006; Thu, 7 Jan 2021
 01:30:36 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
CC:     Bough Chen <haibo.chen@nxp.com>, Angus Ainslie <angus@akkea.ca>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?utf-8?B?R3VpZG8gR8O8bnRoZXI=?= <agx@sigxcpu.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: sdhci timeout on imx8mq
Thread-Topic: sdhci timeout on imx8mq
Thread-Index: AQHV2sbvRYjZGJq5gUaf0U95GBt8kKgMVz+AgABAnwCAAmp/gIAJdBoAgACLvoCA2XSGAIAKjH+AgADWhoCBHVl6gIAB0pCAgABrtuA=
Date:   Thu, 7 Jan 2021 01:30:36 +0000
Message-ID: <DBBPR04MB79308EBA24C4FD6B1053C57E87AF0@DBBPR04MB7930.eurprd04.prod.outlook.com>
References: <CAOMZO5DMMCZPfwNbTaG8_iQhWg2K1XeO719nSA0Gsf2ywHy4jQ@mail.gmail.com>
 <20200205092653.GB2737@bogon.m.sigxcpu.org>
 <CAOMZO5AAzK0QprHpKHaFOANjspJKd_4YaoMqAoGYG4KftcyiYw@mail.gmail.com>
 <VI1PR04MB5040A046E5D93265AE636B29901C0@VI1PR04MB5040.eurprd04.prod.outlook.com>
 <VI1PR04MB504091C7991353F6092A8D91901A0@VI1PR04MB5040.eurprd04.prod.outlook.com>
 <CAOMZO5CkSSidzLUSBUvJNAio3SnmU-fisTbDCiLN9v1EjS+HHQ@mail.gmail.com>
 <5ad361195f2e191484c8a231be0f5a07@akkea.ca>
 <CAOMZO5BarV1=6rx9L_hkJJLUQSicwPNUO4HFKWAXSQ6n0N+Kzg@mail.gmail.com>
 <VI1PR04MB52942233A0BA6BCB692F281E90670@VI1PR04MB5294.eurprd04.prod.outlook.com>
 <cd99776c0107833d69c9c7fc4c8d6ba1a41ea3d7.camel@pengutronix.de>
 <CAOMZO5BzAw8CjvaOzH_Ynr2eapO1MViTOWN5yZ5i_BcAhv3tWA@mail.gmail.com>
In-Reply-To: <CAOMZO5BzAw8CjvaOzH_Ynr2eapO1MViTOWN5yZ5i_BcAhv3tWA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 917f81a8-194a-4439-d7ee-08d8b2abd5bc
x-ms-traffictypediagnostic: DB6PR04MB3127:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR04MB3127C268F81C455BDBF45D3487AF0@DB6PR04MB3127.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N4VDB2rYs1/G0uSTsYXKmTGqf0Cz2di50U4HGnPm7joumk3duXQXb1OPUo10lhMv8MsmvZfXPViZo1W0ZvNzccLrq/l/J1i5gsn5ZhaEeVBBlZ9e700TT3xtmDcXNr0/SGRJMcHtaVEa15Nzi1+K3hOHSRS1tb+x5EZC80kpn8L5JnRSdOY77Wqk4sKbcdhkN5GvVyr4xjKm9aHwYRU9ZDQ60AhRwx4imAPVByLGHjqVYM71e0T3dV+EZOABz8HaapnS8xdcf4O3Ry2xFSLVN30ji/AjbqL+x2TtDMfWpJcvkHZZ2d35cBIskduux/3Ts2CQV5NVQ+H0lHVn2TYpFAMwpR9knnjj6zwTAqHjl6QudfWidxvXzsykgdgKU+32D4bbf0ikY9Z5EOOhE/J23GE7YtDMv5fbDN3ulA5yrxjNS2lX2JahI3n5Rx/ZKdJoH9tBTb+dAXiEzVNhT8duHv42PtFS8MS8H90q0hmLp4GHFw9jodpIq3iaZnpmTmK9YFIuc/kU2619GvZUkev8Bw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7930.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(110136005)(83380400001)(8936002)(86362001)(7416002)(5660300002)(316002)(26005)(53546011)(9686003)(71200400001)(6506007)(54906003)(478600001)(66946007)(66476007)(45080400002)(76116006)(64756008)(66446008)(52536014)(4326008)(66556008)(966005)(7696005)(2906002)(33656002)(8676002)(66574015)(55016002)(186003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?S0JJV0ttbGUyMVVDYnpveTV6WHhLNkxwRXluTjdnRFc2VFl6ak84Z3gxcmlQ?=
 =?utf-8?B?TmhKZkFIQnI4bVJrdGFITnRXMVhPK3NtL24zSDlkb240bkpZdUVDUWN4YjZ2?=
 =?utf-8?B?SlpmNFVpWkxpWjdVYWFWN3JnaUN6TEZmc0lLdnBTVklublZWQWt6RzNMWWlF?=
 =?utf-8?B?MHo1cXdKVFFyQ1QxUEVBZWNrUEQ4bjljbjd2RXZtRW1JMndsNkRBeTZyZC82?=
 =?utf-8?B?RVlmQTQyZTR6cTFMdDV5ZmJ6UThjUXUrQ1pmUGVCRjh4cXg3NjcrWWRPb2c0?=
 =?utf-8?B?QnN1SlpWM1dWM3prdUp3S1pJeGhFVDlhOStFenpHdi9NMzZ3bGc1QVZyQytD?=
 =?utf-8?B?dWxqbVZRbExKQkUwWDlpQ0ZFSm1IdGE5dFNCTHY0S2xGWmFWbVk4VFdzNlNR?=
 =?utf-8?B?eGtFUW9LYzRQbnJKVnl4Ty80NWpiOVlaNWpiVHZvUWZGbU9Db1F3TnlsMnV1?=
 =?utf-8?B?aU9ZanVsOUxaNExVTmY1Q1ZGanJnTUo5UGxvZjN6NWF5VGwyOUk2NS81MldX?=
 =?utf-8?B?eXBZYzlnd0pBaEpUN004TytLUVdrTFkwZUxoUk5YTE1URVhwNUM0SkNaN1BM?=
 =?utf-8?B?dUxXa251eGwyZkZSYjQrcmttZ2J5dDNCRWVDLytReEpzVGtiQ3oyQzduclky?=
 =?utf-8?B?L3Vid0RiQy9SWlJ3Qk91OUN6WHA2bzNPZXRXUEVnc3J5SGN6VmZYYVVyeUJ4?=
 =?utf-8?B?ZDhySFJRdCtWYXlQdUl5SzZYdEdJVExKYzRXcGROL0N1cTdQODVIaU90Q2tZ?=
 =?utf-8?B?VFp2dVpiVlFLMis0RmhBTEZ4NHM5WHovTTFDVEExYW4reFQ4YnRsV21Dak9I?=
 =?utf-8?B?OU04YkxiazZUMWpMdFQ1Qnh4Tzh4TEVSdVU4SzlaRW12RmRTR284eUJobGF6?=
 =?utf-8?B?dGwrMVdhb01vZFJnblc2SlBVSjB4WTI5MzAvVStISDREUzdGdWM5Y1Z6bXVr?=
 =?utf-8?B?OXdOb2pLK0U2NU9lMzNmaThrT2p5UXRKazV4NkUrdUo0NnJGUWprbGhWTDFY?=
 =?utf-8?B?SUNpanF6Q2lOS25vN3ZQUWZzUVRCZXV4UytIVlpEMFZvQnltMzllU0dsYTBR?=
 =?utf-8?B?ZVhZOTc3WXFoank0Vnl2RGZydTdiRTlRUUQ1STBCQzUzaGlIa3dJQ0IrSm5q?=
 =?utf-8?B?Y1VrT1U0cXQ0Y25JN1dFRXROVzhXVGQwOVdzQXYwcmpWSmY3ZG9CellVaUVv?=
 =?utf-8?B?TGRhWWJCcklmbUREcjhtbXpaSTlFdWFEaUNQbGM0dzlYREdmOGRuUG9sY0Qz?=
 =?utf-8?B?WVI4bktrQU9HS1orZVM5aENHTUV2dXlwNmJUKzltblhPYytRaTBvZnBTUzlF?=
 =?utf-8?Q?39T2UKcRl+HR0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7930.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 917f81a8-194a-4439-d7ee-08d8b2abd5bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2021 01:30:36.6795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4g0fG1nt/DWrR0qPCSIeY6OJjPC97RplomR6uWPX2OVuzXoDcWxLXTWKFq2OxOU7ru+5DSthfHpSe9K2ri6Fdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3127
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGYWJpbyBFc3RldmFtIFttYWls
dG86ZmVzdGV2YW1AZ21haWwuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgSmFudWFyeSA3LCAyMDIx
IDI6NTcgQU0NCj4gVG86IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPg0KPiBD
YzogQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPjsgQW5ndXMgQWluc2xpZSA8YW5ndXNA
YWtrZWEuY2E+Ow0KPiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPjsg
UGVuZyBGYW4NCj4gPHBlbmcuZmFuQG54cC5jb20+OyBBYmVsIFZlc2EgPGFiZWwudmVzYUBueHAu
Y29tPjsgU3RlcGhlbiBCb3lkDQo+IDxzYm95ZEBrZXJuZWwub3JnPjsgTWljaGFlbCBUdXJxdWV0
dGUgPG10dXJxdWV0dGVAYmF5bGlicmUuY29tPjsgVWxmDQo+IEhhbnNzb24gPHVsZi5oYW5zc29u
QGxpbmFyby5vcmc+OyBHdWlkbyBHw7xudGhlciA8YWd4QHNpZ3hjcHUub3JnPjsNCj4gbGludXgt
bW1jIDxsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnPjsgQWRyaWFuIEh1bnRlcg0KPiA8YWRyaWFu
Lmh1bnRlckBpbnRlbC5jb20+OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgU2Fz
Y2hhDQo+IEhhdWVyIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBtb2RlcmF0ZWQgbGlzdDpBUk0v
RlJFRVNDQUxFIElNWCAvIE1YQw0KPiBBUk0gQVJDSElURUNUVVJFIDxsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBzZGhjaSB0aW1lb3V0IG9uIGlt
eDhtcQ0KPiANCj4gSGkgTHVjYXMsDQo+IA0KPiBPbiBUdWUsIEphbiA1LCAyMDIxIGF0IDEyOjA2
IFBNIEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPg0KPiB3cm90ZToNCj4gDQo+
ID4gVGhlIHJlZmVyZW5jZSBtYW51YWwgc3RhdGVzIGFib3V0IHRoaXMgc2l0dWF0aW9uOiAiRm9y
IGFueSBjbG9jaywgaXRzDQo+ID4gc291cmNlIG11c3QgYmUgbGVmdCBvbiB3aGVuIGl0IGlzIGtl
cHQgb24uIEJlaGF2aW9yIGlzIHVuZGVmaW5lZCBpZg0KPiA+IHRoaXMgcnVsZSBpcyB2aW9sYXRl
ZC4iDQo+ID4gQW5kIGl0IHNlZW1zIHRoaXMgaXMgZXhhY3RseSB3aGF0J3MgaGFwcGVuaW5nIGhl
cmU6IHNvbWUga2luZCBvZg0KPiA+IGdsaXRjaCBpcyBpbnRyb2R1Y2VkIGluIHRoZSBuYW5kX3Vz
ZGhjX2J1cyBjbG9jaywgd2hpY2ggcHJldmVudHMgdGhlDQo+ID4gU0RIQ0kgY29udHJvbGxlciBm
cm9tIHdvcmtpbmcsIGV2ZW4gdGhvdWdoIHRoZSBjbG9jayBicmFuY2ggaXMNCj4gPiBwcm9wZXJs
eSBlbmFibGVkIGxhdGVyIG9uLiBPbiBteSBzeXN0ZW0gdGhlIFNESENJIHRpbWVvdXQgYW5kDQo+
ID4gZm9sbG93aW5nIHJ1bnRpbWUgc3VzcGVuZC9yZXN1bWUgY3ljbGUgb24gdGhlIG5hbmRfdXNk
aGNfYnVzIGNsb2NrDQo+ID4gc2VlbSB0byBnZXQgaXQgYmFjayBpbnRvIGEgd29ya2luZyBzdGF0
ZS4NCj4gDQo+IEkgdGhpbmsgeW91ciBhbmFseXNpcyBpcyBjb3JyZWN0IGFuZCBJIHJlY2FsbCBo
ZWxwaW5nIGEgY3VzdG9tZXIgd2l0aCBhIHNpbWlsYXINCj4gaXNzdWU6DQo+IGh0dHBzOi8vZXVy
MDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmNv
bW0NCj4gdW5pdHkubnhwLmNvbSUyRnQ1JTJGaS1NWC1Qcm9jZXNzb3JzJTJGRXh0ZXJuYWwtY2xv
Y2stdGhhdC1wcm92aWRlLXJvb3QNCj4gLWNsb2NrLWZvci1TQUkzLWFuZC1TUERJRiUyRm0tcCUy
RjEwMTk4MzQmYW1wO2RhdGE9MDQlN0MwMSU3Q3BpbmcNCj4gLmJhaSU0MG54cC5jb20lN0M4ZDI1
MGExNThjY2U0NjljMzc4MzA4ZDhiMjc0ZDZkMSU3QzY4NmVhMWQzYmMNCj4gMmI0YzZmYTkyY2Q5
OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM3NDU1NTYyMTgzNDk3MDQ5JTdDVW5rbm93DQo+IG4lN0NU
V0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklr
MWhhDQo+IFd3aUxDSlhWQ0k2TW4wJTNEJTdDMTAwMCZhbXA7c2RhdGE9Vmt4dWhtaERpZnpPeHhm
SWdGejlQUjVnS0MxDQo+IFN5UWhHZVNIWXlzWDFDbzQlM0QmYW1wO3Jlc2VydmVkPTANCj4gDQoN
CkZvciB0aGUgY3VzdG9tZXIgY2FzZSwgaXQgc2VlbSBub3QgdGhlIHNhbWUgaXNzdWUuIHRoZSBj
dXN0b21lciBpc3N1ZSBpcyBjYXVzZWQgYnkgY2xvY2sgc291cmNlIGNoYW5nZSB3aGlsZSBwYXJl
bnQgaGFzIG5vIGNsb2NrIG91dHB1dC4NClRoaXMgaXMgaW5oZXJpdCBsaW1pdGF0aW9uIGZvciB0
aGUgQ0NNIGNsb2NrIHNsaWNlIHdoZW4gdXNpbmcgdGhlIHNtYXJ0IGludGVyZmFjZSB0byBjaGFu
Z2UgdGhlIGNsb2NrIHBhcmVudC4NCg0KRm9yIGN1cnJlbnQgbW1jIHRpbWVvdXQgaXNzdWUsIEkg
dGhpbmsgd2UgY2FuIGhhdmUgYSB0cnkgd2l0aCBuYW5kX3VzZGhjX2J1cyBjbG9jayBnYXRlZCBh
dCB0aGUgYmVnaW5uaW5nIG9mIGtlcm5lbCBib290LCBkaXJlY3RseSBtb2RpZnkgdGhlIG5hbmRf
dXNkaGNfYnVzDQpDbG9jaydzIEhXIHJlZ2lzdGVyIGdhdGUgYml0IGluIGNsb2NrLWlteDhtcS5j
Lg0KDQpCUg0KSmFja3kgQmFpDQo+IFJlZ2FyZHMsDQo+IA0KPiBGYWJpbyBFc3RldmFtDQo=
