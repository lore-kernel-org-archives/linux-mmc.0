Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10B6C433E9
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DCFA64F8B
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345395AbhCDAAH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:00:07 -0500
Received: from mail-eopbgr00062.outbound.protection.outlook.com ([40.107.0.62]:34213
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242601AbhCCDCn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 2 Mar 2021 22:02:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDI8bSjbDaAuNI67aHa15UYxwTCbbSDy/0UkBgwJftwVVJDGwAfD0w+zc8kJFmYx5HBE3WHSjRNgHELRBAabkZ6QPraUs6r5lCgIBJ7CZ2eoVMDEhCecsP4y5Yd3wUh0YVqQiuEh+r41HSQYmLk+Zz2pLKe9nkUohKxoJkYISClRyy73NcZYl7g7IjKvw5LD2QSBTtOyfEHVgr4QVtlAWjNZ70Nn4SsQGpS792rHvDXftbKCvVrj/R49T1inn0lOnzswmeq4YF8yBo6arIMXC0iAfaWeEmSvTjoToi6ag5UFTKn2TBfmf1qNOanytYwUg+pj2smmheHIBlHUoy936g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfwoaYlGMCrzQrrWzC7GSuMgBWF8ARGBLiuKv32r4fc=;
 b=abSSKdrLJCVUJFG/oujX8aEDEqeUnZxpLlDnBnnS0S4kFEj7rrFeK++14O+lvfcwC1cis3GLsuzFPipW+cU1c6IBNdKFUgDDuFdiaq7yOzvWkBDFnp3nE9kOz4u3Po+mFPwIBbdF9HnQbYL4RUQrsLJVBWeC5Xgle6u59fh6CGq9+pP/UcaE3R3WzIZGaJdr79MoAXYpdEVterhiQYdbcOKtVdodeRJV3VmKPni8bMXaets4OgWWyJK7i9i8yxUDIRnxAif52Khv5OXWtewWwBDJBXYL7DiFR0UxplrkLTzEM9SKEiK1OBOixljZk5I2nP6GQakfJ9IxXnZKTy5UCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfwoaYlGMCrzQrrWzC7GSuMgBWF8ARGBLiuKv32r4fc=;
 b=OCliViimKwZhY/ZYbmLSW3cpFlyOoQlKAURw315e/F5t5bi4EC+wvg7szluwz8mdz3Y4m3j+bXe7OKoVHF9VuipZa49uqTSEsK365iGmji05uDxR1Ga7wfhYogXf5r+FKT2JOlzyvxlcXXRUIlHf+8H8+SHj6MPvYEjGIf4nLno=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4235.eurprd04.prod.outlook.com (2603:10a6:5:22::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 3 Mar
 2021 03:00:57 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d58c:d479:d094:43d0]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d58c:d479:d094:43d0%9]) with mapi id 15.20.3846.049; Wed, 3 Mar 2021
 03:00:57 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH V3 0/5] imx esdhc dt/driver update
Thread-Topic: [PATCH V3 0/5] imx esdhc dt/driver update
Thread-Index: AQHXCyVy1qUEZ6f+hUuvzL/oNvoo36pwikmAgAER0OA=
Date:   Wed, 3 Mar 2021 03:00:57 +0000
Message-ID: <DB6PR0402MB276016438D7D39579A05D08A88989@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1614222604-27066-1-git-send-email-peng.fan@oss.nxp.com>
 <CAPDyKFq3J=Shzgxp8XsdZqdZcOZ-n5WJ+mWejXM1-Qp8PgjBNA@mail.gmail.com>
