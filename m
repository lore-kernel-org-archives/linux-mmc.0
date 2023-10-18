Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4745ACDB474
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Oct 2023 02:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjJRCHU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Oct 2023 22:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJRCHT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Oct 2023 22:07:19 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D17CC6
        for <linux-mmc@vger.kernel.org>; Tue, 17 Oct 2023 19:07:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsTX6qNSSZhOLhVvfMTizX7EHdnleVrFp0/0SCqY0oPaz/IeYB9ZXAhdUEJw0b8h8SSogxff1x0pj77d0WJhVNyTmE+nc7jAS4lfAoJ+T1gwZuyjenQo+M/21ryPqMJHrgKYcbt++d79ZKoedyFVS1qB4ofp8Rf3ScsARPCumjifdI63v0xkgeb/ziy4lTo5FshZ+Rix7RF/qCBfAtLyJJHLZ7hf85c+M/FghXBih0aEScLKe6JA2e/f89XvzHRHEf6xsbm3kEWpSiOotzi5ohbGbTqr+R0NuvF+pj8FamUTzXBtiJ3Z4DOm2i6rBYgOw7/WMSTx0fsM1/NmI5XzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbVW/O+01a/XEnuWVtvT0aWbSwWF1erZ7obfuHMZWRI=;
 b=WqlCqi0SUXYWsnESu3e4YYbxkQpOtfpHZztXTEKURkbxNNgkmUw6FgD5QjZuxghqA6LvzpmwgNbu/YW2pcceH0UJ+hCkMp1sxXhzl9YndDaoWC/osl8HX9HFdWVxpRgs5jT2KbjpZduMDBqcYEexyrcQhzfOrGeZXjNZu6YvFxlaXq0vfso00qGQvpjh1R2Xs5EgsBmoW+ywsm/suiZx1iJdSQmw/5FrPZXOAdpcYfsruDwTAgC0sr9IvFRVuTskk2g3zMNS0Sp+k7qsqVChkcBg0A/kM9/ANlNxBcXm842zPwpGyAfCk7GYZIEmJpIRNExyeh7rK7zIrMznJW/Eew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbVW/O+01a/XEnuWVtvT0aWbSwWF1erZ7obfuHMZWRI=;
 b=kYEUbzXA6HOz2P3JZvDoUTSNuizTMdc5iZfWqNY1B42QsMlCunoH06BP66z2ngyWxHxOqx78NZjisbvEcIZ1HjN09tUnTSG+3ho5ZUZFkEpjHT7SG7bDUM9Shl2LTGgReE2OsG2jZGuAlrPo/CCSbaa9AsQuCYd+YGb+sAYbWqg=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 VI1PR04MB9785.eurprd04.prod.outlook.com (2603:10a6:800:1dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 02:07:14 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::e796:8366:5d4:4188]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::e796:8366:5d4:4188%4]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 02:07:13 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
Subject: RE: [PATCH] mmc: host: sdhci-esdhc-imx: let usr to config the wakeup
 for gpio cd pin through sysfs
Thread-Topic: [PATCH] mmc: host: sdhci-esdhc-imx: let usr to config the wakeup
 for gpio cd pin through sysfs
Thread-Index: AQHaAMtAiM/X4Tj1c0GMhh2PUfIhYLBN2jIAgADxjMA=
Date:   Wed, 18 Oct 2023 02:07:13 +0000
Message-ID: <DB7PR04MB40100BAA35662C888819E05590D5A@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20231017073129.1406748-1-haibo.chen@nxp.com>
 <CAPDyKFrffRvM51ZSzEffH9iHOWr7A0tu_e7aub7GiXdG49-iNA@mail.gmail.com>
