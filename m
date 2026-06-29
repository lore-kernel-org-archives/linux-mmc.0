Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013038.outbound.protection.outlook.com [52.101.72.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2CD3B892B;
	Mon, 29 Jun 2026 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782727035; cv=fail; b=FddaGw7R8kibBEkr8MnioKnO8bpdNLvHhLmIfs+bv2sCGImqGfpF1PzTIy3CTw2+2/CHzBo42Ak5wvt5/4LT4Idqgn+yhGSitCKIJ7zou12XWobiSY3aU4MYnS12pKC3RYVrUF2mvQhFegq3X3s5QvIL+l8sGeDeUzt8gq8IqcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782727035; c=relaxed/simple;
	bh=BRMqMwDQMdoGh/p1uQEOh8wQbN97cG8QxLllhMq1JFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pDRWGAQaOev0r7hAOaRmI3tVWZPJkzOMO51IGWILmKunDcJoo116X/LNYVXSabXirgYstiyBHbZS6tLaDnYDKD6HQTspa/t8/nNxvEmdh7FF9hUOUbi9o4QaVuOsM125dNb5MkKeisymmd/HvZkDFoUL8Vz1ABg8HD8yALyxBlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JLjvYCYc; arc=fail smtp.client-ip=52.101.72.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JLjvYCYc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mqya3zBF9b4KtPzP+8GzMdM9pSozOxwdu9yetWfUCwWXC3HPZIvPGyoOmNVnkC1zdrJo2jxyrhNUXTFePGpx4yweJw9ypp6/40tM5XslrbwbNme/gl79y2MBQ64P4r+wE3cFS5VZdGdmR/hoJKt0ALKAsvQhtGNmsBHdpNscE8jGrIzMDRcHod6TtMcp5tTaOOmATMYQ6QXk5Ke94vxUPCLmabXhdCha/2YbGwwgZNDwPTua2r9Q2BIEu6PpVGajjr5n6Ql6+WSUbgdhpPh4r4VjzXACHCicqyYtUOeI4ke8qZ5qzA9EeGZQVWGOzgUl6Ppi1LYUaH7nHCQHs3nClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYwsXfTW4Fr9N+GCkSUqCvCZULzfgPrytId1HcTRQv0=;
 b=zViFSIikSWCoHUf80acD+GZQ+NcQTypOi7Dm86BK8/D0DDGKFqrOK1+t7HYm0I6yUpImCCyctvDtW+XNklYy6x4wbEhblnM39hy3sCfJ0e2K2VHIKzd8LQg2vw3sm6nAVMwF8H6KOtyTCw8o3BVHJ4R1GGUFsOm+WTfpG7UD+Y45m8UhGkG+yjxtSml2bKGTZua2zr+HYeulBOBobNtcazOmBPXJj7UwoM610kgVdRctjyrt3WaYczgKp/3hdK3yi/KlO7OkL3iQmNT4rqEGkCYn5Hd8gRyG79fEvsweef1PAY/nbzjSYvcsLwthYZx5G41D9XlvByzXm5yS+dTZGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYwsXfTW4Fr9N+GCkSUqCvCZULzfgPrytId1HcTRQv0=;
 b=JLjvYCYctuh3rXZsZUMGLUb284LwbDr5YguOUQYFE2UkMhQZgNjfbiLXOGO4JDsE8eEQvmJGJ9yXB1GK4/pBYlqMtgtvkxTmRTocrUWbkaZqZCcEexa6gzkF5A90eaaJITl3M0nvEAm2+eT4jjfTJusxdgvujCaP+ddoRSku0+hvDsWNie84Brl1Oic1XlcsTTFfCzqW0I6tagmeF0dnoZX3OaTswnp2WP0h/5E6+ifdP0UGL6GxI1ae1bUs1oQtmcfUjgG1sIJ5JyuxYmKYdeeSsNiPktfRD0Yt1xUfZ64xy3UoJoJjkjpWczHx83cBOlITZ8PXaPQcZKClzVtjnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by FRWPR04MB11245.eurprd04.prod.outlook.com
 (2603:10a6:d10:172::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 09:57:09 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 09:57:09 +0000
Date: Mon, 29 Jun 2026 17:51:48 +0800
From: Bough Chen <haibo.chen@oss.nxp.com>
To: ziniu.wang_1@oss.nxp.com
Cc: adrian.hunter@intel.com, ulfh@kernel.org, haibo.chen@nxp.com,
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev, linux-mmc@vger.kernel.org,
	s32@nxp.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] mmc: sdhci-esdhc-imx: disable irq during suspend
 to fix unhandled interrupt
Message-ID: <20260629095148.rucc2oxsr442v5sa@nxp.com>
References: <20260629091954.3227151-1-ziniu.wang_1@oss.nxp.com>
 <20260629091954.3227151-5-ziniu.wang_1@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629091954.3227151-5-ziniu.wang_1@oss.nxp.com>
X-ClientProxiedBy: MA0PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::9) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|FRWPR04MB11245:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a06e4e7-bbe3-4622-90f9-08ded5c4c8a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|366016|376014|18002099003|22082099003|6133799003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	iLUdAGHN077X3J5lAoATaFRE1u1rCSrW8GdqUBhDWXPNV6dujFXTKnnvO+mVBN6G4t9eR3mRJsRKiPh16K5xLe9kGo6AX8zNd9Jz9GOVoDAnWKWPIE7tvXiZgPqYRDIK/KJROgN3WMhuoWF3jX6ViI5A0sW2G1++FXpHly97xxtYJ18Vsm/FKtSWjCYYw0qRL5Kj+1tI/sxhijc+g1noV1pl3TC9+2p8ADsqj2NYBpdJ4qqi+vxNGA/ONu0a9Cl1I0Zmns0i8MrTyN2DYuymljwReIvxlbLmvdW/qhPr+LlggMhFjhlEQiG2dGJGJ+vx+31Uh9bFAOyhU2HjCH+uv1tbqDu/CmJlLhor4UlZhY6kZj5gPNXoXl2ppZ5vtbMESCkmzkEBN33p9JxYtzfoYXMMMoEMRh1lI4FE+HNrzyhtMz2Jb5fAFbJiLabuiz2lzEv4aO25Q/ySmApPqMooAO6r9ndyh7sp42aSnuAlHet4/BoUr4KsG3rEeKfTUumeSXuajg6MRU1LSmlCIYuVkK4sf/1iw9P2NHLlm+Y87QuKzr1fKFKquwvlbaXzdeIUHXRGQ4GSKb4VgNYAQxDFQFMo0cZP1KMzLOd919d1uuIIM+bO3SZCmi42f1hLxaIt62oICjdvDsQX7Qr+WUXdxT0FLPSMzeYgvJ/sYcovomI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3HJlbpONbPSL8ghENF3C75mze0CMlPQlcjhRwPfkmjd8vhZjCBv8JDm53/F5?=
 =?us-ascii?Q?tc4PlBv9yebgvkYeUQrma1yeblbgFS7CTE1E54PyldXunqdA7nejQBJkvcsb?=
 =?us-ascii?Q?eSM4UDTqJSjJlphGFFoXsDKQJU/omWvhxK13/95Td2JVT2NoVFCPVOEaOKFb?=
 =?us-ascii?Q?LtOJ+QQMSNZfMrxVn6gfUjQWOmwdYn7qa3DwKpUxJPZH51XXhQZ+nVLq/Nj6?=
 =?us-ascii?Q?1YGxd6Dt/pvw0VfvDszO3Sng9FYVIyTqwWmjAtnxhpMSw/awx3Qui1oLMObs?=
 =?us-ascii?Q?77ThuEjisBYU2sgWcKLFzvBIN+ffKvkAr/bYqMqeSx18Gdx8Z5uGvgoveZfn?=
 =?us-ascii?Q?2JngY/V8jHoVclbeNeqvXG/NTorY4whWmzR64LYrnk7eU9kOljBhwX/pN9aF?=
 =?us-ascii?Q?19QwSmfMf11jsVamOXoLz1TMLhSiY6bEdRLr/7sLI0udlhjGzmRm8RbEcLox?=
 =?us-ascii?Q?j/m3VGJp4QM/gWg++gIR3dgoPQr+VWvRmcfmnV42qF9HIleimtE8x9tZTsoW?=
 =?us-ascii?Q?QyGLc4qsUPMGhX0AvgdYwq5li2HxRY26OcS9bf5qW0d0jbBrdeObIzvIYhXd?=
 =?us-ascii?Q?MugCDJ0LqCMUjibl62uiQXjFGY15RUILoRSVdBAPdzfGPhsVgSAV7fjORcZb?=
 =?us-ascii?Q?nKa5uvwRkm1NQpIO4s4q9Jllw1Ba3wqm1X5K3GUA0eTJyGD4wCtoZYpKHX81?=
 =?us-ascii?Q?5fDe8KMFy1rvOyUH/Pbog39iyG1GNpW2eTJSRkRan7oMDzMXkKbEjox1We/T?=
 =?us-ascii?Q?ePax8YuYlLKHKuXIeZHJsjY1sR1BAG+v9lJkDe/f2tBXT8kYTHZ1mVFG3may?=
 =?us-ascii?Q?NVyVkFLJ44Mic2TJwspu1uZWsvTyOCeFr9/c5RA93d7BgpgpLsjpWyME2Ew4?=
 =?us-ascii?Q?kPRN+xymCZ0NXBZk09Z2lrOlauFs+PSn9TBY7igRPf+7BGqgD9XeVHVDYoa3?=
 =?us-ascii?Q?5qH+7HRChFwG12DAdkwU3jxvFPI9SYozX0Yti0sNP5x3W6BzNVC7Tj+Echym?=
 =?us-ascii?Q?uStAkFC9H0wTvVCFknsQkmWQECAdUiQ73Nl4SMWnbSgMP2yLmIrMRYZoT0FO?=
 =?us-ascii?Q?2id6OxDZX1chEaWPXkWhdM1rQbnVgRzLmMI54zVjI177vPO/oqnjN5jkMQjV?=
 =?us-ascii?Q?8ikMEggnZBCh1/CuoPPfed88hWCKxolRc7GtKxMcV0LZ6WUwthCyzGnfsdXM?=
 =?us-ascii?Q?lgroZ2CkOg/P2Ewtq9Bq/RRcwkRVnevtQcgiTQrj09rS1q9aUWxxUPSW1/DR?=
 =?us-ascii?Q?2p4LcbB0s0isTLTYLBZfE2tbLw/l8Y6neH391xTpmWD20K706m2t2AZmTA2P?=
 =?us-ascii?Q?/2v09QrK0I0h56BSFHwWvnW/zRID6pWB3IWb9M8mPhcXBG0IxWBzOtVwtyaq?=
 =?us-ascii?Q?GctGTzxn40GHYRhZVaGaqc56v1K8pnbN6CdcmGPzaUMs18G7uXgDsJqPDv5t?=
 =?us-ascii?Q?k+fp8RnfXiSnuqkBI+ApL5Sm0PHa0D6qWXvdOf+l1oG2DM0OSNh2GtfFwbh8?=
 =?us-ascii?Q?SaAvcwiF+JYDyWtc/8PufNXl3FwClxXKsCkMrrAArZCD5rf/iXAPwMX+ljHW?=
 =?us-ascii?Q?Q1s5KKBMESx9vXbp/TtEwqrD3FpOtGSDDKFUErnQe9ThCuPQGC1tJXc3M47t?=
 =?us-ascii?Q?K0pkgoVynv0DKl65W9GGCqno6SW1fGs/F38nBotoo+IXXf5+iS078RazMKmv?=
 =?us-ascii?Q?ZMylvBHfgZQ3kquzqtnCNDB0SftNs2ny5JPN4QfUxZBGdjIAsvNgus0QqDpy?=
 =?us-ascii?Q?+T8G+zgVzibYWsD1LaJt9DUQWzTO5krCwUA7xTDlgr8L0ybyvLHr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a06e4e7-bbe3-4622-90f9-08ded5c4c8a0
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:57:09.0831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XH8MXL+CkJ3EWmitv3PofzW5JW6weMcuxDBRyxinQWF7nODPgIKLo5nE7NQuO7VfQoGUfXkBvQ/TQTPFKtNfTa+utML0U6Hi1K1d/N2h0OstWtGZ8c8YjlqFWWeul6gf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11245

