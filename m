Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011036.outbound.protection.outlook.com [52.101.70.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F363E9C33;
	Thu, 25 Jun 2026 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404983; cv=fail; b=e25Fz2mW9XF2Hfea123oMfFMlLJc2dsK50ERZ0aBT8Ty9xdS0lbCJCYvD+y3Chso0edZ5tObB5WleNK5yDYA3e2Sro6jwoAYR0crd0H8pLkaY/R7nJfgwuSQ5vWk0k+gQbRL7X8bMj3Jrib0N+9m2S137M9ZYGiBxE0nAtWW0sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404983; c=relaxed/simple;
	bh=eYw0n9GMOZL3WYpe4o7SYP4GQPyVe3F5f20owxSyPyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B1lrJkuVpEoIZ1gHUd9Z87gV8weiKQ6DLGeFErnfwU3DzI50KNUHKvh93ibFky2kcEMtDubuP/MKURltrQCAF6qmfeUjUcti+6SlKQonCSTLW5IB6fJ3op4PFVk8Wo016h2j0d40kfX8hTZTK632i3dOtOlhVOHruPU1KBB14Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=iFmL86AZ; arc=fail smtp.client-ip=52.101.70.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iFmL86AZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwtMTRYdRQ4cKkNlQPbx76f/AF2R68k0d3QmYp+4Vmahc6txcDGReKYuPxY5BYRt3ZC5TPcbc0SXEfP18/25d/6q30eOSsf2Dz5sNkEH2JDk5wXUrUEz/D67CJjxjaGa9wUcwJLOI8wm6XtAe9BL+XFhHU2Kr9avzEZyecJ2SLx5VB5+TVOl9lPYMtS4o2ekja9/OPL929hSJ1Ubai9FC9iZsrtgAtzSYY/nS5MkJ/2tVNrTL0ZNsxE2pFxawAZh68ZJkUJ1WZuJTNqN040UAT14cHbDYaJuaBEv9YwlsrnWsYUALPGNnzvAju8FGAG0i0aO1trHUm+9ABV/luvP6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0o3xlffAcV6/W+i3rEbsmDKBGwZEe7yj17IqWTbrRo=;
 b=lSGYqOBJepRxBCHoAY/Cb0ov3zpXaGdDxuift6zX21lGaUye4ookXfBneTMig57edB5fzk8PP82Zrc7bcu7tCqui63icKx6G4PsdXFvpgRpr+DNmY2osjd+bIx3uzN4ajqJGa6ezJelK0VQ5BQUrwlHZgppUoztWfGX8uRNHLSDXPYlrhoAwfGVRdo255IDZFHkkERpXRROT2p5UehPU2z+qR7ViX747qF7L9/lgqsboAveZh0MxpnuXwhDyqjwU5qNZScigf5ZWQageNb5yXq1ZiFVziuWk/dS4TlkYdVg0tU/cCTtmDmF7cL/70Yt1kMKuLg9z6GbBaeyxjoiklg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0o3xlffAcV6/W+i3rEbsmDKBGwZEe7yj17IqWTbrRo=;
 b=iFmL86AZu9TIkvQv68JnrKYsvp+LPpj3EY6Si5O5SyUzptiz3iRy+y5g1BjVO14yaymj5U8tfTFI1+RZPqvy/6Xdw/9XIHkvdb2iXZ5jClNL7rCLKVyJWxyeeAUt/kSMtTVO1O8dZ3qV1hjGuQ4/UxiXhNS7xk36rMPBUissB6OdmSI/WC2Ofu4vsTsAOsvy9qoLk1aPUGqqBfxeos6EBcjSOh/3UJAXQy/raR2OS1sth5iCF+oKXsz6CiMBH4gX5ulGtwtYOu62wagmgQhcuSK7plDNQqf6rg7lQJ7wQro2wyi5/QUsdtUUuryAX29Tzr6C2l19ikjoNhFWIq0nkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB12005.eurprd04.prod.outlook.com (2603:10a6:800:310::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 16:29:38 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 25 Jun 2026
 16:29:37 +0000
Date: Thu, 25 Jun 2026 11:29:27 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: ziniu.wang_1@oss.nxp.com
Cc: adrian.hunter@intel.com, ulfh@kernel.org, haibo.chen@nxp.com,
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev, linux-mmc@vger.kernel.org,
	s32@nxp.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] mmc: sdhci-esdhc-imx: restore DLL override for
 DDR modes on resume
Message-ID: <aj1XZ-5bgkGDD2eh@SMW015318>
References: <20260625105934.2890635-1-ziniu.wang_1@oss.nxp.com>
 <20260625105934.2890635-3-ziniu.wang_1@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625105934.2890635-3-ziniu.wang_1@oss.nxp.com>
X-ClientProxiedBy: PH8PR20CA0014.namprd20.prod.outlook.com
 (2603:10b6:510:23c::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB12005:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dcd8919-50dd-4d23-ea58-08ded2d6f301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|19092799006|1800799024|366016|18002099003|22082099003|3023799007|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	CAz7AN/aaVuVA8WaPY06PV9wFxMr6BhTS9L+LUt8igkkT76EFGmmWi/pO3oXFgKT6QQM+kvG8x40IPGRJEE0jjzcJFEqSdEvG5/t9HCJQiAX3M2IvGqJF59i3dMXQhJmhzPReYDyuYHdRl/iNJFucEE+3gAgHvaQTK5U+hkbGUGQGybLiFV5aFnPF/mLrdsijovkvHCyGWTbvRGWS49ABcS5Nsa+H7lmBIYYybyJxJeohLpm1R9pxdojU8SIAxvf/GZgmmlrcOQIxcyGjjsuwqaZKnAbTuLrs45O7wghVB3cjq/XlDZyJhEjbKBadMloJ/lJsrojVT37NnZXgp8gcqn+nG4PfpWfN69Ly1bT9TA9fI4jDSPF4Ao5r3EI5ITRQ1PtM5uNb3QQgd0T/Dy/SOrchCheyrq8Tw1fyCAFyFsGhbtS9Mjshs0/iIh0TaMlCcQtP/eBmEONyMcZura3CQFpM5v2pZkfXWha1Nu60AXvRnj4p15i+0ufI827ghUvAk+rUyZN0Nd+Bm3z5OfSRJfHsfpVUoYuhnRFlpidV/bAUksNq60xA+SBS8ltdxS9uJtgO1v6L2TTj7OTHz0sPg1vxa8MUKPgKzDyk/i6wVvZy2PFKuJT0lrEAM7oY34dgCpUnK4Uc0gf2VNleJKSW92BVqJBkYV5IW6TlZJ3I/A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(19092799006)(1800799024)(366016)(18002099003)(22082099003)(3023799007)(11063799006)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uYdsNg/raCPs+gDbLBc7/RlKpy5KQHM6oFWMG30+g5vGntuYMhEVeJjO/LIA?=
 =?us-ascii?Q?b5VJU0HMqUDuIJfIyCrr6KAtYmbjO1I1JuS9NUCdYi7+ggdmMOHz0X5zJ1uz?=
 =?us-ascii?Q?3I+nPrj9poGmqUWeqEc4EZPi1ZiU59+3Q9SPt2E6nrPtAYnSzh5pIcaINJ1k?=
 =?us-ascii?Q?lOK9Q1hkxBJUiU0Vt5ZWV4PuS5SQmJhiHldViFwkctxeFFA1u+ti+jIYqfDD?=
 =?us-ascii?Q?04MJnD+YkErF/tSl+NL36kcE5dpfZUb305YL6UaoksdJdMl2Y+Ge2Ru8rHO6?=
 =?us-ascii?Q?KDuiX3VT6vMIUk2nsL/bvPKs8OKuQgoVf0kuAwb8Qlz6/ZP/yavvUbfywVvx?=
 =?us-ascii?Q?cCy87523LbMUYa8HuNRxQR1sSs+FMpjZCXM7X4rsmSNXRAnrYhWIxeCMcXTa?=
 =?us-ascii?Q?oBAz9FG+iW1ygwo2vCF5Z8KSVmddNM2s59l1BwdcVn5Cf0NJBUqENybUXWQk?=
 =?us-ascii?Q?ADlzSHHKOZLdjW+IRQuxGZ4gjus1mgLxB/LuUltIAqsxbwqlBqyehxbfhNfA?=
 =?us-ascii?Q?aB3TZCjlADE3X6zzx+yWACxfhFG656Sd67Jw05uTSa3oKlh7rS6nf8/wgi5T?=
 =?us-ascii?Q?r18e3nApTbDeIYZOlitgju8Y/iKa5EZTQp1+8KlSqd2jg4sF3i3418V+mzbp?=
 =?us-ascii?Q?z9xnpp19YdPmQZh+2DpQ4JdfBFjn85pHpsp49qmCk/3xBWeiNRyZgBrXq7Pe?=
 =?us-ascii?Q?DWsyMtbHJ05fqOHTILxOh0IS1M6jKtxTnQYdHk52fC5R+62QeRRN7l7ma6ec?=
 =?us-ascii?Q?4ognumePFEgNWUpVPX2sBQNIYXsmoYflljYDRIHol3lcCPsxxYh98K5h+5mb?=
 =?us-ascii?Q?tm1j4IBYgEoyOQr0O4bjg2FSUZqUBs0RNuv/oooXQROFZmq/qO64FpSmKsOA?=
 =?us-ascii?Q?fSMYItc4FBX84dn0yBz8LRXY29Vpa/OpoSL377ZrMI0rFPjevwMAP3rpxHO/?=
 =?us-ascii?Q?SbnT0ONruExZZrX9uMEWk8ZXbcCE8ZC3VfrlQZMivz1Kdl9h5DL5jh/KWftI?=
 =?us-ascii?Q?iWUiUiPKRQDU+NTBKw3l1cTYcLSl1vKmwFmgQ4zpuLWNxichsiIWkT22Pbh+?=
 =?us-ascii?Q?23eFdJ+WgXrW8iCAfaSSEFhf5MaaANzmMmV4o5bqIt6ydVGCRYrpXFrdzloa?=
 =?us-ascii?Q?4ZsvTVysWHbP3UlncEhvwUMcSaer62zd8pAIHELPsyCKwxScqtJTS/TPLMPP?=
 =?us-ascii?Q?gffx7rW7/1tiy8l9CRu7hNs5/u3wUNL57XLQbl6cj0bzvv5fo0ylYJqm3iMx?=
 =?us-ascii?Q?NdD9EHpQnURraZ2B9klANaHBkrRSSf9bx1wNA1k8/isuOX1JV7vl0/lkHwjv?=
 =?us-ascii?Q?zo3O/FDwW+3qTY9onLO0fRTT240v/CbsCSH3ESW+vbvTKjLW5TVnVXHSRN3K?=
 =?us-ascii?Q?fDXq0J5bOxiFofKtzb30VdpIFHvvRMGVyeVPZzKDonefOSto9gZyFNEB24mq?=
 =?us-ascii?Q?nHJ/8VxYVGwkotQxgtdjESMN8WwFubMQmwx/CF6X2SIE+dZspOQqWfCx528L?=
 =?us-ascii?Q?7Y9sYAvnuXS9kiPdVxgKHcZDhx+U/JiWjHGf6apPzXJP2NcoLQh1el7uIwrg?=
 =?us-ascii?Q?asr6fkfiLiX3rlntFfWwh4GTjgjz+NwTxj08sxipsQRjYsG35jePoOHxSAqH?=
 =?us-ascii?Q?fNEEPdjnlI8//qE9/yS0SPa1jJc/N9eudqmcJ8Pw+xfD3P92ydKNr8oOpwoA?=
 =?us-ascii?Q?Yos+DQFqqbEyqliqcu0koWHGUUsYTblAGv2fkuem7IfBpILaQ2X/sWTFFji+?=
 =?us-ascii?Q?YNOjhcMtJMRssbR+6Lkig8uaC2EKLGqCFycv9aDhxSkjzkIB0HPP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dcd8919-50dd-4d23-ea58-08ded2d6f301
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 16:29:37.8145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IomlOcndOL92sLp4TQQJ84OqguN7Ief9vjTEh9T8J1n4Q9a55AFV+5Dp7aTmJdLHV5V2pE8qXRO9xOPrjPdjizZvL1HVnpibsc0oIN/RHAEAPi7yt/TNbxuem9gt2clr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12005

On Thu, Jun 25, 2026 at 06:59:31PM +0800, ziniu.wang_1@oss.nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
>
> sdhci_esdhc_imx_hwinit() unconditionally clears ESDHC_DLL_CTRL by
> writing zero. For SDIO devices that keep power during system suspend
> and operate in DDR mode, the card remains in DDR timing while the host
> DLL override configuration is lost.
>
> Extract the DLL override setup from esdhc_set_uhs_signaling() into
> a helper esdhc_set_dll_override(), and call it on the resume path
> when the card kept power and is using a DDR timing mode.
>
> Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/mmc/host/sdhci-esdhc-imx.c | 38 ++++++++++++++++++++++--------
>  1 file changed, 28 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 6526d65538de..a944351dbcdf 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1349,6 +1349,23 @@ static int esdhc_change_pinstate(struct sdhci_host *host,
>  	return pinctrl_select_state(imx_data->pinctrl, pinctrl);
>  }
>
> +static void esdhc_set_dll_override(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> +	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
> +	u32 v;
> +
> +	if (!boarddata->delay_line)
> +		return;
> +
> +	v = boarddata->delay_line << ESDHC_DLL_OVERRIDE_VAL_SHIFT |
> +	    (1 << ESDHC_DLL_OVERRIDE_EN_SHIFT);
> +	if (is_imx53_esdhc(imx_data))
> +		v <<= 1;
> +	writel(v, host->ioaddr + ESDHC_DLL_CTRL);
> +}
> +
>  /*
>   * For HS400 eMMC, there is a data_strobe line. This signal is generated
>   * by the device and used for data output and CRC status response output
> @@ -1425,15 +1442,7 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>  		m |= ESDHC_MIX_CTRL_DDREN;
>  		writel(m, host->ioaddr + ESDHC_MIX_CTRL);
>  		imx_data->is_ddr = 1;
> -		if (boarddata->delay_line) {
> -			u32 v;
> -			v = boarddata->delay_line <<
> -				ESDHC_DLL_OVERRIDE_VAL_SHIFT |
> -				(1 << ESDHC_DLL_OVERRIDE_EN_SHIFT);
> -			if (is_imx53_esdhc(imx_data))
> -				v <<= 1;
> -			writel(v, host->ioaddr + ESDHC_DLL_CTRL);
> -		}
> +		esdhc_set_dll_override(host);
>  		break;
>  	case MMC_TIMING_MMC_HS400:
>  		m |= ESDHC_MIX_CTRL_DDREN | ESDHC_MIX_CTRL_HS400_EN;
> @@ -2123,9 +2132,18 @@ static int sdhci_esdhc_resume(struct device *dev)
>  	 * restore the saved tuning delay value for the device which keep
>  	 * power during system PM.
>  	 */
> -	if (mmc_card_keep_power(host->mmc) && esdhc_is_usdhc(imx_data))
> +	if (mmc_card_keep_power(host->mmc) && esdhc_is_usdhc(imx_data)) {
>  		sdhc_esdhc_tuning_restore(host);
>
> +		/*
> +		 * Restore DLL override for DDR modes. hwinit unconditionally
> +		 * clears ESDHC_DLL_CTRL, but the card is still in DDR mode.
> +		 */
> +		if (host->timing == MMC_TIMING_UHS_DDR50 ||
> +		    host->timing == MMC_TIMING_MMC_DDR52)
> +			esdhc_set_dll_override(host);
> +	}
> +
>  	pm_runtime_put_autosuspend(dev);
>
>  	return ret;
> --
> 2.34.1
>
>
