Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF6E41C69;
	Wed, 21 May 2025 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747844459; cv=fail; b=nGfgRb8tTf4bdiZjhmWnLYzgbzePM3FpG/tgOXtUs/YYR2yRY37sPk8NeN16jCRYSmmYoahE9joevq8tvCZ7oyaw9LYCL5fkRtzGdncnrtR4UPJBtjBhjR6SMN/aLyqkNeub0V/xZdjcG5oxqwhx0/sBBs2RvlIpqVI2MmhmFdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747844459; c=relaxed/simple;
	bh=5b/SQ5o5p+fdYlJcncluWl+NJ8rvSHeBC80mcLY9PVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CVOQcqfs0jhEe7Da7E1Wglh/yfMGWNxgIUSLokL9fptNQ8kv2MJPLM0VOSvppUVcKeMtrbrVc9Wsv4olWOtPKMoZalg8OmpcmE/qqMTRkJw1fme/bCnhF8zU1OQ6bFn00nfLcIU+eEG44A5vw5MDS46hSNRKKUzGma9ud1nKds8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mtYJjd51; arc=fail smtp.client-ip=40.107.22.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mtYJjd51"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+0UD+tahcvPdNR7zGdsFGYRlhGiJmpQ/RpiU2SuRBuw0v+JGcpzTPKRxTBkfnPhJ9zi4JRHs/ybmEY2p8MNOG3FB1kHuBDIkqGmjclIrCcoAXteFfntry+SbuBhk2P2nFdgAbIlvKgduCtYHGpa5m8UBbSQQ01TpivDXU3OnfLxQSWXdLfEpy+etXCMj0vXzMgdOkRoKVcP5ovgXE+XS2MZbg1f5h5Tj/7as3XpiLcnAJdX4Kx23RbzNoDXmhZ7O0W8dKFwUXocK88BQA0bEvXMZ1WfHnh81vXsXlu36yv1GvZHEZUWbbQN4Efzw2tpN00gnCrIIIB/vGutvI+jgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUsxR5mCkfeCXyPz1qdbUdt9AjTt5g/uphMBFM7IgDg=;
 b=KXpSBEs7Ya4TC/S96awVkimGwgnkiGJG2kvZwYVsSqMlWbhFaHDDAI5zzi1LHaXggy6Xwwk8JEtPxmy7aj5tusyFI5jCh1xUwr8UkbXMgG2GJavz+T8wLUbIlwP/2Wgv9H5J89dCcEd9Zhz5TJxndcePfaPLzquBVz2KcD6WfRHsRqoQ9YItfDDHONaFwLJ2aj9121FFYtdW5BqZ7FCMV04WysJ2wUZwY1OIRvyg9fvSGU91rbd6epjJmsoRoE9aaAHe1D3MeG/2lFM1V/nnSDacyia9gZss+/jFghOIg9vRFSezseY7W0qV/80RqEym9qS4fgLG/IOf4qZNV6Emsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUsxR5mCkfeCXyPz1qdbUdt9AjTt5g/uphMBFM7IgDg=;
 b=mtYJjd51RuHMyl5UeidOApT0qzSJdE/6qlbe6EwLCz+IEkpSDaqrS93P+k9D4XTo93DaqoeajdvhgVQzoo7pe0a/HAdUEYBOk8o/ztFba8wS+JgfoWFwDxYRsHyf/4TL3UhPeUecOc3IyfpT5F2bjN0K+Mqjv2BsM2+UBJ5jCL+GT7ffiFAJdoBe7li1XBn8Ocrk9fzj0qDrkddLSBXr4sfWd5aDpF7JQwJWE1EhScBGNlsKJptK3hN5P66QT1uoEp1uU6uVV3Qc6uo3WMficC34VwVxpBURame9bXny9/KzvQQEsFZ91bLodI15RcTNBh+OwOZCG0MBCKqlceYsew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 16:20:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 16:20:54 +0000
Date: Wed, 21 May 2025 12:20:47 -0400
From: Frank Li <Frank.li@nxp.com>
To: ziniu.wang_1@nxp.com
Cc: haibo.chen@nxp.com, adrian.hunter@intel.com, ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	imx@lists.linux.dev, s32@nxp.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mmc: sdhci-esdhc-imx: optimize clock loopback
 selection with dummy pad support
Message-ID: <aC39X1f6fJErfkDN@lizhi-Precision-Tower-5810>
References: <20250521025502.112030-1-ziniu.wang_1@nxp.com>
 <20250521025502.112030-2-ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521025502.112030-2-ziniu.wang_1@nxp.com>
