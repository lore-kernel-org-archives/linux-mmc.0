Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E44C7EE21
	for <linux-mmc@archiver.kernel.org>; Thu,  4 May 2023 11:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjEDLTV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 May 2023 07:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjEDLTT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 May 2023 07:19:19 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2077.outbound.protection.outlook.com [40.107.14.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E10F49C5
        for <linux-mmc@vger.kernel.org>; Thu,  4 May 2023 04:19:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5RdaKmRct7ixJacXNO+mF0O1/Ni0A4y7MNn+lVaJUwDzZreOfIbo7x0EI6NuKfGazt5vU3JJl/6kyMU0xB4PEXcpgUYxzjw62+ImxHtE98umhBsAujo6VCLbIunmALFHULFryWcvFCIDJkjBavQErGStyfWOhXTu3SK+j7KDcU3b69wEYL8ZURxayIiwZANjGht/TWoILmG0RYINQREIf9bII2GgQGoQVOClqjrzpyJYEtrvThborSZhpGh/ycK8noToD0d3BTTtPUsYbtCxKptWWZS+dJW6+wpeKblFwRWf+BzTPnrfCVr6Xn7Afe61rWsvoRFBEnalojLwbuOaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVzxhB1lhmtu50FpryA4q4GWd1bKnzAgsSL3+UmnpFE=;
 b=Iwaf+9XOE7x9vOtFIGqupRQfmmIz5uzcTZ9S0ASdq7aXUPwjNo9h7/4nYzJj3lJPrfxUHZno0VgeEmxhO3W2PgmzfnCZqOT9lHKlmaRN7YPs3FxCR27DSTEVoUxCUD8rCKkFhXwOHLx2rH+7qiijCbfqWIQJLmR3hrxuAZM6UUwy71HCWCTshooG2lK2M+lZ066r5xPJ1M0fbZjI7XRvZOsoSMZkpciZqCYwdOUKBDJVfT18J8effFVgFNr4/QLl2OL7WDzNDY1W33yCbBg9Gp8n/2Ng8ENz4e8QqgnJr+tkKLkeqIJIn0Vk0qHUfTR7WI+ykTFRGmHkYoc/e8JwKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVzxhB1lhmtu50FpryA4q4GWd1bKnzAgsSL3+UmnpFE=;
 b=OzbeRBk+Zc2DZquanJxzJS8H1SdEyI8fCzvE9qMCLMRXF1d0WuH9gKP18cWJEYxi60q8de0xs2dV0p8AE+WhYr9B5HANXzu7UdIbYFuY1AWhLM5R9V/pQUrJIHxD67ree9RhV4xow3/mLm3mu4S8dK+y/NEzUb1oyqVmH6aCToM=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 GV1PR04MB9516.eurprd04.prod.outlook.com (2603:10a6:150:29::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.21; Thu, 4 May 2023 11:19:15 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::9d1e:facb:ae5a:25b6]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::9d1e:facb:ae5a:25b6%3]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 11:19:15 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
