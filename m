Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCEFC47082
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 11:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E41186128A
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 11:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhFHLYG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Jun 2021 07:24:06 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:19584 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhFHLYG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jun 2021 07:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623151334; x=1654687334;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=7mLqo16CbMJg6KH5vGPUIKkqnAGaHrzNXSsv2rK/bgI=;
  b=iF+WneOXaz+fvbbsPvPV83qf3dlUNFbrEfzWnTPNlUR5yBpe6RCsgiYh
   Xm1XdXIqb1LuYlgrVkoElvcfQ0kk3cEG5vlenKbOMOq8i2eesFuI0VTE1
   PwxzL0D/RytX71uuqGikyn+JmOoqa+R62p6ixHPKiS9JaK1BSjvc7k5Xc
   fDL1qQOZxP0C4XZeKEM5woVFI8yu3e+fMF6On8z9Qf55xeAaK/1p+n6a9
   xKptGSFDMvVbKMW3O8RZnlpnignXHaJ2BLcdrZexTp+rccwxsnuAyme8u
   YZ6xwDQF1p+AqBZ32rZ0vVPApnTdKY+3DAPm7Xuu8GPoe8nt1YAiMdex8
   Q==;
IronPort-SDR: YdrP9OhNagt6ONRvytOZrimCd9QDzHsFmdDfzKdGQ/I1LFGoX16CKqcj2SG1rx5+AQ491hK0fZ
 RjEePQE94w3Bkhq7TfDdldZJ2K1pBsqjCFaDib0bvPIUgVbvwAC0AGnvpHQqNyMb02E3REtLwJ
 mlUiNlAw0e33F4LwufnBIDXwWH+/BNknRyM4BDRj6Bt18sEvEFvfFdsTGXulGScoWuaNbKiurK
 97GOuzztzICKrs1rw4YKhBOCcWqSMxJz4R6OGch5LL73m3AgCIndYOwGOkIDOPPCBzPZ/EL7IK
 4vc=
X-IronPort-AV: E=Sophos;i="5.83,257,1616428800"; 
   d="scan'208";a="171690512"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2021 19:22:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTOH3XyPeBlPrbs5XsWyjRD0p+6vomcKgt3OapRYDLPzIgJtOM9womWgl6MLcKIno/eYzDfsIEoevzGWbW52KEwmyWb+u9J97LwtxxNgysROxkVz5xYynFzzq/gimlnzTUl8AbX8shajUQQ/b8qbyUCpcGA/E9aMwfYcONSEgTNsRNFpEVb1hVNiX7NRacNuzzPlA+To38etKjzJ4Lq9wfJUm3OZMDJanMaIei6Gm8lilUqD+nlkbF3jTb86Jw3NH+eWejjacmN2raRsRsxQWqR6dZ/+LAoOa/z7qBvL8VUKow2YJoOiTb+bkSm/9PMQvzNZr0LY0scgwqfjK/YZmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mLqo16CbMJg6KH5vGPUIKkqnAGaHrzNXSsv2rK/bgI=;
 b=hEZYk1H7MhAbB0QHPDAgNqXGv2cSR1kCkezJuPHabn+uH/H+Umqj7LMf05grC9SbixRgUFcCC41VW7ujyzxbcGjBdlkO4L6liWEBN7QJG2s2c2r8g13om4Uqkz56P4v09aJfN1W8MNeJ4Q68rrJRBGlz6f9FJpawnquX9+D7BTdDD6XuTyAFkaSqnDHhDX0DwjgTOhbIVGlrZsK/j/GazZox0ODYLVdm/Mf63rxjaUfRIVUJZmQS57UZG0X7s8NiCuJ4jv2akHITQtE9i6YPgWRtBsEZsQ+uZogY8r/GYuNdxqiRqbKUUQaGOq/MJk2wbWUjGGLeHFVbgFMpD8zo4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mLqo16CbMJg6KH5vGPUIKkqnAGaHrzNXSsv2rK/bgI=;
 b=PrGza+kwvmBu8Dam+5zwtwbH2LubVZFANUmXcKcTScFR+z/VAxbOu1T22arbZRelp5gGzqyBiJlLasWs6hwthJNyrexy0SvFTAhqn474JjQGuf2mDBJEHDymkS8ZPPzF7ep0yTrbwk8fySDPNRMsFNFS9bismHBT+hbr2fkUuuM=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB5451.namprd04.prod.outlook.com (2603:10b6:5:109::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.20; Tue, 8 Jun 2021 11:22:12 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::78af:772c:a69a:95a0]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::78af:772c:a69a:95a0%9]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 11:22:11 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?utf-8?B?Q2hyaXN0aWFuIEzDtmhsZQ==?= <CLoehle@hyperstone.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
