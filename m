Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011011.outbound.protection.outlook.com [52.101.70.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA4E260580;
	Thu, 25 Jun 2026 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782405601; cv=fail; b=MRvmj2PisPIAJ9GsliF/e1QmkdZOXxhGHcSPTkv3wBzNpsZYRl6b3+ADMGKz9TPEsrJ1FzHPSNb6e54OmKbzxq6sF46eDjVFbhEvq17FOd2A6HtV2gpEsm5gCa3ZDT+E8s4zR59LkQELnov/f4GliJt/hP48QGlLQfkrrsYZ9F8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782405601; c=relaxed/simple;
	bh=CKr1veYRR1/EHb62IYElyaSDs2TpF1y5vcr2PaayibE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N0A7RLEzhhAkh9ZxOL+jAGlJ85dCndU7/hrsJ3YWdiw6Ok259970BQ0jFcVpHrV2gje8T4EPmHTXEpbbMv6hw+1w2D+mbk96dYf96glWKwGFrDEHhzkFtfDJbSFsXen8YJEVh78+pI0lKFphn1NoqKeCStPE+Hacjs12kOyZLm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=e7tqj7Vw; arc=fail smtp.client-ip=52.101.70.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="e7tqj7Vw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwxP0VvDSMjvy48jce3gFjJYtm2KmY2QYwCYXxe37MmfOAZb8iFfrWYxxa/qH8pSGu0We4b6ZL6Bp+cp4LbyCGZeaMOUennO85fFDYp+ZAFDQTh41DNprCgrKwO6CE1GYGumgvyMqeoZwtWpM4N6CbHM3+5Pvf669KYC8ndtjfGQfWEeARUMyPhuPixeZ+xOCyYE5jHS61VRFM6Uwcv5ixixY9c8yiXR0edw+7rYd300yCjVyi9LYf65lrRwmyJUvzre5okkZqh4JWxG42+LQRR1WHDpnE6/mE9fhKNWPC28vI6hT9btMVtQBaq1eOxwOqvtFdOlXIUIwxzyWfVoXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t93TCeImRU366B78coVnbrkYv6N48NOky1GIO4ZcD5Q=;
 b=gXcqKTpdpy3o9dxJh+EIdEduFYMA8Y4WxpLBc2Uavlseq4fpQKnbkKE5wX/pu1X4EjIzg1Sq5B91Y0HTpD66F75DXgSkenmZkAg71eeIxQPVg06nPXw98mozhqkOC5GSH1VnLRgp0CMetXt+G3M1yhYXcKK+c/J9wuoqNI1GPUSGB5n/y2D5pP0IbvpjEbJyvhbfsYYrXU5yzcHE6EKj5FJzymr2oF7u+TzUFCugJdX/parYx41wwfzPc/RKIHYioqGWkaFM7zuOs9T1MnC3VVvRD5sGN5erbL6IwlztwtfrXAEyoRcx5iVFgWzk9IAiMlDKrMJLgT1J8RfnlVxPyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t93TCeImRU366B78coVnbrkYv6N48NOky1GIO4ZcD5Q=;
 b=e7tqj7Vw35CLWw7gDwTGWt4jGIArSVL9oIiZp/1yLw2KzKlB0JWHavj/UJfjZxVSMq9UvCO40TSYiOk6i10LBozJUu26aZX43kyBI4sMD3dFaiLrZlBZRz4PunhxAgn19Re7ZaZBW3f5Ln0vzdx/BlW/uc4Y+s9+kRC39N5imdtyK3mDbBUfFIjSlix4Wi95e9C3ZCiPEIXUHctGL5/svymn8i9BGqhLAOOE/OuCP05QVPHNzarQtj/jSGui9SeX9+hLrSm0zuw4jenPHvV9/g67Pys4kPUBmqX3UbHJHDy+JMr3+LyoC7/pbmUaohUYpx8r21Zs/k8SkaKrVScbcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU4PR04MB10529.eurprd04.prod.outlook.com (2603:10a6:10:55a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Thu, 25 Jun
 2026 16:39:55 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 25 Jun 2026
 16:39:55 +0000
Date: Thu, 25 Jun 2026 11:39:45 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: ziniu.wang_1@oss.nxp.com
Cc: adrian.hunter@intel.com, ulfh@kernel.org, haibo.chen@nxp.com,
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev, linux-mmc@vger.kernel.org,
	s32@nxp.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] mmc: sdhci-esdhc-imx: fix suspend/resume error
 handling
Message-ID: <aj1Z0fYSVY4cw0Mq@SMW015318>
References: <20260625105934.2890635-1-ziniu.wang_1@oss.nxp.com>
 <20260625105934.2890635-6-ziniu.wang_1@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625105934.2890635-6-ziniu.wang_1@oss.nxp.com>
X-ClientProxiedBy: PH5P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::8) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU4PR04MB10529:EE_
X-MS-Office365-Filtering-Correlation-Id: d378f62e-c535-4c25-2e6c-08ded2d86331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|19092799006|376014|6133799003|22082099003|18002099003|56012099006|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	NouVTTqs/Gsof3N8dyJ+ZaXgibOleVphOtwWJEnsIOI1iDpdGv+nn3YS9ZBYG7+eXhayB7nm2GEjhzjY32WTDypBpDxf4ECHK176e4picvtN5HxdoTIGRvZYSy7wKYcqvSfUwaMiuMFJ0NRTCWoRPuwLcHkoH1amQgi7284/zRV/73JrtYlMYmOgikVHNOxjkRchmhlXbCLVmvMbnEDQHE0F0q1qJ0o6OHSG2YpdCVGVu88X7268Cq4fCDtl8pJPP9a50wbEqjeULxmpk5Ahq4ciVVdG44uIvmtr4GfuHciwDbYdIuBFYKcBmxbFyRn5B5bSBegNFgZPrQzh4kjbtOOrO7BcNUrC463Gh8L9tEOYBJLDGpE6Nj+K7mu4KJNGuldZWtryw+yW0jf/bt4SWmdo6eg9bCvc3htx2USdKKlGZjyIBTaH+gR3K8eOq6ezOenuvFedg+Q48pZUVG9n2WfFaKfX+eUr4FHusGvPdiO8v7fSNEc/4kfFftDViIPBdnL+1oANZiKoa/q+9pJgL73NveiIBVNa+QUZZ38WRyQ7RxrdzM/2t5wjNXn0WumFMpGgQQhqlFS6mb2QWd8Qjni9mvZ14b7lFOVe496b/dxQud6AkNaGB8++mJrJrvcDPET/BdUUmrNoOCErFjB2aNxsqcobcbMH/u9yfn48OIU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(19092799006)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fGcNjOMOKHPE8qdNC+70YbZigrJWcXWiL5FBopBwiiaLMVMo2PNGJ6ySVejX?=
 =?us-ascii?Q?Wc6XcLr9tOv0fk1DqZflvnazHHvvSB4FUJPgPr9x3DHeg22QYOE2O1LvNaBG?=
 =?us-ascii?Q?tbZlFpPz8hzUGKy0w7qJTFPfvtPP7htvUuSwwgMutaW4s+Zpg4MaT5hcPz8k?=
 =?us-ascii?Q?/e83+7B2fKWFeYxTxpfbOkE3a9IJAyll0HS/ITl38FvVd/Inv6A0l75Rdr9U?=
 =?us-ascii?Q?jVJA1lF8K2i++5/1gJjl6tLOKgTs5QuinFsIHLuQVU77ljPafgV3Cs/R/EEk?=
 =?us-ascii?Q?MQgm1NJSQDiU7rluamHoIU0zSodDPvv3KyMOjx6XgC3FTT6xaXqMkMxCbhLe?=
 =?us-ascii?Q?RRebKL/HvGI2TsEZIOVhqZL+uM2t3JhjhOAsTxD1OZFcZy2B7YcylJ5a32Ep?=
 =?us-ascii?Q?n1ikpMt1SKAi3zwNv53clJH3Icqdg/sRK1+I0bMX5XFW6PI7eYLJjKJqQ57r?=
 =?us-ascii?Q?Uv/rPH7QdlLxechiJmZCMlG1H091fVh9VvGEd/pv17j7hbS9Ojj21HyKqpXW?=
 =?us-ascii?Q?XmKJ/xhYBIqTpIo/urXGR7xtalYiXvqtGTp76ET/I5AE5xGSs9z6SjIA+4Qb?=
 =?us-ascii?Q?oWFAY8cknfMvRlNFRVksSO6CyLoi5fxpBY/ODwDQqSW/jPOO8IFa1s2GTb8j?=
 =?us-ascii?Q?+nTp5gBsa+tUnHcxA71aRA8mcekEtszQeAiJWO00u0OR/Gno81rY1dSubVsH?=
 =?us-ascii?Q?B5ajbpiioEqXOYfb66wCkx4YLm7lGVGif4W+zoMyws62/iiRULXY2Jfk8efs?=
 =?us-ascii?Q?woIINIHikgG/Vx/2EQUvMtoUe/+x740D45KdZlE7hXgedV0YQN5vQpzGwS66?=
 =?us-ascii?Q?rFEzOnkcbKeNMupJ7SYF+3dobuB3SyCs5flAILWDYtINavf9wd9mLEprOR+o?=
 =?us-ascii?Q?+Ea63O3AmnezFt0QzSrLt1XVzYFGq53SJR+Je1VIxeiFoxOJpY8mbLaKB9GU?=
 =?us-ascii?Q?gpm5R4fvTkR6RuEqp6N1AzbmPjGNS1if/bEVltLEDBG8mEGZ7m6okmX4vu8u?=
 =?us-ascii?Q?V4vP4NKet0I78HN9NOpRDBryGrfnPObK+1XvbvWbV/H8ry6Q0+1m2rSs2N+E?=
 =?us-ascii?Q?VTYBuevwWlIjDjJGQeQP7GKUiEIItXe3qF3Y4QOozA0RmRpEUynFXcY74XXQ?=
 =?us-ascii?Q?1eOx7LEmW5NV+cu9qs8bgmeQ5NeIje9ayZXS9FQ97y8qPgEYNiue6jckPLDo?=
 =?us-ascii?Q?5MlNdvhm0a195ClDIyANtfOzVpKN8yw2nQq4CTQ1ELZ22H6iTyfQ777OTV6r?=
 =?us-ascii?Q?+Uv/AlG/8amF9pbYCAUKVtVJkDqGaJ8oq/Zifh2nL5Zpweor48XkJ8X/QsKG?=
 =?us-ascii?Q?TghhtZTTJGzU0KsqT/aHbr7y4W37Ml/T/Q2j8w1DTS60jrm5h6LVvVckR388?=
 =?us-ascii?Q?8pKeUX2vygQfYvkneKrn6DgfydMpTq2ppusR/eYyguVx9vLZTv9V/MxtUIIz?=
 =?us-ascii?Q?64Y5njx3Orzo1ZSPcgl2KoYt7NZjsidmA0ma08U9dU2necf6AIeR6V7wdkOd?=
 =?us-ascii?Q?KN45+6gdIAexHsACOaPwDVAmURp96cJJp7DjeHmSwCaq5znG28pJIjKrkk8v?=
 =?us-ascii?Q?ws+6BRTMLVYkOOmp6+QgAgSjEbktU/qqOKEdY3CUcsgX7jXpZhXJFoM/jAYF?=
 =?us-ascii?Q?slWDhr4n2FjsAZiMyWHWtHjbsvdPJU10sYteSjih0LCyc+cUGB41t1M4TCad?=
 =?us-ascii?Q?IG9uklA65Ty7nxWW2cD7DpIs7bxsPlqAWprjX+fDivaGsxKx0FygZCS1wcGR?=
 =?us-ascii?Q?nWU0KvoynimabQqWGN2DVjPKs1lq/vSzkPk5XUSSE0LQY+IRy2Qx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d378f62e-c535-4c25-2e6c-08ded2d86331
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 16:39:55.5185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PekRUF+8PApvydGctGxfFseRKKQCNdI3oxLIDS0qaaTrvNGp/lyGqzLPDmd3td3qhrxDmM8r21Ram9b38l9u6Yl7GF9985HMUbQE9QK8xGKWGsKOqeTNXNbxMr+GC2kd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10529

