Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D719C388F9
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 02:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D9D422255
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 02:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pX1Wiaik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgKTCEH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Nov 2020 21:04:07 -0500
Received: from mail-eopbgr70070.outbound.protection.outlook.com ([40.107.7.70]:52355
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725887AbgKTCEG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Nov 2020 21:04:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHFAEU3Ck4DLRU0Kl6Pahj6gI33RMmVewbvhooC4Iie+fN7jcoq9uOKrlWYa+p4DkB/ycwSECnEXyfPD7PNyQap0aXeTm8sHTm0j8ls+AEAL5KIHL4MkMVEhcwFV+QqgMRyNUfm9U/MiKoAP2KLlIqHRy9gMmzILsQnkJHllu5UhbrzyyRvV8X3wDLiUrTAXDPWaL/T220vlCZLZKgcha/6TYa7mOFXpPXG2/XCI85QufxJZSuja/LGe+oyuenQLnkuJEkrMZierpVOYTYfeT0GL4hkOmFkF0h0F/WSobG0KYpjOTMcWiikowQed7viSx7UJOktY2WzMz+3Y47MNBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+inPtlWfryHP7h4vd8r09z3gd644SBDCLlFnDpvZq5I=;
 b=k9KpiI3ICYYlWdAhy07//TL1ppYrl2W/6DCgZbWaO09owasM7Aqp0+jZf/AC2R4tGfhSBhylE8Oc9mnN71dA553AGLTjqs7qZFjv3D1ZyhrAiJ+Vhy8xFR9/qZXcBnHIB6iIzC8x5FtKDxvTXi39dX/mLamwQr+3pvELU6p5mDrqsSgCdre95t55FOBHanQjN5Qe4yxbPRRgJMeIH7S4DLxAH44a73OmldIOeCQhjrr/W05K5FdTf6H2Mq/Bnx0+Ab3lafdao9YK8lfvLsBpuJN/497DgKJJNWjKUQdpXFLC0YJAnPj/ck888Uob+pR08CuGvfN5Mk1opEswJ4FM0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+inPtlWfryHP7h4vd8r09z3gd644SBDCLlFnDpvZq5I=;
 b=pX1Wiaik4wJlqFl3vTH6lNi2zaIFEJyXyyHZkq7YDeFQsAnnB8tQZmipv3AO5L1lZ8bLT12ZjxFQmthgBddrdQfOg1hmU3Yepj/mFbx3/ugHjiqkRaXHlto0d6gAhaX+Ktl8P73063IL94NVb3O84duEmW2Gy18oNi0dEBQHunI=
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 by AM6PR04MB4837.eurprd04.prod.outlook.com (2603:10a6:20b:a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Fri, 20 Nov
 2020 02:04:02 +0000
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f]) by AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f%4]) with mapi id 15.20.3589.022; Fri, 20 Nov 2020
 02:04:02 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: RE: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
 controllers use fixed indices
Thread-Topic: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
 controllers use fixed indices
Thread-Index: AQHWvovBvcqJCTixR025fdiTeTkR06nQRXqQ
Date:   Fri, 20 Nov 2020 02:04:02 +0000
Message-ID: <AM7PR04MB688536E10A0B35D75A9F8F34F8FF0@AM7PR04MB6885.eurprd04.prod.outlook.com>
References: <20201119155025.965941-1-vladimir.oltean@nxp.com>
In-Reply-To: <20201119155025.965941-1-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7a7271ea-931c-4fa6-4a2b-08d88cf88d42
x-ms-traffictypediagnostic: AM6PR04MB4837:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4837AEF33477D14E2862FB02F8FF0@AM6PR04MB4837.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FsoI+diklFKYrhy/0m/n9IbYmacBgBo+eCz4YeIiWYGSKxw1iqsp+s50zr4LTZIxbNAf7dc9yb4ySMTh4Mz990E7RmeqN8zssIvtS/MAyVu7ULxwzAssmw6ln52fPYukI/xPuvG0fwY3BgB8+SWbx2uIDGA/+xJsVleAgJS5mcgnO9nOo5BaHlW4xISGV8LAceROtSp+30yJlgArlsWp8mnNb+mNjrDDujX8wCjU5JJ6GWB2rouBRYVZyiqhbcpiJaXFUi1b9ZqarFLq3Uec41Vdu44dkaQID50Nj09PvYt6n1cdr5yXM1wau/kTh0h4Mgm1HjMgJb0yItjkvSWSe6hrMG06rF0cYJD+EfOjIKvPT01XrTJ/vITjVOoqGmTkvYyiDSecbqVabt4RVE4U7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6885.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(4326008)(8936002)(8676002)(52536014)(66476007)(76116006)(66446008)(5660300002)(66556008)(66946007)(64756008)(86362001)(54906003)(478600001)(110136005)(26005)(9686003)(7696005)(2906002)(316002)(186003)(966005)(6506007)(83380400001)(71200400001)(53546011)(33656002)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: aAVQRZE83bwM5Tl+K2tCOuLyI7LNRHXAU9yALEakqnyns4RTOeSSFvcpgKJqW1FIyl5hUXGP791DofBFMH+wXRQJTD7Tk+N3eNZNQpzTQ6lGv79VSG6NZxvqea3f4aYLv1R303N/TTcE4ZbmHxQsNYP72CeNxzmRMlgnHCRQncvLy6y12zrLjQ8gKolbp4RSIxBF5EPoK5x8rXLISotbWX6DUbFwSz8eskabhmqgd6MRn9rdCeC13tCV7VTNiO0pMzEabvy0XQlXZWmowRuQleXC8QnAbtapyEZ43KLIixpSI3VaFC+oI5sA/mwOl52YR5XeOeS7ICUlwHyCAq4ZVVbVHnMVymIRrMBwY3LZs/vWvboap8/DN55pDRywILm1aPv8QSumTbgBin/GdmVbvYgiqdzbaNRzY+4goCsFBX1Zrihp1cJXLxpgkjA5D3VkxZG4uH5snCXC4DqxGpebMX5N5KOAXrp2Z9lDn5qNdflQ8vljD0XSsbm+TlR5ed9hFnShHI7wAVBNozfrxo+bWuddoHpqo2uXttdQvmS/sgUsf0aBUAhPrXIG/xkGF57d6lerE+pop8kXukupRbTJ991F874VEK4KvbGoYVwj/8M2sRG+/kW4O3Ulxy7BIWZg6hI/3YGcFDluov7KY0nUJg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6885.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7271ea-931c-4fa6-4a2b-08d88cf88d42
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 02:04:02.1918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ng3BucfDKdtodOxcguJCxwetatZ9reRPj1w2napaF4YwBw3Wg3VoU+SPoSGolQkJtNN/Et2dHUbG38intzvKNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4837
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Vladimir,