On Mon, Jun 29, 2026 at 05:19:51PM +0800, ziniu.wang_1@oss.nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
> 
> When using WIFI out-of-band wakeup, an "irq xxx: nobody cared" warning
> occurs. This happens because the usdhc interrupt is not disabled during
> system suspend when device_may_wakeup() returns false.
> 
> The sequence of events leading to this issue:
> 1. System enters suspend without disabling usdhc interrupt
> (because device_may_wakeup() returns false for usdhc device)
> 2. WIFI out-of-band wakeup triggers system resume via GPIO interrupt
> 3. WIFI sends a Card interrupt before usdhc has fully resumed
> 4. usdhc is still in runtime suspend state and cannot handle the
> interrupt properly
> 5. The unhandled interrupt triggers "nobody cared" warning
> 
> Fix this by unconditionally disabling the usdhc interrupt during suspend
> and re-enabling it during resume, regardless of the wakeup capability.
> This ensures no interrupts are processed during the suspend/resume
> transition.
> 
> Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>

Reviewed-by: Haibo Chen <haibo.chen@nxp.com>

Regards
Haibo Chen
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 7fcaecdd4ec6..c4a22e42628e 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -2076,9 +2076,10 @@ static int sdhci_esdhc_suspend(struct device *dev)
>  	if (mmc_card_keep_power(host->mmc) && esdhc_is_usdhc(imx_data))
>  		sdhc_esdhc_tuning_save(host);
>  
> +	/* The irqs of imx are not shared. It is safe to disable */
> +	disable_irq(host->irq);
> +
>  	if (device_may_wakeup(dev)) {
> -		/* The irqs of imx are not shared. It is safe to disable */
> -		disable_irq(host->irq);
>  		ret = sdhci_enable_irq_wakeups(host);
>  		if (!ret)
>  			dev_warn(dev, "Failed to enable irq wakeup\n");
> @@ -2129,10 +2130,10 @@ static int sdhci_esdhc_resume(struct device *dev)
>  	/* re-initialize hw state in case it's lost in low power mode */
>  	sdhci_esdhc_imx_hwinit(host);
>  
> -	if (host->irq_wake_enabled) {
> +	if (host->irq_wake_enabled)
>  		sdhci_disable_irq_wakeups(host);
> -		enable_irq(host->irq);
> -	}
> +
> +	enable_irq(host->irq);
>  
>  	/*
>  	 * restore the saved tuning delay value for the device which keep
> -- 
> 2.34.1
> 
