Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B841C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Oct 2021 14:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A14B61212
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Oct 2021 14:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhJUOCd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:02:33 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:58432 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231256AbhJUOCc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Oct 2021 10:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1634824815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YycY/ISqb/TGWCnEJ3r8KJBhHzL4dovBMkP2Dh3MSco=;
        b=Mh06+LA3V4PFekA1rchhKtdn5yOjzpzKusoVTVI7w//l6ln817FU42tG7BX9+Mw9flA2tM
        gG08ND+yBsftVQTGEecwFBoMPoYiguEhchmyPzEyGwd1mPSOMMB4xqR5amLT4OyFB0tm1R
        Nj2Ky6Hcbgqg+/JhZZR3BUOXZsY6IP0=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2050.outbound.protection.outlook.com [104.47.14.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-25-xwYe7n8vNSKWZOwFqWhDKQ-2; Thu, 21 Oct 2021 16:00:13 +0200
X-MC-Unique: xwYe7n8vNSKWZOwFqWhDKQ-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m37tGLuyaoWG6ja2ZfCPoc/qPzSMk3/dZscwIkaoj6N9pIsRPY+PHpy3MvaYL4v5sVIpHBYkobfDzFoAXW3wPUzc+RhNN2NmAWieeaKqxEuMRDbCOcr2nnDLHUGDwGI/w0eC8T/UtTXgvg4dA+nl7MnZYZsVjEeFHjcL7YPAyO9gWZH5q4hmlIF+cKLmfc8XIBfNCoOnCdaogH8Kl3gQTsYrgRTBxEYBnu0CNHMAVDwY6Z+w6fF1l4wpo21CBhpY1fmbeRtGf8YImX6hboTq8bUGh8AbrT8nKy7wNmO1oi7b/mRBdpMWHguINL39bkJpFu+tijwQJDIxi7e4BnDS0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PpBqOfmdO9V2tSWfofZtZbpLiUL/z7AvnR6f1I8zus=;
 b=K+QTqFdXfh9EIcCzOOwi9Kzhzr1iaw85whqrHP6cP6ySkCZarh8QqzDqYOQQntmWJNnYxkLyvIqYkxQ2lCfnMJNWufxyUpsm5NaKsOnHXDfMiiIBfGKMBUEVb7NzyxAS5M09qxTKtG09ecEWiDS02wi1Y+sgnNctIjwMjI64XpOK13Enf8Az1iCdnwdWy1zDg2ZnZMl3hssO7fQusYjFehsOKqqCEzFuNHKcCIyb0MaymZ6ucrrFy6/q2nbGRQO4Ps+7O01SViL6p7Wu6RtNzYmvBaxN+05HEiE2sgB3FNjzkrKYpnwbF7rOUp+IcYmdxT68EI6CGQWL+xpo3/64cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VE1PR04MB6496.eurprd04.prod.outlook.com (2603:10a6:803:11c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 21 Oct
 2021 14:00:12 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde%7]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 14:00:12 +0000
Date:   Thu, 21 Oct 2021 21:59:56 +0800
From:   Chester Lin <clin@suse.com>
To:     Bough Chen <haibo.chen@nxp.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>, dl-S32 <S32@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Radu-nicolae Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        "Ivan T . Ivanov" <iivanov@suse.de>, "Lee, Chun-Yi" <jlee@suse.com>
Subject: Re: [RFC PATCH 2/3] mmc: sdhci-esdhc-imx: add NXP S32G2 support
Message-ID: <YXFyXDv2FVV2Smk1@linux-8mug>
References: <20211021071333.32485-1-clin@suse.com>
 <20211021071333.32485-3-clin@suse.com>
 <YXEXMGGiVOiLZ0H9@linux-8mug>
 <VI1PR04MB52943C2FF87D6C95639F282590BF9@VI1PR04MB5294.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <VI1PR04MB52943C2FF87D6C95639F282590BF9@VI1PR04MB5294.eurprd04.prod.outlook.com>
X-ClientProxiedBy: AM6P194CA0041.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::18) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
Received: from linux-8mug (118.166.56.207) by AM6P194CA0041.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:84::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 14:00:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae71e323-6df4-4256-6fa5-08d9949b1931
X-MS-TrafficTypeDiagnostic: VE1PR04MB6496:
X-Microsoft-Antispam-PRVS: <VE1PR04MB64968147208F467E7B43E011ADBF9@VE1PR04MB6496.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YCMSmQgMR1MYxYKDpKnfVwSpLW7hgyvcbTc1k5Sjgl5MU2KZEXflE+onqQCx1UFm0MAWU353kpwc5q8PlOKiEMzrrIFolx52z+DaMK7eNNqw0tnRRyeJsuh6tNdu1GFShY8VyzxuYrmlyyp/7VUmgc+QND8Sg798Ul8+QMfkFO96cSt6kWrgQ2TAPFkwMRCc4/S3GSrfxvHqt+v+3xQ9P9dXOI4r8e5ZqU7WwIqksH6FuB9TcghhRaolwdqtwdwNv4KAxNqVnLav0LH1XPCYRG3+5BoMATPAEgP+ayr9/WnaYGQCpsgTg602zwvysRKQ28REFiwP8S/kGnLrmH/5BgOgLTStQt2QL10uHq8Ml/zQCwr3ELHKamvOy0pJSadfltjjyvdwzei99jeCFRiXqAEKKypanBfX8OPzcMoaSZJorURkUhKdNzPM8MlrxKBWo8haT/Uelzqi5LBn/L8X5PGy6u5EPVPUlmY0ZykUdBxa5Yhn+MvprgdJ4JhJWzJTeLccJg0YV7marAsmleL1y1hKo2jNPoQthnlT0lEzdM87phOFXo+j6JypIm+6nUYIF/HzByf7KU4/nKwigyim/af7FD3u59w47qW4VX5bcJWt8F0b7dqGJtE3TJ8D2Akd5+ixE8uH/EeoK/1ITxBIKKiJfh6Id3+EzlL0Q17pRf8GcljLFo9wPpP04aHEhH9XKwVJHsE15CPxIXW5vvVc/RUf8wgVzlYsaXg/utzaKgU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(83380400001)(55236004)(508600001)(6496006)(2906002)(38100700002)(45080400002)(66556008)(53546011)(33716001)(8936002)(4326008)(6666004)(66946007)(66476007)(316002)(86362001)(54906003)(5660300002)(107886003)(966005)(55016002)(7416002)(956004)(186003)(8676002)(26005)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RyYQ7h0N4ru91Dma2I+POvEtKIWkNwFDRLF7QrNEAdulycQNn/gdW4PPrnAF?=
 =?us-ascii?Q?XADvBsEXWlLBJBhSO0h6NCdYw4Jg97TeyGESxovBTS6lH15vFpXXjYdvsfRC?=
 =?us-ascii?Q?pUwYg98GsDesjSYiRuGE9NSepG0Cl4SBx8RIFNmNzvkvXSgasqld7+ix3QPL?=
 =?us-ascii?Q?JDOYwsXuuxngsa2ug3qJHywnKRsd/vJjuO/rDA439etdCWhmgHMLUPRscsvK?=
 =?us-ascii?Q?ki5QZs+ZiVXpk2/kk7rnKm2uTb5zlUwodl5RFMbBpNej69iDXtQqppcdGSzc?=
 =?us-ascii?Q?05K6hlOJM8ECmJSZlRTUWDWAs+TsdtI3slsjEJtxHnsXOuWGlhcqjmMSAwol?=
 =?us-ascii?Q?k09uUcfZ3SjFDacRu9SEsFZ6RWYqGFQsM12ROIm3vflLiipHAuyZTKiJ/Ww8?=
 =?us-ascii?Q?+A65czzGTy5mhui1WAjGKDcAySETCpavMSo/KD+0oOi0Bik1bEDtivcrQJsm?=
 =?us-ascii?Q?CxP/p9BySzC9t8uG9ruQC8bOvLYFVi+dVJMwPxUVWuveld2VmNcTHqdDHrki?=
 =?us-ascii?Q?UH/rubnm/Vkx8bXwAt+SLhM7x9c3Q0EV65tIdHHuG9Bd4Iu7ljk60/8XnNlb?=
 =?us-ascii?Q?fS3Omn3LQiTv6iq3n3gupLHXevJfANfp4O1vmRWlzBuGMvsspN/c9IMnPpQz?=
 =?us-ascii?Q?gXNUGAwWg1hEQzdMQBMIraoWFQNJ40iJq6Sw10EzStVZPBN2umTthq8wtPSe?=
 =?us-ascii?Q?lXqqbTNe4mtsOEnK5dvDGxMzWCtbC1ZNbJzwGjOIQYx5hBf5nA7kI+DTUHzR?=
 =?us-ascii?Q?U4CJqJe0WAF3rFx/Q/B95OCPYv409EntLYNOAnXmlHE5uzQ8QB6KV13T2QZT?=
 =?us-ascii?Q?5SXy8o1rWCqiEaEKq5oRe4zd1ZWaL9XXc3FS/8hwE+ZuLYBtiDHP1T7Lz5sr?=
 =?us-ascii?Q?vjhtj3d0Jf1xkkPfT9iLn/G5w20qpH6fTbF//Q/ng1JFPkPMHoEhrgimQy5A?=
 =?us-ascii?Q?jT2U/P1R395WfTM4CS/OPNxNX71fJdDO/Yy1eVc349JNWUdEOv4cKi9GuVov?=
 =?us-ascii?Q?r+WLaxEfke6sYjkP44pyCgdshl0pL/EcHOz0aofOvm8VimcOv8fJ2wpuZUog?=
 =?us-ascii?Q?gleBiWEFK5AxcLD84bR97HGKdmMlLGVKKxzdVE2V5njLnIhVxWVPaXBRELYk?=
 =?us-ascii?Q?51HuLFBcUF88/oiz1hiw81rU0RribmCHTNpiWcUFHmLj1yh5kMuZpTeDP9/0?=
 =?us-ascii?Q?jTJ0dWSFFQV6dEhWwLgHVAPtXzCmfYWzLrOuT85C2IJNpE1iV1h8rzMU1oiS?=
 =?us-ascii?Q?BgpwCrPPBr5NTz460CdpnzD6zPKzXGWnL4QX7bX5uZXtGjSRssnzMnpwqJom?=
 =?us-ascii?Q?BtNfiJ2UKrLWfHD0Kc8oAlDSECT/0ViD8vs5D4XFNn9qXd9wwXqVYjKD4uV6?=
 =?us-ascii?Q?sLmFi2nmz+5YRgaT7qMhbgBU9rZlglhTwXENYSd3ppn9fhAnNZDz50g82yHc?=
 =?us-ascii?Q?5ZFBR664b1g=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae71e323-6df4-4256-6fa5-08d9949b1931
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 14:00:12.2792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clin@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6496
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Haibo,