Subject: RE: PATCH] mmc: block: ioctl: Poll for TRAN if possible
Thread-Topic: PATCH] mmc: block: ioctl: Poll for TRAN if possible
Thread-Index: AQHXXD2WfUw9V7TgJkajnPZV25duWqsJ9ukQ
Date:   Tue, 8 Jun 2021 11:22:11 +0000
Message-ID: <DM6PR04MB657541577A86E4000061E810FC379@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <CWXP265MB26809A40B098D219C44E70FAC4379@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <CWXP265MB26809A40B098D219C44E70FAC4379@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hyperstone.com; dkim=none (message not signed)
 header.d=none;hyperstone.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd8b227c-6462-40a5-0fc5-08d92a6fa934
x-ms-traffictypediagnostic: DM6PR04MB5451:
x-microsoft-antispam-prvs: <DM6PR04MB545112BD54EABDEF2A026F4EFC379@DM6PR04MB5451.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BgPfVbTxNAHxu+BgsjrOcU4uXkwnYIvK/h95wUE3p+n1aLyrYpGTbRkkj6cKOUqRHHDovyWkUoMjZhjS/DPEB8pdtsVNJ30DvU8KonQLMTixuHWwvr216y3XMS8ByqRM1S+F3GSt+WzyvzxC+WGpkcC12Oi3c3ZMfF5A5ntXGTAx4BOeBbKRMcMHAKVQCaMY7umt+S3Vq9yFnDbEJYb7XX2I3Og/cf5/UF7d23pdh4itmJKgyxmbC4AOg4oYv6Pk/sZdyjcyBzuWy9du7D5p7BAZ1bHucgDtgIiQSPIkK/bp/GxMDOF6xuwY6/+lVzpcvWk2GpGGAvc600kTsvyGUMSbTs3RdTFhYV24613SBmy8Xr8WAsxLtEaIyIM9TOXrIynPyXRLk13YN3s9ZkhJbrTogqu6cF9miUenEVKGvOhRzL9tdpohTpAKw2sNwqn2DoUWjZBWdA+IjuReFWMb39zuh4hKC9IthQmwsq6gY5YS4v+6E+ymFQrpJ/A+57y92p+4H0xuV2iHIX0NwNUCH9BXVSWsCIsS1TBur0MCohrJrdxmqnVdPmqWXEq66in66GPwO4A3A2gP7ENgQxzcU20JBJstrY4KPRVgNQmQwJ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(186003)(26005)(110136005)(2906002)(498600001)(83380400001)(7696005)(64756008)(122000001)(38100700002)(66946007)(52536014)(66476007)(66556008)(66446008)(55016002)(71200400001)(5660300002)(8676002)(86362001)(9686003)(6506007)(76116006)(4744005)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVJ0Wk1EL0Ira0s5cVQ1YjZTMHV3R01NMTZIZEFXdnFEY3A3c1NUR2JPQlh3?=
 =?utf-8?B?YUdOVmZEbFNoS05WYlJpcEl2WkZ0WW1LQVhpcUpBYmQzTkl4cnVySmN3VkFZ?=
 =?utf-8?B?V3l4cExMYmdzNzM3dkszK3BHb3VtYWg1UnNENlZiaFZvYWhzRmlaR2c0cmV2?=
 =?utf-8?B?N0JvYmIzN05Dd3BIRWp5KzkyQmxnTmhGaDFheUpTcnNDNXlOaVhsV0VTSmJr?=
 =?utf-8?B?cXJMdnJvaG5CcWt4TU9rMW1maDFyOGpKTWRIQTROYlhuSlJaTEFucVY4K25R?=
 =?utf-8?B?UzBSRGhZd3JQSFBYaHBSWGpweUUxQWIwTWdCY01oakVJT3hkWVRVUklVU1BJ?=
 =?utf-8?B?emNGZXpRaktJZ0RpM0RjNHJRaHRBU2tSajFHNjJUcDljcHVPZk5CRHdMZjJm?=
 =?utf-8?B?d0NVRjVLNThUQ0xOQkFvR0tyTUlkQXVDaWFCb3FLZ1diSXRvVVFLNjhuQ2xD?=
 =?utf-8?B?QXc2enc0dW1DaTMwbXFSa0lTMlJDVFFVTXhNUkN3Z3E4UWFzcnh3MzlvTGZz?=
 =?utf-8?B?bWo2YmI5M3pPc2E0WWo0VE1obHUrcXk0RFd4ODdhS2k5OU0wZERISFMzcVdN?=
 =?utf-8?B?bzErZ0RxSHVEOFllQ2JvbUhtcGpVWm8rU3ZsYzBoSTNLdkd2alJyRlFrWiti?=
 =?utf-8?B?dGswSHFuUEtvZUxwZUhDdFBwb0VUNkh3RStwRk5UQ0RTS1BZSDFVWEJhL0hO?=
 =?utf-8?B?azlha3VUMzhMcFBnNHlBZzFDQ29rSmJIRFcrY1Q5Zjl0WTZnMkxPSE9pcmsz?=
 =?utf-8?B?QjA5aHhoeHRyZEFPbis4SFpmNFRVSDljcC8xb292UFNzYXBtMkh5UTcyWTk4?=
 =?utf-8?B?SVNoSHNuRTV0SmdJOXdQQmFzdDl0TXpGQy9ZMnpISnhCYnIwSjNGemJhOXZw?=
 =?utf-8?B?Qjl5b0JZZGd1Tlg3QnRJR1NabUNlYkYrSGRQUmZDVUk1NW1KV2lMU29zbnNq?=
 =?utf-8?B?UmhsN0NxRmZtWWYvd0RGSEJDYW1xR0kvRkw0VWRIbFhhMjdURnhHTkVKYVIv?=
 =?utf-8?B?K0NFY1l0d3I2UGsvbW9xcVlrQkE2YU9oMUN2dFR0eW1oTHRmQW4xaFZrNGM2?=
 =?utf-8?B?aDVkc1hvM0g3RGZRUGIzTXpqQVVOeHJuaXdXNDBUcGs0VGx6VmQ4emxjQlpl?=
 =?utf-8?B?eDNzRVJ6dWt2UkkzYStHbnVpWFZsZm02ajNHYXZBMGNRMFNCUjdnblpSd2tD?=
 =?utf-8?B?a0luaEI0WVRtcktEOEliazllUTlucjluY0R5VEJTd2lHTzVhN3ptQWJ2NnRa?=
 =?utf-8?B?TnVkdVJESWtrdGc0djZKS1JvZmEvT2R0SGdWTTM5VFdieTlCR3VWNi84Q1Vv?=
 =?utf-8?B?bWdQMWk5M0grbitXTzlRWDZwVHBCWEVDbGU3TThhbkU5cjhPWTJ1Qk5MK25G?=
 =?utf-8?B?Q09Ha3hDVVRxM3dLZU11aXhBS2xNNTlxRGtJYURndExEVm0xSjI1TG1uMkRz?=
 =?utf-8?B?aTRtak92OVBPSEdBdEdjMXlMUzFycDlHZEo4UnlOc0c1QTFQMnFKbGVSSmRu?=
 =?utf-8?B?RlVOa3VRWWNvQXlHTE9QQ3BBZndSbDRRUWdaVU9LeEdlM1BhL0Y1K3RqK05n?=
 =?utf-8?B?dVE4T0NBSHptUGV0UW5aRjJVejNOV3QrMDJKOHhiZWR0RTd5cFFXQS9jNld4?=
 =?utf-8?B?SVZBU2k0VWhSVVhqTkNPeUFFekgrZVZaYnZqN1U3SmtLeU1jSm1PSmh4Y3Fw?=
 =?utf-8?B?YmQxQkNSR3FnWXVoajdteWJDT3RBdW1GNnR0V3M0QTEzSG9abUYvZXlDdk1D?=
 =?utf-8?Q?Iq1cLxP6g5JGWyHkQOTg8K4tbUsl52Hz2bzj6Gd?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8b227c-6462-40a5-0fc5-08d92a6fa934
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 11:22:11.6162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +UB3XqMJGKE23aYd7ZYaXhV2Zwby0Wceo5CX9yrVFXeQksWzRYHR0BSJfntzzBsh2qdjxQYjJcGTmCPeuzjBOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5451
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiBQb2xsIGZvciBUUkFOIHN0YXRlIGlmIHRoZSBpb2N0bCBjb21tYW5kIHdpbGwgZXZlbnR1YWxs
eSByZXR1cm4gdG8gVFJBTg0KPiANCj4gVGhlIGlvY3RsIHN1Ym1pdHRlZCBjb21tYW5kIHNob3Vs
ZCBub3QgYmUgY29uc2lkZXJlZCBjb21wbGV0ZWQgdW50aWwNCj4gdGhlIGNhcmQgaGFzIHJldHVy
bmVkIGJhY2sgdG8gVFJBTiBzdGF0ZS4gV2FpdGluZyBqdXN0IGZvciB0aGUgY2FyZA0KPiB0byBu
byBsb25nZXIgc2lnbmFsIGJ1c3kgaXMgbm90IGVub3VnaCBhcyB0aGV5IG1pZ2h0IHJlbWFpbiBp
biBhDQo+IG5vbi1idXN5IFBST0cgc3RhdGUgZm9yIGEgd2hpbGUgYWZ0ZXIgdGhlIGNvbW1hbmQu
DQo+IEZ1cnRoZXIgY29tbWFuZHMgcmVxdWlyaW5nIFRSQU4gd2lsbCBmYWlsIHRoZW4uDQo+IEl0
IHNob3VsZCBub3QgYmUgdGhlIHJlc3BvbnNpYmlsaXR5IG9mIHRoZSB1c2VyIHRvIGNoZWNrIGlm
IHRoZWlyIGNvbW1hbmQNCj4gaGFzIGNvbXBsZXRlZCB1bnRpbCBzZW5kaW5nIHRoZSBuZXh0IHZp
YSBpb2N0bCwNCj4gaW5zdGVhZCB0aGUgY2hlY2sgc2hvdWxkIGJlIG1hZGUgaGVyZS4NCj4gU28g
bm93LCBpbiBkb3VidCwgd2FpdCBmb3IgVFJBTiBleGNlcHQgZm9yIHRoZSBmZXcgY29tbWFuZHMg
dGhhdCB3aWxsDQo+IG5ldmVyIHJldHVybiB0byBUUkFOIHN0YXRlLg0KSXMgdGhpcyB0aGVvcmV0
aWNhbCwgb3IgZG8geW91IGhhdmUgYW4gZXhhY3Qgc2NlbmFyaW8gaW4gd2hpY2ggdGhlIHBvbGxp
bmcgd2l0aCBjbWQxMyBpc24ndCBlbm91Z2g/DQoNClRoYW5rcywNCkF2cmkNCg==
