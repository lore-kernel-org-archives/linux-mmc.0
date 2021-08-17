Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2228C4320A
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Aug 2021 06:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AACEF60FD9
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Aug 2021 06:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbhHQGmP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Aug 2021 02:42:15 -0400
Received: from mail-am6eur05on2073.outbound.protection.outlook.com ([40.107.22.73]:60085
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230094AbhHQGmO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Aug 2021 02:42:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfgsBmMQn1LIbnKJHlShrjW4CLado+8YVgL7LIUDjD7tvESCJ1xcJPEKeGfZtP4ncXLVxI+sdUFa60n51SjDGOyPvJm67BmyL+HxbiYaNLQEtm2akXnSilNBZzw22zjgS1/pnKgMSTDZmNd0yhtDad2XODyiu3D+lPdbxKgJSL+FM6pMZNK6xvWXVrnwoPUXC0hrzWvbZT/JIc3SGJXZ2jVhxFdwY+7JyfjDTvbAQAI/5xmEW5F5E3qCwkPtvR3ZrY6PXGQWX0XlH4En6ckXzhio5sfmQaH+vvylKwYEQCsHXenveVMKvygCvhS+1BHJDO3x/q4KTOtCpqMsifwucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdGcI8nOu6aDc/31UaH9kinjepqoW6dGZGxxfwhik4A=;
 b=UIyWfWbYqEw6BueFba+kl8sfH1I/drBRfbk++FTupr8hRT2Chnua/7urAGkSiRe5UsH5+TlzptzZPcnsyKSm0zqjgco+IWrNaY7Fa6fHPcYjcZWuNKiWImPQzTuZOw35P9HWD7OpxU58LlBNkbJhfp6xECizO6IsDYTYBE5bYLrjDli7+hhoZKrLPWP0QmH5ufAJelqxlHWC5sa200QcJJpl8ggo+eaTsFufyXy6ugZ5LeyAtfKp6Gdxi4ha4ploDV+UGQKGx4c0NpEm6KddWit5hv011x18fGXKIhHdEp3i7IcdoDK0vhMV6EcXizqnjEqjlghPK1GWmw0PR28MHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdGcI8nOu6aDc/31UaH9kinjepqoW6dGZGxxfwhik4A=;
 b=iTXhYquqEJcpdC/3nBPWSHRHpWzHAEXMLcTF1NYboGbO5Xhme5PMy6kppdQjLe/78X0rbzCo8kVgmBhYpqdJkmwofurQhknmgmxZbmh89oI+cDEz+6cCPz5r67ekapz0QJr+WeVRpkHPoBzGCEIlm7r1GukdiFpBzlPDG/9G+TM=
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com (2603:10a6:803:5a::22)
 by VI1PR04MB3199.eurprd04.prod.outlook.com (2603:10a6:802:3::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 06:41:39 +0000
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::c59c:3e45:7b94:e5b7]) by VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::c59c:3e45:7b94:e5b7%7]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 06:41:39 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 3/6] dt-bindings: mmc: fsl-imx-esdhc: add
 fsl,sdio-async-interrupt-enabled binding
Thread-Topic: [PATCH 3/6] dt-bindings: mmc: fsl-imx-esdhc: add
 fsl,sdio-async-interrupt-enabled binding
Thread-Index: AQHXkp6tG0/Z3/M/9EqFi1WsjhyfN6t2JAWAgAET8VA=
Date:   Tue, 17 Aug 2021 06:41:39 +0000
Message-ID: <VI1PR04MB529432136DB9F5FEB5F5E98090FE9@VI1PR04MB5294.eurprd04.prod.outlook.com>
References: <1629117508-4886-1-git-send-email-haibo.chen@nxp.com>
 <1629117508-4886-3-git-send-email-haibo.chen@nxp.com>
 <CAPDyKFqagBkbnxxh+KWbV2=sjkj3mGrKXUweOL5TrMJ1-Hmnww@mail.gmail.com>
