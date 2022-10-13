Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A503DC433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Oct 2022 09:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJMJlg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Oct 2022 05:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJMJlf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2022 05:41:35 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80081.outbound.protection.outlook.com [40.107.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30328FF8FC
        for <linux-mmc@vger.kernel.org>; Thu, 13 Oct 2022 02:41:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlIpoM42OiUz50PDToXDrwsvYJQBehXRmY23rhabSrK+XqHv+xZwWECbfPcLBXI/aIHEbiL30QnH+SYpF/HIwfUFb1NvlFGEDq1kLE1V0IsN2T6NeG4zlu6RoVuCVWGVDrkT6rnuVxIyCe49awSLzLCA4gvSWr46OAyObUkd6vv7/MZi9wYQMX1TBMaVTcnKuAfMPu7wOua80kqj75ml2Hi79UgTXmiMbH/1FtdedAFbXbHNJUJv6K/Gr2+lrfs8x9jVfE1ogIEoqMGSjRYeChgObc1Td7VZgsky7JeQ70woB19Ekcq4d5+14ZQ5EPTTRNwJpC1YKV7S4/oMzpf0jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6tS57d37GuKGKTRGKV1r+jfkZrp1StzNNDCTLzXM8o=;
 b=CUC014d3bPIPMLYoUVUgNi9BoIpNPOxmDyifL0k68bes+uq6yj8m5Akyflknp2Cecr9jJm4pYfVlbjGHuDY6vfWFN8TAEM9T4Dv6o6rS7krK3YReJ74ARLclPsUWWEDgia8X6xWyji3l/mRLSzywdL4Wmj2lgSS3eEipXjrPig6tkpGRfcg29TnL29UQE3k7FfPcsMlmGkxRWrVrWs4oYYSn18Tco12GpwpJV0nCResIlA4knRypxfvtwYPbmu3PDkvC4VuKkUFhkY3bBD92PiGNqQvmwhXSwdlPgocZh2B7QoJ+SIfRG8nXBoA3+8g2O7Xd9DiggUWt8cIcsJYGiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6tS57d37GuKGKTRGKV1r+jfkZrp1StzNNDCTLzXM8o=;
 b=qOO/Q3SjlZHQfOiw7Uo0I/Bx62Fefe8RUsafIcdFCrZ6AUc8rYzhyeaBB+cqlxpNW4qpXJqovmbMC7AndbbjjbZBg2wGVFR7EgFUsV/GwacXjFFQaQj2QWX/EMbTF73l4+OqbfjZ9mm4nUtt902+UI+QiN5+cDM5GgKrqyoetL4=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 DU2PR04MB8742.eurprd04.prod.outlook.com (2603:10a6:10:2e0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.15; Thu, 13 Oct 2022 09:41:30 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::4cee:c7ba:1bbf:1c27]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::4cee:c7ba:1bbf:1c27%3]) with mapi id 15.20.5709.015; Thu, 13 Oct 2022
 09:41:30 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] mmc: sdhci-esdhc-imx: Propagate ESDHC_FLAG_HS400* only on
 8bit bus
Thread-Topic: [PATCH] mmc: sdhci-esdhc-imx: Propagate ESDHC_FLAG_HS400* only
 on 8bit bus
