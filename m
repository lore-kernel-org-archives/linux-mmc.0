Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5D1C433E0
	for <linux-mmc@archiver.kernel.org>; Fri,  8 Jan 2021 01:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08E0B23601
	for <linux-mmc@archiver.kernel.org>; Fri,  8 Jan 2021 01:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbhAHB2c (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Jan 2021 20:28:32 -0500
Received: from mail-vi1eur05on2041.outbound.protection.outlook.com ([40.107.21.41]:43361
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729738AbhAHB2c (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 7 Jan 2021 20:28:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUtQ+B0vPQTebcrbzqHY0/OPys6jKWaUWpKD+bnj85/uuvi9SgKSHIWy86he1lRAdrCbOGYDBOG7+IlouYF3Ld+68CDos1nTl/c0VfMFndHMUQUEHEfo9rREqpqxsPHV0lmUwOdxPvg0TKNwbI0i1Pdd7SbPguezLMyoX+p6+Eocov4A29qAxmbyqsvqJriL8kKQ9MDhTgWZmxL2J15wzPtUUNH0ZjQt04LtTXujGTno5xT3kfDSZ8/EQFOuL247/FrRGJbcMuYtj9VbPouFpw2CifilZ8yXXSrSu3Q5brZpRnDGAy2HrdeiUm9HEDb7FR5LhsaaCienBPMN4k7+ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0SaHkfp/Wi5hdK5id5ItPQpmLFKIRENMj79MoQqM9o=;
 b=ER+t6/CQIeol5yABaM+GqeWRfuLEeoABPPMkZuGJB5ustYavTa/xZN5bgmC9RWt06PjAfDiI+MWoZL67AyLwam78N96+MD2LlyjUzWxdxepMtr9+tQeSEYtfo2yE2IaVgftHf/lmox05tsiZxZ8vs18mECdkIjQtqh7b0aTrFGGfyUMJ/LngOcrgJyFbfU2EBtKr28K1jJbjv9wkFdUy9c/mIKkVDoALBm6ReI5UNkPiXA8wO/Hsj/QqwlkR58T7y6huGh/Vhb1VpgQab8aBV8Zhr/AFrcwLi2OXqLsAj6siVfQICgjYfaahsSR6S+wIQZZSJDh1EatxYH3UgcfnaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0SaHkfp/Wi5hdK5id5ItPQpmLFKIRENMj79MoQqM9o=;
 b=pl/gCTXu8V4rvKqDuPy0NN6jxdNedideCFK9RfQ2V4jwI1JlofMUiFcmm67i1Uh/uz1CoNU+wCZi4P+kfPWRnIwvnkZtzZrQxBbZGeQFJLvQMSOC6DeFNABQlaZXYVZOLVSb8hXUBOj/ZJ1VyQu4HGzFwOZ+j58Yn85RpPyUY1s=
Received: from DBBPR04MB7930.eurprd04.prod.outlook.com (2603:10a6:10:1ea::12)
 by DBBPR04MB7787.eurprd04.prod.outlook.com (2603:10a6:10:1e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Fri, 8 Jan
 2021 01:27:41 +0000
Received: from DBBPR04MB7930.eurprd04.prod.outlook.com
 ([fe80::b9a4:10d0:2535:d481]) by DBBPR04MB7930.eurprd04.prod.outlook.com
 ([fe80::b9a4:10d0:2535:d481%6]) with mapi id 15.20.3742.006; Fri, 8 Jan 2021
 01:27:41 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
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
Thread-Index: AQHV2sbvRYjZGJq5gUaf0U95GBt8kKgMVz+AgABAnwCAAmp/gIAJdBoAgACLvoCA2XSGAIAKjH+AgADWhoCBHVl6gIAB0pCAgABrtuCAAKjrAIAA5KAw
Date:   Fri, 8 Jan 2021 01:27:41 +0000
Message-ID: <DBBPR04MB79303EBE9EC378C3C74E16B387AE0@DBBPR04MB7930.eurprd04.prod.outlook.com>
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
         <DBBPR04MB79308EBA24C4FD6B1053C57E87AF0@DBBPR04MB7930.eurprd04.prod.outlook.com>
 <f7e3cdd37d425d2df96112258dcaf0bc6565f3cf.camel@pengutronix.de>
In-Reply-To: <f7e3cdd37d425d2df96112258dcaf0bc6565f3cf.camel@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d7ddf09-ebcb-4024-85c6-08d8b37497c8
x-ms-traffictypediagnostic: DBBPR04MB7787:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBBPR04MB77873E5C015A206FFE6B375287AE0@DBBPR04MB7787.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xHFy2BHI3MeoWlUprO109sJSwQj0M2A4lmCRuuveVpXROUuzZSHopf5eNHX5Vp5X08b8gh2FukCIFvEoelBmNw6RPhgfe6KtgtzNDngFMRy12WtHTARYyS330zjuzNC9aaLTTUlABXZnaGhlWTTJnj2EAbpRohp0IrmcC0vfQ3rH4RswByVKwM/YZX7ym5yPxHLi82KaJl1d6Nb5Z6cjjdxKEm1NmoSHYrlPor74npyvSakOTPBbo4fc7XsqGXknYSAQuAuBjzRG5Sr39Laislt5Y0cgPCahFwIKYPSovpojFbNGfZyH9u9xyxl1Nbuip6BmxxdQMwAkol4dtchxOSgkGTxHtuNVwl3YW+NAFIDsNqH12h/hxblKhUPQWghOH7OiFTwB9HX+CSh0anbUvCHmFwVGvUj9A4bYiszsruXzMb+ekKkcc8gIj7SUb0lBOfWHta7Us812Pe7D/eUt7mTl/jZJBMlT8AkKwdbnW35wGDhk+iG1jh09f9b+3mIBH+VGDxt1yGoqOdL37Hsgxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7930.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(39850400004)(376002)(346002)(110136005)(8936002)(54906003)(186003)(5660300002)(26005)(55016002)(86362001)(66476007)(66556008)(52536014)(64756008)(66446008)(33656002)(7416002)(966005)(71200400001)(4326008)(8676002)(316002)(7696005)(478600001)(2906002)(66946007)(76116006)(83380400001)(45080400002)(6506007)(53546011)(66574015)(9686003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QlFFZmVxR0FKRW1xS1pSUE5WVm1lRkw1N1hMa2pYdXpTcGFJdlh1czlKL3JL?=
 =?utf-8?B?ZHVTTkFkUVBFM0s4dDZ1YnJ4ZUQyTUJjbEJZZkpMOE5vWEdKbE16UDNITVEv?=
 =?utf-8?B?a0wvTjJBdGhEMHVaNmJMbGtRNGRFYkhRZTVqNDRGNTdkTHV1Nk1FRHk4UjI1?=
 =?utf-8?B?dDdkYmZqams4RHhhUDNXSkZmaS8wbGtmRzZQMDVlU1ROTWdwNkNwcXg4VjBQ?=
 =?utf-8?B?b1YzZUxpQmZvZGIrV3gyYlZYczVEa1ZxeW9ieVdFMUZWL3VtUTVtSnBnREhJ?=
 =?utf-8?B?b1hjd1NOdUFaYWlNQW5tQkFUUHBhY09kM29adjlFWVhGMzlmOHZveFdLZHcx?=
 =?utf-8?B?T2k4dFcwVUQvVGE0MlJqNW9BMDZjb1h0WnVCeVBFeVhaZnNSZTJVL1dQTkgx?=
 =?utf-8?B?NmxIVFVKVUQ1QWZqSE5telFvQyt0VmxIeUJtazdtc3U0cEZnZk5nVGJyeXFG?=
 =?utf-8?B?TUhRcFA0djcxUW1reW1aZTRsVjVpREZRbDFHWW9NdXYrMXpKKzJ2bFg1cDQ0?=
 =?utf-8?B?L3pQbWd6L2NPZzdiQnJENzd4d0IyZmhDR2xvZUw5bGhtcXBtOENkLzhkRVJC?=
 =?utf-8?B?ekd6bys1UENKNDZ1N3AwMHYvUTZ4UGRkQW1WcGw3Yk93aDMyQVBXckZQbUtL?=
 =?utf-8?B?SU5pMjQxSjRBL1JmWkExNm1IZFZhVzNoUTBTS3g1MDIrdWV0aWE5aWlSTHFt?=
 =?utf-8?B?eVJtZ3JBMWdoejJLSXhpcGFmcVY1UU5uR3JoQTEyMW10VzZLaFFmS1NhcnhE?=
 =?utf-8?B?ampPU3dvYWZIbkx5NmFGdlJKdWFuMlo1amRSSXpSWTFONmI2RUZCQjA3ekFU?=
 =?utf-8?B?SnZNOGwyWmFJU1FiSmRRbXBYSTVlYUllUEZYMm41Z0dXSys1WnFFL3NQakVX?=
 =?utf-8?B?aC9RN2NjdU80a3h4My9KMDBSZlBhSHZrcFdjU29wc2c0WXZIOFo1eWQ5QUZU?=
 =?utf-8?B?eTV5MjVFbDNudEdyOXpkR1J0RWYxYVQzR1MxMHQwKzFTNG51Y1JobXo5VDF4?=
 =?utf-8?B?Y1EvaENSS0lTR1lkK2ZOOXhSaHI1VXpvVWNnQkhpNXoxcC9Td25NL3ppS05l?=
 =?utf-8?B?MHF4LzhucWVBVDVoaHNBa2VTa0dUOUorUnhKZzA4RUVwcnA3dUJmRFl0TlUr?=
 =?utf-8?B?dHNDWDc2bGxiN0RObWFGMlNsUnJDSmVyNnp2amhyYzVFM1N0WDRqTDd6NXMv?=
 =?utf-8?B?WFovRjRVWWdkODFsUWh6bGRsbkZNaGNBcWRsbUxIY1NsRy9Ud0MyTC9YKy9l?=
 =?utf-8?B?Zm5obEV4N0lHQVBFU2doMlVyTDlRRmhrczJzMzV6U2ltTTZBUGhJWFY5Yk5o?=
 =?utf-8?Q?8RcGIwW3dQ6UE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7930.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7ddf09-ebcb-4024-85c6-08d8b37497c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 01:27:41.5212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ji0iyS/XJFyklf2Ph6Hvi9NRvP+Q9NLBSiGwzbnVyGncmXSADl4EwoOynFF6/UYA4ZlEHBVjphpeB+6WLxkz3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7787
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiBTdWJqZWN0OiBSZTogc2RoY2kgdGltZW91dCBvbiBpbXg4bXENCj4gDQo+IEhpIEphY2t5LA0K
PiANCj4gQW0gRG9ubmVyc3RhZywgZGVtIDA3LjAxLjIwMjEgdW0gMDE6MzAgKzAwMDAgc2Nocmll
YiBKYWNreSBCYWk6DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJv
bTogRmFiaW8gRXN0ZXZhbSBbbWFpbHRvOmZlc3RldmFtQGdtYWlsLmNvbV0NCj4gPiA+IFNlbnQ6
IFRodXJzZGF5LCBKYW51YXJ5IDcsIDIwMjEgMjo1NyBBTQ0KPiA+ID4gVG86IEx1Y2FzIFN0YWNo
IDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPg0KPiA+ID4gQ2M6IEJvdWdoIENoZW4gPGhhaWJvLmNo
ZW5AbnhwLmNvbT47IEFuZ3VzIEFpbnNsaWUNCj4gPGFuZ3VzQGFra2VhLmNhPjsNCj4gPiA+IExl
b25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+OyBQZW5nIEZhbg0KPiA+ID4g
PHBlbmcuZmFuQG54cC5jb20+OyBBYmVsIFZlc2EgPGFiZWwudmVzYUBueHAuY29tPjsgU3RlcGhl
biBCb3lkDQo+ID4gPiA8c2JveWRAa2VybmVsLm9yZz47IE1pY2hhZWwgVHVycXVldHRlIDxtdHVy
cXVldHRlQGJheWxpYnJlLmNvbT47IFVsZg0KPiA+ID4gSGFuc3NvbiA8dWxmLmhhbnNzb25AbGlu
YXJvLm9yZz47IEd1aWRvIEfDvG50aGVyIDxhZ3hAc2lneGNwdS5vcmc+Ow0KPiA+ID4gbGludXgt
bW1jIDxsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnPjsgQWRyaWFuIEh1bnRlcg0KPiA+ID4gPGFk
cmlhbi5odW50ZXJAaW50ZWwuY29tPjsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47
IFNhc2NoYQ0KPiA+ID4gSGF1ZXIgPGtlcm5lbEBwZW5ndXRyb25peC5kZT47IG1vZGVyYXRlZCBs
aXN0OkFSTS9GUkVFU0NBTEUgSU1YIC8NCj4gPiA+IE1YQyBBUk0gQVJDSElURUNUVVJFIDxsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+DQo+ID4gPiBTdWJqZWN0OiBSZTogc2Ro
Y2kgdGltZW91dCBvbiBpbXg4bXENCj4gPiA+DQo+ID4gPiBIaSBMdWNhcywNCj4gPiA+DQo+ID4g
PiBPbiBUdWUsIEphbiA1LCAyMDIxIGF0IDEyOjA2IFBNIEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBl
bmd1dHJvbml4LmRlPg0KPiA+ID4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gPiBUaGUgcmVmZXJlbmNl
IG1hbnVhbCBzdGF0ZXMgYWJvdXQgdGhpcyBzaXR1YXRpb246ICJGb3IgYW55IGNsb2NrLA0KPiA+
ID4gPiBpdHMgc291cmNlIG11c3QgYmUgbGVmdCBvbiB3aGVuIGl0IGlzIGtlcHQgb24uIEJlaGF2
aW9yIGlzDQo+ID4gPiA+IHVuZGVmaW5lZCBpZiB0aGlzIHJ1bGUgaXMgdmlvbGF0ZWQuIg0KPiA+
ID4gPiBBbmQgaXQgc2VlbXMgdGhpcyBpcyBleGFjdGx5IHdoYXQncyBoYXBwZW5pbmcgaGVyZTog
c29tZSBraW5kIG9mDQo+ID4gPiA+IGdsaXRjaCBpcyBpbnRyb2R1Y2VkIGluIHRoZSBuYW5kX3Vz
ZGhjX2J1cyBjbG9jaywgd2hpY2ggcHJldmVudHMNCj4gPiA+ID4gdGhlIFNESENJIGNvbnRyb2xs
ZXIgZnJvbSB3b3JraW5nLCBldmVuIHRob3VnaCB0aGUgY2xvY2sgYnJhbmNoIGlzDQo+ID4gPiA+
IHByb3Blcmx5IGVuYWJsZWQgbGF0ZXIgb24uIE9uIG15IHN5c3RlbSB0aGUgU0RIQ0kgdGltZW91
dCBhbmQNCj4gPiA+ID4gZm9sbG93aW5nIHJ1bnRpbWUgc3VzcGVuZC9yZXN1bWUgY3ljbGUgb24g
dGhlIG5hbmRfdXNkaGNfYnVzIGNsb2NrDQo+ID4gPiA+IHNlZW0gdG8gZ2V0IGl0IGJhY2sgaW50
byBhIHdvcmtpbmcgc3RhdGUuDQo+ID4gPg0KPiA+ID4gSSB0aGluayB5b3VyIGFuYWx5c2lzIGlz
IGNvcnJlY3QgYW5kIEkgcmVjYWxsIGhlbHBpbmcgYSBjdXN0b21lcg0KPiA+ID4gd2l0aCBhIHNp
bWlsYXINCj4gPiA+IGlzc3VlOg0KPiA+ID4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVj
dGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGY28NCj4gPiA+IG1tDQo+ID4gPiB1
bml0eS5ueHAuY29tJTJGdDUlMkZpLU1YLVByb2Nlc3NvcnMlMkZFeHRlcm5hbC1jbG9jay10aGF0
LXByb3ZpZGUtDQo+ID4gPiByb290DQo+ID4gPg0KPiAtY2xvY2stZm9yLVNBSTMtYW5kLVNQRElG
JTJGbS1wJTJGMTAxOTgzNCZhbXA7ZGF0YT0wNCU3QzAxJTdDcGluZw0KPiA+ID4gLmJhaSU0MG54
cC5jb20lN0M4ZDI1MGExNThjY2U0NjljMzc4MzA4ZDhiMjc0ZDZkMSU3QzY4NmVhMWQNCj4gM2Jj
DQo+ID4gPg0KPiAyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2Mzc0NTU1NjIxODM0
OTcwNDklN0NVbmtub3cNCj4gPiA+DQo+IG4lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3
TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhDQo+ID4gPg0KPiBXd2lMQ0pYVkNJNk1u
MCUzRCU3QzEwMDAmYW1wO3NkYXRhPVZreHVobWhEaWZ6T3h4ZklnRno5UFI1Z0tDMQ0KPiA+ID4g
U3lRaEdlU0hZeXNYMUNvNCUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiA+ID4NCj4gPg0KPiA+IEZvciB0
aGUgY3VzdG9tZXIgY2FzZSwgaXQgc2VlbSBub3QgdGhlIHNhbWUgaXNzdWUuIHRoZSBjdXN0b21l
ciBpc3N1ZQ0KPiA+IGlzIGNhdXNlZCBieSBjbG9jayBzb3VyY2UgY2hhbmdlIHdoaWxlIHBhcmVu
dCBoYXMgbm8gY2xvY2sgb3V0cHV0Lg0KPiA+IFRoaXMgaXMgaW5oZXJpdCBsaW1pdGF0aW9uIGZv
ciB0aGUgQ0NNIGNsb2NrIHNsaWNlIHdoZW4gdXNpbmcgdGhlDQo+ID4gc21hcnQgaW50ZXJmYWNl
IHRvIGNoYW5nZSB0aGUgY2xvY2sgcGFyZW50Lg0KPiA+DQo+ID4gRm9yIGN1cnJlbnQgbW1jIHRp
bWVvdXQgaXNzdWUsIEkgdGhpbmsgd2UgY2FuIGhhdmUgYSB0cnkgd2l0aA0KPiA+IG5hbmRfdXNk
aGNfYnVzIGNsb2NrIGdhdGVkIGF0IHRoZSBiZWdpbm5pbmcgb2Yga2VybmVsIGJvb3QsIGRpcmVj
dGx5DQo+ID4gbW9kaWZ5IHRoZSBuYW5kX3VzZGhjX2J1cyBDbG9jaydzIEhXIHJlZ2lzdGVyIGdh
dGUgYml0IGluDQo+ID4gY2xvY2staW14OG1xLmMuDQo+IA0KPiBXaGlsZSB0aGlzIG1pZ2h0IGJl
IGFuIG9wdGlvbiB0byBmaXggdGhpcyBzcGVjaWZpYyBpc3N1ZSwgSSB3b3VsZCBob3BlIHdlIGNh
bg0KPiBjb21lIHVwIHdpdGggc29tZXRoaW5nIG1vcmUgZ2VuZXJpYywgYXMgdGhlIGN1cnJlbnQg
Y2xvY2sgZnJhbWV3b3JrDQo+IGJlaGF2aW9yIGFsbG93cyB0byB2aW9sYXRlIHRoZSBzeXN0ZW0g
c3BlY2lmaWNhdGlvbiBjb25zdHJhaW50IHRoYXQgcGFyZW50DQo+IGNsb2NrcyBtdXN0IG5vdCBi
ZSBkaXNhYmxlZCB3aGVuIGFueSBvZiB0aGUgY2hpbGRyZW4gYXJlIGFjdGl2ZS4gVGhpcyBzZWVt
cw0KPiBsaWtlIGEgZnVuZGFtZW50YWwgaXNzdWUgYW5kIG1pZ2h0IGh1cnQgdXMgYWxzbyB3aXRo
IG90aGVyIGNsb2NrcyB0aGFuIHRoaXMNCj4gc3BlY2lmaWMgbmFuZF91c2RoY19idXMgY2xvY2su
DQoNClllcywgbXkgcHJvcG9zYWwgaXMgZm9yIGRlYnVnIHB1cnBvc2UuIFdlIHdpbGwgZG8gZnVy
dGhlciBkZWJ1ZyBvbiBvdXIgRVZLIGJvYXJkIHRvby4NCg0KPiANCj4gQ2FuIHlvdSB0ZWxsIHVz
IGlmIHRoZXJlIHdlcmUgb3RoZXIgaXNzdWVzIGZvdW5kIHdpdGggdGhlIFBMTDEvMiBnYXRpbmcg
cGF0Y2g/DQo+IFRoZSBmYWN0IHRoYXQsIGFjY29yZGluZyB0byBCb3VnaCwgaXQncyByZXZlcnRl
ZCBpbiB5b3VyIHRyZWUgc2VlbXMgdG8gc3VnZ2VzdA0KPiB0aGlzLg0KDQpJdCBpcyBtYWlubHkg
YmVjYXVzZSB0aGF0IHRoZSBQTEwxLzIgZGVyaXZlZCBjbG9ja3MgYXJlIHNoYXJlZCBiZXR3ZWVu
IENvcnRleC1BIGRvbWFpbiAmIENvcnRleC1NIGRvbWFpbi4NCk00IGRvbWFpbiBtYXkgYWxzbyBu
ZWVkIHNvbWUgb2YgdGhlc2UgY2xvY2tzIGVuYWJsZWQgZXZlbiBBIGNvcmUgZG9tYWluIGRvZXMg
bm90IHVzZSBpdC4gVGhlcmUgaXMgbm8NCndlbGwtZGVmaW5lZCBIVyBtZWNoYW5pc20gbGlrZSBD
Q00gQ0NHUiBkb21haW4gY29udHJvbCB0byBtYW5hZ2UgdGhlIFBMTCBkaXZpZGVyJ3MgZ2F0ZSBi
YXNlZCBvbiBlYWNoIGRvbWFpbidzIHJlcXVlc3QuDQpTbyBJIHJldmVydGVkIHRoYXQgcGF0Y2gg
aW4gb3VyIGludGVybmFsIHRyZWUgYmVmb3JlIHdlIGZpbmQgb3RoZXIgbW9yZSBzb2xpZCBzb2x1
dGlvbiBmb3Igc2hhcmVkIGNsb2NrIG1hbmFnZW1lbnQuDQoNCg0KQlINCkphY2t5IEJhaQ0KPiAN
Cj4gUmVnYXJkcywNCj4gTHVjYXMNCg0K