X-ClientProxiedBy: PH7P220CA0153.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 876b6c19-e049-4299-1fe6-08dd988375c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tuUHt56/uLNeiEUOhO5K+hmrxXeCoqK69SCi3ZJSvRPLRKn3rf1ey4EtvLB/?=
 =?us-ascii?Q?w5EipuvjZ8i+xQwbO9Udx6RAbsqnxCTUcl9ACBvJEMR/6mlGgoaFXUefIIPm?=
 =?us-ascii?Q?8bcD8aAXE/iKGosPEHIeURJp3404dJlKKbDCea9bGX/4ibfpgznh8X2JyPta?=
 =?us-ascii?Q?r9FePT1Kz0XqlP5+/pKetrY2SF18S82izIq8jf/WoRH+tUWI/rURHkIGtV/W?=
 =?us-ascii?Q?GSOVpa818aV7SoiwVdoFd7d7fdMooiv5lhPAzPu7wfmmsft4c59gn0RY3v+Q?=
 =?us-ascii?Q?vuXCSF5ZP+47iB26VXqeAso/YI38/tFYZNSL04AGqL056iBGH7uoIVm8fumw?=
 =?us-ascii?Q?qWr32DBczKjkJl7MMv9ygi9aNuttzlngGdCVcsW8rRVj9SBAxLK6l0Mk6NAn?=
 =?us-ascii?Q?p8xvja3QbTDjQXqBfxATfbrVvBWug5R6QxQCuC9gYI+DVt9vFAVratYY/pQW?=
 =?us-ascii?Q?5V/6MGKxLaNsLq9egaYwrvLo3B/dza/3pco4HNzAnDY3dsk2z7QsL3PfQ+bZ?=
 =?us-ascii?Q?TW9m2DDQFxKfMvptnLkSHdhGW19g/H1tjM08lcBTuyoNRgz+zXDb719QATgE?=
 =?us-ascii?Q?vl/oPN7lHzpwTYjOu6UMrWloVhiDpXKpWWe6grQgBBzZMp6Zh1eCLHyn0Wb9?=
 =?us-ascii?Q?UlODjIf9WafzjsEhEyMKreASLIIUZwQyvrbXYlJIygL5QK+9CKw6m2Nfa3aG?=
 =?us-ascii?Q?zxqclrJ9u4oDqGseQQ6Df2w5clhzyR3J7OaOhNC9HGvWBU5kG3YSGzHnYPSF?=
 =?us-ascii?Q?3cYJVreVwtHsf/L6ArbgOJjuaFgCShw8qPmjlzoYOTmpU+Tfd7RYuobEy7K6?=
 =?us-ascii?Q?LEWWMnSDd1NzGNXK7rdWKlqMXQrv0dLWnWuiHq2VD9q+zn8w2Yg8q5IqQ2Zv?=
 =?us-ascii?Q?RhFXvro1i2nI6hkhuaLHAPNVu3KOmsJ3ayypXEvtgxEvGTGT7F3wOHs5lsod?=
 =?us-ascii?Q?Iz29t07EX7hWcihbDDcihjoFPrgdB5b49airQV2H8ghzNoPiqbn3q0r56uyZ?=
 =?us-ascii?Q?0A4SVqP/rDNarqd6zxo7fScW54u6IdFO7jDnC1fUMT9upIWkc2ooeswUeUOF?=
 =?us-ascii?Q?PDSdCHHds6jOjHAd28Jcd2ZORQdkT3hPJ5LybxglvHt8/SR16O10x3uYQ1AA?=
 =?us-ascii?Q?xmP3AgQV9/FrBjoM6tZaxm4VY/YGaVCwsmLOhat1RbPG73HMhUlfF4BBBW2T?=
 =?us-ascii?Q?UaFyOeao5+l1A/0SieZqaoZla3YIejl4AlGCMCOCLYxhr44VacBvV61uLo/Z?=
 =?us-ascii?Q?yuh2o1EvwtmlZcuRnfYM5c28SdZQzq4OkZ1puUJkcqYPXPNThejNeRVpgz3q?=
 =?us-ascii?Q?K6o4pYfH+K50+N9n4xNuZGIGVB3wn9cYgXisPN+eEvGbdeFxpjlbDCooM1gA?=
 =?us-ascii?Q?+2UELLBCtffIrkufGmoszjxCFTWk5qD92dCCcU2X2KrHoS/opDRZY92E6n7n?=
 =?us-ascii?Q?2aw5AYh7loLZhrvP7XcmnM7PCMJQQjdRjuhAT5EXv1Fiv4unbqWj7Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0rcXXLMd41ImtOX+sMI5nXHoTKfwc+XIymAOVWPiy1elgNvG6LHNPhtqaDUB?=
 =?us-ascii?Q?oHRiG9WVgC0xKNAoeOnv9HwDWbRV59QV6wMLWFIjihO77eefqLWBRQHwNV6+?=
 =?us-ascii?Q?IZ6xNFMB5q5Y3COUXhI7jR/ZJPJRJ6fTgbvTwZNiRuBxspjdW0HwA3o4rZ5h?=
 =?us-ascii?Q?VM6YR1IRCrcZQbWT2a2vlZY7xnt6PWH9Z36iYxg2mcomFVdlvXNYWO1/lQyx?=
 =?us-ascii?Q?T2vluDjPmBEz5Vg8dY1H6K9rWm+Gume1VvBWXlP6OiTWPgfxBReRMwYYIcLB?=
 =?us-ascii?Q?FkUniZPJw2tVbiHlWVmCoxRT6/qIclRxPUlZhqiwNSVDozPS547NM0R4DvTM?=
 =?us-ascii?Q?P93YZ485CMRJMloMvstNOjSafVWQgxSs8sccX1/CjL4R2WEsV/P+JFuOff6A?=
 =?us-ascii?Q?ejThNE279tkOYrYzjr4zW8CwKodOdUjeSRYIrNawJdhJ4kF/CS/QhFF6oDWV?=
 =?us-ascii?Q?sy9O3ymebXYyHUdtEC5eqbmNGu/QeYOAyqiUeqZ55F8iHJut38f9eUStXluu?=
 =?us-ascii?Q?pXw1fKLNof8VTlQ17yBbiwwgUwIfg9+HRC38hpSunMC/CDw/l5kSlBCqQquU?=
 =?us-ascii?Q?iYRPg4ukPYuyiwPveV+ziZt2Dh0GSroQQBdG6dmDMnZfp0pqI/0Dq25PCb+A?=
 =?us-ascii?Q?melHenzNDzpN/GHUgsxT9IaoiLfTyofwGD7EVnWj8Tw1BF0MWuDTtkhb+zfZ?=
 =?us-ascii?Q?yfN5aU9mCIimsqtxz7o2Q9mDpywNnReyphapns8cgXa8+5MEFEzPWY6cSHYe?=
 =?us-ascii?Q?cpqbwzBnwtayrDEnVe1u2aRY7u37HK5NgjN/Ri/xTGxs2rgdvlyE6qoHXAyw?=
 =?us-ascii?Q?+aQyXvRw/f2p4k0vb6E5dmfgFbS47o0jbIZAJJR8eQgD0N9WeICokNxbXYyr?=
 =?us-ascii?Q?PDIIfYLsZ6AQMgOYG7D94NtjYJn0baTz0GqZI9QS9flFN7DLHWUfDUdXM4AP?=
 =?us-ascii?Q?gj44F0qWKiaRvbNHHVqklbxYvJ59X1xDIcwi17Rxbm3NZG+W1QkyucWGb7Cp?=
 =?us-ascii?Q?cMlbw5hyRHZ4yXqjhi3ScmPH3X1bB6sP3lkxJTszP7zHvEP0GS0R4J9f1SNg?=
 =?us-ascii?Q?eFq6auWlrspkNfXpqjtUIuL5erQjmYH2qVlVUCX8AUkVw3WBvm95WZKYNS5t?=
 =?us-ascii?Q?DyOMiyqdguBXotymAcRx0SvJga+lIi0C2iuw0Gkuzw913rmBMcldVoV9XAJg?=
 =?us-ascii?Q?p90g20c1Q0Q5MER/Vy5z+mYGw5PaXnHl8s4B7yey12V9MF/OrR7emnhD61YO?=
 =?us-ascii?Q?L3x9hzh0t4/zKPmh772ST6No2ImpL3fcKPDoUFOs5nVwfkkrHl3n8wAkEzPL?=
 =?us-ascii?Q?1mH1V5zGvG/M6mXl5gZX6Fzn8nU58p7RPgsZw4f8huo6ytKZOdL9CFsMaoie?=
 =?us-ascii?Q?/nfV0sa1/tKBLLVMAfLOODmylVD0ucfzKpNIHmMyeb2YFMylZF1j+rWpJU2r?=
 =?us-ascii?Q?RTMsVBU5zyq97NKWclw302KR0LzWZeZT3UvNfzv8uGqhW9+om10D6dez16A7?=
 =?us-ascii?Q?LimX9V+ChAq9iHomvqOiJTVSyGv73yiae2438Gk+PGl0c3LcDD3HNbtvGjph?=
 =?us-ascii?Q?xx44daIz20LaNYuCFDg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876b6c19-e049-4299-1fe6-08dd988375c7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 16:20:54.2412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ci2hWtO4OQTsIc7cvVmssfjTRRW4E7w81ps0wkdz8LUO0KPwCOWDCsCg3mhxIo+BbnRJY635PI4qLNY9lv40kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8510