In-Reply-To: <CAPDyKFqagBkbnxxh+KWbV2=sjkj3mGrKXUweOL5TrMJ1-Hmnww@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 135eae1c-c8e6-4395-5388-08d9614a116c
x-ms-traffictypediagnostic: VI1PR04MB3199:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB3199F2504F0720D00F6D2DC290FE9@VI1PR04MB3199.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mYdzgrAJbbO0Sb1TYwvKYNatXVNDGkbizZGVOMFzvfZzN3BXvRtrgPlMPMMhuAwNwm8+OfAeQ2XH3s6Milwt69mPGOao7LwwzRTuGh0uTNg1yHVcDO3Sf/bJoc9BOVWFCCjfI+JQMg4oovgbWxWOZ/frAks1yee2oy1FM97DBYuH6X2OaESv9P8X8vvr5WKJkAptGsYJPeCgQA7V+z61qtNkcrjLusPSBGREECjHzIqsTHzGSzw8VzyoXb7ZJrT5FkBgfDay9BumZ1F/qU7pK0f92AUJvbsmNtCdZu/FfxtMhRLK39jtWtVsv8aQjX/l9C/GIDZa9LPu36u9tTt3l2Q7wG6f4XIAM9ENo6xFFPiiIzPLthKRV5hDivqxqBRXAuUtVdPUr6tC77Qfv3gneyhlBOm/MBw5RpzO9aP6BqoyuhsBFvunl0Mpgkdd5k8f/yhGPVFMoNzrGcQHXvLGciE53eXbNt5UdtoYF0YNKtcEf6eQSPhcxuVa11ImkphRw79E4HRzBD9zaVE91eaUw6PHMZVI01+sc3+gO7TWxBh6T6rf6c1/6BKt02afulJ9Qemw+SdoOux/XXb8m+fP0wf8ifihAwmoE+9pQaTJ21HbSOGvTiLebyJEPePgmCwJXddiyfOqT7dIhgq5oV+lNcWQYdYqA2VDzYc8Hqczns+YoENphqTXIAFyXax6WKx/h4g86Z06sVNgPGD4KBFQ8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5294.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39850400004)(346002)(136003)(376002)(7696005)(8936002)(52536014)(9686003)(26005)(86362001)(83380400001)(33656002)(5660300002)(6506007)(38070700005)(38100700002)(122000001)(66476007)(66556008)(2906002)(71200400001)(64756008)(66946007)(54906003)(478600001)(66446008)(76116006)(53546011)(316002)(55016002)(4326008)(186003)(8676002)(6916009)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUVpakhzbjBUc2JLREoyN2VYTzBLM1FFaCtnN2NscGZnRE9YR29PWmxXNjhL?=
 =?utf-8?B?VkVlY0tyU0NZbEh5aUZsYzhZbzZoM1QvWmxiNDFQSUhZMXd5SkRXN3NlNFVF?=
 =?utf-8?B?Z1NtdGc0bll1YUlQK1A1bUVzTUZuSDVpQTZVK0N2ZzY5MDNGc3Z6cUNCbVZo?=
 =?utf-8?B?eVVHVXdhTmlod1BMZXd1VUVYeVRPaEkxV0pJL1RQQ041WmNJYU1BcllmdmJX?=
 =?utf-8?B?M20rMlVoWEpnc0xRQUJkcGdZL3UreWZHTndyZU8zT2ZJazA3VUl5enIyRzNs?=
 =?utf-8?B?bHZUWmxjdldJSEc2MWgyb1ZEc2x5d1p2QThQY0tpcTJQN3B1QmthNDdWUTQz?=
 =?utf-8?B?N2hpRkpVTFcvZXhRZXU1WFV6bjhmMGpEL09GckdmTGZ2MlJFWFNDZnhXY2dt?=
 =?utf-8?B?OUoydGFmVk44NHBxSzVsaVZuY3pndWo0VC96V0c5QS82NWtmbVEyUFJTNUgz?=
 =?utf-8?B?SjhrU21OSnFYRjhZMGlRVU1zZ1NCWkx3SGtlK25DYnNQMGdVTGs0d1g1c0tF?=
 =?utf-8?B?TjlCbzlObzdwZjBydnBGVGRqOTlZYVhCZlRKLzF1bWZIbU5CTDFsdjl5Nncr?=
 =?utf-8?B?RVUxY0M3ajVwZENlNHhneUdYSjkzSHhVQVEvZStzMUN1Ynh3bTdaQTh4UFk5?=
 =?utf-8?B?K1BPMUZGZUdydkFtK1lFc1NmUVFGOXN0cUxmM1IwWmcxK1ZRc1NDaUYrTzlJ?=
 =?utf-8?B?VVVUMGhmNFpZM0hIdWVlN0FzbDRmUTdOSm9TWTdiNTdUL1JsTEZ5b3RMMWF4?=
 =?utf-8?B?Nk96YWdpd0xKM0xvV0xkWVB1R3hlbHN6Q2NVSlRkcFVRRDZQRHZEQ05sc016?=
 =?utf-8?B?dGhhdlFZM3NNcE5EOFR0OVJ0RldYaktsbVF3VStkQlNnRFgrM1Bpb21tVWww?=
 =?utf-8?B?eWFWWTB6T0tybGlHcWt4Q2x0empvQkMrUS9NOVJUbUNXaVB4NSszLzZ6V0py?=
 =?utf-8?B?c0FHK21zc2tCTUpQWkRKbTlBRDNYcWZjb0ZZRE5uVGVRd1VHYUEzSlMvN2E0?=
 =?utf-8?B?clcxZjQ4V1p1Vi9TWnpiaklIZW9vdThLL1gyRnRXTnhMNGlienoydUxUaDF2?=
 =?utf-8?B?Sy9PVWdxWjlHTkFyRFF1ZGxTVHdUbnN4UlZvRCtHM1IwS3RaR01SNndNaHE1?=
 =?utf-8?B?VzkxNmtsdWx4Uks3UUJFRFdQcm1mZm9tTlFsclFzaHRqYmxEZ3lvMVplNmR5?=
 =?utf-8?B?alFFczd6cSt2OEs0V1ZiellDZUZwZkRTZlNxUUlKZ25sZjJzY2ozanJoa2Ny?=
 =?utf-8?B?b3BqMmJ2V3RZd0ZnQk5aRTVzVFlLV3VNTkpKSkJnUFNnZUJpWk1xYUV0YVNz?=
 =?utf-8?B?QmZxdHA2Y1YrY2syemV1b1hENTdiSzhwTDRjdXo2aENXblIwbXh1ckVmazZO?=
 =?utf-8?B?L1BndkRxdVNtQ2xQMFM0MUJ4RzI5WUp0dXV6Z2FDMUVCWVFidVZEU0Ftbjkv?=
 =?utf-8?B?NDYzWFZhakg1UXhvek1NSkpmTE0wbEhldEpTQk1HeEtHK2RaNUNreHBuNVhq?=
 =?utf-8?B?RmRXN2xHQmRQSm1OSGZBVFFvbGZ4SVNtY0Fjd2pGdjlMQTRMb0hQaUZ6UVJW?=
 =?utf-8?B?anBwVHQ5VjgwRXp6TW5RUEZBdGFuaDNVMkxVdmlidmxpRTgyWXhJbU1XdDdp?=
 =?utf-8?B?ZUhnNU5icURrVVYvcjBUcmV5amh4OTNGKzZLdll2bGppLzhjRTdHUjRzSVE2?=
 =?utf-8?B?WEpRUjN5d3V2TDB6bW1rL2gzZWNmdEs0bWRJejF5aDIxdXlHYUJRQnZETjhm?=
 =?utf-8?Q?GEAMbpD3YS2vrMq3hn11vWZJGp5NjfLCcffFODc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5294.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 135eae1c-c8e6-4395-5388-08d9614a116c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 06:41:39.5922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoWDLhYuNPZ3punRfZqeQPrSC2F0a+jsDkbqhO80QPi4dkyMGyXgBs0Se9ix1+XSEJ8drG/6Kb/Wh+m8mHyLCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3199
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVbGYgSGFuc3NvbiBbbWFpbHRv
OnVsZi5oYW5zc29uQGxpbmFyby5vcmddDQo+IFNlbnQ6IDIwMjHlubQ45pyIMTbml6UgMjE6NDMN
Cj4gVG86IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gQ2M6IEFkcmlhbiBIdW50
ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgU2hhd24gR3VvDQo+IDxzaGF3bmd1b0BrZXJu
ZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IFNhc2NoYSBIYXVlcg0K
PiA8cy5oYXVlckBwZW5ndXRyb25peC5kZT47IFNhc2NoYSBIYXVlciA8a2VybmVsQHBlbmd1dHJv
bml4LmRlPjsgRmFiaW8NCj4gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPjsgbGludXgtbW1j
IDxsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnPjsNCj4gZGwtbGludXgtaW14IDxsaW51eC1pbXhA
bnhwLmNvbT47IERUTUwgPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsgTGludXgNCj4gQVJN
IDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggMy82XSBkdC1iaW5kaW5nczogbW1jOiBmc2wtaW14LWVzZGhjOiBhZGQNCj4gZnNsLHNk
aW8tYXN5bmMtaW50ZXJydXB0LWVuYWJsZWQgYmluZGluZw0KPiANCj4gT24gTW9uLCAxNiBBdWcg
MjAyMSBhdCAxNTowMCwgPGhhaWJvLmNoZW5AbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9t
OiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+ID4NCj4gPiBBZGQgYSBuZXcgZnNs
LHNkaW8tYXN5bmMtaW50ZXJydXB0LWVuYWJsZWQgYmluZGluZyBmb3Igc2RpbyBkZXZpY2VzDQo+
ID4gd2hpY2ggZW5hYmxlIHRoZSBhc3luYyBpbnRlcnJ1cHQgZnVuY3Rpb24uIFdoZW4gZ2V0IHRo
aXMgcHJvcGVydHksDQo+ID4gZHJpdmVyIHdpbGwgYXZvaWQgdG8gdXNlIERBVFsxXSBmb3IgaGFy
ZHdhcmUgYXV0byB0dW5pbmcgY2hlY2suDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIYWlibyBD
aGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21tYy9mc2wtaW14LWVzZGhjLnlhbWwgICAgICAgICB8IDEwDQo+ICsrKysrKysrKysN
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL2ZzbC1pbXgtZXNkaGMu
eWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9mc2wtaW14
LWVzZGhjLnlhbWwNCj4gPiBpbmRleCBiNWJhZjQzOWZiYWMuLjhhOWYxNzc1YjBlMiAxMDA2NDQN
Cj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL2ZzbC1pbXgt
ZXNkaGMueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
bWMvZnNsLWlteC1lc2RoYy55YW1sDQo+ID4gQEAgLTEyMiw2ICsxMjIsMTYgQEAgcHJvcGVydGll
czoNCj4gPiAgICAgICAgLSBjb25zdDogc3RhdGVfMjAwbWh6DQo+ID4gICAgICAgIC0gY29uc3Q6
IHNsZWVwDQo+ID4NCj4gPiArICBmc2wsc2Rpby1hc3luYy1pbnRlcnJ1cHQtZW5hYmxlZDoNCj4g
PiArICAgIGRlc2NyaXB0aW9uOiB8DQo+ID4gKyAgICAgIFJlY29tbWVuZCBmb3IgU0RJTyBjYXJk
cyB0aGF0IGVuYWJsZXMgU0RJTyBhc3luYyBpbnRlcnJ1cHQgZm9yDQo+IFNEUjEwNCBhbmQgU0RS
NTANCj4gPiArICAgICAgb3BlcmF0aW5nIG1vZGVzLiBTRElPIGFzeW5jIGludGVycnVwdCB1c2Vz
IERBVFsxXSB0byBzaWduYWwgdGhlDQo+IGNhcmQncyBpbnRlcnJ1cHQuDQo+ID4gKyAgICAgIHVT
REhDIHR1bmluZyBtZWNoYW5pc20gbXVzdCB1c2UgREFUWzBdIGFuZCBDTUQgc2lnbmFscyB0byBh
dm9pZA0KPiBhIHBvc3NpYmxlDQo+ID4gKyAgICAgIGNvbmZsaWN0IGFuZCBpbmNvcnJlY3QgZGVs
YXkgbGluZSBjYWxjdWxhdGVkIGJ5IHRoZSB1U0RIQyBhdXRvIHR1bmluZw0KPiBtZWNoYW5pc20u
DQo+ID4gKyAgICAgIEVuYWJsaW5nIHRoaXMgZGV2aWNlIHRyZWUgcHJvcGVydHkgaXMgb25seSBy
ZWNvbW1lbmRlZCBmb3IgbGF5b3V0cw0KPiB0aGF0IGFyZQ0KPiA+ICsgICAgICBtYXRjaGluZyB0
aGUgU0QgaW50ZXJmYWNlIGxlbmd0aC4NCj4gPiArICAgIHR5cGU6IGJvb2xlYW4NCj4gDQo+IFdl
IGFscmVhZHkgaGF2ZSBhIGNvbW1vbiBtbWMgcHJvcGVydHksICJjYXAtc2Rpby1pcnEiLCB0aGF0
IHRlbGxzIHdoZXRoZXINCj4gdGhlIGNvbnRyb2xsZXIgc3VwcG9ydHMgU0RJTyBpcnFzICh3aGlj
aCBpcyBkZWxpdmVyZWQgb24gREFUMSkuDQo+IA0KPiBDYW4ndCB5b3UgdXNlIHRoaXMgaW5zdGVh
ZD8NCj4gDQpIaSBVbGYsDQoNClRoYW5rcyBmb3IgeW91ciBxdWljayByZXBseSENCg0KQWNjb3Jk
aW5nIHRvIG91ciBXaUZpIHRlYW0gcmVwbHksIHRoZSBzZGlvLWlycSBoYXMgdHdvIHR5cGVzLiBT
eW5jIGludGVycnVwdCBhbmQgQXN5bmMgaW50ZXJydXB0Lg0KV2hlbiBXaUZpIHNlbmQgb3V0IHRo
ZSBpbnRlcnJ1cHQgc2lnbmFsIGR1cmluZyB0aGUgaW50ZXJydXB0IHBlcmlvZCwgaWYgaXQgc3lu
YyB3aXRoIGNsb2NrIHBhZChqdXN0IGFzDQp3aGVuIHNlbmQgb3V0IGRhdGEpLCB0aGVuIHRoaXMg
aXMgc3luYyBpbnRlcnJ1cHQuIFdoZW4gdGhpcyBpbnRlcnJ1cHQgbm90IHN5bmMgd2l0aCBjbG9j
aywgaXQgaXMgYXN5bmMNCmludGVycnVwdC4gQXN5bmMgaW50ZXJydXB0IGhhcyBhIGJldHRlciBv
dmVyYWxsIHBlcmZvcm1hbmNlIHRoYW4gc3luYyBpbnRlcnJ1cHQuDQoNCkxvZ2ljYWxseSwgYXV0
byB0dW5pbmcgY2lyY3VpdCBzaG91bGQgb25seSB0YWtlIGNhcmUgb2YgdGhlIGRhdGEgYW5kIGNt
ZCBsaW5lLCBhbmQgaWdub3JlIGludGVycnVwdCBzaWduYWwuDQpCdXQgdW5mb3J0dW5hdGVseSBj
dXJyZW50IGkubXgtdXNkaGMgSVAgZG8gbm90IGlnbm9yZSBpbnRlcnJ1cHQgc2lnbmFsLiBTbyBp
dCBkZXRlY3QgdGhlIGludGVycnVwdCBzaWduYWwsDQphbmQgdGFrZSB0aGlzIHNpZ25hbCBhcyBh
IGRhdGEgc2lnbmFsLCBhbmQgYWRqdXN0IHRoZSBkZWxheSBjZWxsIGFjY29yZGluZ2x5LiBGb3Ig
c3luYyBpbnRlcnJ1cHQsIGR1ZSB0byBpdA0Kc3luYyB3aXRoIGNsb2NrLCBzbyBubyBhZmZlY3Qs
IGJ1dCBmb3IgYXN5bmMgaW50ZXJydXB0LCBpdCB3aWxsIGludm9sdmUgd3JvbmcgZGVsYXkgY2Vs
bCBjaGFuZ2UgcmFuZG9tbHkuDQoNCkkgaW52b2x2ZSBhIG5ldyBwcm9wZXJ0eSBoZXJlLCBiZWNh
dXNlIGluIHNkaGNpLmMsIHdlIGRlZmF1bHQgdXNlIHRoaXMgImNhcC1zZGlvLWlycSIgZm9yIGFs
bCBzZGlvL3NkL21tYy4NCkkgbmVlZCBvbmUgcHJvcGVydHkgd2hpY2ggY2FuIHVzZSBvbmx5IGZv
ciBzZGlvIGRldmljZSwgYW5kIG9ubHkgd2hlbiBzZGlvIGRldmljZSBlbmFibGUgYXN5bmMtaW50
ZXJydXB0Lg0KDQpCZXN0IFJlZ2FyZHMNCkhhaWJvIENoZW4NCg0KPiA+ICsNCj4gPiAgcmVxdWly
ZWQ6DQo+ID4gICAgLSBjb21wYXRpYmxlDQo+ID4gICAgLSByZWcNCj4gPiAtLQ0KPiA+IDIuMTcu
MQ0KPiA+DQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0K