On Thu, Oct 21, 2021 at 08:00:43AM +0000, Bough Chen wrote:
> > -----Original Message-----
> > From: Chester Lin [mailto:clin@suse.com]
> > Sent: 2021=E5=B9=B410=E6=9C=8821=E6=97=A5 15:31
> > To: Ulf Hansson <ulf.hansson@linaro.org>; dl-S32 <S32@nxp.com>; dl-linu=
x-imx
> > <linux-imx@nxp.com>; Bough Chen <haibo.chen@nxp.com>; Aisheng Dong
> > <aisheng.dong@nxp.com>; linux-mmc@vger.kernel.org
> > Cc: Rob Herring <robh+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>;
> > Sascha Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; Radu-nicolae Pirea (OSS)
> > <radu-nicolae.pirea@oss.nxp.com>; Andreas F=C3=A4rber <afaerber@suse.de=
>;
> > Matthias Brugger <mbrugger@suse.com>; Ivan T . Ivanov <iivanov@suse.de>=
;
> > Lee, Chun-Yi <jlee@suse.com>
> > Subject: Re: [RFC PATCH 2/3] mmc: sdhci-esdhc-imx: add NXP S32G2 suppor=
t
> >=20
> > Hi NXP S32 and i.MX Linux teams,
> >=20
> > On Thu, Oct 21, 2021 at 03:13:32PM +0800, Chester Lin wrote:
> > > Support the SDHCI controller found on NXP S32G2 platform. The new fla=
g
> > > ESDHC_FLAG_SKIP_ERR004536 is used because the hardware erratum bit is
> > > not applicable for S32G2.
> > >
> > > Signed-off-by: Chester Lin <clin@suse.com>
> > > ---
> > >  drivers/mmc/host/sdhci-esdhc-imx.c | 17 +++++++++++++++--
> > >  1 file changed, 15 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> > > b/drivers/mmc/host/sdhci-esdhc-imx.c
> > > index f18d169bc8ff..d0f7d46a0354 100644
> > > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > > @@ -196,6 +196,9 @@
> > >   */
> > >  #define ESDHC_FLAG_BROKEN_AUTO_CMD23	BIT(16)
> > >
> > > +/* ERR004536 is not applicable for the IP  */
> > > +#define ESDHC_FLAG_SKIP_ERR004536	BIT(17)
> > > +
> > >  enum wp_types {
> > >  	ESDHC_WP_NONE,		/* no WP, neither controller nor gpio */
> > >  	ESDHC_WP_CONTROLLER,	/* mmc controller internal WP */
> > > @@ -289,6 +292,13 @@ static const struct esdhc_soc_data
> > usdhc_imx7d_data =3D {
> > >  			| ESDHC_FLAG_BROKEN_AUTO_CMD23,
> > >  };
> > >
> > > +static struct esdhc_soc_data usdhc_s32g2_data =3D {
> > > +	.flags =3D ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
> > > +			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> > > +			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
> > > +			| ESDHC_FLAG_SKIP_ERR004536,
> > > +};
> > > +
> > >  static struct esdhc_soc_data usdhc_imx7ulp_data =3D {
> > >  	.flags =3D ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
> > >  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200 @@ -347,6
> > +357,7 @@
> > > static const struct of_device_id imx_esdhc_dt_ids[] =3D {
> > >  	{ .compatible =3D "fsl,imx7ulp-usdhc", .data =3D &usdhc_imx7ulp_dat=
a, },
> > >  	{ .compatible =3D "fsl,imx8qxp-usdhc", .data =3D &usdhc_imx8qxp_dat=
a, },
> > >  	{ .compatible =3D "fsl,imx8mm-usdhc", .data =3D &usdhc_imx8mm_data,=
 },
> > > +	{ .compatible =3D "nxp,s32g2-usdhc", .data =3D &usdhc_s32g2_data, }=
,
> > >  	{ /* sentinel */ }
> > >  };
> > >  MODULE_DEVICE_TABLE(of, imx_esdhc_dt_ids); @@ -1359,8 +1370,10
> > @@
> > > static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
> > >  		 * erratum ESDHC_FLAG_ERR004536 fix for MX6Q TO1.2 and MX6DL
> > >  		 * TO1.1, it's harmless for MX6SL
> > >  		 */
> > > -		writel(readl(host->ioaddr + 0x6c) & ~BIT(7),
> > > -			host->ioaddr + 0x6c);
> > > +		if (!(imx_data->socdata->flags & ESDHC_FLAG_SKIP_ERR004536)) {
> > > +			writel(readl(host->ioaddr + 0x6c) & ~BIT(7),
> > > +				host->ioaddr + 0x6c);
> > > +		}
> >=20
> > Hope you don't might that I raise this question here. Is it really nece=
ssary to
> > unconditionally apply the erratum bit even if some SoCs might not need =
this
> > workaround? From the S32 implementation in CodeAurora[1], I noticed tha=
t
> > this bit is not required by S32V/S32G so I wonder if there's any better=
 way to
> > refine this part?
> >=20
>=20
> I confirmed with IP owner before, for SoC contain this errata fixup, clea=
r this bit 7
> will enable the fixup, set the bit 7 will disable the fixup.
> For SoC which do not contain this errata fixup, this bit 7 has no definit=
ion.
> So it's okay to clear this bit 7 unconditionally.
>=20

Thanks for your reply. If I understand correctly, this bit should be almost=
 the
same even if the IP can be used in different SoCs. Actually I haven't found=
 an
issue even if I have tried to clear the bit-7 on S32G274A although this pat=
ch
just gets the driver working on S32G, which still has limited functions [e.=
g.
pins_100mhz and pins_200mhz are missing]. I just wonder if any case should
avoid touching this bit since the s32 downstream kernel has a specific hand=
ling
for this part.

@NXP S32 team:
Please let us know if any concern about this bit.

Thanks,
Chester
>=20
>=20
> > Thanks,
> > Chester
> >=20
> > [1]
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsou=
rce.
> > codeaurora.org%2Fexternal%2Fautobsps32%2Flinux%2Ftree%2Fdrivers%2Fm
> > mc%2Fhost%2Fsdhci-esdhc-imx.c%3Fh%3Drelease%2Fbsp30.0-5.4-rt%23n1268
> > &amp;data=3D04%7C01%7Chaibo.chen%40nxp.com%7Cec36a273354b4b66c45b
> > 08d99464c449%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63770
> > 3982782606697%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> > QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Dhvzsy
> > 3W%2FpKXBmXxS8%2F73huzb157a%2FuHa5G4lFWj5ABQ%3D&amp;reserved=3D
> > 0
> >=20
> > >
> > >  		/* disable DLL_CTRL delay line settings */
> > >  		writel(0x0, host->ioaddr + ESDHC_DLL_CTRL);
> > > --
> > > 2.30.0
> > >
>=20


