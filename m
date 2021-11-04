Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2013C433F5
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Nov 2021 02:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEADD611C9
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Nov 2021 02:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhKDCJB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Nov 2021 22:09:01 -0400
Received: from mail-eopbgr00073.outbound.protection.outlook.com ([40.107.0.73]:60391
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230198AbhKDCJA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 3 Nov 2021 22:09:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXe3MVae1pCL9ySYogxlXZzPgNtT4NdqwK6kSF1pEzseEsjEPl946muThybiIDzltzkirj7pA9Hy/m/HoFd4+ylK+nFzCwdIMZthVR5mqUlCEaBtojeC2xnDveL3oX+oxbWeRkQUM4fRMYwsoznefevsngjH8IYydjea3uN59Cm5B9pI5Yw+GCXkrdJ8JwYxAJRHwJpR+l03Xef2NCy92iOI37MfmQDtQz+Ikk/mcl+KUO2b4BLsCkXi4woxgkhaVcWEjasSQaDT5+Q9rl1uGwhOVXoRNrV/JLuNkqwhGaQE+J0VF5hdlQskfq2A9/1Lj1CNLMm+hdYAYCqOkmdIbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKXOOsKhnBVjE8Oq9ktd2ruNdmr2j+aI5kt2ig6Fb2U=;
 b=e/5FgosZasep6XXM6wMGq+O7DqpxkLuyTvcYJVgEB3vhsRAbFok3SM2ZRzJuoyMqugsuT7mlajNZJ0OJGp7av3gSOBPd1Jf/Z2K2eMqPhw39jrgyqNlmxIuG5yqnr6AUaNK2YX7gpfTZysI4OpP/TYup7B4/kS2LrDfK2CUEmuVwUL+d9wW1lafdwYYCXMLNuh4ctbNlab+vMH8bxhnzftcI37pb7qmwocL3jzEklAMwlVbSCgJ5ntkTFv7YFIE5jPFN41WRqs07Ubv6rXhoyFQClYOYYYsjs/EpVBzCD55ApYG9R9CMlq9qVFkszm3Pad0muAS6wS2UgHOpDMmZRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKXOOsKhnBVjE8Oq9ktd2ruNdmr2j+aI5kt2ig6Fb2U=;
 b=ZTv9wo/f0OtBvYGiwnnW5YneN8MXFIrazMM3v1uV3TeopPChrc4HBRv457hSLehcZjartQX1rlMw3dJFcPI8bKNtPw9k6zWQYXiNKuhAgQkDcbvkyG1ismScossdJ0l6SNnnrCMd9DOzulc7Q0FluVzjHVem5bIRKV9AUPf7iqw=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 DB8PR04MB7116.eurprd04.prod.outlook.com (2603:10a6:10:127::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15; Thu, 4 Nov 2021 02:06:10 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::94cc:8972:12cd:5bef]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::94cc:8972:12cd:5bef%3]) with mapi id 15.20.4669.010; Thu, 4 Nov 2021
 02:06:10 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>
CC:     "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] mmc: sdhci-esdhc-imx: disable CMDQ support
Thread-Topic: [PATCH] mmc: sdhci-esdhc-imx: disable CMDQ support
Thread-Index: AQHX0NltNnUwTqAIJUyyxnRkg02IaKvynvgA
Date:   Thu, 4 Nov 2021 02:06:10 +0000
Message-ID: <DB7PR04MB40101E7FDF84E2997074861D908D9@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <CAJ+vNU3zKEVz=fHu2hLmEpsQKzinUFW-28Lm=2wSEghjMvQtmw@mail.gmail.com>
 <20211103165415.2016-1-tharvey@gateworks.com>