On Wed, May 21, 2025 at 10:55:02AM +0800, ziniu.wang_1@nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
>
> For legacy platforms without dummy pad:
> When clock <= 100MHz: Set ESDHC_MIX_CTRL_FBCLK_SEL to 0 (external clock
> pad loopback) for better bus clock proximity.
> When clock > 100MHz: Set ESDHC_MIX_CTRL_FBCLK_SEL to 1 (internal clock
> loopback) to avoid signal reflection noise at high frequency.
>
> For i.MX94/95 with dummy pad support:
> Keep ESDHC_MIX_CTRL_FBCLK_SEL at 0 for all speed mode. Hardware
> automatically substitutes clock pad loopback with dummy pad loopback
> when available, eliminating signal reflections while preserving better
> bus clock proximity.

Add indents after : to better read

For legacy platforms without dummy pad:
   When clock <= 100Mhz: Set ...

For i.MX94/95 with dummy pad support:
   Set ESDHC_MIX_CTRL_FBCLK_SEL at 0 for all speed mode. ....

>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index c448a53530a5..5f1c45b2bd5d 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -212,6 +212,9 @@
>  /* The IP does not have GPIO CD wake capabilities */
>  #define ESDHC_FLAG_SKIP_CD_WAKE		BIT(18)
>
> +/* the controller has dummy pad for clock loopback */
> +#define ESDHC_FLAG_DUMMY_PAD		BIT(19)
> +
>  #define ESDHC_AUTO_TUNING_WINDOW	3
>
>  enum wp_types {
> @@ -348,6 +351,15 @@ static struct esdhc_soc_data usdhc_imx8mm_data = {
>  	.quirks = SDHCI_QUIRK_NO_LED,
>  };
>
> +static struct esdhc_soc_data usdhc_imx95_data = {
> +	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
> +			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> +			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
> +			| ESDHC_FLAG_STATE_LOST_IN_LPMODE
> +			| ESDHC_FLAG_DUMMY_PAD,
> +	.quirks = SDHCI_QUIRK_NO_LED,
> +};
> +
>  struct pltfm_imx_data {
>  	u32 scratchpad;
>  	struct pinctrl *pinctrl;
> @@ -392,6 +404,8 @@ static const struct of_device_id imx_esdhc_dt_ids[] = {
>  	{ .compatible = "fsl,imx7ulp-usdhc", .data = &usdhc_imx7ulp_data, },
>  	{ .compatible = "fsl,imx8qxp-usdhc", .data = &usdhc_imx8qxp_data, },
>  	{ .compatible = "fsl,imx8mm-usdhc", .data = &usdhc_imx8mm_data, },
> +	{ .compatible = "fsl,imx94-usdhc", .data = &usdhc_imx95_data, },
> +	{ .compatible = "fsl,imx95-usdhc", .data = &usdhc_imx95_data, },

You'd better mention "fsl,imx94-usdhc" and "fsl,imx95-usdhc" already in
binding doc after "---" to let maintainer known these already documented.

Frank

>  	{ .compatible = "fsl,imxrt1050-usdhc", .data = &usdhc_imxrt1050_data, },
>  	{ .compatible = "nxp,s32g2-usdhc", .data = &usdhc_s32g2_data, },
>  	{ /* sentinel */ }
> @@ -1424,9 +1438,10 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>  		break;
>  	}
>
> -	if (timing == MMC_TIMING_UHS_SDR104 ||
> -	    timing == MMC_TIMING_MMC_HS200 ||
> -	    timing == MMC_TIMING_MMC_HS400)
> +	if (!(imx_data->socdata->flags & ESDHC_FLAG_DUMMY_PAD) &&
> +	    (timing == MMC_TIMING_UHS_SDR104 ||
> +	     timing == MMC_TIMING_MMC_HS200 ||
> +	     timing == MMC_TIMING_MMC_HS400))
>  		m |= ESDHC_MIX_CTRL_FBCLK_SEL;
>  	else
>  		m &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
> @@ -1678,7 +1693,9 @@ static void sdhc_esdhc_tuning_restore(struct sdhci_host *host)
>  		writel(reg, host->ioaddr + ESDHC_TUNING_CTRL);
>
>  		reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
> -		reg |= ESDHC_MIX_CTRL_SMPCLK_SEL | ESDHC_MIX_CTRL_FBCLK_SEL;
> +		reg |= ESDHC_MIX_CTRL_SMPCLK_SEL;
> +		if (!(imx_data->socdata->flags & ESDHC_FLAG_DUMMY_PAD))
> +			reg |= ESDHC_MIX_CTRL_FBCLK_SEL;
>  		writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
>
>  		writel(FIELD_PREP(ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_MASK,
> --
> 2.34.1
>
