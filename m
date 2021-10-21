Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0384C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Oct 2021 07:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB36D60F9F
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Oct 2021 07:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhJUHYD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Oct 2021 03:24:03 -0400
Received: from mail-eopbgr50087.outbound.protection.outlook.com ([40.107.5.87]:1126
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230095AbhJUHX7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 21 Oct 2021 03:23:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbtvGcau3kuGj0JtpjYfdcmWgMOreTK5WAquS60/SBS1arkFc15NV9h3Z+pn/V1MHdjZN34G6uiiXDvdzQwQ6sE9iR+/Zj9R5I8pfl7Zn934chWqPed4RCMtcsZoQWiE19N5RgkgIkedPgogpz/kXC3oAxTw6SJIeogZUa2Po607+DVYGEieYiDHBwN8+LQvMkqKHCYBF2VbyCMbfu4Kw2ej2ATMDwJd42KvybE5mwHfB1J3tZCY8PINKwx6pzGWhPx+jYvyH9ooi3s2fAgq1E4/KlLVE+KuVXOLneDUsgRL3y7VUC2XgcYpWhYGnKcFXDpLfj7Rk6zrEwnBFUevMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dossIH81Dbn7e/ha4kx1vFpLZeBrU6zII1Gv3tK3BwQ=;
 b=RkZrCl+XRfR83BUzSALUF6YSG9DIcMnW6Pf6iUt1XdNAvErmcVzIx2m8Cka+1wAr3qM4It4aCBaEEzNFBlqHchY61WZhYATFOZqqPdZpCjUofozjXIoXL5nD/PFVQ6fLxq+PZA8EXUG52HzbaDRq26WxXQxqBXJ91wuWqGGH3hyibIrJHWwoonTIuO8zQykAqWc1PLyOhc7w1+ovaCKfoT12ZrSWRHl3ABvuVZCL+33LWB+MWuhzKI+Ba7cphuCN92r6ThxUYBmKDa2SbeAJ5sisvHwXXuFiDcP829SeSPD6sL54iwX8D90P486Mkp5PKDLhNWBOs+vlNeJR4MLhhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dossIH81Dbn7e/ha4kx1vFpLZeBrU6zII1Gv3tK3BwQ=;
 b=Po1YeC2JKhFz1tHsoEh7yHLEuk2D8s1K1I51WWs8FPkSE15dvNlyBgXe2WKY1K7JLrd+/xrVXmFKNNSVbBggALRDEcmSlPHGog2W7BJtLFa8PR9v80N+/tpUN/7jvHXquEy6ikiEzm/Tj4lUliBscZGUROoytkzx5RWgU2mah8Y=
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com (2603:10a6:803:5a::22)
 by VI1PR04MB3199.eurprd04.prod.outlook.com (2603:10a6:802:3::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 07:21:40 +0000
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::6c18:7e06:8efa:c8c9]) by VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::6c18:7e06:8efa:c8c9%6]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 07:21:40 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Chester Lin <clin@suse.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        dl-S32 <S32@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Radu-nicolae Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>,
        =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        "Ivan T . Ivanov" <iivanov@suse.de>, "Lee, Chun-Yi" <jlee@suse.com>
Subject: RE: [RFC PATCH 2/3] mmc: sdhci-esdhc-imx: add NXP S32G2 support
Thread-Topic: [RFC PATCH 2/3] mmc: sdhci-esdhc-imx: add NXP S32G2 support
Thread-Index: AQHXxks6gGPmv4zpGkyIzNunP0BeP6vdC0Hg
Date:   Thu, 21 Oct 2021 07:21:39 +0000
Message-ID: <VI1PR04MB5294A2C3C85714C79AF4730590BF9@VI1PR04MB5294.eurprd04.prod.outlook.com>
References: <20211021071333.32485-1-clin@suse.com>
 <20211021071333.32485-3-clin@suse.com>