I have already upstreamed a patch for all affected layerscape boards.
https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/commit/?=
h=3Dimx/dt64&id=3D342ab37ecaf8c1b10dd3ca9a1271db29a6af0705

Please check whether it works for you.
Thanks.

Best regards,
Yangbo Lu

> -----Original Message-----
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Sent: Thursday, November 19, 2020 11:50 PM
> To: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org
> Cc: Adrian Hunter <adrian.hunter@intel.com>; Ulf Hansson
> <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org;
> linux-kernel@vger.kernel.org; Ashish Kumar <ashish.kumar@nxp.com>; Y.b. L=
u
> <yangbo.lu@nxp.com>; Michael Walle <michael@walle.cc>
> Subject: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
> controllers use fixed indices
>=20
> As the boot order in the kernel continues to change, sometimes it may
> happen that the eSDHC controller mmc@2150000 (the one for eMMC) gets
> probed before the one at mmc@2140000 (for external SD cards). The effect
> is that the eMMC controller gets the /dev/mmcblk0 name, and the SD card
> gets /dev/mmcblk1.
>=20
> Since the introduction of this SoC, that has never happened in practice,
> even though it was never guaranteed in theory. Setting
> "root=3D/dev/mmcblk0p2" in /proc/cmdline has always caused the kernel to
> use the second partition from the SD card as the rootfs.
>=20
> Preserve that old behavior by adding some aliases which create naming
> consistency:
> - the SD card controller uses /dev/mmcblk0
> - the eMMC controller uses /dev/mmcblk1
>=20
> The aliases are parsed by mmc_alloc_host() in drivers/mmc/core/host.c.
>=20
> Cc: Ashish Kumar <Ashish.Kumar@nxp.com>
> Cc: Yangbo Lu <yangbo.lu@nxp.com>
> Cc: Michael Walle <michael@walle.cc>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts | 2 ++
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts          | 2 ++
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts          | 2 ++
>  3 files changed, 6 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> index 8161dd237971..7d292999f8da 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> @@ -23,6 +23,8 @@ aliases {
>  		serial2 =3D &lpuart1;
>  		spi0 =3D &fspi;
>  		spi1 =3D &dspi2;
> +		mmc0 =3D &esdhc;
> +		mmc1 =3D &esdhc1;
>  	};
>=20
>  	buttons0 {
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> index 13cdc958ba3e..c0786b713791 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> @@ -23,6 +23,8 @@ aliases {
>  		gpio2 =3D &gpio3;
>  		serial0 =3D &duart0;
>  		serial1 =3D &duart1;
> +		mmc0 =3D &esdhc;
> +		mmc1 =3D &esdhc1;
>  	};
>=20
>  	chosen {
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> index 1efb61cff454..c1d1ba459307 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> @@ -19,6 +19,8 @@ aliases {
>  		crypto =3D &crypto;
>  		serial0 =3D &duart0;
>  		serial1 =3D &duart1;
> +		mmc0 =3D &esdhc;
> +		mmc1 =3D &esdhc1;
>  	};
>=20
>  	chosen {
> --
> 2.25.1