On Thu, Jun 25, 2026 at 06:59:34PM +0800, ziniu.wang_1@oss.nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
>
> Fix several error handling issues in sdhci_esdhc_suspend/resume:
>
> 1. Use pm_runtime_resume_and_get() instead of pm_runtime_get_sync()
>    to simplify error handling. If it fails, the device is unclocked
>    and accessing hardware registers would cause a kernel panic.
>
> 2. Make pinctrl_pm_select_sleep_state() and mmc_gpio_set_cd_wake()
>    failures non-fatal in suspend path. These failures only mean
>    slightly higher power consumption or missing CD wakeup, but should
>    not block system suspend.
>
> 3. Check pm_runtime_force_resume() return value in resume. If it
>    fails (clock enable failure), return immediately since accessing
>    hardware registers on an unclocked device would cause a panic.
>
> 4. Make mmc_gpio_set_cd_wake(false) call in resume not check return
>    value since it always returns 0.
>
> 5. Always return 0 on success path instead of propagating non-fatal
>    warning return values.

each patch fix one problem.

Frank

>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index c4a22e42628e..4d6818c95809 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -2060,7 +2060,9 @@ static int sdhci_esdhc_suspend(struct device *dev)
>  	 * 2, make sure the pm_runtime_force_resume() in sdhci_esdhc_resume() really
>  	 *    invoke its ->runtime_resume callback (needs_force_resume = 1).
>  	 */
> -	pm_runtime_get_sync(dev);
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		return ret;
>
>  	if ((imx_data->socdata->flags & ESDHC_FLAG_STATE_LOST_IN_LPMODE) &&
>  		(host->tuning_mode != SDHCI_TUNING_MODE_1)) {
> @@ -2094,10 +2096,12 @@ static int sdhci_esdhc_suspend(struct device *dev)
>  		 */
>  		ret = pinctrl_pm_select_sleep_state(dev);
>  		if (ret)
> -			return ret;
> +			dev_warn(dev, "Failed to select sleep pinctrl state\n");
>  	}
>
>  	ret = mmc_gpio_set_cd_wake(host->mmc, true);
> +	if (ret)
> +		dev_warn(dev, "Failed to enable cd wake\n");
>
>  	/*
>  	 * Make sure invoke runtime_suspend to gate off clock.
> @@ -2105,7 +2109,7 @@ static int sdhci_esdhc_suspend(struct device *dev)
>  	 */
>  	pm_runtime_force_suspend(dev);
>
> -	return ret;
> +	return 0;
>  }
>
>  static int sdhci_esdhc_resume(struct device *dev)
> @@ -2121,12 +2125,12 @@ static int sdhci_esdhc_resume(struct device *dev)
>  			dev_warn(dev, "Failed to restore pinctrl state\n");
>  	}
>
> -	pm_runtime_force_resume(dev);
> -
> -	ret = mmc_gpio_set_cd_wake(host->mmc, false);
> +	ret = pm_runtime_force_resume(dev);
>  	if (ret)
>  		return ret;
>
> +	mmc_gpio_set_cd_wake(host->mmc, false);
> +
>  	/* re-initialize hw state in case it's lost in low power mode */
>  	sdhci_esdhc_imx_hwinit(host);
>
> @@ -2153,7 +2157,7 @@ static int sdhci_esdhc_resume(struct device *dev)
>
>  	pm_runtime_put_autosuspend(dev);
>
> -	return ret;
> +	return 0;
>  }
>
>  static int sdhci_esdhc_runtime_suspend(struct device *dev)
> --
> 2.34.1
>
>