In-Reply-To: <20211021071333.32485-3-clin@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65656afb-8c9b-47e1-bd06-08d994636cf9
x-ms-traffictypediagnostic: VI1PR04MB3199:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB31999C3C17D32F0FBB68562090BF9@VI1PR04MB3199.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:773;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6DjZLxFQl/TgNTtkSvvqV7VMz19L2gdduYKyh0RDVAxFFZUygTT8mafeijcvMrae607Ik6w/IKmI3lIspIYSplsevYTwDveBPbhk2g8N2AoqPvGt41EWOYKVvHZ408UgumcRBY2TFUNG9U31j2u2NGHkXFE7xdmOKdlLMt6S+0PvaoAglIXlNgkeUuynTazeJ8eu5n4u/2upMx4sN0SVGEQh7Wnb96Hj7ZyiDHxQIqAQpxs6vLutaxa2r3YiFYgQQwT3DAMkzNVJGull5FD97TU/CM54IRZo9kwO+a8aujAZSxD9n2b6RZE3MJ5xorQerEC7V0Xu+jAVWlh3+Af57uMSm/K/rQLvKqldlbJvGk4h9klB8TmeY5WXIlIR6MCPcVqxtNnQwnlMFtNnz+NenebgzndjnuinroQ/IQ4oWC7cbC+bUZAWg5yq0q8Nq3eK+b/bBVZvdugaQ/boURZyO1dQF7rJE0LRF1R2X95lBHPm5eeShdGaMSLE59mdlY3v3Y55/qe0130ZevtdoTSae57t+rRzIhMZTuC+NKZaNAA48GsO9pbCeUOu3Ut0cX1fOi9WpSjfU7cMPu63S4H6PTUrZeFbmcTJYeR1oW6JG9pfxN8fpSnjew05EogpwRuBpIKn48qbIDGpyWuPuNuPeao/2UL/5hqnapEsvCzOQ3a4jCQLnTZ/JYvDVIsS8XsM0XU66XY5kt/MhypXnjZKaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5294.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(38070700005)(110136005)(64756008)(26005)(99936003)(7416002)(7696005)(53546011)(52536014)(9686003)(4326008)(76116006)(5660300002)(38100700002)(66446008)(8676002)(6506007)(66946007)(33656002)(2906002)(71200400001)(66476007)(122000001)(55016002)(83380400001)(316002)(54906003)(86362001)(186003)(508600001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlYyWWxSbmYyL2YvcnZTMlhvclBIUzF3YzhwcXFkdURyZlJLekswRmVNY1d2?=
 =?utf-8?B?cmVYMERQN0tBdHE5TjB0ZCt3SkJOMmp0aWNHNVp1ZGgwaTU0SDhCZEVSN3Ri?=
 =?utf-8?B?NVI1VUcxQ1Q4OHdiVVRENHBmYk8yUmRLZ2VUWmNkYzVBQ3dvUFhESHloU2ho?=
 =?utf-8?B?N29XYStoODdMQ04rYW5QV3VoZUZJUDVWMExFWmE3RldUU1g3dUg1N2tPZjdo?=
 =?utf-8?B?bmhuZlg2d21SODdmcnFUZllLTnY4QXpWTE9hUXlzaG1PYnRucWVIRzVBSy90?=
 =?utf-8?B?L3ZFalpGSk1TS1V2S2U1ZmR0VndJQkxOUWFuRVRRYXB6RUQxZmlBREc3MEVp?=
 =?utf-8?B?TDRiUWMzYXo0L0NzZTcvVEFHWjcxcVhIZHZneVJJb3hwZGZuTSt6SWlYYmdp?=
 =?utf-8?B?dTJiN05tV2dvNFZjZ0p2OVU4d1kxUFg5ZlVZV0phNWpYZHcrVmN5VENXVFUy?=
 =?utf-8?B?STN0bER1L3lONVRlOGpaeEs5ZWFMbDlJd1dOT0w0cE9PbTBQb3gwYUpHU24x?=
 =?utf-8?B?SUEvMHpXbFhPQ3BZK1JLcE5vZEpLMG9xYzlzS2R6VVh2d3VXS0krT0U2Q2lC?=
 =?utf-8?B?MjFTNVQ2c2dXQUkzMGRpYTNqMlhSeGZQSFAwUzgweU1qQjdtZDRKNVVtZUxt?=
 =?utf-8?B?d0RIa1ZQdjh5K3JhMXlBYUxpMXhjYUdKZS9HYlF1SUFtdGJBS2N5NCtmKzBy?=
 =?utf-8?B?M2x2Z0F2QkRBWXNwQzdYQ2o3cUd4bEYrTUV1TWpORHdFVDlSNkFFaUVucXFq?=
 =?utf-8?B?NFAzMjE3NmwvUXFtSGx5ZklOTjB6SjlkcCtjRUh6WnoxL3I3L0ZxQ0lzNnU3?=
 =?utf-8?B?Mzh5azVJK1dicEFCeGlhQmtTOVZ4RkJMbVU1UmRLTlZYTUJ5SWtrbDVjbDF2?=
 =?utf-8?B?VXhoMG5WSHpVOHdwZFQxVC9rSXJ1WFpPNDhpV1RWYTVwai8rVGlmOWVTWGhG?=
 =?utf-8?B?VU9pYWRqdkJqZ2dDWExyMUlKRTBuRnJWejViMFhBdGN0Y3lBNVpXdDlsOVVs?=
 =?utf-8?B?K2ZNK2JzTmluR1M0VzdrelhtZzJYcGxKVDhadWdZRFhkR0h2SDdLekEzc2Rt?=
 =?utf-8?B?ZC8zUmVuR3U2NkxBMStRcmZkelhVOUNrV3cxTG5sRHlrNmVZTUVFSnVsMXp5?=
 =?utf-8?B?RXZGa0VLdEpMNWtsbzRMZk14ZFZ3RW1KVUc5em56MmVSWDZOR2ZpcGMzZmYx?=
 =?utf-8?B?VTZLMUd6M3kzaDlVS2h0MUphTjVhMkVKVi9lSnJzb2w4OUNaVGhVUnBDWWxq?=
 =?utf-8?B?c2h0QzFSdFo5VFlScFQrUHBEaFU5NGZKenhGQnlCNHhhU293ZGM5eStEZ3Zo?=
 =?utf-8?B?V2p5YS9EVElJVW5RdXJjWHhWckVpTWVMTlovYnozNGpzRFJHSFRVMTgzYU5o?=
 =?utf-8?B?OUVyV2p1VHBVNGlCd1QrODc1TklJa1AwcllOVlpiRkljUXhGRjRwdWdhaURi?=
 =?utf-8?B?VmJ4bE5SRFR1KzlUSGdQdVdxRGNMN0x2OFJMQ1hWRmZjNXk3YThIcDF4cGlI?=
 =?utf-8?B?bWhkRHdJUStyaGVaZGJTSXZHU0Y5Q3ZiUGx1ZHRTYmsyMkgyemR4UHZVZnVH?=
 =?utf-8?B?ZXFwQW8zWE16Z1JjWTZuMWgrSGlTYnNIMDNQRkpCakc2djM5QUw3RVhLL3dH?=
 =?utf-8?B?aTUrY3JmQWJUdzd5RzBTbXZVY2RzbDRiY3k1UWFDWjU2Y1NUQWU1Ym1wcnJ0?=
 =?utf-8?B?dWMxaFB2Z0xneFQycTNQZ0lTUUhnTVVpL1BQelNMb1h5YWpRTVNEaVVobkdD?=
 =?utf-8?Q?Hbn0M42hVpc+oAupizu52+l5eSJmMpVuO2E74y3?=
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=SHA1;
        boundary="----=_NextPart_000_01FB_01D7C68F.56C56900"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5294.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65656afb-8c9b-47e1-bd06-08d994636cf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 07:21:39.9235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: haibo.chen@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3199
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

------=_NextPart_000_01FB_01D7C68F.56C56900
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Chester Lin [mailto:clin@suse.com]
> Sent: 2021=E5=B9=B410=E6=9C=8821=E6=97=A5 15:14
> To: Ulf Hansson <ulf.hansson@linaro.org>; dl-S32 <S32@nxp.com>; =
dl-linux-imx
> <linux-imx@nxp.com>; Bough Chen <haibo.chen@nxp.com>; Aisheng Dong
> <aisheng.dong@nxp.com>; linux-mmc@vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>;
> Sascha Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; Radu-nicolae Pirea (OSS)
> <radu-nicolae.pirea@oss.nxp.com>; Andreas F=C3=A4rber =
<afaerber@suse.de>;
> Matthias Brugger <mbrugger@suse.com>; Ivan T . Ivanov =
<iivanov@suse.de>;
> Lee, Chun-Yi <jlee@suse.com>; Chester Lin <clin@suse.com>
> Subject: [RFC PATCH 2/3] mmc: sdhci-esdhc-imx: add NXP S32G2 support
>=20
> Support the SDHCI controller found on NXP S32G2 platform. The new flag
> ESDHC_FLAG_SKIP_ERR004536 is used because the hardware erratum bit is
> not applicable for S32G2.

What's this bit7 definition on S32G2 usdhc?  Any issue if clear bit 7?

Best Regards
Haibo Chen
>=20
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> b/drivers/mmc/host/sdhci-esdhc-imx.c
> index f18d169bc8ff..d0f7d46a0354 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -196,6 +196,9 @@
>   */
>  #define ESDHC_FLAG_BROKEN_AUTO_CMD23	BIT(16)
>=20
> +/* ERR004536 is not applicable for the IP  */
> +#define ESDHC_FLAG_SKIP_ERR004536	BIT(17)
> +
>  enum wp_types {
>  	ESDHC_WP_NONE,		/* no WP, neither controller nor gpio */
>  	ESDHC_WP_CONTROLLER,	/* mmc controller internal WP */
> @@ -289,6 +292,13 @@ static const struct esdhc_soc_data
> usdhc_imx7d_data =3D {
>  			| ESDHC_FLAG_BROKEN_AUTO_CMD23,
>  };
>=20
> +static struct esdhc_soc_data usdhc_s32g2_data =3D {
> +	.flags =3D ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
> +			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> +			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
> +			| ESDHC_FLAG_SKIP_ERR004536,
> +};
> +
>  static struct esdhc_soc_data usdhc_imx7ulp_data =3D {
>  	.flags =3D ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200 @@ -347,6
> +357,7 @@ static const struct of_device_id imx_esdhc_dt_ids[] =3D {
>  	{ .compatible =3D "fsl,imx7ulp-usdhc", .data =3D =
&usdhc_imx7ulp_data, },
>  	{ .compatible =3D "fsl,imx8qxp-usdhc", .data =3D =
&usdhc_imx8qxp_data, },
>  	{ .compatible =3D "fsl,imx8mm-usdhc", .data =3D &usdhc_imx8mm_data, =
},
> +	{ .compatible =3D "nxp,s32g2-usdhc", .data =3D &usdhc_s32g2_data, },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, imx_esdhc_dt_ids); @@ -1359,8 +1370,10 @@
> static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
>  		 * erratum ESDHC_FLAG_ERR004536 fix for MX6Q TO1.2 and MX6DL
>  		 * TO1.1, it's harmless for MX6SL
>  		 */
> -		writel(readl(host->ioaddr + 0x6c) & ~BIT(7),
> -			host->ioaddr + 0x6c);
> +		if (!(imx_data->socdata->flags & ESDHC_FLAG_SKIP_ERR004536)) {
> +			writel(readl(host->ioaddr + 0x6c) & ~BIT(7),
> +				host->ioaddr + 0x6c);
> +		}
>=20
>  		/* disable DLL_CTRL delay line settings */
>  		writel(0x0, host->ioaddr + ESDHC_DLL_CTRL);
> --
> 2.30.0


------=_NextPart_000_01FB_01D7C68F.56C56900
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

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
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
9w0BCQUxDxcNMjExMDIxMDcyMTM2WjAjBgkqhkiG9w0BCQQxFgQUd0PwiMzhtbQv3TNTXahuQxdL
0IowgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAoGCCqGSIb3
DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAhow
CwYJYIZIAWUDBAIDMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgEwgd8GCSsGAQQBgjcQBDGB0TCB
zjCBtjEcMBoGA1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwCSVQxETAPBgNVBAoM
CE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzAR
BgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNj
b20xCzAJBgNVBAYTAk5MAhMtAAbHVf9AFft39E7nAAAABsdVMIHhBgsqhkiG9w0BCRACCzGB0aCB
zjCBtjEcMBoGA1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwCSVQxETAPBgNVBAoM
CE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzAR
BgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNj
b20xCzAJBgNVBAYTAk5MAhMtAAbHVf9AFft39E7nAAAABsdVMA0GCSqGSIb3DQEBAQUABIIBAAN8
+eaPmpl8azKXX8CrbHSqFFZRimL4eHIkLePajAtljZk0/7y84vLPS5z9aAOIrMUI+zkvNodkjv+Z
IWbu+3SyBj2fzoG0zEBIBF4IzocdtMpgmsazwsSBHWZrHog4iM1KiIopZzrziMEiEdanYmIPOdKQ
i9PjnvhnryK4oBCOalXNyTBUfF7awK2cT9gsfiSkuxI/1vuSUDRBPiFke71GMoVqDhbzavdk30b7
BKRhHl7nQ4OGbyenOruhznd1TverJJBttwAkffSDJKj5aqb9YjTAUSD8BWXWUbg3fU4F7cSo5c0q
sbPzmTnUB5aw1Fs4ydGsFk0/cecuRfqEcD0AAAAAAAA=

------=_NextPart_000_01FB_01D7C68F.56C56900--