In-Reply-To: <20211103165415.2016-1-tharvey@gateworks.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5436b040-e7eb-4543-e12e-08d99f37abec
x-ms-traffictypediagnostic: DB8PR04MB7116:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB8PR04MB711657283E0E8BE02424A52C908D9@DB8PR04MB7116.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:83;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HE8cluoTr+NKW/1Qd5yOZAySdfVChCaJBe83dUkMTZKzsKVG7Oufx0fOH9mpdPYLn1wIjLRAVfpybYWUqbEfQQwlYVD/Lwa9uBsea+5AWo8+QxfzLq7iwUZgEV9eL+YhLqyPzXUgFMN7pqTWWmCoZ9zizh/FCi306cBDJuwgwzLmJiG59k4w0UAnF3+GKHnHsqvydEya8nz+iuJ+m+tTUTg3oUmQ8ov/2AyuNyRAqqCBg8TjN9WpeTG9IBcdVn0Hmp3VhveLrJw/t581Eoh3H50hcNVulGM60MApkxoBUI6OhMgk2stZrA1Pc33TowiaPRtUJFO+lLiLpf2F7tEjnD2jxVORUebOS1hyNYDFiwK4hRUJ8A303PghSGHeFYy8H+6hrU7enxBh6RAABO/tUEQoARnb46XIlTyVxvarIzZ7U/pbZxA4w/oTiPv3JeKda0SKKrpyAVlRB6+Homu7mXITnyRZ/CC3Ny067qXSze94ntXiaM4VVMDpjrdZcDiqHh6rnDyp6opq4HAh1m9SY/Gm7PuhM0d0JeCiJz0fSWx3aR7MetfWjLCJCz536JA7pf5WV1lOnZ4TJa7CKohFyfxKpfP2WkSxFIhtrtP/bWzWA1IPa7o1LEQSw0L7qQa7j0ctMgeUuC+Fxtqfd9dPOTk6XcaBLVBCZjT7BRwgkLs6HIAgNbzqxUmFAUxIV9TUCgvAo7rjzUOvwNzgLAzbN5n/hi5jUrqKcJIf9t3LXJw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(8936002)(8676002)(83380400001)(186003)(122000001)(86362001)(38100700002)(71200400001)(921005)(55016002)(26005)(9686003)(66556008)(5660300002)(66476007)(99936003)(53546011)(4326008)(110136005)(38070700005)(6506007)(33656002)(54906003)(66446008)(7416002)(52536014)(2906002)(7696005)(64756008)(66946007)(316002)(6636002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UDF6VUpDc1NqR28xQWJlMFpnM1pFRS9uVE41a1EwY2V1cnNsTXNpUTh2RElr?=
 =?gb2312?B?Y0RpOWhlVzBiNGpJeElWODA0WGFDMk9FMGJQVlNsZnRxbzgrb2Y2bktZRW81?=
 =?gb2312?B?c05RTVF6SHQ2TWZldmFjc21vUzU4N0pTQUtmTEc2QjhnMGx5NWdQWGtDRlFn?=
 =?gb2312?B?eDROTCtnZ3dQUHNCTFV4enJVL05rbUNzS3VMcDYyU2ZmUEdpWDcwbUhadWhH?=
 =?gb2312?B?MWNGNG95TWp1T1NGSCt1V0poYXZsb1RQcUJqKy91VDlNOGpIYTk4b1hJREhJ?=
 =?gb2312?B?WThNNUFtdXN6ajI1SG9GemdSWEJxdkNOc3MwNEZPQmJhTnh2WFJBaUxTR3hU?=
 =?gb2312?B?VmtyWEgxYTQrSy9SNDZieGdaOEZPYUpMdFZHZFZYK1IvUjF6Tlo3Zmpxb3B1?=
 =?gb2312?B?dDZ3bDFGR2c0bjV0eEpwTkVvSTk2eEpJZUI1eDBxTWx6blNPbXRJcGpxRW1Y?=
 =?gb2312?B?UVp6S0RiUkJPTThJekdSczBvYW9hK0dncXNSaE5WOHFuNXJySUlJQkRQcmE3?=
 =?gb2312?B?SytZL3plUXVTdVRtMDcvcEZtVDI0THpSazlRUWx6R3JXSnBGK3dtL1Vvb3dF?=
 =?gb2312?B?ZHFrQlNORFVSb0VKV1p6SnBGVURBYlN1KzUwRUd5Vml5eEs4ZFA5WW95OStD?=
 =?gb2312?B?UEpxRGhDZ2VRWVdhY0l5a0MySGl5QjlGay84Q2lsazd1MFRPWElFamE1VmFr?=
 =?gb2312?B?YWpSbWVTU2Roam9oeGF4eUZWSjJybXFaTEJjbFFSN1g3OEdUYkQ1MjBRWXdO?=
 =?gb2312?B?R0FnNVBpSlduVjZIMFdIRlZFZG01VUx4T2gyZWRPV2RyZWFiamRRM1BpWVgy?=
 =?gb2312?B?OGxvVmFvV2lzVitiMHkrWjBJSDRadnRKaTJMeVFyM05salNFMVBGdTFESmlj?=
 =?gb2312?B?L09INDNnZVZEcDdhRW93Z2FLM1BlZjNGMTFCeXlKQ0doUzhTOEJzSGZFSCt4?=
 =?gb2312?B?OHZTbitULzY5cTdxODdrY2QxMUYzbE40Vm5CSjZlanIzMlg2Nkw5bXRUeVJI?=
 =?gb2312?B?LzN5TFkyUWFMRXFYQVEzNzZlempQL2I1SXcxVXl4VUpPSTJqVitIZGxYNzdo?=
 =?gb2312?B?dS8waCtYVnJNOXJqaVZyVVhiMDcvWUVrajNDeTRnMmZFblJrMjB6MWI4VTV0?=
 =?gb2312?B?ZS82eFpvY3NKTkNjOE0xRy9Ea2JzZTRJRmg2L201Y0VuajJPNEZ2VWhXYjZU?=
 =?gb2312?B?aWN4R0QyR1VtSFZRMHF2OHFrd0UzSUIzRHVJaGFwT1EvTnRFTWZDakNyeGxN?=
 =?gb2312?B?M3c1UmdNY1JCNmcrTElrZ1VEYTFDNUR5SEdXNUxYTnJNYUtML0lySGhmWTA4?=
 =?gb2312?B?UnAvSlVOemxSNDhpVDlZZUFjazFNa1hpeUhTMjZYdjdwVnNhVzBJZ1ZKNEpO?=
 =?gb2312?B?aUh3dE5OOTliMnlMZmFHbFpzL2FIc3hDQTNIaGpCNE5xUUdKMnlOb3ZNeDF4?=
 =?gb2312?B?bk51U0swQzl0cWRUWVhKcnFWS0JEOUkyUjlaUm1adk42N01oeXNyOGZYekFP?=
 =?gb2312?B?cDVsK3VSUStZMjB1RFB2WE0vYXlGTjZYTFdOVmZEbHBnN0p6aWE2RTVRZzlY?=
 =?gb2312?B?ZS9CcTQ3Nm0yLzBOZGhPZXVCaEV2UUxXMERoWXBIeWR5dmRXYVppYjQyR2VC?=
 =?gb2312?B?cEpSUnBpVVNoNlVkUHpPWDYxL0dZVzdGQldUckQwL1lEQjRMc2RaM1VUTnNW?=
 =?gb2312?B?YzNQSTBzS20yaWVLMEkyUGQ5NXRtZmM4Zi9SRmdkQVJjSEZhT1Fhdlo3d0RV?=
 =?gb2312?B?WGtDSTFIWVRUdnB0NWV4OVd1eXhKUHgzWGwvL1Z6NDE5NEZTcC9TNnBZd0U1?=
 =?gb2312?B?RVFZU1g0amJWdS8vQkw0MFVSNGNjVTlQbG1qY2ZpUEJUaHVQTWF3U1NqNGN0?=
 =?gb2312?B?NUZlcHBnSzUxYlVCcTdSSWZOemluSGZkRHhvS3JaQWhZb2lxTExvWFA1TzJ1?=
 =?gb2312?B?b3pJVkliOVR0WEIwdFFHKzJYVVgyMjJmMWxZMDVJeGRhTjgyUzVnd3A1ZWVl?=
 =?gb2312?B?bFZOVlFuQW40aGpyRjFmVHVIcXZCa3NUaHhOd0hxLysvTERDMnRDUUVEaGY2?=
 =?gb2312?B?THdXVTFTSkw0ay9BTU4zU3ZXb1FJbjBERXVMdjNVb3JmMmw5UW1sL1dUMDVu?=
 =?gb2312?B?VW1hTDRXSmdHekU2cDV6K1QyejZOZE1OM05jNlhtejVwVS91UitMNzd3SGJk?=
 =?gb2312?B?emc9PQ==?=
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=SHA1;
        boundary="----=_NextPart_000_019B_01D7D163.93557DE0"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5436b040-e7eb-4543-e12e-08d99f37abec
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2021 02:06:10.4532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sJR9ZnZWKiiwOZC7f8lBEyR5YrK7D2DBWtyu1Y6rgT+lTdmI5r3uFqoMq7NhEbSx9b7V4shUpH0iKrky5utR1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7116
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

------=_NextPart_000_019B_01D7D163.93557DE0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Tim Harvey [mailto:tharvey@gateworks.com]
> Sent: 2021=C4=EA11=D4=C24=C8=D5 0:54
> To: Adrian Hunter <adrian.hunter@intel.com>; Ulf Hansson
> <ulf.hansson@linaro.org>; Shawn Guo <shawnguo@kernel.org>; Sascha =
Hauer
> <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>;
> dl-linux-imx <linux-imx@nxp.com>; Bough Chen <haibo.chen@nxp.com>;
> linux-mmc@vger.kernel.org; Marcel Ziswiler <marcel@ziswiler.com>;
> Schrempf Frieder <frieder.schrempf@kontron.de>; Adam Ford
> <aford173@gmail.com>; Lucas Stach <l.stach@pengutronix.de>; Peng Fan
> <peng.fan@nxp.com>
> Cc: tharvey@gateworks.com; stable@vger.kernel.org
> Subject: [PATCH] mmc: sdhci-esdhc-imx: disable CMDQ support
>=20
> On IMX SoC's which support CMDQ the following can occur during high a =
high
> cpu load:
>=20
> mmc2: cqhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D CQHCI REGISTER DUMP =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> mmc2: cqhci: Caps:      0x0000310a | Version:  0x00000510
> mmc2: cqhci: Config:    0x00001001 | Control:  0x00000000
> mmc2: cqhci: Int stat:  0x00000000 | Int enab: 0x00000006
> mmc2: cqhci: Int sig:   0x00000006 | Int Coal: 0x00000000
> mmc2: cqhci: TDL base:  0x8003f000 | TDL up32: 0x00000000
> mmc2: cqhci: Doorbell:  0xbf01dfff | TCN:      0x00000000
> mmc2: cqhci: Dev queue: 0x00000000 | Dev Pend: 0x08000000
> mmc2: cqhci: Task clr:  0x00000000 | SSC1:     0x00011000
> mmc2: cqhci: SSC2:      0x00000001 | DCMD rsp: 0x00000800
> mmc2: cqhci: RED mask:  0xfdf9a080 | TERRI:    0x00000000
> mmc2: cqhci: Resp idx:  0x0000000d | Resp arg: 0x00000000
> mmc2: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI REGISTER DUMP =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> mmc2: sdhci: Sys addr:  0x7c722000 | Version:  0x00000002
> mmc2: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000020
> mmc2: sdhci: Argument:  0x00018000 | Trn mode: 0x00000023
> mmc2: sdhci: Present:   0x01f88008 | Host ctl: 0x00000030
> mmc2: sdhci: Power:     0x00000002 | Blk gap:  0x00000080
> mmc2: sdhci: Wake-up:   0x00000008 | Clock:    0x0000000f
> mmc2: sdhci: Timeout:   0x0000008f | Int stat: 0x00000000
> mmc2: sdhci: Int enab:  0x107f4000 | Sig enab: 0x107f4000
> mmc2: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000502
> mmc2: sdhci: Caps:      0x07eb0000 | Caps_1:   0x8000b407
> mmc2: sdhci: Cmd:       0x00000d1a | Max curr: 0x00ffffff
> mmc2: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0xffc003ff
> mmc2: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x00d07f01
> mmc2: sdhci: Host ctl2: 0x00000088
> mmc2: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xfe179020
> mmc2: sdhci-esdhc-imx: =3D=3D=3D=3D=3D=3D=3D=3D=3D ESDHC IMX DEBUG =
STATUS DUMP =3D=3D=3D=3D
> mmc2: sdhci-esdhc-imx: cmd debug status:  0x2120
> mmc2: sdhci-esdhc-imx: data debug status:  0x2200
> mmc2: sdhci-esdhc-imx: trans debug status:  0x2300
> mmc2: sdhci-esdhc-imx: dma debug status:  0x2400
> mmc2: sdhci-esdhc-imx: adma debug status:  0x2510
> mmc2: sdhci-esdhc-imx: fifo debug status:  0x2680
> mmc2: sdhci-esdhc-imx: async fifo debug status:  0x2750
> mmc2: sdhci: =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> For now, disable CMDQ support on the imx8qm/imx8qxp/imx8mm until the
> issue is found and resolved.
>=20
> Fixes: bb6e358169bf6 ("mmc: sdhci-esdhc-imx: add CMDQ support")
> Fixes: cde5e8e9ff146 ("mmc: sdhci-esdhc-imx: Add an new esdhc_soc_data =
for
> i.MX8MM")
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Haibo Chen <haibo.chen@nxp.com>

Best Regards
Haibo Chen
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> b/drivers/mmc/host/sdhci-esdhc-imx.c
> index e658f0174242..60f19369de84 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -300,7 +300,6 @@ static struct esdhc_soc_data usdhc_imx8qxp_data =
=3D {
>  	.flags =3D ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>  			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
> -			| ESDHC_FLAG_CQHCI
>  			| ESDHC_FLAG_STATE_LOST_IN_LPMODE
>  			| ESDHC_FLAG_CLK_RATE_LOST_IN_PM_RUNTIME,
>  };
> @@ -309,7 +308,6 @@ static struct esdhc_soc_data usdhc_imx8mm_data =3D =
{
>  	.flags =3D ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>  			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
> -			| ESDHC_FLAG_CQHCI
>  			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
>  };
>=20
> --
> 2.17.1


------=_NextPart_000_019B_01D7D163.93557DE0
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIgXjCCBU0w
ggM1oAMCAQICCBLkWWZl3+DFMA0GCSqGSIb3DQEBCwUAMGUxIjAgBgNVBAMMGU5YUCBJbnRlcm5h
bCBQb2xpY3kgQ0EgRzIxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJ
RWluZGhvdmVuMQswCQYDVQQGEwJOTDAeFw0xNjA0MDgwOTE1MDRaFw0yNDA0MDgwOTE1MDRaMIG2
MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQ
IEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmS
JomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTEL
MAkGA1UEBhMCTkwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDAWrnSkYP60A8wj4AO
kATDjnbdgLv6waFfyXE/hvatdWz2YYtb1YSRi5/wXW+Pz8rsTmSj7iusI+FcLP8WEaMVLn4sEIQY
NI8KJUCz21tsIArYs0hMKEUFeCq3mxTJfPqzdj9CExJBlZ5vWS4er8eJI8U8kZrt4CoY7De0FdJh
35Pi5QGzUFmFuaLgXfV1N5yukTzEhqz36kODoSRw+eDHH9YqbzefzEHK9d93TNiLaVlln42O0qaI
MmxK1aNcZx+nQkFsF/VrV9M9iLGA+Qb/MFmR20MJAU5kRGkJ2/QzgVQM3Nlmp/bF/3HWOJ2j2mpg
axvzxHNN+5rSNvkG2vSpAgMBAAGjga4wgaswHQYDVR0OBBYEFFiVYO5OdO9lIqq97RmpK3qOF50H
MBIGA1UdEwEB/wQIMAYBAf8CAQAwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL253dy5wa2kubnhw
LmNvbS9jcmwvTlhQSW50ZXJuYWxQb2xpY3lDQUcyLmNybDAfBgNVHSMEGDAWgBR54UkB4HvONDkp
QxkyZWE8BthVqzAOBgNVHQ8BAf8EBAMCAQYwDQYJKoZIhvcNAQELBQADggIBAAbOUfjWTDj+hByL
1uNjWcpi78tBzOvltka5EfKCj8uuv1WQVfvugF0RsqzpgfWMwj/EnTVHHrM++avuUtapouyqkq7z
8xBFpWa9nsg8vvmyHPCHoQdBqFaIHjCM/Gr6jVB1boBWaQTMr8FEG7DHlhObshlm3zF26il5NjAS
GhwryzJjD6/oHyKiw1BSxHvhpPc01e5nemXPX3C0pY3tcD1LYurGDWvGHVTH1BIMoOkmTa1EXcov
P3WwfSvEQBnM4Zcu8TIrSb+xu4GutPXM6R9G0vrgyJLUcA3LqThr4uZ5hANjLCCzmMRiOLPKbHfO
UCS+JLaduhVv0Bff2AXY2cOcTdIFYgwUeARrgxyCTjxoLNY96XRGzpdEZhUW3/rwjrZbIBMUvyc8
yONci+Ye1Hd+FRIVwDyRnHOz/KSwvgdIXcLlN/bKJ4ew0xVYW9Y0mGYWgsmHpQYZ5MynGhnmwxtd
GMbPyPehlBS2dLbhAAKYoL+eaoUOqnjildk2wD6gFg125oDysOAqLxyK3VY9kB5Z8Vjh30Lk5B5u
O7oxk3/hG8oEdn4qz61lRl7N8TDhBNHcKAm+ls5BBqZUsONASebHhP8yLkS9pKXMe5bjudLk1XVv
cSsm/iIRJYkdbeTXipBu4gjMQ/OCl+QqFqydDvRe9CQdzPqUhr8PgxxgysQJMIIFrDCCA5SgAwIB
AgIITn4GzGWRAEgwDQYJKoZIhvcNAQELBQAwWjEXMBUGA1UEAwwOTlhQIFJPT1QgQ0EgRzIxCzAJ
BgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMQswCQYDVQQG
EwJOTDAeFw0xNjAxMjkxMjQwMjNaFw0zNjAxMjQxMjQwMjNaMFoxFzAVBgNVBAMMDk5YUCBST09U
IENBIEcyMQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRob3Zl
bjELMAkGA1UEBhMCTkwwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCj7P72jqfzYGq/
J6jwexnlOfZGxRwwxYu9TlvW8pM1dQAjhXRixRBEhMH5APbZg+rYqbqLQMjI91HU1ueKw2kNCZUT
buyu125GkHyW9mA44Nf/eGGN5NZFnbY8AgjnuAi8qpkIxRa9hF1hmxIo/7hD6USSzz3Kz3ne2nc8
jwR5TO1PepRN+ztNuAPkD2z7XMI+ojtv9eZdOuRYGbCaaoMcGKPAi/PLm4TcxMG6dVkUCXaQP+OI
GB2P7g7i7n3c3LVz1zgh/pe/Pf4MQiN29tQutTIYhq3Al2/DoXFG3nOeZgp7dXLOxjtmT/wyw5m/
OhI8ExJkFZIeP97x8HAMQMp/pdDQEPtnbsBZNRx12TWymGffwcc7ASmMp87E0Zft9JerPYlpG2Vq
a9KgKt3jOsfl/3iFxJUVw/2cX2bcmpHMCZsZhN3OACMqM9FVYCBpkYXxv+VorkCLyAISLvrsO7My
xeS+P38FDDx/KfnE5jnnNGYWjaNTz9uVbL+OwDBR4QEOjgo9EC49tKI63wl/w1sM68MY8rAQLx17
vpLE+Le6WG4VvRDPGxuTf34RPcjHLfjswBlOOL9rzsZ4gNaL6cJYfBk9BISDR7QtWHu5E01vVyVY
gsQX9tIx7fNPetYpYObMKJOff4+Jyq9gztxaJmLeyuUKQgB5qJq/20xoBndcbwIDAQABo3YwdDAd
BgNVHQ4EFgQUkEhTIyp56oSbPT65DuiZdEBeoLYwDwYDVR0TAQH/BAUwAwEB/zARBgNVHSAECjAI
MAYGBFUdIAAwHwYDVR0jBBgwFoAUkEhTIyp56oSbPT65DuiZdEBeoLYwDgYDVR0PAQH/BAQDAgEG
MA0GCSqGSIb3DQEBCwUAA4ICAQCEgqJeyVvGvlbUtkMyrE930h6kWRDQMk/z8I2bk6rIGB8l4okp
kyI8E3HH9QX2bogCom03L3y3UY8ean+KQnaOapWpPQg1S3v0os/sdWvf+3ZKkgltbOnHxlA8b5Al
XiLWRLA1+TeBQMoLeFHv6s4P6JI7nXrczLP8LPOM3X6zJZFV6eluLM+h/yIT1yRmcP1XTn8gvzxq
VIcg2i1ur6jS1s2GgId0S7u797sx1UhPV4e3x+5vkzXRGHODmn+sS7OvUCqIQ4AZhxW8kOesjyZj
cxzXxEtJwGJUen8aqR/dIWJa+L/+iQshAYy6zUbQJU2qvCsr/ok8H3TvUXNmOjlLWOJXn9Q2HMvK
RKeBxoTf7T/MqIA/a+SKZ8cdDvZImThAjQo69EHUYZ4XpStdE7CTo09gQWLHBN1XMcnaE6aonHlJ
FcTK2003XYFPzBA6VilSZelpp38SPa+dWxLmcdxhtGfYC+b8OCawAn/Qik1oweIDNdmbYKkLRzxI
aLiZZhUDs9rH4+cZcFtn3C0rG9GuRWmI0am5cMJZm9cSTHXXzH4DVKog2ifwNLm1uuR8/ZMt6nvD
NmATpoU3ZDHJd0eziTuBCVOobTgt/uijawdJs7mQBtTjgpjDl8G0ukbunGXJXl+v6iQvvRrlJZhM
8+yhyEOrJod4BaCHH9rj74VGNDCCBfwwggPkoAMCAQICCDWXO7CfYZ/wMA0GCSqGSIb3DQEBCwUA
MFoxFzAVBgNVBAMMDk5YUCBST09UIENBIEcyMQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIu
Vi4xEjAQBgNVBAcMCUVpbmRob3ZlbjELMAkGA1UEBhMCTkwwHhcNMTYwMzE4MTA1MjE2WhcNMjYw
MzE4MTA1MjE2WjBlMSIwIAYDVQQDDBlOWFAgSW50ZXJuYWwgUG9saWN5IENBIEcyMQswCQYDVQQL
DAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjELMAkGA1UEBhMCTkww
ggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCly7+CWLCDR2fV3flTSlksy/Bs0Y3VZb/X
mmrMFykb9kGrmr7KCrj/OQSpAAzdxmxKLZTa2OIpk4R+PhyzIQlVkVCLBcym2yYSt+TsEygu1og3
v28U53VvN2NbQdpJNv0aQnsJNxvvP8UoqLBzaPndVU0NHXFUGdQ0RoHUDNA6SnqGC6kKCeWTD1f7
/b6LtQKKmTYlYuymD2ysVofS/CuAwXER+zjXLqIFUPvRH/j6y6hq1e+AW/eW0ZnfH+FqTc3WEeSM
mrehrWNKQuanoqhACptwdOR4qiYw6Y9QkrVioOSl1sa65GRhTci8Jbk5mCV2uSKBw5Now1Rp5lQC
/w/dNO2o3iMin8eWz/bpVH4Kp2gC2bPKkETK84UO3Oo+pXMVd+RSXYdnQkZNgRdQR+cjSxQkLIul
ws7UOOfASnwD656iVgiksBK6kbMYwZnkjk67VGgXZu56wSDBv5ZXsdE0BdOZ7NSHetYubh8ChTC/
WXKwgI58YYlDZWQ17k5fM5u/OOXfQVh0NZvoX7EgPIbQDDF+3hxdlykU4ZHcUfhlnk4f5Q2XUjGc
3BWkZKqbMRTvGehNeXJUfdD+NgMbbsdKggtCn/JEwldbH9efntlVc2brditnflexf3WkwcNGhB0k
EwqTJrzXd2CCaESzNIgFgqqiIW3Udowr8qc/BJIs7wIDAQABo4G6MIG3MB0GA1UdDgQWBBR54UkB
4HvONDkpQxkyZWE8BthVqzASBgNVHRMBAf8ECDAGAQH/AgEBMBQGA1UdIAEB/wQKMAgwBgYEVR0g
ADA7BgNVHR8ENDAyMDCgLqAshipodHRwOi8vbnd3LnBraS5ueHAuY29tL2NybC9OWFBSb290Q0FH
Mi5jcmwwHwYDVR0jBBgwFoAUkEhTIyp56oSbPT65DuiZdEBeoLYwDgYDVR0PAQH/BAQDAgEGMA0G
CSqGSIb3DQEBCwUAA4ICAQCHr83XcZ67rjIJvbUQ7xgQWbwycWuQiRADywkqB1mxAhG6Pt4rNpup
D/t3BtH/oAyz+gxGLEBLP2qLH0kMvGhTj4cCyKkW6EkUxlP9U1OGYqaU0s8wv3SnyhbD3BrSNHo4
Bp+FGCb8gLHMGQdtmP9A3wZdQ89tyu+Jjfb6ddDYyZD1XFaVYCs08dDJxrN+xuPv+vmfP80kqDvT
uLTteabsJTnx8BbO+5WjzjaOJcg2o6Ts6rfL3QvtpIdmulELWTif6C/50eZbnyaHGTwiZtpR/oYl
kA0M2u5/ALz/ayS+ar09JRc7lq0aV3r8IIbYSPW+Wygmg7m/cSUMJFMyPWExW/IqbIv16Ju16EbP
aQMzUsRbrYJiwv9nuV6okhAGutdtw0pIQ7PCktcooAagK4EUaPuwYfKlmQamaF8geLXz440WmCJs
LGVtiARAMlFlf5zNuM+PvSzKOedLQJem0IX0UhZaag0HLUw3ChhVfMxAzBUeAq9KxWayGnPA0AZZ
Dmxw6ExfVqNWuPMrhIFJL7aMGuegO+NXV8K5LI/ZmnRk2hzZhSGbpCg/dAp5vlu380ZL52bsXeJk
Q0cP3H5FZ6EZTVnFOnRCCKsbJRmwMMl+G3sCQsCG3Fi0JbevpuYbDO5ubjrd9id6XAMe29d8UtyF
gqXgRA4jgZsZIOdIpNUJ0TCCB2owggZSoAMCAQICEy0ABsdWyH4wxYEwyQ4AAAAGx1YwDQYJKoZI
hvcNAQELBQAwgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNlIENBIDUxCzAJBgNVBAsMAklUMREw
DwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMRYwFAYDVQQIDA1Ob29yZC1CcmFi
YW50MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPyLGQBGRYDbnhwMRMwEQYKCZImiZPy
LGQBGRYDY29tMQswCQYDVQQGEwJOTDAeFw0yMTA5MjIwMTMwMjVaFw0yMzA5MjIwMTMwMjVaMIGa
MRMwEQYKCZImiZPyLGQBGRYDY29tMRMwEQYKCZImiZPyLGQBGRYDbnhwMRMwEQYKCZImiZPyLGQB
GRYDd2JpMQwwCgYDVQQLEwNOWFAxCzAJBgNVBAsTAkNOMRYwFAYDVQQLEw1NYW5hZ2VkIFVzZXJz
MRMwEQYDVQQLEwpEZXZlbG9wZXJzMREwDwYDVQQDEwhueGExMjkzNzCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAMwIT9TWi+9HbVkhS5COw35vY0wHawaDlhh/xAs9Ooxu8CrHq1fN46+Z
cLTvvDp9FNO/tlxRxZt3CUskxOkAq79LhM2ppYC1nTXsBiBtPoWiG/99xmXQOWEkRi/5PHHSixdC
y9kOOg5EhV0W6pzF/hFBA3uMK9Amq+i0LK5NoCT2FG1gyH0U1tUgpDe2nXKgnMLI7KmvT322nlmE
wqfqklA1FUS2CHhh2ZiL6/rlTlXWaqTezzKulDCOk2sKnz0nLWSv1ZdUW5Qb03SC47OcDFIWjUc8
/z4IN2JFd06fNY2r1c1dIKolev86muTvoH7Sg4jHG13rMCsZLXkMOwJzBSkCAwEAAaOCA4kwggOF
MDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRVhu2FOILrmUuaklY/g5/dGoWovkUC
AWQCATgwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMCMA4GA1UdDwEB/wQEAwIHgDAMBgNV
HRMBAf8EAjAAMCcGCSsGAQQBgjcVCgQaMBgwCgYIKwYBBQUHAwQwCgYIKwYBBQUHAwIwQQYDVR0R
BDowOKAiBgorBgEEAYI3FAIDoBQMEmhhaWJvLmNoZW5AbnhwLmNvbYESaGFpYm8uY2hlbkBueHAu
Y29tMB0GA1UdDgQWBBRWbh0tRGFocEkr5ZMgCxTGc8JVuTAfBgNVHSMEGDAWgBRYlWDuTnTvZSKq
ve0ZqSt6jhedBzCCAUYGA1UdHwSCAT0wggE5MIIBNaCCATGgggEthoHIbGRhcDovLy9DTj1OWFAl
MjBFbnRlcnByaXNlJTIwQ0ElMjA1LENOPU5MQU1TUEtJMDAwNSxDTj1DRFAsQ049UHVibGljJTIw
S2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhw
LERDPWNvbT9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlz
dHJpYnV0aW9uUG9pbnSGL2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VD
QTUuY3Jshi9odHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCC
ARAGCCsGAQUFBwEBBIIBAjCB/zCBuwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVy
cHJpc2UlMjBDQSUyMDUsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZp
Y2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9i
YXNlP29iamVjdENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6
Ly9ud3cucGtpLm54cC5jb20vY2VydHMvTlhQLUVudGVycHJpc2UtQ0E1LmNydDANBgkqhkiG9w0B
AQsFAAOCAQEAJpGYHveFzmgLQ4J62fcmPkd4wJ8urL46itMWCgyLBPRARYB9oArCqPd4j0Yl0RmS
F1oNZgVDYQTy2aLoe+YGm23TkdJsTx1ExTxtv+njRnvvlSXMMULlOIt25/Vj+vTZ/wjFDq6PJOSZ
MSQHaVHSUrkLBT1H0pBmCA1Ecjuo7gUpG5T2NqD5KJP083pJZ+nogA9TVC9Ob+jNx0d/UR7UgRLf
KOxBG05AakTa4luadPIRktiULtjzG20WDhvAIg4M9w1+9SV+LpvvqBtkovpCfj9Rf4pNRV1CjjTY
AFIH0s3Q11HnFd1UNHKUvpp7/SrTyxaCXBO68U5aJz4zDjwIPzCCB+swggbToAMCAQICEy0ABsdV
/0AV+3f0TucAAAAGx1UwDQYJKoZIhvcNAQELBQAwgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNl
IENBIDUxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVu
MRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPy
LGQBGRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTDAeFw0yMTA5MjIwMTMw
MTRaFw0yMzA5MjIwMTMwMTRaMIGaMRMwEQYKCZImiZPyLGQBGRYDY29tMRMwEQYKCZImiZPyLGQB
GRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDd2JpMQwwCgYDVQQLEwNOWFAxCzAJBgNVBAsTAkNOMRYw
FAYDVQQLEw1NYW5hZ2VkIFVzZXJzMRMwEQYDVQQLEwpEZXZlbG9wZXJzMREwDwYDVQQDEwhueGEx
MjkzNzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL6VTRRCbJgUEuoR2bppNZQc3ghr
l0pDEZjK8uaayFYadelTc6iWe8EBLWrrOWd17yNeXc054yw+Yu8eI1IWMEE/mo5l93Kw+BkuCUda
vpqZUMOvaPDKkHNPBNPJ6AP+vmZW8p/46dxo6Nx6xGzkpbUZ1Ju1a9LuxeFQBNNvV54wYbFmoKJF
eQQ3RZdEafNucOw8ukTyWurcC8fPUQwqE1sFRdtjLeJWZBtrvNim4oikb5UFxcmoaQkJ/sqoJGZL
+bR3ZZx3101+Y7RJp56hfqT1eqkJkc7OTz+tsZx3p1a6r266NCB/RBIGVD2cFmhUs2Uitp/oB+9k
BhycuX8wowECAwEAAaOCBAowggQGMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRV
hu2FOILrmUuaklY/heaKboS14X4CAWQCATowEwYDVR0lBAwwCgYIKwYBBQUHAwQwDgYDVR0PAQH/
BAQDAgUgMAwGA1UdEwEB/wQCMAAwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDBDCBlAYJKoZI
hvcNAQkPBIGGMIGDMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAS0wCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBGTALBglghkgBZQMEAQIwCwYJYIZIAWUDBAEFMAoGCCqGSIb3DQMHMAcGBSsOAwIHMA4G
CCqGSIb3DQMCAgIAgDAOBggqhkiG9w0DBAICAgAwQQYDVR0RBDowOKAiBgorBgEEAYI3FAIDoBQM
EmhhaWJvLmNoZW5AbnhwLmNvbYESaGFpYm8uY2hlbkBueHAuY29tMB0GA1UdDgQWBBQY587dMxoS
HzI5SkUyoLrumaVa5jAfBgNVHSMEGDAWgBRYlWDuTnTvZSKqve0ZqSt6jhedBzCCAUYGA1UdHwSC
AT0wggE5MIIBNaCCATGgggEthoHIbGRhcDovLy9DTj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1
LENOPU5MQU1TUEtJMDAwNSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2Vy
dmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9jZXJ0aWZpY2F0ZVJl
dm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9uUG9pbnSGL2h0dHA6
Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Jshi9odHRwOi8vd3d3LnBr
aS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsGAQUFBwEBBIIBAjCB/zCB
uwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2UlMjBDQSUyMDUsQ049QUlB
LENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24s
REM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVjdENsYXNzPWNlcnRp
ZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY2Vy
dHMvTlhQLUVudGVycHJpc2UtQ0E1LmNydDANBgkqhkiG9w0BAQsFAAOCAQEAsjJuJnMzvA59CAlY
87eQCOafWbMF4HfC4oobtAqboB48BtCZ5dOeo+X4XQRaSmTwFJ2hZjX614KFnRGXLk/nDIY4pp8+
fqfgHKUdY1ceVqs+Kjtabk3gY8zq7PtFUsAkwp4OW23kwphh7Awx1tf3XRZeOqwiVuk5V57GT8Tu
dKNiOZqut3mrcdZINNUsqjt7ZA82r4ov5MbEBHeWVjo7CeWbgZFZhKhMKC9+2DKEUkdDJUcDYqxz
+Rh+6B+dgxeYkTGIqHELhkMjMCC5SwRNHfCxXCI+qRy4zIAo2K3V96zs3ungqiFZuFrpatfSBfAL
d86AIrOgsHhvOB0UU1W//zGCBLMwggSvAgEBMIHOMIG2MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlz
ZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRob3Zl
bjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTETMBEGCgmSJomT
8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwCEy0ABsdWyH4wxYEw
yQ4AAAAGx1YwCQYFKw4DAhoFAKCCArkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG
9w0BCQUxDxcNMjExMTA0MDIwNjAzWjAjBgkqhkiG9w0BCQQxFgQUjvV5DuiDl1C7Nvm2CWBQr9KD
VjIwgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAoGCCqGSIb3
DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAhow
CwYJYIZIAWUDBAIDMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgEwgd8GCSsGAQQBgjcQBDGB0TCB
zjCBtjEcMBoGA1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwCSVQxETAPBgNVBAoM
CE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzAR
BgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNj
b20xCzAJBgNVBAYTAk5MAhMtAAbHVf9AFft39E7nAAAABsdVMIHhBgsqhkiG9w0BCRACCzGB0aCB
zjCBtjEcMBoGA1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwCSVQxETAPBgNVBAoM
CE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzAR
BgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNj
b20xCzAJBgNVBAYTAk5MAhMtAAbHVf9AFft39E7nAAAABsdVMA0GCSqGSIb3DQEBAQUABIIBAEjz
IU+dbrBHkFTwkh5bd661TFgk4tX9YjKkJIye/FlM5SdI7uvZpF0ZuhvCvrPJb0wxMTkdFzbtkXCu
02GaLu82q5UM1LyTvw/NvltCMGvdgs+s+1ICU/X45Uu83eie2ZlW3Un5Sg5yEpbXcfG22Ud81P9y
hWDZWi1HFX3HndyVOSmkz0DpK+sN8FiS0nMV86Pt/WGw/A9SwzVRD40q7TgEd7TzzJyP5saDQV95
UQSxIKZUITnSBbCmZpp/pOsLbT1HI+n5lGUYoVZDtGdorzPBsFqPE0grRC6Ja1j2JNM1jeR0X3EQ
4l699T3Q4AL+ypRmQXFOdqok0vwmKtSIxUMAAAAAAAA=

------=_NextPart_000_019B_01D7D163.93557DE0--