Thread-Index: AQHY3ubJV5yuJzpbuUetDaQ2cjwbHa4MEdgw
Date:   Thu, 13 Oct 2022 09:41:30 +0000
Message-ID: <DB7PR04MB4010BB997526796CA888C33F90259@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20221013093248.2220802-1-s.hauer@pengutronix.de>
In-Reply-To: <20221013093248.2220802-1-s.hauer@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|DU2PR04MB8742:EE_
x-ms-office365-filtering-correlation-id: d917d1f4-a32e-4b05-add3-08daacff1bba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NXi9tnV85WlwgM7d57QoD2LXTfKcf40zLRxBgT4F+vJnv5LpPgmYiOQUI0NCGWe5d7MOEO5laMW1ZQdJs1WHWyhTsU4BKsRlwkY/sSEQCsL/Yb15qwbawL0tUYn4H8bpBx0sqY8sywqtyTg6n/X9GWpP+AmDpR4zndgGGQAeM6se3gKzzxyWkjdalMYad4E75PesTwRkGKce1vrqKHinNN45+xXurKXJua8qNBuGXGz+y8JGuSpmMfT3hu4Ur7FpEmH9V7KvqxGhisTBdeM25FUyiHEMulgIEX18BoMHtDhCdbuHZiZXsn0FxltrSy4NXbp4Fh7cWREms68GhPrvz/NJBqP7dUVHRU3sjaymvEsVhtcezjwikoFyW2o6iG9c3XaytqqShxQKgVqh4N5v3jgKpepcrSQ/JDUkrpj6I9OrbZVkPvd/RrC+3xngVaZ3qN0AnT/OnxINcpEUVeTPRIGPiQxc+IxuiIQhMyaMXB3SKPINj5lrlrdmc5MjAjFKpKBQMR5eNBQ4Kr5tSAGRDv8HEXP3YcXXnPsHW8sw5A1pAVPBwQ9dOYIPbzgtJUWW0QD/TXMP4eKaMncDQgsmmSda2s4hq+tBzSTtpT08wQOy3CtWfqaLYizT8IEJxvZPU9Og+3YBwV49F1r0r0PpNy1tDoGx9QVMaA82OtR+XkiZFy7lziMfBGJXfaqjM8yAlyRrlgQ28TMG+UwJwj3IezUfZTMX43JLzE6OGWhlD5G0ScFtpsdZJWGb0CYJnBYH0x4V6DbcQI0daKPsMsKAAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199015)(71200400001)(54906003)(110136005)(38070700005)(316002)(2906002)(66946007)(76116006)(4326008)(8676002)(66556008)(66476007)(66446008)(64756008)(5660300002)(52536014)(8936002)(41300700001)(55016003)(7696005)(53546011)(83380400001)(26005)(186003)(9686003)(122000001)(478600001)(6506007)(38100700002)(33656002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?cm5pZFdKQTNXcFVrcmF1ZWZkU0JNOFdQb2hFM2x5TmJ3NkxHSDFNWE0zMVNZ?=
 =?gb2312?B?amlXUDZ4VGUvZlFTMFg1MlFzOUZHTm5rZDJ5cWZqQUpvSC9FNEtvUHdOUlJj?=
 =?gb2312?B?RlRIM1RhUXc4VHJnRFl5bGlXS3ZvRjRnV2hUUEFPaG5YOVpldjZLVkpBaDZO?=
 =?gb2312?B?U3R6YkUxb1ovMllaZXVOcU15SFNPeHRKb3hneERpb2xNLzRUeW8vUTNPNlFH?=
 =?gb2312?B?U1NnRXpRNThncGdiMFJtVXNmbHl6Q2dSRlhVYUR3NWF1bmY5TlNWMUZTd1Nh?=
 =?gb2312?B?MEplOVNWbUFyTFFCaGJIUk03a2k1bUpRbXJDajQ0aHRTZUFuYW9ickhiSURH?=
 =?gb2312?B?aG9tVHUwM1NIUGJ0S0U4SVVQSWVWNFhockFveWRsZWQ0K2UrWktTQTNMTEx6?=
 =?gb2312?B?bytqLzNKU1FFM09UZFdlTldQVzJLMVJIRDM3Qm1vVERNQStYZmx6dlpYQjQ1?=
 =?gb2312?B?VUJHQ1JYMkN4R2txS2phbit5RnRPREVjTHg3VEZNdWN0VFkrbE0rZWZFSzlH?=
 =?gb2312?B?YTV5aU1BUzVNRi9uVVNLTlZmc05lb28wQXV5NUFvS2l1em1kbkducFM0Qm1T?=
 =?gb2312?B?ZUVUMUxNRU1uK3MxNFZzWEFxQ2wxTFh0VzFHS2J3MzB4djFLNmlLQ1ZEL29M?=
 =?gb2312?B?N2t6Tkw1TnB6NWNsRk9xSi8rYnZ1L2pvcUp1blRBNGJENzFDSHFtdVVMY0F6?=
 =?gb2312?B?ZVJzK1JBRDhmbk12NWttNE1lNXYvK1VjZGhBMDFEL1Vqb01oQzJHU3BIclNu?=
 =?gb2312?B?ZGJmVUdIaEg4M3Q1aTN4MVpLbW5rTk0vOUFQYkViZkNGWjY4VDJEYnpYNDV2?=
 =?gb2312?B?bDhvMHZ6M0p0SHBURnJJNlE4YjJmblE1dk1IcVAwRnJoVFFrNGZVVisrRHFZ?=
 =?gb2312?B?V1dpclN1Q3pabytJTjcxTVQzS1BVTHBzQU9kaGdsb1g2R3dRVXhIdFZMWmhn?=
 =?gb2312?B?V1hZV1Y3eFZwb2gxZVRxUGozSko3cFBCVjNtNjJmM2s0amYrd2QrUHVlZ2Vx?=
 =?gb2312?B?Rzdpb0ZYeVNBYjRJa3V5a3ZvSkNzZkwzZVRsL29rclZmSzBLaDdZRjdFSlNQ?=
 =?gb2312?B?aFNsVWlKUlpSVkFFR09naVpndzM4RWNyVnlyN3AvaGRYZ1p6eUM3UmdtbGc4?=
 =?gb2312?B?TlJnVS9LMlhMS2EzczJZVXpNY0NDMkxhM1JicVpJSFR0UE0xd2wweWZKOGts?=
 =?gb2312?B?Q1pBbU80by9SV09lRDBZZHg0MVR6TWk3bXRvMytjSVQvdk15eDZIdWlkU0Qy?=
 =?gb2312?B?MWhuWWg2NGJNTzB2Y29OVDFvTExMMGdqaHJUc2V5ZWJhTGJtQ1ZzSFp1QnU3?=
 =?gb2312?B?ZW1BVHl1Vk80QjlQcWJKWDUweXlyZE5SaVE1b2FLVWJFWU1QUjFyU3pPKy9s?=
 =?gb2312?B?MU5zT3JiQTFubU5qY0IyM2F4L1hoTjVMS1hhQkxHOGhCOEpKMkkrQ1o0K2Uw?=
 =?gb2312?B?ZU1XbnlsT05LWjBnZkw3ME5SYVlFREZiRVJzaDlFRVY4SDgweUhvQ1l3WXRq?=
 =?gb2312?B?NXh3Q1pyZEhFdVNWWFZTeVBMWjFzdW5PaGVFRjBKeEQ0MGlKdDdxMlZzMWtL?=
 =?gb2312?B?TWMyVjFEVlhTN3MzRUlFVndzNzY4ekZlSWpSbmlpQWl5VWlZZUR1bXJCdlpx?=
 =?gb2312?B?MjBTQWgzeWlZU3FaVGlEblAvSDdOLzRNeHp0ZHNPZHdHMi9jd3FFT3hZOTRh?=
 =?gb2312?B?eHU3bUpTMVlSK3NrcVVydkZLZlJTUCt4aFRpdXRKRXlJY0xqZVhHSEZHVXUz?=
 =?gb2312?B?TDJxbXplVHJkVVExODJkdnczcUlGV3VDclNEdTBqV2ZLN1R1Qk42dStWbE5C?=
 =?gb2312?B?dzc1TmVaVHVRMGE3eHdoRTdlaGZSTEVJUTNTYTN0ZlZxdmFnOTJkVTYrNllO?=
 =?gb2312?B?Ykhsa252bURJSGpNMzAxY3VDMGttR0ZFUGVNSUJQYW0wZ0c2MVR4QVBMYnlH?=
 =?gb2312?B?VkVOMzdvZlJ6YkRIWmZyUk5JSkFzc012bUZSUEl0ZkdUenFMeDI2TUNDcUMz?=
 =?gb2312?B?WVl2dFJwS3ZGTUl5NGQ3czRrZVdvOW9Id0N6enBBcGgwSStjUjAvWXBObG9s?=
 =?gb2312?B?SUpqRGhhWXdnUWJpNnZ5cUo5Z09FeG1UVC93NlZZTXA5VkRVQUp3MXF5T1lO?=
 =?gb2312?Q?ss0LoTZiUadttYG1Zn+T+KP1J?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d917d1f4-a32e-4b05-add3-08daacff1bba
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 09:41:30.7891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eIT65hwSsQogeEyjsm+eXH21HLxyCPPvnYW/f5GgMo4x0jweWt7fBgiiBjELz2/6GJWbWkl6HT6mofwKV/8/pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8742
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTYXNjaGEgSGF1ZXIgPHMuaGF1
ZXJAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMjLE6jEw1MIxM8jVIDE3OjMzDQo+IFRvOiBs
aW51eC1tbWNAdmdlci5rZXJuZWwub3JnDQo+IENjOiBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54
cC5jb20+OyBBZHJpYW4gSHVudGVyDQo+IDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47IFVsZiBI
YW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPjsNCj4gUGVuZ3V0cm9uaXggS2VybmVsIFRl
YW0gPGtlcm5lbEBwZW5ndXRyb25peC5kZT47IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54
cC5jb20+OyBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+DQo+IFN1YmplY3Q6
IFtQQVRDSF0gbW1jOiBzZGhjaS1lc2RoYy1pbXg6IFByb3BhZ2F0ZSBFU0RIQ19GTEFHX0hTNDAw
KiBvbmx5DQo+IG9uIDhiaXQgYnVzDQo+IA0KPiBUaGUgY29yZSBpc3N1ZXMgdGhlIHdhcm5pbmcg
ImRyb3AgSFM0MDAgc3VwcG9ydCBzaW5jZSBubyA4LWJpdCBidXMiIHdoZW4gb25lDQo+IG9mIHRo
ZSBFU0RIQ19GTEFHX0hTNDAwKiBmbGFncyBpcyBzZXQgb24gYSBub24gOGJpdCBjYXBhYmxlIGhv
c3QuIFRvIGF2b2lkIHRoaXMNCj4gd2FybmluZyBzZXQgdGhlc2UgZmxhZ3Mgb25seSBvbiBob3N0
cyB0aGF0IGFjdHVhbGx5IGNhbiBkbyA4Yml0LCBpLmUuIGhhdmUNCj4gYnVzLXdpZHRoID0gPDg+
IHNldCBpbiB0aGUgZGV2aWNlIHRyZWUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTYXNjaGEgSGF1
ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+DQoNClJldmlld2VkLWJ5OiBIYWlibyBDaGVuIDxo
YWliby5jaGVuQG54cC5jb20+DQoNCkJlc3QgUmVnYXJkcw0KSGFpYm8gQ2hlbg0KPiAtLS0NCj4g
IGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMgfCAxNCArKysrKysrKy0tLS0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+IGIvZHJp
dmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBpbmRleCAzZjRlYjQ5YWZhMDI1Li4w
MDM1MzRiNzg0OTNiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhj
LWlteC5jDQo+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gQEAg
LTE2NjMsNiArMTY2MywxMCBAQCBzdGF0aWMgaW50IHNkaGNpX2VzZGhjX2lteF9wcm9iZShzdHJ1
Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCQlob3N0LT5tbWNfaG9zdF9vcHMuZXhl
Y3V0ZV90dW5pbmcgPSB1c2RoY19leGVjdXRlX3R1bmluZzsNCj4gIAl9DQo+IA0KPiArCWVyciA9
IHNkaGNpX2VzZGhjX2lteF9wcm9iZV9kdChwZGV2LCBob3N0LCBpbXhfZGF0YSk7DQo+ICsJaWYg
KGVycikNCj4gKwkJZ290byBkaXNhYmxlX2FoYl9jbGs7DQo+ICsNCj4gIAlpZiAoaW14X2RhdGEt
PnNvY2RhdGEtPmZsYWdzICYgRVNESENfRkxBR19NQU5fVFVOSU5HKQ0KPiAgCQlzZGhjaV9lc2Ro
Y19vcHMucGxhdGZvcm1fZXhlY3V0ZV90dW5pbmcgPQ0KPiAgCQkJCQllc2RoY19leGVjdXRpbmdf
dHVuaW5nOw0KPiBAQCAtMTY3MCwxMyArMTY3NCwxNSBAQCBzdGF0aWMgaW50IHNkaGNpX2VzZGhj
X2lteF9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCWlmIChpbXhf
ZGF0YS0+c29jZGF0YS0+ZmxhZ3MgJiBFU0RIQ19GTEFHX0VSUjAwNDUzNikNCj4gIAkJaG9zdC0+
cXVpcmtzIHw9IFNESENJX1FVSVJLX0JST0tFTl9BRE1BOw0KPiANCj4gLQlpZiAoaW14X2RhdGEt
PnNvY2RhdGEtPmZsYWdzICYgRVNESENfRkxBR19IUzQwMCkNCj4gKwlpZiAoaG9zdC0+Y2FwcyAm
IE1NQ19DQVBfOF9CSVRfREFUQSAmJg0KPiArCSAgICBpbXhfZGF0YS0+c29jZGF0YS0+ZmxhZ3Mg
JiBFU0RIQ19GTEFHX0hTNDAwKQ0KPiAgCQlob3N0LT5tbWMtPmNhcHMyIHw9IE1NQ19DQVAyX0hT
NDAwOw0KPiANCj4gIAlpZiAoaW14X2RhdGEtPnNvY2RhdGEtPmZsYWdzICYgRVNESENfRkxBR19C
Uk9LRU5fQVVUT19DTUQyMykNCj4gIAkJaG9zdC0+cXVpcmtzMiB8PSBTREhDSV9RVUlSSzJfQUNN
RDIzX0JST0tFTjsNCj4gDQo+IC0JaWYgKGlteF9kYXRhLT5zb2NkYXRhLT5mbGFncyAmIEVTREhD
X0ZMQUdfSFM0MDBfRVMpIHsNCj4gKwlpZiAoaG9zdC0+Y2FwcyAmIE1NQ19DQVBfOF9CSVRfREFU
QSAmJg0KPiArCSAgICBpbXhfZGF0YS0+c29jZGF0YS0+ZmxhZ3MgJiBFU0RIQ19GTEFHX0hTNDAw
X0VTKSB7DQo+ICAJCWhvc3QtPm1tYy0+Y2FwczIgfD0gTU1DX0NBUDJfSFM0MDBfRVM7DQo+ICAJ
CWhvc3QtPm1tY19ob3N0X29wcy5oczQwMF9lbmhhbmNlZF9zdHJvYmUgPQ0KPiAgCQkJCQllc2Ro
Y19oczQwMF9lbmhhbmNlZF9zdHJvYmU7DQo+IEBAIC0xNjk4LDEwICsxNzA0LDYgQEAgc3RhdGlj
IGludCBzZGhjaV9lc2RoY19pbXhfcHJvYmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRl
dikNCj4gIAkJCWdvdG8gZGlzYWJsZV9haGJfY2xrOw0KPiAgCX0NCj4gDQo+IC0JZXJyID0gc2Ro
Y2lfZXNkaGNfaW14X3Byb2JlX2R0KHBkZXYsIGhvc3QsIGlteF9kYXRhKTsNCj4gLQlpZiAoZXJy
KQ0KPiAtCQlnb3RvIGRpc2FibGVfYWhiX2NsazsNCj4gLQ0KPiAgCXNkaGNpX2VzZGhjX2lteF9o
d2luaXQoaG9zdCk7DQo+IA0KPiAgCWVyciA9IHNkaGNpX2FkZF9ob3N0KGhvc3QpOw0KPiAtLQ0K
PiAyLjMwLjINCg0K
