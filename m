Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBE7C4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Dec 2022 03:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiLTDEk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 19 Dec 2022 22:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiLTDEg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Dec 2022 22:04:36 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2084.outbound.protection.outlook.com [40.107.8.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB43A13DD5
        for <linux-mmc@vger.kernel.org>; Mon, 19 Dec 2022 19:04:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgPCHfO19IZ19hZzCfITEHqrJ/fDVWDO1vcwWrhGLAg7oQZEGEAeztypVHDqGd687ixcDiELXCCKV/5xIJLzd7S93z992hDDr5SPoF2OV2FQGexCCM5Pt9oO5MqpNrn0KEPnNaTnKYt55giHX3QYd7XZHmOBTDS1wkLxpejKqBFmFu/qb845LahuVmtSgp5jLUWQVSmQWeSUQw68D4fY8fqd3r4hap+elxdpuh8i43U0SWNVS3D5bCpERCVvkl6LS9TTJJMGkWhpWLnOJ0QWCeiWmt1E93HW761uYb0GyEVYZrYvH42OhO2F+4F/DZWAu/+U7kZNqT+zsdvZ16lkBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7aPbmi990buQVq9my850b6bREOZSGgxn9rZk3qRLWs=;
 b=cu+bW+WPo/hIqcTtNR761X3rg/mhxSmM2ZzO43QUCaBjypuxeMKXsZ+r7yJm2GDdj/abzaA8ftA7uCUjfOqz7rmJkT/5bJZTrNUTvmz7bbgBQKAtEx5qfX7UXO9cvMBpiDcO45Y94GT27fcKNvWemhOnnvUClSic7lx9COHyFzpxS+ZqIsuli0SCZx/fi2teTjQdW8q9HQah8wemX+42eWAuV32bLFdmzBWo0EFfUGBJclueikASPiVpopsdsFqyrWrz9JgyJortBDeqLh+2DyJBUf3kIhbQCvcD5YREgML09MR/HaRbY0BXuO/5j3uNcV6iGqgTh0QsHgOzzP5lUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7aPbmi990buQVq9my850b6bREOZSGgxn9rZk3qRLWs=;
 b=k6gQ17R4B7OhwreMkdzLzhj71QfiU2jUsx7py3YzUW4saTCJJYZpQPAWUoyw0o7fdZARP1BZJp4uunsk9sbOgrcnGdBLQXsu6VVJa+bhOa+QeVy6Te87j3/nsM1RYyg7AqSqW1LHuPONYB73C4kd5unx9OQCaCCIWU7BN40Gw+U=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 PAXPR04MB9400.eurprd04.prod.outlook.com (2603:10a6:102:2b2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16; Tue, 20 Dec 2022 03:04:32 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 03:04:32 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Marek Vasut <marex@denx.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Zach Brown <zach.brown@ni.com>
Subject: RE: [PATCH] [RFC] mmc: sdhci: Always apply sdhci-caps-mask and
 sdhci-caps to caps
Thread-Topic: [PATCH] [RFC] mmc: sdhci: Always apply sdhci-caps-mask and
 sdhci-caps to caps
Thread-Index: AQHZFBXReIdYOpZu+0iR69srOCDoq652FGwg
Date:   Tue, 20 Dec 2022 03:04:32 +0000
Message-ID: <DB7PR04MB4010BE5749B5C9949A691C1990EA9@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20221220015254.796568-1-marex@denx.de>
In-Reply-To: <20221220015254.796568-1-marex@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|PAXPR04MB9400:EE_
x-ms-office365-filtering-correlation-id: dfaefe0d-60b1-4f14-6488-08dae236eada
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4h17mB2i1fKYJc9Ecq+FxIVeGDW24Umpv3QFokE6HKllOZkGBI4iV3UNbeFrgxjwJrtjk+L2CljkIXwl3JrG0RLzy4lG7EGOc0yUFyzCZslZmGZoG7yV2kHfmpZTppI5o+4CfHAxjAm3X/5WHMY+H7GCF4O/fz5lr0uXJpOw/Ya/S0BsrTgBa2n1XK1ec8Nf0K1MFU1/dAdgOLWP/9tmV082m0BIodC142MEjlbMn3+kRnbgmilVzVSmVyJYdxFXFqAXsBcVKD+28rlWUO/FOKesvQIEzEyNkXUiZZtIGxELUGmjxf9NxPfAJ5mqfShDCoiFEiNfHg5CMuE9dqPT5ocRYICFc/4pANXY5knHSlI9MPfFHjKTqZDXV2U7vnVS5iI03s6d27lI2QWe+MRtk/DqyQ2m8LQ8tRYzOZeD9maPYE2NfkkLwW9eGnMZltz8J5pGEPpyQc4cPWssFDXYvmUx1nM316D++37dWiL9BkN+cE/Lqh84mEkALnKABmCf//VrqdNggig283BsZ1JzNn40ZLBe8AqtmU+F3Agj9FkR1ZPwOkQukeWrdTGVfkZwdm8dN7sXlpTKeAHiU+EYKK4Bx0E4uk6S0o8YM4C+O8n53UDh2deQM0m63oMcxy2kU+yy5W8VNqUhXLeRIw60ooRsecm7JebACUhmzJjfYoSdYu8yJI+/Ixoogu6iWuvkJ6tM1KEEmvdzvJqQyLr7SQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199015)(38100700002)(86362001)(26005)(2906002)(71200400001)(186003)(110136005)(53546011)(6506007)(7696005)(478600001)(52536014)(8936002)(33656002)(316002)(122000001)(55016003)(9686003)(54906003)(66946007)(76116006)(8676002)(66446008)(66476007)(38070700005)(41300700001)(66556008)(83380400001)(5660300002)(4326008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RUZZSEVzK3NVNXpWeVhPQTRGc3d1aWRlRzIvaUN3S2liZWY2MkxGSzExVFlt?=
 =?gb2312?B?ZjZwalQwd0Zndzd1M1orci9OemJIeGlEVGc0aFZhK2FaaVpuYW9KUG1RNUdU?=
 =?gb2312?B?WWZsZmQzamN4YzBSUXVkVG5qa1NBRURGTHBrQmhNbkJoYTJZTlhOY0FhM1lI?=
 =?gb2312?B?QjQ4NkRuRW1NZ3Ftbk9pU0l3OUNQUm1tbUh6Vlk5VUJhYVFTcEdSYnBPSWpT?=
 =?gb2312?B?U0lDdGJ3NHZkRm1HLzRKQzhPTUVjNEo5b0VjTWRhT01MSGNkOXNRNXJKUlhh?=
 =?gb2312?B?UDZIQmxDZHc2cm5zVFgwK2xmZ1lWdVhCNXJHRTN2SjNIbzJNMnA5QUlydHdO?=
 =?gb2312?B?bnlScXplaG5FeUFlNERha0xEVVpBRkIrZ3RCbkN6TE0yK0t0dC9aYy83TjZa?=
 =?gb2312?B?WTFLei9xcS83RWhqeFlObUFlL1JrcVB1RHNDTjhBOEdja1cxSTIxelZvT29m?=
 =?gb2312?B?L2F0MExUcHovVThQbXVWRGZkSHIrNU43VmV3VEl4MHRCcHNhT2JNTTNLTkFr?=
 =?gb2312?B?ZDZWVnVuRllRclhBVUVpQVhQMXpRRjVxN1FXTlpaSEZWNUlzaThzdmV1cjVM?=
 =?gb2312?B?b2ZIc0szS2FtUTh2bS8xOGljYldyV3BRYmpHT29nakVROHk4cnlpQXpuVGtp?=
 =?gb2312?B?cmJCSjdjTmhoRk9LVjhOQ2U1bzFWTjlKUGF4MFExT2d2YzMzN1NQK0xsWHRW?=
 =?gb2312?B?dVgyUnNzNENxMnNDSUJTOThHeU9DZmwvSjhlekZJZDNBK2NQdTZualZzYlF1?=
 =?gb2312?B?VkR3OUgvdWM0VSt0VTVqMEpSczRJc2V1M2l4YnZaMGVLZDI3em93bmJhbTVF?=
 =?gb2312?B?QjhWY3d3WWJzY0ppSXJDNEd1bkIyZFRzSmVRTG1OTDV1TjJsUFo5RW91THI1?=
 =?gb2312?B?RlJ0ZDVKTU5HMkZiNHFnSXJpMjBGNlg3SnBQalBYMVpoU2FVV1plc1ErM2cy?=
 =?gb2312?B?NXJBUVBQZG5rdVdoRFNqeG10TmFQZUN2NTRMN2pFbWdYdnByOUlXM0IxQ0NX?=
 =?gb2312?B?TzFiKzVNOVUwdlVnUUViQWxSbWJoWTBRcE1XdDBlSHE2QnYxNHV5aWduVGxD?=
 =?gb2312?B?VHZGU3ZPY1Q0SG5tMGVNT2pYNTg0NE9LT2FjSG1jODlXN3kySitxZ0FXaVAw?=
 =?gb2312?B?NlRrV3VweE56RXNBWmM1S010L2NxNGF0TEhGNTJTcm4vaTZDeGRDT0RuVG5V?=
 =?gb2312?B?WStwbTZMVXRXNFVLKzJTUlcxZlBrOWkyM0ZuUzhuTExkbkVmNVhiKzlsazBn?=
 =?gb2312?B?T0x2SjVKd2pXeE51ZGJOVExlbHhGdFRBTnRxZmpZV0t6WUQxRDBYYkRsbVUz?=
 =?gb2312?B?NExRSHJzb1pHS1BrZFdVKzhjeVhzNm9WeXR4bUdZVFlpdk1IVXJpRyt3OTZR?=
 =?gb2312?B?UW13c1M0K3E2OVptRGw4NldvVVNzRWliaXVtTTBFd1pqNGZ3b25rRFVaZ0Vn?=
 =?gb2312?B?N3R5VUIwY2Y1RXBxNG5tZVMxSUVSZ1lnNHozS2lNT3VNeHcxQ3RzeXdOYjFZ?=
 =?gb2312?B?UURjWGZkRzZiYk5uelEzTnBTVTBkSTVDc3liSHlxMkFIR2ZCYTE1bVZwcElF?=
 =?gb2312?B?ZmQyaWlxdGVtY1c1Y01HanlwcDRuZHpMelFsTEcrekkxaHFwSFo1U1lrS2pZ?=
 =?gb2312?B?NHZlc1paSnZWL1lGQmFQNnNqYXN6N3d5SmIyTmlJaFJIb0ZWeWovUlFmaXBM?=
 =?gb2312?B?QkRodmxwS0JNMEFBeWcwV0M3M2pmN2R0NDJrdDZCU2ZWOUlCdmJUcFJNRHpS?=
 =?gb2312?B?SjZpOHBQVHZwRUJwK2EzWExhVFJ2RHVBZm1DalF3L3ZZa21WMGU4TUxZS2Fr?=
 =?gb2312?B?YlpOaVBRTWNHb1JCN1duVVVIeDE5OHpsc1duYmROZHAxTkl4dWR0TmFXYnlV?=
 =?gb2312?B?UFoxRGhiSDFKcXdiMUY5ME5jQnVaMC9neGJVdllxczMyWXB6VFNXMXpMZ0Jh?=
 =?gb2312?B?WmJtSU1ERFJiclVnRkd6K3hFSUgyN2l1TUV6TlBSNm13NnY0U1YvQjNDZnpS?=
 =?gb2312?B?K3NyeFUzOFAvaW1ubHg1OFNoSnIva1p2bldpN1pmS001Q0RFSVRMT0RjT01x?=
 =?gb2312?B?NGhzRlQwUjlVaXlhRzQ3VC9mMjBqMGY4WXZpaUlmU0owaXU2TERFQnNNQlJs?=
 =?gb2312?Q?Y5j7ZZpaavo3bbB0VeXrIDqeu?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfaefe0d-60b1-4f14-6488-08dae236eada
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 03:04:32.2170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qC5ds3sY0mVH1VXVlRL5p80rjDnjhgNhpoOijFmlEQwB5lrKCvyTtvsgg6sgwWUAhgjpWZGizeYr2jPGfzx4xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9400
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJlayBWYXN1dCA8bWFyZXhA
ZGVueC5kZT4NCj4gU2VudDogMjAyMsTqMTLUwjIwyNUgOTo1Mw0KPiBUbzogbGludXgtbW1jQHZn
ZXIua2VybmVsLm9yZw0KPiBDYzogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+OyBBZHJpYW4g
SHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47DQo+IFVsZiBIYW5zc29uIDx1bGYuaGFu
c3NvbkBsaW5hcm8ub3JnPjsgWmFjaCBCcm93biA8emFjaC5icm93bkBuaS5jb20+DQo+IFN1Ympl
Y3Q6IFtQQVRDSF0gW1JGQ10gbW1jOiBzZGhjaTogQWx3YXlzIGFwcGx5IHNkaGNpLWNhcHMtbWFz
ayBhbmQNCj4gc2RoY2ktY2FwcyB0byBjYXBzDQo+IA0KPiBUaGUgb3JpZ2luYWwgaW1wbGVtZW50
YXRpb24gaW4gdGhlIGNvbW1pdCByZWZlcmVuY2VkIGJlbG93IG9ubHkgbW9kaWZpZXMNCj4gY2Fw
cyBpbiBjYXNlIG5vIGNhcHMgYXJlIHBhc3NlZCB0byBzZGhjaV9yZWFkX2NhcHMoKSB2aWEgcGFy
YW1ldGVyLCB0aGlzIGRvZXMNCj4gbm90IHNlZW0gY29ycmVjdC4gQWx3YXlzIG1vZGlmeSB0aGUg
Y2FwcyBhY2NvcmRpbmcgdG8gdGhlIHByb3BlcnRpZXMgZnJvbSBEVC4NCj4gDQo+IDkyZTBjNDRi
OTJlNCAoIm1tYzogc2RoY2k6IFVzZSBzZGhjaS1jYXBzLW1hc2sgYW5kIHNkaGNpLWNhcHMgdG8g
Y2hhbmdlDQoNCk5lZWQgdG8gYWRkIEZpeGVzIGFzIGJlbG93Og0KRml4ZXM6IDkyZTBjNDRiOTJl
NCAoIm1tYzogc2RoY2k6IFVzZSBzZGhjaS1jYXBzLW1hc2sgYW5kIHNkaGNpLWNhcHMgdG8gY2hh
bmdlIHRoZSBjYXBzIHJlYWQgZHVyaW5nIF9fc2RoY2lfcmVhZF9jYXBzIikNCg0KSSBkaWQgYSBn
cmVwIHVuZGVyIHRoZSAvZHJpdmVycy9tbWMvaG9zdCwgc2VlbXMgYWxsIGNhbGxlcnMgdXNlIE5V
TEwgZm9yIHRoZSBwYXJhbWV0ZXIgY2FwcyBhbmQgY2FwczEsDQpTbyBtYXliZSB3ZSBjb3VsZCBq
dXN0IHNpbXBsaWZ5IHRoZSBjb2RlIGxpa2UgdGhpczoNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bW1jL2hvc3Qvc2RoY2kuYyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYw0KaW5kZXggZjNhZjFi
ZDBmN2I5Li4wZWQ4YzViMzZlY2IgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNp
LmMNCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYw0KQEAgLTQwOTAsOCArNDA5MCw3IEBA
IHN0YXRpYyBpbnQgc2RoY2lfc2V0X2RtYV9tYXNrKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KQ0K
ICAgICAgICByZXR1cm4gcmV0Ow0KIH0NCg0KLXZvaWQgX19zZGhjaV9yZWFkX2NhcHMoc3RydWN0
IHNkaGNpX2hvc3QgKmhvc3QsIGNvbnN0IHUxNiAqdmVyLA0KLSAgICAgICAgICAgICAgICAgICAg
ICBjb25zdCB1MzIgKmNhcHMsIGNvbnN0IHUzMiAqY2FwczEpDQordm9pZCBfX3NkaGNpX3JlYWRf
Y2FwcyhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgY29uc3QgdTE2ICp2ZXIpDQogew0KICAgICAg
ICB1MTYgdjsNCiAgICAgICAgdTY0IGR0X2NhcHNfbWFzayA9IDA7DQpAQCAtNDEyNCwyNCArNDEy
MywxNiBAQCB2b2lkIF9fc2RoY2lfcmVhZF9jYXBzKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCBj
b25zdCB1MTYgKnZlciwNCiAgICAgICAgaWYgKGhvc3QtPnF1aXJrcyAmIFNESENJX1FVSVJLX01J
U1NJTkdfQ0FQUykNCiAgICAgICAgICAgICAgICByZXR1cm47DQoNCi0gICAgICAgaWYgKGNhcHMp
IHsNCi0gICAgICAgICAgICAgICBob3N0LT5jYXBzID0gKmNhcHM7DQotICAgICAgIH0gZWxzZSB7
DQotICAgICAgICAgICAgICAgaG9zdC0+Y2FwcyA9IHNkaGNpX3JlYWRsKGhvc3QsIFNESENJX0NB
UEFCSUxJVElFUyk7DQotICAgICAgICAgICAgICAgaG9zdC0+Y2FwcyAmPSB+bG93ZXJfMzJfYml0
cyhkdF9jYXBzX21hc2spOw0KLSAgICAgICAgICAgICAgIGhvc3QtPmNhcHMgfD0gbG93ZXJfMzJf
Yml0cyhkdF9jYXBzKTsNCi0gICAgICAgfQ0KKyAgICAgICBob3N0LT5jYXBzID0gc2RoY2lfcmVh
ZGwoaG9zdCwgU0RIQ0lfQ0FQQUJJTElUSUVTKTsNCisgICAgICAgaG9zdC0+Y2FwcyAmPSB+bG93
ZXJfMzJfYml0cyhkdF9jYXBzX21hc2spOw0KKyAgICAgICBob3N0LT5jYXBzIHw9IGxvd2VyXzMy
X2JpdHMoZHRfY2Fwcyk7DQoNCiAgICAgICAgaWYgKGhvc3QtPnZlcnNpb24gPCBTREhDSV9TUEVD
XzMwMCkNCiAgICAgICAgICAgICAgICByZXR1cm47DQoNCi0gICAgICAgaWYgKGNhcHMxKSB7DQot
ICAgICAgICAgICAgICAgaG9zdC0+Y2FwczEgPSAqY2FwczE7DQotICAgICAgIH0gZWxzZSB7DQot
ICAgICAgICAgICAgICAgaG9zdC0+Y2FwczEgPSBzZGhjaV9yZWFkbChob3N0LCBTREhDSV9DQVBB
QklMSVRJRVNfMSk7DQotICAgICAgICAgICAgICAgaG9zdC0+Y2FwczEgJj0gfnVwcGVyXzMyX2Jp
dHMoZHRfY2Fwc19tYXNrKTsNCi0gICAgICAgICAgICAgICBob3N0LT5jYXBzMSB8PSB1cHBlcl8z
Ml9iaXRzKGR0X2NhcHMpOw0KLSAgICAgICB9DQorICAgICAgIGhvc3QtPmNhcHMxID0gc2RoY2lf
cmVhZGwoaG9zdCwgU0RIQ0lfQ0FQQUJJTElUSUVTXzEpOw0KKyAgICAgICBob3N0LT5jYXBzMSAm
PSB+dXBwZXJfMzJfYml0cyhkdF9jYXBzX21hc2spOw0KKyAgICAgICBob3N0LT5jYXBzMSB8PSB1
cHBlcl8zMl9iaXRzKGR0X2NhcHMpOw0KIH0NCiBFWFBPUlRfU1lNQk9MX0dQTChfX3NkaGNpX3Jl
YWRfY2Fwcyk7DQoNCg0KQmVzdCBSZWdhcmRzDQpIYWlibyBDaGVuDQoNCj4gdGhlIGNhcHMgcmVh
ZCBkdXJpbmcgX19zZGhjaV9yZWFkX2NhcHMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJlayBWYXN1
dCA8bWFyZXhAZGVueC5kZT4NCj4gLS0tDQo+IENjOiBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVu
dGVyQGludGVsLmNvbT4NCj4gQ2M6IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3Jn
Pg0KPiBDYzogWmFjaCBCcm93biA8emFjaC5icm93bkBuaS5jb20+DQo+IFRvOiBsaW51eC1tbWNA
dmdlci5rZXJuZWwub3JnDQo+IC0tLQ0KPiBOb3RlOiBJIGFtIHNlbmRpbmcgaXQgYXMgYW4gUkZD
LCBiZWNhdXNlIGl0IHNlZW1zIEkgbWlnaHQgYmUgbWlzc2luZw0KPiAgICAgICBzb21ldGhpbmcg
b2J2aW91cy4NCj4gLS0tDQo+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMgfCAyMCArKysrKyst
LS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMTQgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jIGIv
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jIGluZGV4DQo+IGYzYWYxYmQwZjdiOTUuLjUyNzE5ZDMx
MThmZmQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYw0KPiArKysgYi9k
cml2ZXJzL21tYy9ob3N0L3NkaGNpLmMNCj4gQEAgLTQxMjQsMjQgKzQxMjQsMTYgQEAgdm9pZCBf
X3NkaGNpX3JlYWRfY2FwcyhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwNCj4gY29uc3QgdTE2ICp2
ZXIsDQo+ICAJaWYgKGhvc3QtPnF1aXJrcyAmIFNESENJX1FVSVJLX01JU1NJTkdfQ0FQUykNCj4g
IAkJcmV0dXJuOw0KPiANCj4gLQlpZiAoY2Fwcykgew0KPiAtCQlob3N0LT5jYXBzID0gKmNhcHM7
DQo+IC0JfSBlbHNlIHsNCj4gLQkJaG9zdC0+Y2FwcyA9IHNkaGNpX3JlYWRsKGhvc3QsIFNESENJ
X0NBUEFCSUxJVElFUyk7DQo+IC0JCWhvc3QtPmNhcHMgJj0gfmxvd2VyXzMyX2JpdHMoZHRfY2Fw
c19tYXNrKTsNCj4gLQkJaG9zdC0+Y2FwcyB8PSBsb3dlcl8zMl9iaXRzKGR0X2NhcHMpOw0KPiAt
CX0NCj4gKwlob3N0LT5jYXBzID0gY2FwcyA/ICpjYXBzIDogc2RoY2lfcmVhZGwoaG9zdCwgU0RI
Q0lfQ0FQQUJJTElUSUVTKTsNCj4gKwlob3N0LT5jYXBzICY9IH5sb3dlcl8zMl9iaXRzKGR0X2Nh
cHNfbWFzayk7DQo+ICsJaG9zdC0+Y2FwcyB8PSBsb3dlcl8zMl9iaXRzKGR0X2NhcHMpOw0KPiAN
Cj4gIAlpZiAoaG9zdC0+dmVyc2lvbiA8IFNESENJX1NQRUNfMzAwKQ0KPiAgCQlyZXR1cm47DQo+
IA0KPiAtCWlmIChjYXBzMSkgew0KPiAtCQlob3N0LT5jYXBzMSA9ICpjYXBzMTsNCj4gLQl9IGVs
c2Ugew0KPiAtCQlob3N0LT5jYXBzMSA9IHNkaGNpX3JlYWRsKGhvc3QsIFNESENJX0NBUEFCSUxJ
VElFU18xKTsNCj4gLQkJaG9zdC0+Y2FwczEgJj0gfnVwcGVyXzMyX2JpdHMoZHRfY2Fwc19tYXNr
KTsNCj4gLQkJaG9zdC0+Y2FwczEgfD0gdXBwZXJfMzJfYml0cyhkdF9jYXBzKTsNCj4gLQl9DQo+
ICsJaG9zdC0+Y2FwczEgPSBjYXBzMSA/ICpjYXBzMSA6IHNkaGNpX3JlYWRsKGhvc3QsIFNESENJ
X0NBUEFCSUxJVElFU18xKTsNCj4gKwlob3N0LT5jYXBzMSAmPSB+dXBwZXJfMzJfYml0cyhkdF9j
YXBzX21hc2spOw0KPiArCWhvc3QtPmNhcHMxIHw9IHVwcGVyXzMyX2JpdHMoZHRfY2Fwcyk7DQo+
ICB9DQo+ICBFWFBPUlRfU1lNQk9MX0dQTChfX3NkaGNpX3JlYWRfY2Fwcyk7DQo+IA0KPiAtLQ0K
PiAyLjM1LjENCg0K