In-Reply-To: <CAPDyKFq3J=Shzgxp8XsdZqdZcOZ-n5WJ+mWejXM1-Qp8PgjBNA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 68a7a97e-ed6b-420c-c724-08d8ddf091a3
x-ms-traffictypediagnostic: DB7PR04MB4235:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB42355688DF4754A783B8B634C9989@DB7PR04MB4235.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u4V7xujgf2BAIYTs/zMy/WzMZ5sjrf7nMjtCuGh5YpGrf3c9lv6io0iRYnwXpSGZQ+5a+fbrTJjp9JoRjkaFqytPfnCEw8XEESM4EVNupdODVIUqFfyqh00T5WwlV9TiTy7gtngSD6ECjvBx39X1b3wuxs48iUSw5Cp9InbTzBnJ0D6p5+CvXBvJ/Di4CdyS9R60gOr/5UlCe8a8myLsw6cpx+VHHTQS63pnXiuIOmfd5GRQK16AA/HqmGm7gsRWUDNZqLaKzMlAmtBSd9ED3Y6NBw6zznelSUuNOEHALVhcbP5ofDEGdDo7evmGYm7+0zQ2nIu5MRJsdSzd63EEzG1LoEb6nPtxPa9seYD04A6gt+UblkwVspHVetKkULl8410O79stk1sUx633hMWvW3rZRLMTy4IZO142KaCjgqWXEIf4hYJHzoCgQj/wVl++k/CDKJajm0MSkF1b7tZjv5fmThBO2n7/CV+Us4TDuvFnO5T5jTapTqMo0hnE2VGQuRvUeIGIlIbPrH0jUwqYTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(6506007)(4326008)(55016002)(110136005)(86362001)(9686003)(54906003)(478600001)(316002)(83380400001)(7696005)(5660300002)(15650500001)(2906002)(186003)(52536014)(8676002)(66946007)(7416002)(76116006)(66556008)(64756008)(66476007)(66446008)(8936002)(26005)(33656002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3mvjNOXZRiQATWom4aDhzp7Dk2G9n9ztEMNOrIAWRecrWm1MqK7d5j5uOrhK?=
 =?us-ascii?Q?0zSwoguhPfl9TXXuN7wgfX+ZZgIsZLYGtUvljCA440Z7XkZrLzo2ZwuOFSwG?=
 =?us-ascii?Q?sRoZL9CMgIbMOoDDDHVeT7sRsvixcmFJVsMVKroJ39xtUYGgg3/vOGb/Z/uD?=
 =?us-ascii?Q?jNf+hRYMeicOLuyN0YQNLyS0It7+UM9stPPkT0zRiNcs5K4ff9XnnH6iORwn?=
 =?us-ascii?Q?aKOQ5M9xqQNW8BQTeHJxqeSDTgOdQ3cRsE4YmKHZ9rA/+GK900c2YCNVe8p8?=
 =?us-ascii?Q?+56/6dUlZ9MSf0y3R8p1gGdcoWQPvHJic9hdzFcu7cOfRG2AQ55783VOG27f?=
 =?us-ascii?Q?V3a7LVTLJwSblzqvVDrfNP9X6+TiABsMcpBtxuw4uIVVjbsU/NhK3UL2foC4?=
 =?us-ascii?Q?bxrbY93s67CSs9f30APup0nIyPG5nREUjbSslaA/wHil/Un2E3oOWBbVxNY5?=
 =?us-ascii?Q?HcedkyBlb80PPm0dCArVUExbB7JZwHFAuWMUbNR0yUQPDwKQ1OsjSFB8YAtK?=
 =?us-ascii?Q?m1d9b9rTaQ7lLNnARz/ajB1TqZrxKLd3dnGpspxzmjdTM9uJMwaMXKApeHBR?=
 =?us-ascii?Q?aFHv6IGNLfRYKN90xfTqjbqdP04g2Z2MAkxkvo5ru+jCJaP9QWDKzjVo5BOu?=
 =?us-ascii?Q?YuKX43Ii3xna7XNRir/BNOVsDzCeJAsWwpVn6u8/nHb6bA3GZ48qmxbH8YTT?=
 =?us-ascii?Q?h6KQuVqXfNIbHCliI1sfd+Gm2DNk5Zf2awzw5r2LCUCfk4Zp+NRq5PzRFr5m?=
 =?us-ascii?Q?XPrz5zdRvEQMDAdwSXVIXnGbqg3/eF94iJvXodEK+/C8EeJLip0CCNBDny+k?=
 =?us-ascii?Q?ez9qRqZaE+HT/HA5vWCM4YN8cMlGDOhGs+uTSlLELkGQ1/sXdBh5APYe7C1Q?=
 =?us-ascii?Q?kTDdEWo4L21pCViQwZfDn4WiRDdkQZlB7lEirmbo2GTHiQbSug1nOROWiQ/e?=
 =?us-ascii?Q?9Nb3KD+luD21vEs5dGwNvN4Kxyx294y0juFtZWbplH/cBwztUgxyEk2SKQJN?=
 =?us-ascii?Q?nm8tnlaOwPM03s+8qDc49BQIZEC4IMGAekUInvM1jcsiVmqhNrz1flx73doA?=
 =?us-ascii?Q?str95oMYyYZPj4fKXqbxBF8T0qWiYZF1IvADTvY4jM/StHpsNe4Af/WIdeYb?=
 =?us-ascii?Q?4eqFp+DlHHaCVMT2edkDKEx1qKr2UVgVcH/tQil4ZF35msnHZxP8QJsS+jmN?=
 =?us-ascii?Q?x+mzOXkg0ma+4xxGzUfJB9xC6dVNCcpANJiFHt4vXFYPZ/MVp00OR5LEaVU1?=
 =?us-ascii?Q?1QPQwhgU8tAFC0HwZtWvIRFS5rKHUPsNNmQUB+2wXzWcWKtwAYdlTEmArsRZ?=
 =?us-ascii?Q?Z8Px7DD8hKotj4a7YC3lZM3v?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a7a97e-ed6b-420c-c724-08d8ddf091a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 03:00:57.7704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kgfCNGxWdHHAR0RLk9om4L3/F+bKufARwSurGZT4QY6szCHqjwmuzUIJzkopGzVsCrZBKOSqxOUxH/jYXIqs9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4235
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Shawn,

> Subject: Re: [PATCH V3 0/5] imx esdhc dt/driver update
>=20
> On Thu, 25 Feb 2021 at 04:22, <peng.fan@oss.nxp.com> wrote:
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > V3:
> >  Patch 1, drop unneeded pinctrl-0/1/2
> >  Patch 2 is new to avoid break dt bindings check
> > V2:
> >  patch 1, 2, 3 is new
> >  patch 4 is not changed
> >
> >
> > Peng Fan (5):
> >   dt-bindings: mmc: fsl-imx-esdhc: add pinctrl bindings
> >   dt-bindings: clock: imx8qxp-lpcg: correct the example clock-names
> >   arm64: dts: imx8qxp: correct usdhc clock-names sequence
> >   dt-bindings: mmc: fsl-imx-esdhc: add clock bindings
> >   mmc: sdhci-esdhc-imx: validate pinctrl before use it
> >
> >  .../bindings/clock/imx8qxp-lpcg.yaml          |  6 +++---
> >  .../bindings/mmc/fsl-imx-esdhc.yaml           | 20
> +++++++++++++++++++
> >  arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 18 ++++++++---------
> >  drivers/mmc/host/sdhci-esdhc-imx.c            |  2 +-
> >  4 files changed, 33 insertions(+), 13 deletions(-)
> >
> > --
> > 2.30.0
> >
>=20
> Applied patch 1, 4 and 5, thanks!


Would you pick patch 2,3?

Thanks,
Peng.

>=20
> Kind regards
> Uffe