Subject: RE: [PATCH] mmc: sdhci-esdhc-imx: make "no-mmc-hs400" works
Thread-Topic: [PATCH] mmc: sdhci-esdhc-imx: make "no-mmc-hs400" works
Thread-Index: AQHZfnnfG7x2A2ixUkOZIy+HDe4Mq69J920A
Date:   Thu, 4 May 2023 11:19:15 +0000
Message-ID: <DB7PR04MB40106AE4E6B96677165C462E906D9@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20230504111836.3599573-1-haibo.chen@nxp.com>
In-Reply-To: <20230504111836.3599573-1-haibo.chen@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|GV1PR04MB9516:EE_
x-ms-office365-filtering-correlation-id: 8be6b235-9b4b-4eca-e4ad-08db4c916501
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4gBf8rOKr6DTBCJg4m9ZBVn9rDXIrizzJMxnUy36zVO91986wpNFaCSUjm6FWHTJCmFFqy2RMN9fhF1uESUSyKzInG9PpYUR37DT113GjYmBePdMi17Prex6PewI4772kyZj7tVLURMofJAdGaKFzIThjzN1G9lY+kfaJ4XI89rmb5HmA2H/sjhE6fvmfGf6Cv652akU+L4gc0TRLN+L61FU8+kO6ImTJbtdhGelmaZwZwVKL3OkMwOFFN/C+E3q49lRsebP7WjpxXvyo1c1dpkTRDf7sn2VG6Uv+oSP5xda5IqhCEMHWcCvxOL6HgNptDmv7OlznjYZE9AXc4B2LS0xZWj953EwNpecDPjxKsd7UAllyrFREIXEMnQ3PQ8xUFYA3a2b2BjV94UD0WFUdUn3iMTC7jyPiX6E/r5fuogSK3ZiQTgVyXAW0/4nq/S3nW6g1nK4dvU99N3uw7LO3FWcAbR8b8hbEmVrp31C2qx8QDwKTr97OUivHrCOI2JRAFj65bj8IIWW0zv+Dff/wyRS9xDOlpPUssPI8vQll8Dsiho7wdI00QmeAXjF4HMVOPzbSMsWLThH6hIbRcjUd2i/oJiQOYHvkldT7msRo3xE/eTzMsNJrBbJFPaDrHkV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(186003)(76116006)(83380400001)(7696005)(6506007)(478600001)(110136005)(71200400001)(41300700001)(54906003)(9686003)(53546011)(26005)(122000001)(52536014)(2906002)(64756008)(33656002)(38100700002)(5660300002)(66476007)(66446008)(66556008)(66946007)(8936002)(8676002)(4326008)(38070700005)(55016003)(86362001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WlRkN1dtV2NxNFI3Mm5sZmg2RXg0OWNhZVIxelM3QVh4S3NNSkp0U3JtMXky?=
 =?gb2312?B?MVpPaStmWkJHbSttZWJiblEzOUxCdEVIOExUTVhJTUFGNkkrVDQvWittZ0k2?=
 =?gb2312?B?c2JjTFFIMmRhSUNGVGhsZkNLOUd6cVlkb3k1RlNNMzV0T2dzOGFKa2dMM1ls?=
 =?gb2312?B?TnBmNUtnTUgwajVhWmwxZ3pZaFNqRmloTTNETFlKVmVEYzdiUVVHWUEzZ2wr?=
 =?gb2312?B?OEgvdmN1dFc1QUVoc2pnNG1lRTBMQ2pjaU1oU2Q3N2RPbUZEOVN6K3ZxQndD?=
 =?gb2312?B?RUtGU3lXb0RYMnBIMVRDOER1amovKzM3RmErejlYdEVDSkF6WE1QV2hjQlNx?=
 =?gb2312?B?RDR6LzRKcUdYOVRhT2xObXBJZkVtMWRQaExsTzVwdU8ybnJlQ291S2xLeXg2?=
 =?gb2312?B?K2VFMGplTFpWcWJIRTExc1I0VUZHN2VURVdDUHRWSXN5S1JYZFRpRGtZV0Ra?=
 =?gb2312?B?ZHhCaUdSbWtnSVVrdFFsVXdyR2tQZEptRHIzNjFIVmh5cjd5UGRjSW5ZeTRn?=
 =?gb2312?B?S0VxTW9QU0JLcjJMU2gyU05pcWRUbW0zUGVRMEdSZlVpekx5MmViOGJpdXBu?=
 =?gb2312?B?cXFGQThaMXQ1M1VxOWc1MlY2SGVkcXVjeU4vUk90WDliNWtEWnkvZzEweDZN?=
 =?gb2312?B?T3pmTWVjUnBoQ1NlMUpPWW4wRnhYOHYrZm1rc1pTSUN1Y1NqanJYZUZraG5Q?=
 =?gb2312?B?WlB5b25aTFY0MzZjL0hSMERPUktPSTFrNUQxRUpJV3JmcHJRKzFuWnhHam91?=
 =?gb2312?B?eGdmYjk0ZkFEUHBkK1JpcHBlVnkvSmd4SndKSTVKaVpXOU14NU1wTDBIa2k0?=
 =?gb2312?B?aUJ3UTR1WWFyLzhIRlNYTmRSTkRudFhpUmMyWGZMVU5pbURBSHNyYWJITTla?=
 =?gb2312?B?Y2MrbE1velVnV1lvMXRTN3lGY1VxS3pPSzAxRWZRa29TYkh3MGxjVjNFUUV3?=
 =?gb2312?B?NEZFS0dlSkhNYWZTbXZzTlc0K21vVXA2Y05lUzQxdkZ5QWJtKzZZWk1pOEtj?=
 =?gb2312?B?aFhzRUVWMTFnTlkzZ2RQdm43WTRoekdjUDZkdXY3VkxqcW5rdEFWWWR3WlNY?=
 =?gb2312?B?VWZKYit4WTJtalFkU1dnMCtzS3FSclVIK3VselhrbjB3a3ZhQm1wb3hRK3Vj?=
 =?gb2312?B?ZmVlekcyVEZVSVoyczIvbXE2US9Ea1BxUmMvRzlXWnFFMVIwamFMbkFUc3hH?=
 =?gb2312?B?MC9oL01iWFFibzZJUHlWSmdra0hkakFXRmFTam9ZRlUvTVlrOVhwTW51NEdU?=
 =?gb2312?B?ZHo0Um9Hc2VNbmNvSk9CR1JmTC9VTjh1eUo5S3BtUm10cFNpaUNJVS94MVM2?=
 =?gb2312?B?MkhaUzRXaStjb0F2VitVY2M4REhqMjFGR0ZIbXhHTFJKbVFSalg5LzR2RjNG?=
 =?gb2312?B?U0pPVGpYN3Q2bEFNWFprcUJ5Q0hKMittU29JSmdrYVBBTWR2RytYdEV4RDNP?=
 =?gb2312?B?OWRPZjZwbzN4Yjc4RzNMb2VHYVdKejJHSDYxSGxCUDExQTNxd3Bqb0g0YjdG?=
 =?gb2312?B?WlhUbkVGQlp3OUkwRlVtYWdZa3o5WUQ3bzNuRDVaZ2xMTXBzOUNWYksvZ2FY?=
 =?gb2312?B?N0dFMkFOTGEvWmpOVlRibHh2RGhSRUM4QTdWc3c5c3c1NXBaZzh3RW5IbWp5?=
 =?gb2312?B?YVZKSHFhcTBTdVdQcjFmbU9SUnBhNWhFTnNPcUdsM2ZlSklhK1E0UUM4UG1Z?=
 =?gb2312?B?Y0tFbUhLcWdiMkJ2TGNjN29NTHppbmg3aEhYUWdScnhhK3FZM1VjaHJmNDYy?=
 =?gb2312?B?L3VuWG5iV0xyM3dkMjNHTjFFdTUxQmRDd2gzQjE2blRKSVQveXpKVGdyWjFB?=
 =?gb2312?B?ekY4TGFUZElvNzROUGUyTEh2elc2dW5PWmJ0RGRtOWRxT1pGZjlINUR5cmxC?=
 =?gb2312?B?SksveTBaNVgxSkVMNWMvUnp3R1haSTJzUWhrSWFUSkhzWml4WVNSQzNiQWZK?=
 =?gb2312?B?SXUrUHEzWFNOanJXK0NWaEptRnZFcThjZEt6b21ONDFycWIxR3JxN1ZxWUR5?=
 =?gb2312?B?VE5uTzVBbmVacXhUTklSS3FwOUNiY1VseGE3c0RLa2V5Y1hKUVBScHFPaUhJ?=
 =?gb2312?B?QkJUN0ZYUngxQnhrVzl2RHpxWFpRZEJkMGk3ZE1zQWhDZHFvRHJ3UG5EWkRP?=
 =?gb2312?Q?POjw=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be6b235-9b4b-4eca-e4ad-08db4c916501
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2023 11:19:15.1080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kEC8GlUABODZRxlZv0wZ+wh1UjIxw9B5I6R6ByA+UevPndPf+xbLiwIgnVlzEwwNrzwY7/qdBFnUZr0QPWuLHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9516
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

U29ycnksIGZvcmdldCB0byBjYyBzdGFibGUgbWFpbGxpc3QsIHdpbGwgcmVzZW5kIGFnYWluLg0K
DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm91Z2ggQ2hlbiA8aGFp
Ym8uY2hlbkBueHAuY29tPg0KPiBTZW50OiAyMDIzxOo11MI0yNUgMTk6MTkNCj4gVG86IGFkcmlh
bi5odW50ZXJAaW50ZWwuY29tOyB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOyBzLmhhdWVyQHBlbmd1
dHJvbml4LmRlDQo+IENjOiBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXgg
PGxpbnV4LWlteEBueHAuY29tPjsgQm91Z2ggQ2hlbg0KPiA8aGFpYm8uY2hlbkBueHAuY29tPjsg
c2hhd25ndW9Aa2VybmVsLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBmZXN0ZXZhbUBn
bWFpbC5jb20NCj4gU3ViamVjdDogW1BBVENIXSBtbWM6IHNkaGNpLWVzZGhjLWlteDogbWFrZSAi
bm8tbW1jLWhzNDAwIiB3b3Jrcw0KPiANCj4gRnJvbTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBu
eHAuY29tPg0KPiANCj4gQWZ0ZXIgY29tbWl0IDFlZDVjM2IyMmZjNyAoIm1tYzogc2RoY2ktZXNk
aGMtaW14OiBQcm9wYWdhdGUNCj4gRVNESENfRkxBR19IUzQwMCogb25seSBvbiA4Yml0IGJ1cyIp
LCB0aGUgcHJvcGVydHkgIm5vLW1tYy1oczQwMCINCj4gZnJvbSBkZXZpY2UgdHJlZSBmaWxlIGRv
IG5vdCB3b3JrIGFueSBtb3JlLg0KPiBUaGlzIHBhdGNoIHJlb3JkZXIgdGhlIGNvZGUsIHdoaWNo
IGNhbiBhdm9pZCB0aGUgd2FybmluZyBtZXNzYWdlICJkcm9wIEhTNDAwDQo+IHN1cHBvcnQgc2lu
Y2Ugbm8gOC1iaXQgYnVzIiBhbmQgYWxzbyBtYWtlIHRoZSBwcm9wZXJ0eSAibm8tbW1jLWhzNDAw
IiBmcm9tDQo+IGR0cyBmaWxlIHdvcmtzLg0KPiANCj4gRml4ZXM6IDFlZDVjM2IyMmZjNyAoIm1t
Yzogc2RoY2ktZXNkaGMtaW14OiBQcm9wYWdhdGUgRVNESENfRkxBR19IUzQwMCoNCj4gb25seSBv
biA4Yml0IGJ1cyIpDQo+IFNpZ25lZC1vZmYtYnk6IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5Abnhw
LmNvbT4NCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gLS0tDQo+ICBkcml2ZXJzL21t
Yy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jIHwgMTggKysrKysrKysrKy0tLS0tLS0tDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+IGIvZHJpdmVycy9t
bWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBpbmRleCBkN2MwYzBiOWUyNmMuLmVlYmY5NDYw
NGE3ZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0K
PiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+IEBAIC0xNjM0LDYg
KzE2MzQsMTAgQEAgc2RoY2lfZXNkaGNfaW14X3Byb2JlX2R0KHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UNCj4gKnBkZXYsDQo+ICAJaWYgKHJldCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gDQo+ICsJLyog
SFM0MDAvSFM0MDBFUyByZXF1aXJlIDggYml0IGJ1cyAqLw0KPiArCWlmICghKGhvc3QtPm1tYy0+
Y2FwcyAmIE1NQ19DQVBfOF9CSVRfREFUQSkpDQo+ICsJCWhvc3QtPm1tYy0+Y2FwczIgJj0gfihN
TUNfQ0FQMl9IUzQwMCB8DQo+IE1NQ19DQVAyX0hTNDAwX0VTKTsNCj4gKw0KPiAgCWlmIChtbWNf
Z3Bpb19nZXRfY2QoaG9zdC0+bW1jKSA+PSAwKQ0KPiAgCQlob3N0LT5xdWlya3MgJj0gflNESENJ
X1FVSVJLX0JST0tFTl9DQVJEX0RFVEVDVElPTjsNCj4gDQo+IEBAIC0xNzI0LDEwICsxNzI4LDYg
QEAgc3RhdGljIGludCBzZGhjaV9lc2RoY19pbXhfcHJvYmUoc3RydWN0DQo+IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCj4gIAkJaG9zdC0+bW1jX2hvc3Rfb3BzLmluaXRfY2FyZCA9IHVzZGhjX2lu
aXRfY2FyZDsNCj4gIAl9DQo+IA0KPiAtCWVyciA9IHNkaGNpX2VzZGhjX2lteF9wcm9iZV9kdChw
ZGV2LCBob3N0LCBpbXhfZGF0YSk7DQo+IC0JaWYgKGVycikNCj4gLQkJZ290byBkaXNhYmxlX2Fo
Yl9jbGs7DQo+IC0NCj4gIAlpZiAoaW14X2RhdGEtPnNvY2RhdGEtPmZsYWdzICYgRVNESENfRkxB
R19NQU5fVFVOSU5HKQ0KPiAgCQlzZGhjaV9lc2RoY19vcHMucGxhdGZvcm1fZXhlY3V0ZV90dW5p
bmcgPQ0KPiAgCQkJCQllc2RoY19leGVjdXRpbmdfdHVuaW5nOw0KPiBAQCAtMTczNSwxNSArMTcz
NSwxMyBAQCBzdGF0aWMgaW50IHNkaGNpX2VzZGhjX2lteF9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KPiAgCWlmIChpbXhfZGF0YS0+c29jZGF0YS0+ZmxhZ3MgJiBFU0RI
Q19GTEFHX0VSUjAwNDUzNikNCj4gIAkJaG9zdC0+cXVpcmtzIHw9IFNESENJX1FVSVJLX0JST0tF
Tl9BRE1BOw0KPiANCj4gLQlpZiAoaG9zdC0+bW1jLT5jYXBzICYgTU1DX0NBUF84X0JJVF9EQVRB
ICYmDQo+IC0JICAgIGlteF9kYXRhLT5zb2NkYXRhLT5mbGFncyAmIEVTREhDX0ZMQUdfSFM0MDAp
DQo+ICsJaWYgKGlteF9kYXRhLT5zb2NkYXRhLT5mbGFncyAmIEVTREhDX0ZMQUdfSFM0MDApDQo+
ICAJCWhvc3QtPm1tYy0+Y2FwczIgfD0gTU1DX0NBUDJfSFM0MDA7DQo+IA0KPiAgCWlmIChpbXhf
ZGF0YS0+c29jZGF0YS0+ZmxhZ3MgJiBFU0RIQ19GTEFHX0JST0tFTl9BVVRPX0NNRDIzKQ0KPiAg
CQlob3N0LT5xdWlya3MyIHw9IFNESENJX1FVSVJLMl9BQ01EMjNfQlJPS0VOOw0KPiANCj4gLQlp
ZiAoaG9zdC0+bW1jLT5jYXBzICYgTU1DX0NBUF84X0JJVF9EQVRBICYmDQo+IC0JICAgIGlteF9k
YXRhLT5zb2NkYXRhLT5mbGFncyAmIEVTREhDX0ZMQUdfSFM0MDBfRVMpIHsNCj4gKwlpZiAoaW14
X2RhdGEtPnNvY2RhdGEtPmZsYWdzICYgRVNESENfRkxBR19IUzQwMF9FUykgew0KPiAgCQlob3N0
LT5tbWMtPmNhcHMyIHw9IE1NQ19DQVAyX0hTNDAwX0VTOw0KPiAgCQlob3N0LT5tbWNfaG9zdF9v
cHMuaHM0MDBfZW5oYW5jZWRfc3Ryb2JlID0NCj4gIAkJCQkJZXNkaGNfaHM0MDBfZW5oYW5jZWRf
c3Ryb2JlOw0KPiBAQCAtMTc2NSw2ICsxNzYzLDEwIEBAIHN0YXRpYyBpbnQgc2RoY2lfZXNkaGNf
aW14X3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJCQlnb3RvIGRp
c2FibGVfYWhiX2NsazsNCj4gIAl9DQo+IA0KPiArCWVyciA9IHNkaGNpX2VzZGhjX2lteF9wcm9i
ZV9kdChwZGV2LCBob3N0LCBpbXhfZGF0YSk7DQo+ICsJaWYgKGVycikNCj4gKwkJZ290byBkaXNh
YmxlX2FoYl9jbGs7DQo+ICsNCj4gIAlzZGhjaV9lc2RoY19pbXhfaHdpbml0KGhvc3QpOw0KPiAN
Cj4gIAllcnIgPSBzZGhjaV9hZGRfaG9zdChob3N0KTsNCj4gLS0NCj4gMi4zNC4xDQoNCg==
