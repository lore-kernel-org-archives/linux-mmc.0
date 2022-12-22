Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14448C4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Dec 2022 02:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiLVCW5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Dec 2022 21:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiLVCW4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Dec 2022 21:22:56 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2078.outbound.protection.outlook.com [40.107.105.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF0112D31
        for <linux-mmc@vger.kernel.org>; Wed, 21 Dec 2022 18:22:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jD1aMxsnButkk9fxLFDngToyvs+lHMG65R+cELWKfKntkq0InwhUSbugXGnz22PwRflFhRyfVuh3lIytaSgHYI4ndGH5wOsbmZyfNDiWGql+U2hooETr2ulDi7QHBhQ28ImBfoyBeU0pnXumv231/cqIwuMdnUgAHZeyU2Tp7bxzP5ejovgucTQfIhjExpAGJBXJTZC0GZ3gbY9j8Kk7TJ0OYAFjBZWn2gGVKu5M1qznHyY8446fF0PkCyDG786vKPcd1rbb8f6qM1zmgw2t/LzLZD2ku3GTH45MyUPKeOlIyZbD35wSi84Fbm4VrfyUSsDFwxSlp8i5KhIeXb5P/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oChmm2EGDPQSGI7XGlSCUrfB9Ws8qHZ38J4n7v8Dlrg=;
 b=GbbD/xmTkeKzpFd5J7seAnTujfqtklRZTwTfxz/vurGsvWAjm1S14OIy9NGJCJvLyjBJT2tIMJo0EqB/m76CmA6xnHSqswBh/c2H9hkA95NqjbvxPeNi2LNUqGdoojYUtmsvadLtdfL2ffxlBBH3GGqAj3JBQB69dlc2LbYJ6OtTvgck0KdbjADpBIIs5byW6mcKPiL1Vgdp6Nhmr9mJPyl6cmT3KK5n/EubUKrCXat5sZ+eX8v/cP8Rti7shAGpgx66gfIDspU0Nirarrj68GQm8HiiKktyNUwjBJYrhjXLIU6S5+SANRoA7vxNX7nhJTEmJtn4CJrctU0k7OnlkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oChmm2EGDPQSGI7XGlSCUrfB9Ws8qHZ38J4n7v8Dlrg=;
 b=sqMrsP+Eq65TMInYtmGIw7W+wVHe4weWmn0kgMIVocBeaJaOaHqNXIFDFmov7oFoRC2+qDC+mPxovGvpkGAeTfkfSvqry2OZ1lk7d7Cr5y/RTnfYeXOFhB9qaGy58YnygYCgMlBbv+0eUvKqWLkCNu4jfEFagTtJaIsYDP4FXMI=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AM8PR04MB7731.eurprd04.prod.outlook.com (2603:10a6:20b:249::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 02:22:53 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 02:22:52 +0000
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
Subject: RE: [PATCH v2 2/3] mmc: let the host side can find card type during
 card init process
Thread-Topic: [PATCH v2 2/3] mmc: let the host side can find card type during
 card init process
Thread-Index: AQHZFS9ouiKaKHltX0+N9OmbVqgHYq54ZEQAgADJp0A=
Date:   Thu, 22 Dec 2022 02:22:52 +0000
Message-ID: <DB7PR04MB4010EE22324A48BC31B9A1D090E89@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20221221112853.789675-1-haibo.chen@nxp.com>
 <20221221112853.789675-3-haibo.chen@nxp.com>
 <e5ea9e85-9d84-18e2-b6f4-0af14b00c5f0@intel.com>
In-Reply-To: <e5ea9e85-9d84-18e2-b6f4-0af14b00c5f0@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|AM8PR04MB7731:EE_
x-ms-office365-filtering-correlation-id: edde9ee1-6467-4096-fc16-08dae3c36df2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GwBiztF0PYJHuHiMllKMaBDx5rs8jm/f4fNUnFxrwPO00CFKW2LjVUj3l/0kAY5IneKb2jTYEIAQb++8BLP9XLrhyw8HkNW/WRpHu9gZFgECJzcOaqTkr8MA17XXuRaOeA9KrMfY2mnbyGQ8JIMahjbhYdF5fgPa0bizGCRq2QBmq7J/zBsUdC+QBcERoW2aYXzCqqPODVg6/DLS9WopFaC9mri3xNNHw5vHF2WiLUIglmQeiufoOym+vAl4X8EJwbsozji4y/pi6qNBe+opyBr+sWdUJfi8rKO4eEEGhFP3N1ChVwctr5cBQobWDRTNQJisxOA7c0TezWvHjkEeuaBKCMFgCkTBQtYDIpX9tA1DCK9x0LgHzM0mNTr3aQ+zcBATTwGO68cthY0ibaxjAZEHp+cB1TmG1guCPCAr/+9rHzxhiiduUV0XBBFFPVKRZUUrPcYav694FfO1j2ZaCERGMRY3TJY4QEZwJT3V85COFP4wddCVvKMsSxYqnVGCIy7Cw7/Jcw3kNxQhjOKaWMzjUItWmVuKHzEj0bwKIir8khE7yiyXErXE926G5L+qJ81vIcQY//ObGmTw/Qfi+KnVVC3RYnt7O2KvHDWeQHYvLCPlDZafIbjSCBEMfZUkqbQIpwGBruS3hME/LcSme/6AWLcHk1pxGZR3jhb2Z10PDk2XnxlTq/AwZVq5xcUbYWECcrEwLpkS+5sJ+XJmpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199015)(2906002)(33656002)(478600001)(86362001)(55016003)(53546011)(122000001)(83380400001)(38100700002)(38070700005)(6506007)(5660300002)(41300700001)(7696005)(186003)(26005)(52536014)(71200400001)(8936002)(316002)(6916009)(8676002)(76116006)(9686003)(66946007)(64756008)(66476007)(4326008)(54906003)(66556008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTFaR1N1RzRoY1hzRXNnQkI2ZTI4MzEwU3VuaVllY0NJVk52L3ZGMXYwNGZO?=
 =?utf-8?B?TFpqUHRUdDlYQnhvMWhpakgwQzFidkUvSUE4ZTdxWHBNUjBoYWY0d3RXQWtY?=
 =?utf-8?B?REpvcjB6bUt6U1dCL2xuQSs2cWRQS3piZTdQWDI2VEc5YVMza3V6RlRGVng0?=
 =?utf-8?B?YVhzUjI0WXNkenB1cExrSnVNNThtd3J5YW8vT2wrM2ZIcnJseGg0bkRGT1oy?=
 =?utf-8?B?UkNSK3lDTjFtMkloT2svM2J1QldvVldKMXZIWEZXVW5HR3k3bVNNSEE0U0o5?=
 =?utf-8?B?cEtjUXh1UVZ3TDZxOXlsWU8rOXhFMTZZRGNQV3VZdnVpdzI5RWJNS0M2M1lw?=
 =?utf-8?B?L2UvSURjMGxXNWE1cVREVEgvcUtVZDBuTUJNVTg5UmszaUl4cnhxa0xHWFB2?=
 =?utf-8?B?WGRnZ21SbGd0bjV3Rkc2S0ZMNVVKNUNBaDF5aUZQOTc4QVRTekNqMHR3d2dw?=
 =?utf-8?B?ZVBydDlyc2FEajRQTmI3ZXBrYlo0dTNIM2JKcnA2Mmp6Y2o4eUNuTTY5ejk4?=
 =?utf-8?B?TmE2TjFDcFR2QzNPU1lQT1dWMEZlYi9BdndaVmRDRjBpZXdBN0VEd1BiUVNT?=
 =?utf-8?B?VjY0ekVrTm5ibXhKK3VMT2d4WkFPMEhTWGpGNEV1YnFNNnVjWDJXSnRwZklu?=
 =?utf-8?B?dmFyQVBGTjVmam5PS2VVRGZqSzRONUplV213RUtObTcyV2RRQnkwbHM0OXkz?=
 =?utf-8?B?SkcxV0RsaFJsSW1CY0o4S3dKWWwwc3hWUkc1SFR0ckd0ZGZ4VGR3b2lybTN3?=
 =?utf-8?B?c0pYU01TYk9EUEJlcEk4K3pWMWxvektLajNMR2ViSlpYejFqZWwxN1ZibE1o?=
 =?utf-8?B?Mm1WR1I1Z1BGbndQTnd4aVZDeEJvaDlMYTdtRjg1alM4cHFzWVVYU0lnbnlJ?=
 =?utf-8?B?cEt0YTZUQVpaVHlTQUhhTGc0MzgrVTV5SktKZXBKYjJVTWFEL0ZaeVlUREZ1?=
 =?utf-8?B?WGFRYjhEMlVIbi92VzgvMXRvY3hDeHJoNFJwNVBBd1dSbUJNTDcxYXV0RWRa?=
 =?utf-8?B?Wkk1dDZZVC9nRjZmVmszelZaOXl1ZjdvMkdlNmRXcVZud3prVlZxY21SNVli?=
 =?utf-8?B?OUFHakhqMjAwUW1UVHJpVXlZeTg4MjlIa3MrOUlWNnQ3c3MyTUJIbU1oY0xj?=
 =?utf-8?B?cElSWFRQUUs1TmtYdWRiS0hEZXVidFpZV01QUkEzREhlSC9hSm5YdXpJdzh4?=
 =?utf-8?B?eUZhNm1TWnpRb092WGhCRWdlcXo5M3BYQTNZNU5VbS8xaWdRVjBhVTVsYk4y?=
 =?utf-8?B?ak1NRjZyd1d6bWZrRlpmelE2bzhzN1pBdnFnMEkyNjZzcUFhdjhJcGtqZ3Jx?=
 =?utf-8?B?WnVIRDVuMkZjZ1kxOGliWjdPNU5DVzlhR2wxdVl2N2ZkQnhINHVJb1NzVm5E?=
 =?utf-8?B?bmpyUDlLM3V6SDRFYWpNMWVyL25VSHdzNWhTRW5wekxSL0JCdm8rZkZjTy9D?=
 =?utf-8?B?ZE9qL2kwczMwVDhWOG45VXRjTGw4UkQxcUJjMUp5dXEzb2tGTkJYalYvSnlh?=
 =?utf-8?B?d2V6enF5SjU3aWtTV1NSbjBFWGRwL1piN0Z6STUvWXlpMlUyUkdHT2ZydGZy?=
 =?utf-8?B?alFIMlBoYy8ySTRXYjVIa1JZM3BTNkp3aEZEZWpROEsxQzdGczFpL21VaGQ0?=
 =?utf-8?B?R3lQVDZjR0VNRGUyZDFDRGxmM2t5MERmVlpqVE52eG16UXZ1N1dZYXRob0VL?=
 =?utf-8?B?NW54SDJnRHZod2JCMmpCM1lJbldBNDRGWE5vTmJTZUZ4dE9ya09LNnl0cnNX?=
 =?utf-8?B?cnNCcktpaG9RN2R6b3hOZlNySGNhdEx6MzgvQXkxV3pTVFBRSlExUCtTbU5w?=
 =?utf-8?B?S04vekdVd2J4L3ZkV1VFYWxGMU9PMmJNbm1kK24yc0ZsZUpLSzZEQ3djT2xr?=
 =?utf-8?B?WVJ3V3VkZGkxWUtIVHlrOUJacXc0TDhYTDJkdEd6b2NvbmtURisxU2QrRElx?=
 =?utf-8?B?Tm5VMEVGQlJTTTJwai82QzRUUXVaYlJoSzZkb3ExWEZxNzdYaXpPU1RMckIx?=
 =?utf-8?B?NWJkQmdtcXJpOGIrWlE3TEtEdXdwUVdwTTRtSTBPQzNiOXVvdk5yT2tUenpL?=
 =?utf-8?B?Tk5IY2orZU9MdkdVaGVyS1puMC9OVU8vbW8rb1ppYWY1Yk1JNGRqZkswODRP?=
 =?utf-8?Q?HKuk23UHeD3w/7Qkkg0jRXqtx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edde9ee1-6467-4096-fc16-08dae3c36df2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2022 02:22:52.8802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6q1NR5vOIuFpIvb9tm+uBfc0S/6Y3uhbPicl0sZUc0eyv5K9t8s1+Apla9ZTm39xN+1qDeil/QNeyoBhU/vkLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7731
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBZHJpYW4gSHVudGVyIDxhZHJp
YW4uaHVudGVyQGludGVsLmNvbT4NCj4gU2VudDogMjAyMuW5tDEy5pyIMjHml6UgMjI6MjANCj4g
VG86IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gQ2M6IHNoYXduZ3VvQGtlcm5l
bC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4g
ZmVzdGV2YW1AZ21haWwuY29tOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsNCj4g
bGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsga2dyb2VuZXZlbGRAbGVuYnJvb2suY29tOw0KPiB1
bGYuaGFuc3NvbkBsaW5hcm8ub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMi8zXSBtbWM6
IGxldCB0aGUgaG9zdCBzaWRlIGNhbiBmaW5kIGNhcmQgdHlwZSBkdXJpbmcNCj4gY2FyZCBpbml0
IHByb2Nlc3MNCj4gDQo+IE9uIDIxLzEyLzIyIDEzOjI4LCBoYWliby5jaGVuQG54cC5jb20gd3Jv
dGU6DQo+ID4gRnJvbTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiA+DQo+ID4g
RHVyaW5nIHRoZSBjYXJkIGluaXQsIHRoZSBob3N0IHNpZGUgc29tZXRpbWVzIG1heSBuZWVkIHRv
IGRpc3Rpbmd1aXNoDQo+ID4gdGhlIGNhcmQgdHlwZSB0byBoYW5kbGUgYWNjb3JkaW5nbHkuIFNv
IG5lZWQgdG8gZ2l2ZSBob3N0LT5jYXJkIHZhbHVlDQo+ID4gZWFybGllci4NCj4gDQo+IERpZCB5
b3UgY29uc2lkZXIgbWFraW5nIHVzZSBvZiB0aGUgLT5pbml0X2NhcmQoKSBob3N0IG9wPw0KDQpX
b3csIGEgdmVyeSBnb29kIHN1Z2dlc3Rpb24sIEkgd2lsbCBoYXZlIGEgdHJ5LCB0aGFua3MhDQoN
CkJlc3QgUmVnYXJkcw0KSGFpYm8gQ2hlbg0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhh
aWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tbWMv
Y29yZS9tbWMuYyAgfCAgOSArKysrKy0tLS0NCj4gPiAgZHJpdmVycy9tbWMvY29yZS9zZC5jICAg
fCAgNyArKysrKy0tDQo+ID4gIGRyaXZlcnMvbW1jL2NvcmUvc2Rpby5jIHwgMTAgKysrKysrLS0t
LQ0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMgYi9kcml2ZXJz
L21tYy9jb3JlL21tYy5jIGluZGV4DQo+ID4gODljZDQ4ZmNlYzc5Li42M2RlNzZhNTFiZTMgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMvY29yZS9tbWMuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
bW1jL2NvcmUvbW1jLmMNCj4gPiBAQCAtMTY1OCw2ICsxNjU4LDggQEAgc3RhdGljIGludCBtbWNf
aW5pdF9jYXJkKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCwNCj4gdTMyIG9jciwNCj4gPiAgCQkJZ290
byBlcnI7DQo+ID4gIAkJfQ0KPiA+DQo+ID4gKwkJaG9zdC0+Y2FyZCA9IGNhcmQ7DQo+ID4gKw0K
PiA+ICAJCWNhcmQtPm9jciA9IG9jcjsNCj4gPiAgCQljYXJkLT50eXBlID0gTU1DX1RZUEVfTU1D
Ow0KPiA+ICAJCWNhcmQtPnJjYSA9IDE7DQo+ID4gQEAgLTE5MjYsMTQgKzE5MjgsMTMgQEAgc3Rh
dGljIGludCBtbWNfaW5pdF9jYXJkKHN0cnVjdCBtbWNfaG9zdA0KPiAqaG9zdCwgdTMyIG9jciwN
Cj4gPiAgCQlnb3RvIGZyZWVfY2FyZDsNCj4gPiAgCX0NCj4gPg0KPiA+IC0JaWYgKCFvbGRjYXJk
KQ0KPiA+IC0JCWhvc3QtPmNhcmQgPSBjYXJkOw0KPiA+IC0NCj4gPiAgCXJldHVybiAwOw0KPiA+
DQo+ID4gIGZyZWVfY2FyZDoNCj4gPiAtCWlmICghb2xkY2FyZCkNCj4gPiArCWlmICghb2xkY2Fy
ZCkgew0KPiA+ICAJCW1tY19yZW1vdmVfY2FyZChjYXJkKTsNCj4gPiArCQlob3N0LT5jYXJkID0g
TlVMTDsNCj4gPiArCX0NCj4gPiAgZXJyOg0KPiA+ICAJcmV0dXJuIGVycjsNCj4gPiAgfQ0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL3NkLmMgYi9kcml2ZXJzL21tYy9jb3JlL3Nk
LmMgaW5kZXgNCj4gPiA3MmI2NjRlZDkwY2YuLjE0N2IxODhiOTE2ZSAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL21tYy9jb3JlL3NkLmMNCj4gPiArKysgYi9kcml2ZXJzL21tYy9jb3JlL3NkLmMN
Cj4gPiBAQCAtMTQzMSw2ICsxNDMxLDggQEAgc3RhdGljIGludCBtbWNfc2RfaW5pdF9jYXJkKHN0
cnVjdCBtbWNfaG9zdA0KPiAqaG9zdCwgdTMyIG9jciwNCj4gPiAgCQlpZiAoSVNfRVJSKGNhcmQp
KQ0KPiA+ICAJCQlyZXR1cm4gUFRSX0VSUihjYXJkKTsNCj4gPg0KPiA+ICsJCWhvc3QtPmNhcmQg
PSBjYXJkOw0KPiA+ICsNCj4gPiAgCQljYXJkLT5vY3IgPSBvY3I7DQo+ID4gIAkJY2FyZC0+dHlw
ZSA9IE1NQ19UWVBFX1NEOw0KPiA+ICAJCW1lbWNweShjYXJkLT5yYXdfY2lkLCBjaWQsIHNpemVv
ZihjYXJkLT5yYXdfY2lkKSk7IEBAIC0xNTYzLDEyDQo+ID4gKzE1NjUsMTMgQEAgc3RhdGljIGlu
dCBtbWNfc2RfaW5pdF9jYXJkKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCwgdTMyIG9jciwNCj4gPiAg
CQlnb3RvIGZyZWVfY2FyZDsNCj4gPiAgCX0NCj4gPg0KPiA+IC0JaG9zdC0+Y2FyZCA9IGNhcmQ7
DQo+ID4gIAlyZXR1cm4gMDsNCj4gPg0KPiA+ICBmcmVlX2NhcmQ6DQo+ID4gLQlpZiAoIW9sZGNh
cmQpDQo+ID4gKwlpZiAoIW9sZGNhcmQpIHsNCj4gPiAgCQltbWNfcmVtb3ZlX2NhcmQoY2FyZCk7
DQo+ID4gKwkJaG9zdC0+Y2FyZCA9IE5VTEw7DQo+ID4gKwl9DQo+ID4NCj4gPiAgCXJldHVybiBl
cnI7DQo+ID4gIH0NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9zZGlvLmMgYi9k
cml2ZXJzL21tYy9jb3JlL3NkaW8uYyBpbmRleA0KPiA+IGY2NGI5YWM3NmE1Yy4uNWJjZjRhZGE0
NzM4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvc2Rpby5jDQo+ID4gKysrIGIv
ZHJpdmVycy9tbWMvY29yZS9zZGlvLmMNCj4gPiBAQCAtNjk5LDYgKzY5OSw5IEBAIHN0YXRpYyBp
bnQgbW1jX3NkaW9faW5pdF9jYXJkKHN0cnVjdCBtbWNfaG9zdA0KPiAqaG9zdCwgdTMyIG9jciwN
Cj4gPiAgCWlmIChJU19FUlIoY2FyZCkpDQo+ID4gIAkJcmV0dXJuIFBUUl9FUlIoY2FyZCk7DQo+
ID4NCj4gPiArCWlmICghb2xkY2FyZCkNCj4gPiArCQlob3N0LT5jYXJkID0gY2FyZDsNCj4gPiAr
DQo+ID4gIAlpZiAoKHJvY3IgJiBSNF9NRU1PUllfUFJFU0VOVCkgJiYNCj4gPiAgCSAgICBtbWNf
c2RfZ2V0X2NpZChob3N0LCBvY3IgJiByb2NyLCBjYXJkLT5yYXdfY2lkLCBOVUxMKSA9PSAwKSB7
DQo+ID4gIAkJY2FyZC0+dHlwZSA9IE1NQ19UWVBFX1NEX0NPTUJPOw0KPiA+IEBAIC04MDAsOCAr
ODAzLDYgQEAgc3RhdGljIGludCBtbWNfc2Rpb19pbml0X2NhcmQoc3RydWN0IG1tY19ob3N0DQo+
ID4gKmhvc3QsIHUzMiBvY3IsDQo+ID4NCj4gPiAgCQlpZiAob2xkY2FyZCkNCj4gPiAgCQkJbW1j
X3JlbW92ZV9jYXJkKGNhcmQpOw0KPiA+IC0JCWVsc2UNCj4gPiAtCQkJaG9zdC0+Y2FyZCA9IGNh
cmQ7DQo+ID4NCj4gPiAgCQlyZXR1cm4gMDsNCj4gPiAgCX0NCj4gPiBAQCAtODk4LDE0ICs4OTks
MTUgQEAgc3RhdGljIGludCBtbWNfc2Rpb19pbml0X2NhcmQoc3RydWN0IG1tY19ob3N0DQo+ICpo
b3N0LCB1MzIgb2NyLA0KPiA+ICAJCWdvdG8gcmVtb3ZlOw0KPiA+ICAJfQ0KPiA+DQo+ID4gLQlo
b3N0LT5jYXJkID0gY2FyZDsNCj4gPiAgCXJldHVybiAwOw0KPiA+DQo+ID4gIG1pc21hdGNoOg0K
PiA+ICAJcHJfZGVidWcoIiVzOiBQZXJoYXBzIHRoZSBjYXJkIHdhcyByZXBsYWNlZFxuIiwgbW1j
X2hvc3RuYW1lKGhvc3QpKTsNCj4gPiAgcmVtb3ZlOg0KPiA+IC0JaWYgKG9sZGNhcmQgIT0gY2Fy
ZCkNCj4gPiArCWlmIChvbGRjYXJkICE9IGNhcmQpIHsNCj4gPiAgCQltbWNfcmVtb3ZlX2NhcmQo
Y2FyZCk7DQo+ID4gKwkJaG9zdC0+Y2FyZCA9IE5VTEw7DQo+ID4gKwl9DQo+ID4gIAlyZXR1cm4g
ZXJyOw0KPiA+ICB9DQo+ID4NCg0K