In-Reply-To: <CAPDyKFrffRvM51ZSzEffH9iHOWr7A0tu_e7aub7GiXdG49-iNA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|VI1PR04MB9785:EE_
x-ms-office365-filtering-correlation-id: cda73db0-8abb-4073-612e-08dbcf7ef20d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0i5kQYvlpWsRkwddTUDBvUc8iyk8LrffZNHrlM+2Nub5p1Jt4Viu37w/iSjHGuGDISZxAM4T9QK6h62cMCJ6Tf57ztmKI9sMK4jFZuOT5jENbVnf5XJjP96y89pdReZRfWX/6N/IgPNJI3pNxgtnlWtckxWKiytd1SGLF479Cdxmwswz3JJv0TQhVY9/DimXBFqJGNXNdDDl2rofR5qCS+s2E/wr8rRXfoUQqcSY2rmtzuAzst1yQHAjspEhjkUA84S6+s36UDI61sfZLLAYGORKyIFwXAzu0abllqwQkv6xGHKCJlnJ4N0FZ27NVFustb6zvnFQNCwGL/m0JHBBm+gwZEkJw5TNORbppUDQ/N++ySCCqs41G/6WN0bwQG4G37WdbYxFn+7brQ+HxA/QN62Z6iPikzMoaGo+1TgJonfYaAxzK6UdMpxwmrvbduct5iIXBh2i96mz8kunEJRxYfZf8hSQ0jjPmV+kCU55T3euDqN0gDUYCM2pJYOMpFYISZ9NUzeeCIcewCPcTaavQnvgmNhkXlTzJ1ejXNCJhQjcdkf+ZEfv2d+kzJaBBn2eKMBk9gADZIuRLkjxosMvgIsHG0wpXNjj8UURt8mYHNc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(136003)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2906002)(41300700001)(5660300002)(8676002)(8936002)(4326008)(52536014)(55016003)(316002)(76116006)(66946007)(6916009)(66476007)(66446008)(66556008)(86362001)(64756008)(54906003)(33656002)(478600001)(71200400001)(6506007)(7696005)(53546011)(9686003)(38100700002)(38070700005)(122000001)(83380400001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjhWamRhNHluZmdMUkhDN3dYOG1YRnVZQlNSdStTRW5TbTFBYkEvYVFUempK?=
 =?utf-8?B?M3VtL2ZtRmtUWlcyT2c0d3QxaDVGSThaUHBrQ09FY1QzSTJTZHdDRTkrZkNS?=
 =?utf-8?B?TEplL0U4azYzSFovSjV4b1Z4M2hGUjRTNExHOEc0QVBpSnF3eWZ5MXFPcG9D?=
 =?utf-8?B?Tkd4WEdRNmtXMXUyUUJjS3hqTmxscnJ0T245SXVtVzlPU2QxRnE2b21JcFBh?=
 =?utf-8?B?V3VmZkVydDJTTDFMdmJ2QTk3bkF0WWUwdXdQVjh5d0dhK1ZmRWhqMzBJTmN1?=
 =?utf-8?B?UnlMNGplejUvaUhoNUdPTlN2RFlKVXNyazJIRkg1NUtzNUl4SlVBR0xBMWJ6?=
 =?utf-8?B?eW1YaXVsRUhrSUhMYXk2YjdpSHZNWjQ1RU5NNThZVjJWYXdwc1ZoTXFzcFVt?=
 =?utf-8?B?M3Q5S01NRzNlVWt1TVRqMTZRdWlmV3RYdkNFOGhmVHRVbHlJMGx5QUw3cmtF?=
 =?utf-8?B?b2FrZ3VyZmlycXUxL0RRMFFFOHNDNWxTd0srdjk1eGxkWFRoV25RQzZ3bDIv?=
 =?utf-8?B?Ullmc1dSb2RuZlhLRXNaUXg0azU5YUcxQXJrZ2QrQk5LdngrZUN2STVZZFAz?=
 =?utf-8?B?RU80c3JZUjJTK20zcmQ5NkhVMWlwQnV5elg3SGxJMUpMaUN2aG9JeXdqNkNG?=
 =?utf-8?B?K0RzalNleTVtTUVrUlVXakE1WDcyUDB2ZFhpbk5vN2cycDRjS3gyOEVlMm9R?=
 =?utf-8?B?ZTJSMXFFMFNvRzR0WTc2aldUOWNXZ0pwRDFycHE4YlM5UTlNcW84T2hOMTRL?=
 =?utf-8?B?L2VqSlU4OHoxbEhQK2pUVkI4QlVlT1V6STNKaGNMNURBdDcvUXEvUnlhUmdY?=
 =?utf-8?B?Vy94TllBaElQYm1DNWtGWUkvbU90YVpSdzc2aVVyNDMydmtwdHJsZHpWeXhS?=
 =?utf-8?B?SjgyZGVrQXVmVWN0M1ZzVlh1cmM3RHQ2Sy9zS2t3eFZ3QlhDdjB2NmxiR3R6?=
 =?utf-8?B?V1hZT0N0S0xSOW5Ua1JvRWZCY0h2TDdDbjJoTlJBK2QzVTZOVW5hemM2Zk5G?=
 =?utf-8?B?blMxYUpKOEg4MEJZOStUNHQyeEZDZnBnZlhiTzFLcXlzdzk2OFhpTDc5NkhL?=
 =?utf-8?B?amx3V1hCcGkxMjQ0dE4xZkx0aFdyUHJvaXZlMHdqWm9mYVNYWWxXY1JHU0VU?=
 =?utf-8?B?cXErWng5NStNMmFJaWVUTHQyaTdLYW5HTEdVTnlHSnRGbjhERGY2dCtCUzd5?=
 =?utf-8?B?L1htSmJmN1I5ajlJN2lLMEpkMVhqVEFsY0h2Z0Q0Z0I5OU1lRVE2TjR0OEJR?=
 =?utf-8?B?ZVZjNTVLNFJVMWo3TmVhbmRDZGU2OFVoeDZNdzJ0dVlGWEVCK1hRRFNYM1g3?=
 =?utf-8?B?bnFPdmpPcTNybmF0cmNUTnRDQkErSmlHekxlWjhvbmNOSTZsQ2tKMGRaVEp4?=
 =?utf-8?B?NHgrc1VCZXpMVXFMaERCVlVVR0xRRnhUVDRYY3NHZG1zYnNqMFhUYVE2SVlq?=
 =?utf-8?B?NUFYdU5Lckk5NXNXMk1MdGRGYWo0ZUtvWTJFbUVVMVZCUkNqdGxSUXh1OThQ?=
 =?utf-8?B?VHFDVGlIQ1A4T1dxNnI5emxMUUJxVGxzWkFGRzZSN1o5M2RSc1ZNL3FUUGpR?=
 =?utf-8?B?dnNGaVBaandlQnVXVzZwbkZMT29ab0pOYU0wOWltRUM5MGpoaXYxclZDQ2Ru?=
 =?utf-8?B?UjhqTUk1bGd6NnVLMTZmYTBPMm1NUkFPdlFMTk5EazNxMGhrWmxIQ01qR2V1?=
 =?utf-8?B?WEI0d1ZLcVBhUTN0djRTMU9HN2tVamJvcTN3MnM0UXZTck5RaXZDNkNtYk56?=
 =?utf-8?B?REVWWmthKy9tMXZDK2RiZko4ZVN2U0h6ODFhSE9oSlpUR3JyYzFpQlVMWlUv?=
 =?utf-8?B?ZEhlYUNCSFJtOUNXQXVFaFFrYTZlYnluTWJBTUhnUTBUU1JLWFZxSU1OeU1U?=
 =?utf-8?B?VXJDODF2M28vMmQrMXZTTFRmYU4weklNNGJib1BuZVErbjRDZW5DQVI2UytX?=
 =?utf-8?B?RUZKZGZVa296Ly9Ic1VFeFRCTFN1YmppS2tPc0szdEJFYjBqOHhzR0J4cldy?=
 =?utf-8?B?VnJxWE5iWFdSVm5UZzkrcjhDcEpYTEhwV0crZndCSGlQNG4wMlZpUld4bTdr?=
 =?utf-8?B?OU1kTUFZNzZacmdrY2VCemZDNmhQWEtraFJGNlB5SkgrT2I5eG5vMUVTTGN0?=
 =?utf-8?Q?t9bE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda73db0-8abb-4073-612e-08dbcf7ef20d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 02:07:13.6331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yT2Qv5OisacF1Jn3C1Lt6U2XcM1t57B/xGj+/f5U0PHZ1CHfqmU9Lq5qK7ejHQfPWI7lZTDuN4/aBQrLRhjVDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9785
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVbGYgSGFuc3NvbiA8dWxmLmhh
bnNzb25AbGluYXJvLm9yZz4NCj4gU2VudDogMjAyM+W5tDEw5pyIMTfml6UgMTk6MzUNCj4gVG86
IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gQ2M6IGFkcmlhbi5odW50ZXJAaW50
ZWwuY29tOyBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4
LWlteEBueHAuY29tPjsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5k
ZTsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb20NCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gbW1jOiBob3N0OiBzZGhjaS1lc2RoYy1pbXg6IGxldCB1c3IgdG8gY29u
ZmlnIHRoZSB3YWtldXANCj4gZm9yIGdwaW8gY2QgcGluIHRocm91Z2ggc3lzZnMNCj4gDQo+IE9u
IFR1ZSwgMTcgT2N0IDIwMjMgYXQgMDk6MjYsIDxoYWliby5jaGVuQG54cC5jb20+IHdyb3RlOg0K
PiA+DQo+ID4gRnJvbTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiA+DQo+ID4g
Q3VycmVudGx5IGRlZmF1bHQgZW5hYmxlIHRoZSBncGlvIGNkIHBpbiB3YWtldXAsIHRoaXMgd2ls
bCB3YXN0ZSBwb3dlcg0KPiA+IGFmdGVyIHN5c3RlbSBzdXNwZW5kIGlmIHVzciBkbyBub3QgbmVl
ZCB0aGlzIGNkIHBpbiB3YWtldXAgZmVhdHVyZS4NCj4gPiBOb3cgbGV0IHVzciB0byBjb25maWcg
dGhlIHdha2V1cCBmb3IgZ3BpbyBjZCBwaW4gdGhyb3VnaCBzeXNmcy4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYyB8IDE0ICsrKysrKysrKystLS0tDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4g
PiBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gPiBpbmRleCA0MGE2ZTJm
ODE0NWEuLjJlNDY2NDgzNDRiYSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3Nk
aGNpLWVzZGhjLWlteC5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1p
bXguYw0KPiA+IEBAIC0xNzk3LDkgKzE3OTcsMTIgQEAgc3RhdGljIGludCBzZGhjaV9lc2RoY19p
bXhfcHJvYmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgICAgICAgIC8q
DQo+ID4gICAgICAgICAgKiBTZXR1cCB0aGUgd2FrZXVwIGNhcGFiaWxpdHkgaGVyZSwgbGV0IHVz
ZXIgdG8gZGVjaWRlDQo+ID4gICAgICAgICAgKiB3aGV0aGVyIG5lZWQgdG8gZW5hYmxlIHRoaXMg
d2FrZXVwIHRocm91Z2ggc3lzZnMgaW50ZXJmYWNlLg0KPiA+ICsgICAgICAgICogRmlyc3QgY2hl
Y2sgdGhlIFNESU8gZGV2aWNlLCBzZWNvbmQgY2hlY2sgdGhlIGdwaW8gQ0QgcGluLg0KPiA+ICAg
ICAgICAgICovDQo+ID4gLSAgICAgICBpZiAoKGhvc3QtPm1tYy0+cG1fY2FwcyAmIE1NQ19QTV9L
RUVQX1BPV0VSKSAmJg0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIChob3N0LT5tbWMtPnBt
X2NhcHMgJg0KPiBNTUNfUE1fV0FLRV9TRElPX0lSUSkpDQo+ID4gKyAgICAgICBpZiAoKChob3N0
LT5tbWMtPnBtX2NhcHMgJiBNTUNfUE1fS0VFUF9QT1dFUikgJiYNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAoaG9zdC0+bW1jLT5wbV9jYXBzICYNCj4gTU1DX1BNX1dBS0VfU0RJT19JUlEp
KSB8fA0KPiA+ICsgICAgICAgICAgICgoaG9zdC0+bW1jLT5jYXBzICYgTU1DX0NBUF9DRF9XQUtF
KSAmJg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICBob3N0LT5tbWMtPnNsb3QuY2RfaXJx
ID49IDApKQ0KPiA+ICAgICAgICAgICAgICAgICBkZXZpY2Vfc2V0X3dha2V1cF9jYXBhYmxlKCZw
ZGV2LT5kZXYsIHRydWUpOw0KPiANCj4gSWYgdGhlIHdha2V1cCBpcyBHUElPIGJhc2VkLCBpdCBk
b2Vzbid0IG1lYW4gdGhhdCB0aGUgZGV2aWNlIGlzIHdha2V1cCBjYXBhYmxlLA0KPiBzbyB0aGlz
IGlzIHdyb25nLg0KPiANCj4gSW4gcHJpbmNpcGxlIHRoaXMgbXVzdCBiZSBtYW5hZ2VkIHRocm91
Z2ggdGhlIEdQSU8gaXJxY2hpcCBkcml2ZXIgaW5zdGVhZC4NCg0KWWVzLCBJIGtub3cgR1BJTyBh
bmQgVVNESEMgYXJlIGRpZmZlcmVudCBkZXZpY2UsIGNvbWJpbmUgR1BJTyB3YWtldXAgdG8gVVNE
SEMgaXMgbm90IHRoYXQgcmVhc29uYWJsZS4NCkkgc2VuZCB0aGlzIHBhdGNoIGJlY2F1c2UgSSBu
b3RpY2UgdGhlcmUgaXMgc2ltaWxhciBjb2RlIGluIHNkaGNpLXBjaS1jb3JlLmMsIHJlZmVyIHRv
IHNkaGNpX3BjaV9zdXNwZW5kX2hvc3QoKQ0KDQpTZWVtcyBQQ0kgc3Vic3lzdGVtIGNvbWJpbmUg
R1BJTyB3YWtldXAgdG8gUENJIGNvbnRyb2xsZXIuDQoNCkFueXdheSwgSSB3aWxsIHRyeSB0byBp
bXBsZW1lbnQgdGhpcyBpbiBHUElPIGlycWNoaXAgZHJpdmVyLg0KDQpCZXN0IFJlZ2FyZHMNCkhh
aWJvIENoZW4NCg0KPiANCj4gPg0KPiA+ICAgICAgICAgcG1fcnVudGltZV9zZXRfYWN0aXZlKCZw
ZGV2LT5kZXYpOw0KPiA+IEBAIC0xODc4LDcgKzE4ODEsOCBAQCBzdGF0aWMgaW50IHNkaGNpX2Vz
ZGhjX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICAgICAgICAgaWYgKHJldCkNCj4g
PiAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPg0KPiA+IC0gICAgICAgcmV0ID0gbW1j
X2dwaW9fc2V0X2NkX3dha2UoaG9zdC0+bW1jLCB0cnVlKTsNCj4gPiArICAgICAgIGlmIChkZXZp
Y2VfbWF5X3dha2V1cChkZXYpKQ0KPiANCj4gQXMgSSBpbmRpY2F0ZWQgYWJvdmUuIEl0J3Mgbm90
IHJlYWxseSB0aGUgZGV2aWNlIHRoYXQgY29ycmVzcG9uZHMgdG8gdGhlIG1tYw0KPiBjb250cm9s
bGVyIHRoYXQgY2FuIHdha2UgdXAgdGhlIHN5c3RlbSwgYnV0IHJhdGhlciB0aGUgZ3BpbyBpcnFj
aGlwLg0KPiANCj4gPiArICAgICAgICAgICAgICAgcmV0ID0gbW1jX2dwaW9fc2V0X2NkX3dha2Uo
aG9zdC0+bW1jLCB0cnVlKTsNCj4gPg0KPiA+ICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiAgfQ0K
PiA+IEBAIC0xOTAxLDggKzE5MDUsMTAgQEAgc3RhdGljIGludCBzZGhjaV9lc2RoY19yZXN1bWUo
c3RydWN0IGRldmljZQ0KPiA+ICpkZXYpDQo+ID4NCj4gPiAgICAgICAgIGlmIChob3N0LT5tbWMt
PmNhcHMyICYgTU1DX0NBUDJfQ1FFKQ0KPiA+ICAgICAgICAgICAgICAgICByZXQgPSBjcWhjaV9y
ZXN1bWUoaG9zdC0+bW1jKTsNCj4gPiArICAgICAgIGlmIChyZXQpDQo+ID4gKyAgICAgICAgICAg
ICAgIHJldHVybiByZXQ7DQo+ID4NCj4gPiAtICAgICAgIGlmICghcmV0KQ0KPiA+ICsgICAgICAg
aWYgKGRldmljZV9tYXlfd2FrZXVwKGRldikpDQo+IA0KPiBEaXR0by4NCj4gDQo+ID4gICAgICAg
ICAgICAgICAgIHJldCA9IG1tY19ncGlvX3NldF9jZF93YWtlKGhvc3QtPm1tYywgZmFsc2UpOw0K
PiA+DQo+ID4gICAgICAgICByZXR1cm4gcmV0Ow0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4NCj4g
DQo+IEtpbmQgcmVnYXJkcw0KPiBVZmZlDQo=
