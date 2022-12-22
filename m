Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E50C4167B
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Dec 2022 02:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiLVCYu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Dec 2022 21:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiLVCYu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Dec 2022 21:24:50 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2044.outbound.protection.outlook.com [40.107.8.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EE612D31
        for <linux-mmc@vger.kernel.org>; Wed, 21 Dec 2022 18:24:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hh2rzcl1umNZA5P1QKXi2GZLJNNclmlMncozbQb9EYYrj1cP26iUiiIYvYU5jcL+txT13y2Kn1VOAcV834u/AriN8sg3+sMnVWFdOtaHLAeDtAoahssTx60dfMMDO/ekTnWs9dGs6qqJZg3uxv192vF3bHjQHJ0g3UTc9m9E0ssbbjJWh290jLSRswj8CesI4K3yVozsg2eziaDIBXn9m1jhS4VVREvQmSAwNidAcUAWfFsfVv9DFkj3d9vZiJmAgF4c1L9/4a5/uJ5RFS3GnoEYHW/6+sQlMHyHbQ3Fu2IaRsTKEfsaQCgRvIXYtzXDpUt9f3B7FYNUjUGUl15bEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zW39ynBYmiCC87xXjvKp3+VcQXWhCilZxUJ3zikLlws=;
 b=n2MxHwQUqcC86sj6e6teh6MV58OkTTUp1w+JHezt+IzmlLgwqXV6bZpO53uouWQ2boslU7MJiTBqt6coDNrxngVkFMD40Q0BgZoP++RvBC5L/oZgZuivd3EfAQgc9MbCaxKGRx0XDEarCgoNivs4FA4p+Q1hkbPlNH7ak1asieu+oXrjjsasYTtlED1Icd8wmfNiXewWQrfgc9KeZuj4OCcd3ppTZTdm4l/q6QSUzIl7ePfDh11/t5dkOqJBpeyKFlR1nAXX07VnjnOahFY8K4VugT5ILK504Ons6jDPRyQ5PtoQ+eMCh9/xL5vL2Fm8PHUC5RqQ3tIrB3XViaw6wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zW39ynBYmiCC87xXjvKp3+VcQXWhCilZxUJ3zikLlws=;
 b=Om87B2vcL9O2DCf+1EAsZcClKn8YZGfblPUj4GZAKG6G7fOgTTseArSNL+2UC1Z3gFtc+L8tE+4lonYTO2mngcoi++bjMNaHO67e3dIl5/IBYbbRCUWlIepvBey1fbfVdLwq8YH/4iC9yluV9TarSZVfjTsNT+Z0QGgt1Rvwr0w=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AM8PR04MB7731.eurprd04.prod.outlook.com (2603:10a6:20b:249::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 02:24:45 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 02:24:45 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "kgroeneveld@lenbrook.com" <kgroeneveld@lenbrook.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: RE: [PATCH v2 3/3] mmc: sdhci-esdhc-imx: only enable DAT[0] and CMD
 line auto tuning for SDIO device
Thread-Topic: [PATCH v2 3/3] mmc: sdhci-esdhc-imx: only enable DAT[0] and CMD
 line auto tuning for SDIO device
Thread-Index: AQHZFS9qmYPJ+WnPwkWHk0ZaGliFQK54ZJUAgADJsZA=
Date:   Thu, 22 Dec 2022 02:24:45 +0000
Message-ID: <DB7PR04MB401033B6EF3FA06A247ADDC690E89@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20221221112853.789675-1-haibo.chen@nxp.com>
 <20221221112853.789675-4-haibo.chen@nxp.com>
 <2e89e4e8-cac8-dc1d-9ec7-01599190167b@intel.com>
In-Reply-To: <2e89e4e8-cac8-dc1d-9ec7-01599190167b@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|AM8PR04MB7731:EE_
x-ms-office365-filtering-correlation-id: 6c246883-087c-4e4e-0084-08dae3c3b11a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nq1Llq+MYNNI2wnkvcZ26L6vIHmhmlvz8Ow4tj4kL9hM1SJaSa+mB3yKrju/t+hviDYXDZqVlc3Y0WRCL6tq6GtQhPCm54PEE1D6p+K144Vk62V00xMLcG3hfh8k/BYfETlh/PN2Nvc/avNiuLQZlaASXz+zWeEqHK5qf0/1gIaVYychVHpQPYbZnuHZxrbvWodbloqJzwNqzWvh37U4uJ1ml/wNzuNMCg1+zyZgfWJYFDB+MRJcZkSYLfYB1AgBaL0/X9gdvWIe95nNrATXm34SWMneIRhNUI6xsyVxbT3Suu+6b4uD/qn4ZU6h0d0T+DjKqrDjBa/Sldr/Ekpoyjgkoqhw8TqHTBiCL9z/yndB/2dm7+rD4snb8S8V4YRVrB+XUuYm5GqtIedKFcenHBsMWUIq1gbEwK3O6uz8XGPbTLJaMjtIRuJYncDa6BLylc5X3t4xaKDXFFRW0DKkXHi8uIHiWnZQ9SsHuoobkgzjQK7i1z1e9kls0CEX/6ecgEf+ijEWeEn7T9+t0lY9C2rMuAfnQXwl8NPQ/OGr+q+RM8wBVeWOiQI+NyM8xqjjR6sLCCtITKrpTWpV5Fnp8LT6w6OeH/FuwrD7Vmm533OgBuTsbh0xyx3DYC3m6fewk0C3D3uxnytcflEvoMb9vVOK7TBf0lsNVvo3KVFpHyCpjMU2la4T/1fW5eRP/r4MVZfg6fjuFRsNU3YjDBFOpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199015)(2906002)(33656002)(478600001)(86362001)(55016003)(53546011)(122000001)(83380400001)(38100700002)(38070700005)(6506007)(5660300002)(41300700001)(7696005)(186003)(26005)(52536014)(71200400001)(8936002)(316002)(6916009)(8676002)(76116006)(9686003)(66946007)(64756008)(66476007)(4326008)(54906003)(66556008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0QzaFV3dVU0bTRqbFI2Y2ExMlBHcFRCVERmQWtDeER2anB5L1cxTkJ2dHEw?=
 =?utf-8?B?c0JBa2h0TkpPd0JSZXRoSkpwYU5ET2lhUXJBREZMMFVwamtmc0UyZEkrUk10?=
 =?utf-8?B?UUx2a0xrQ1RjVXhycXFteFRzRVgvZUxwS01renNWL3g1VkVtVGxTZmtXU3dG?=
 =?utf-8?B?bW5NMzl1dm5ISGRJUDc0aHhQcUhmZldnZEhINUM5QWpadXRFMGVOVFZiV09q?=
 =?utf-8?B?VWt5YjVLQ0h4MU5BOVZPWDZDcUxHTmcxamMwTGpTc1hHT2E3bkhIeHVwOHJI?=
 =?utf-8?B?N21TNWkxWHcvZ2VnUkpIc0d3MHQ0SEpGWlRrYW03emJGYmhWRWV4Nk5weHhW?=
 =?utf-8?B?WERVdGtrRXE5T1U3TENNMXA1Mk1zWXRkaW1zeHZoMjVuazZxNEgySmtQYW4w?=
 =?utf-8?B?ZklvN2NGYUtiYjF5WjNGT1dTZ2t6TU9GTjFRUGZhZUhFSnZBTHNWbWo5aXNY?=
 =?utf-8?B?SmlDL0VueUYzQ05Lalh2ZWE1emd3aGc0VlBqNnA2V3loeGhESHpMZi9vNGU4?=
 =?utf-8?B?aGd5QWlhZ1ZBdlh3VzZpNkRGNzZkdHlUcS9FVEFFZjJ2amJoT1o2Vmdjb3dh?=
 =?utf-8?B?S0xUR1ZITHR2RGsydjVnNGJrQzFjUTJIR1o1OUNtMWNHQXVsV1BpU1lFTzM5?=
 =?utf-8?B?TklSTGM1ZktiNGtodlArbU9melNGbzcrUjBnYUQ0MnZ6R0JNcnJWWHpBR1Rt?=
 =?utf-8?B?a3QyNjAyVFdKUllwTlNqVjZWM0hlK2VwTDJUcEhDV0Y1WTRLVWVRbEwwd3g3?=
 =?utf-8?B?VFY2SklhVFpXVlNLaTc4L09BSUJUVjMrbi9Xek9IUFI1cjV5cVl4RzBDb1BQ?=
 =?utf-8?B?c0JjV0hjYWdLaXhrdUNEeE5QZ2dkSWxabEw4MDVvcFNmeWFMK1JqaU9TNHp4?=
 =?utf-8?B?V2tWMEJhM3FqY3hJT1M1N2tZaW1wbkNDN0JJeUlaY0dWSUlBYjkzRXpidHJo?=
 =?utf-8?B?YVhDZEJJU05OZDd4VnpacGVBR0F0TUNoOXd2cjdyUDRVa3ZSdDNCcmhpY0ow?=
 =?utf-8?B?aXBsRHBLUTNrL0dwTEZHYlBWeU5lWnFWb3grbFg1VTJDSEtQWG9xT2NHdnFL?=
 =?utf-8?B?OHBETjNNOFM5V0pGRVB6ZE82WGpkYTRBdHN1OW10WWdHaTYyNks4VVFpVmIy?=
 =?utf-8?B?VG1TNlZKVytINDVzTktabyt2OUlJWWdYVHlDdWZneGwzWDM5MEZYbVk1Wktu?=
 =?utf-8?B?Z1g5S3hZRy9ZK3VwZllOa2ZsemhzZ3RnQnpYYU9mcUhQd1Y5OGZ0SDR3UVhG?=
 =?utf-8?B?WXV0UG5mUXBvdkRGWW80TldGZDJhWXowTU80cjE1a2VPemVLUEkrSWNaeEdD?=
 =?utf-8?B?NmNQOU55KzhFU0tKTjBqTHNIOHo4VldpRDc3V0lHSmxoUXR3ajA4cWpsay9B?=
 =?utf-8?B?Ym1vRnZaZlNFZGI0d24xNzhzdmNCQ3MrWUNlYlJRU3dXVDh6WHplTG5YUVlW?=
 =?utf-8?B?Ty9VTjFxQW1CeUFRRHIvZGFseTV5eDZKUkI2UnRpcytTV2MyaVAyeUltUU4v?=
 =?utf-8?B?SkZhUnRHNWFncEp3aW03L29GQldtanRzb3VWbWFpTlQ0SGo2WFR2RlpJRmYz?=
 =?utf-8?B?WnFXVmJDT2lXa0tkWTh6cEo2VDdweHhCZWxjU1FRdmNoUnBDNkt2YVJsN2hN?=
 =?utf-8?B?MS9hQXc2eFBCNW1OanVoVzhXNnVqOENhN1BQbUFkdnRnU0JQazZ2UU5HYi9m?=
 =?utf-8?B?cXdaN1BJMDd0em5jeHlwZUpYV01IVkRtV1lCc0RjK0RUZnRlNlNqcEZnYXFz?=
 =?utf-8?B?eThhaDZPdUlWSmZzamhCcFcvRmZDQml2MndYcUpHSEhKNEpqQlRaYzJhSlIz?=
 =?utf-8?B?aXo5a2xvSGVtTXZLaW5WS3RYNExvRXZSd3Iza3NoM2ZrZXYzcy9RTXFVb3pM?=
 =?utf-8?B?MHhyMEh4ZWZzNTJoYWNkUDIwdU9FQkppNTdHcXMxVU5ENndmR05WT3NRclFz?=
 =?utf-8?B?SldhNjFHTGFWR0I2MFhScGF3Zmg1ZFUycVd0VGhNdVU0eVFqRThrZWFjeE0v?=
 =?utf-8?B?NEtBb1BKWis5MzV3RjEyR0V6QXhIYkVhcDNpQVpjeHNTNENhNFlJMEVCV3Zz?=
 =?utf-8?B?eUVJTGtsaVhXNmFCSkdhajgrRjAvU2lOS3Q1am0yaWFNZ0tncG5oQS9tdVVi?=
 =?utf-8?Q?+5IMyvpEGU2CcEaKkdHdm8I0r?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c246883-087c-4e4e-0084-08dae3c3b11a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2022 02:24:45.5433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9xal5Nrt7J/CWrrdidpAZH0yOtcWX/fR2Ce3dKUcjO/1keRwndc4396De69+haEbNcVu8pco2yNSLR/I+n8dHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7731
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBZHJpYW4gSHVudGVyIDxhZHJp
YW4uaHVudGVyQGludGVsLmNvbT4NCj4gU2VudDogMjAyMuW5tDEy5pyIMjHml6UgMjI6MjENCj4g
VG86IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gQ2M6IHNoYXduZ3VvQGtlcm5l
bC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4g
ZmVzdGV2YW1AZ21haWwuY29tOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsNCj4g
bGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsga2dyb2VuZXZlbGRAbGVuYnJvb2suY29tOw0KPiB1
bGYuaGFuc3NvbkBsaW5hcm8ub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMy8zXSBtbWM6
IHNkaGNpLWVzZGhjLWlteDogb25seSBlbmFibGUgREFUWzBdIGFuZA0KPiBDTUQgbGluZSBhdXRv
IHR1bmluZyBmb3IgU0RJTyBkZXZpY2UNCj4gDQo+IE9uIDIxLzEyLzIyIDEzOjI4LCBoYWliby5j
aGVuQG54cC5jb20gd3JvdGU6DQo+ID4gRnJvbTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAu
Y29tPg0KPiA+DQo+ID4gVVNESEMgSVAgaGFzIG9uZSBsaW1pdGF0aW9uOiB0aGUgdHVuaW5nIGNp
cmN1aXQgY2FuJ3QgaGFuZGxlIHRoZSBhc3luYw0KPiA+IHNkaW8gZGV2aWNlIGludGVycnVwdCBj
b3JyZWN0bHkuIFdoZW4gc2RpbyBkZXZpY2UgdXNlIDQgZGF0YSBsaW5lcywNCj4gPiBhc3luYyBz
ZGlvIGludGVycnVwdCB3aWxsIHVzZSB0aGUgc2hhcmVkIERBVFsxXSwgaWYgZW5hYmxlIGF1dG8g
dHVuaW5nDQo+ID4gY2lyY3VpdCB0byBjaGVjayB0aGVzZSA0IGRhdGEgbGluZXMsIGluY2x1ZGUg
dGhlIERBVFsxXSwgdGhpcyBjaXJjdWl0DQo+ID4gd2lsbCBkZXRlY3QgdGhpcyBpbnRlcnJ1cHQs
IHRha2UgdGhpcyBhcyBkYXRhIG9uIERBVFsxXSwgYW5kIGFkanVzdA0KPiA+IHRoZSBkZWxheSBj
ZWxsIHdyb25nbHksIGZpbmFsbHkgd2lsbCBjYXVzZSB0aGUgREFUQS9DTUQgQ1JDIGVycm9yLg0K
PiA+IFNvIGZvciBTRElPIGRldmljZSwgb25seSBlbmFibGUgREFUWzBdIGFuZCBDTUQgbGluZSBm
b3IgYXV0byB0dW5pbmcuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIYWlibyBDaGVuIDxoYWli
by5jaGVuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNk
aGMtaW14LmMgfCAxNCArKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5z
ZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kt
ZXNkaGMtaW14LmMNCj4gPiBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4g
PiBpbmRleCBiZjhkNmY2MGE5ZWUuLmQ2Y2U0YzhkMjNkYyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvaG9z
dC9zZGhjaS1lc2RoYy1pbXguYw0KPiA+IEBAIC00NDgsNiArNDQ4LDIwIEBAIHN0YXRpYyBpbmxp
bmUgdm9pZA0KPiB1c2RoY19hdXRvX3R1bmluZ19tb2RlX3NlbF9hbmRfZW4oc3RydWN0IHNkaGNp
X2hvc3QgKmhvc3QpDQo+ID4gIAkJYnJlYWs7DQo+ID4gIAl9DQo+ID4NCj4gPiArCS8qDQo+ID4g
KwkgKiBGb3IgVVNESEMsIGF1dG8gdHVuaW5nIGNpcmN1aXQgY2FuIG5vdCBoYW5kbGUgdGhlIGFz
eW5jIHNkaW8NCj4gPiArCSAqIGRldmljZSBpbnRlcnJ1cHQgY29ycmVjdGx5LiBXaGVuIHNkaW8g
ZGV2aWNlIHVzZSA0IGRhdGEgbGluZXMsDQo+ID4gKwkgKiBhc3luYyBzZGlvIGludGVycnVwdCB3
aWxsIHVzZSB0aGUgc2hhcmVkIERBVFsxXSwgaWYgZW5hYmxlIGF1dG8NCj4gPiArCSAqIHR1bmlu
ZyBjaXJjdWl0IGNoZWNrIHRoZXNlIDQgZGF0YSBsaW5lcywgaW5jbHVkZSB0aGUgREFUWzFdLA0K
PiA+ICsJICogdGhpcyBjaXJjdWl0IHdpbGwgZGV0ZWN0IHRoaXMgaW50ZXJydXB0LCB0YWtlIHRo
aXMgYXMgYSBkYXRhIG9uDQo+ID4gKwkgKiBEQVRbMV0sIGFuZCBhZGp1c3QgdGhlIGRlbGF5IGNl
bGwgd3JvbmdseS4NCj4gPiArCSAqIFRoaXMgaXMgdGhlIGhhcmR3YXJlIGRlc2lnbiBsaW1pdGF0
aW9uLCB0byBhdm9pZCB0aGlzLCBmb3Igc2Rpbw0KPiA+ICsJICogZGV2aWNlLCBjb25maWcgdGhl
IGF1dG8gdHVuaW5nIGNpcmN1aXQgb25seSBjaGVjayBEQVRbMF0gYW5kIENNRA0KPiA+ICsJICog
bGluZS4NCj4gPiArCSAqLw0KPiA+ICsJaWYgKCFob3N0LT5tbWMtPmNhcmQgJiYgbW1jX2NhcmRf
c2Rpbyhob3N0LT5tbWMtPmNhcmQpKQ0KPiANCj4gTG9va3MgbGlrZSAhaG9zdC0+bW1jLT5jYXJk
IHNob3VsZCBiZSBob3N0LT5tbWMtPmNhcmQNCg0KWWVzLCBteSBtaXN0YWtlLCBteSBsb2NhbCB0
ZXN0IHZlcnNpb24gaXMgY29ycmVjdCwgSSB3aWxsIGZpeCB0aGlzLg0KDQpCZXN0IFJlZ2FyZHMN
CkhhaWJvIENoZW4NCj4gDQo+ID4gKwkJYXV0b190dW5lX2J1c3dpZHRoID0gRVNESENfVkVORF9T
UEVDMl9BVVRPX1RVTkVfMUJJVF9FTjsNCj4gPiArDQo+ID4gIAllc2RoY19jbHJzZXRfbGUoaG9z
dCwgRVNESENfVkVORF9TUEVDMl9BVVRPX1RVTkVfTU9ERV9NQVNLLA0KPiA+ICAJCQlhdXRvX3R1
bmVfYnVzd2lkdGggfA0KPiBFU0RIQ19WRU5EX1NQRUMyX0FVVE9fVFVORV9DTURfRU4sDQo+ID4g
IAkJCUVTREhDX1ZFTkRfU1BFQzIpOw0KDQo=
