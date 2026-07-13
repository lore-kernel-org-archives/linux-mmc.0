Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011071.outbound.protection.outlook.com [52.101.65.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3937930C178;
	Mon, 13 Jul 2026 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783954378; cv=fail; b=sY/0E2YKdq7xH9a680PcaNKul167x1RRI1WlUmKLtLpczhK63BM94IA27SyWQzmA7terKuRvrFIssQNCaAa0wUXeR7fZUq5lTfyHAVEnzkDwf8S8m7FhetVzed7Z7/vbvM0osCUIEqlUmH5IB118vQFey165NHrW3OiEFlTR65s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783954378; c=relaxed/simple;
	bh=FFl1ErWh7oFNvxlThSP2P67lHAtZ1n8E8pqUzgoNbIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Crvd6JuFSCFvuN99AkHSfFl+FVI9FDBSXUW87oEomYAUwJmnEGwPDyPLGLw7tYXt7vuYuGvZ2xJQRHSdnS/Oy/h2jRO21Joywmcbqx1xbTYgDIY7Db80iT+GlVx+ufjwCY2Kf9SIPXaEIF4zKcufBzMxi7ZAPGjyilLTF2UYD5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hOyMxbDq; arc=fail smtp.client-ip=52.101.65.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hOyMxbDq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zb0GZ44TCrgezJhuIqW65zPEIbgqWqCRs7IdoX3sSJj3m2mzT6EJruw/y0ogmNTcKLWTntDP/5bP6g7yZ7tJsG7/QhKTq2Xrq/C4LSLfDAtGe0N83IwKIHZ5v98X7lqVTjcoTRBVlzXTXOj7WQacU12IeEYaz8XFLUYlX62o2tS1yD7gIfcNr+qxoQvJEPN9jZSXx8wT/AEpmHnL6jAEP2xT9/NIs7S76ISKQZwwDu+SXSiu1E+PaU/NJU2t+nx7wj+6POc8GYe48GEVxFV5kAnc8+fcICoKfaDi+Yo2pkWpI/OHq4KgPMbGGvQyT8QTRuIH0IEVjhWf1N1gkahpYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uiEQqHbvP5v7TCWNfpyK+13J1fdJFu+NQm4UFoidP4=;
 b=QtWIL+4H51qKQtSXgbw9c+JhS/D6a1sMDDj/ncXCz+hpMJN/qevWBPcwQK8hUbn0qNQBn6n5Iz9OLxEGlZdX9H72IaP1GWFGDWrp06/EyIGYWqPBxcdh8CCMitKEb6nXVoFfXdDwY4iOkLl44mV5amzO3RyfpLb9GgaCV7nX9k/U9QNgINKfLJwHs5MEj4vASDpOxNe5Z6g0AeV3Mlo5ln3I6GzGbWbs0JZGnBhS+YNQpbkQe2rUotBlwWApdBZNjIrSNcCMez2H3om9ORj9Q1tvdohYuk/euxGPCPhoTszyyb6x9WN+h6zZFPjy+cQYJ1yoZ2ZBPvIZsYlqGuVyAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uiEQqHbvP5v7TCWNfpyK+13J1fdJFu+NQm4UFoidP4=;
 b=hOyMxbDq66cGsuh8dSeYdHYypwCv4G666KuSNM8FeePg4W5dS8vxPkWcy7EnhTj4ZmTbFFr9HMFC/H9JewfOX7JpxbEvUAYwPXFmAbmdMFjToiCWPwvPJrgcTQgftUhyNhDkpRqJLvtsimfk/I0eBfY7tCrnjV+07WZuiLdI6ovQBwOSF1+q7CGGXgZDlNnFa8ABuTA1LUN8DSghASfdufWdTEC+1924M1k7MMTx02inPMx4E/UjgDqzIa9xHKlxUzcxfjFbvxyzZCL+RgEN5vKM0eEaRZsRNziP+R0ddpM6+FQoABhvEfVtk0eDJw91TqTKbO2w8P8awSb9CTHAlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM9PR04MB8416.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 14:52:54 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 14:52:54 +0000
Date: Mon, 13 Jul 2026 09:52:43 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: ziniu.wang_1@oss.nxp.com
Cc: adrian.hunter@intel.com, ulfh@kernel.org, haibo.chen@nxp.com,
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev, linux-mmc@vger.kernel.org,
	s32@nxp.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 7/8] mmc: sdhci-esdhc-imx: make non-fatal errors
 non-blocking in suspend
Message-ID: <alT7u_qNf8JqoXUX@SMW015318>
References: <20260713043904.4144172-1-ziniu.wang_1@oss.nxp.com>
 <20260713043904.4144172-8-ziniu.wang_1@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713043904.4144172-8-ziniu.wang_1@oss.nxp.com>
X-ClientProxiedBy: PH7P221CA0051.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::21) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM9PR04MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: 8908bcba-faa8-4f29-83d8-08dee0ee6b42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|19092799006|1800799024|6133799003|18002099003|22082099003|11063799006|4143699003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	SgmfJUC9lanrywthj7TO75xN6lUFf59KBsjaPn+/CSq8LU+qffO7EXXCU3JN03POfRa/oWoEsBLsejinwxpgRk+oxGzZ4x3veK68V/7uryw5yWy09dSm+oknaf68y4GUsEHcpJIrejtgbXY0AC52dka8kG4SOhY50XNLQ0qEIBcmrdCUWf9PGxCer7OHAqUzxAGpz+ED3qGrPImhmkRYoRpJOn+i0VMR2Np9YdlihWjNiD2MxK4nc3M3ajwOroLUkV2mjfpJPzb1VK7fVHmdTNu9uSWKKoeVjdCaRd5ZNwzGz+SnIsAtyLQoRvTtnDAiZQ5EmSFKcyRHEdd9J02/xGlVG3d6qUY/9cO2azi8di4HRHQxzVHAS1t6Ej38HEuDrS48cK+uL0gfoFlQmohSg4j6oq/I0ryDX4WoUWqLQOZU8TsYn5SGWH74bnmkx1Fgvp4c7eZkq5yBXeGuCke2X2Nv2e3WLFhZj4TOhMHeCw8dKlcO9z3FMicStExlLQauA1H65ZKQWksqbHF4RmwFFsJ6YfjW3WtKAv+zRfi/ljRknGNScgQM7wq4fyzJ/4lDGR64WxGWU4/VZbo8aWauxOGFZ3Qcau1ZY82RgoGvESopACaoNB1vuAmvXEDff1zlUmJCoTRKhTJuXWe0rgHLQ706NMCFg+geKxhzhvb/i58=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(19092799006)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ikha65TL0LMQAqfiGjiI4TyjtvQsK/yDEKHDutJV2judof5QFOjfxzv4O1Rt?=
 =?us-ascii?Q?WT9CZsNeh3JFfr2NAMvtpoxImtkHGtS20wvmO4y+6Ih1412etY0MXglHOe5s?=
 =?us-ascii?Q?3NRLug+ePCrS5i94QpoHrSeQ25WytP3sUby4+rUfALidiCDdnfmKqnTgQrOM?=
 =?us-ascii?Q?oMOAOJ0HQbu5lK3J0YpMRCsJBKvaPZwKcDdDVxkV8NgExZ4wJdHR7B9k/YCm?=
 =?us-ascii?Q?NFUWrRRXWDuAogC7/v0mNIIcp1NpGjsBHw5MnL44bUvEEUawCtK/O918q0BW?=
 =?us-ascii?Q?hGIefGPaUUv+TpMz18ge2IBw4AVwkU1i+A0oTsqdpWQ/CJG+NHbdwBG8whZ7?=
 =?us-ascii?Q?txA6ugIlMG19zH34n7VPrpIuvQMOVdnf4tBoSVrraPeQJVJ4UBwr8M4Y41Bm?=
 =?us-ascii?Q?e7zRsywz/PsZpk0rdAE/qPxn5/Rd4TgL7Gfej5++DIEzL4QXgAGUMF/Xj74s?=
 =?us-ascii?Q?12vFG3Eg/9uIxYZvJveJ1RXRQiEbCXYPk7x0BATHAvu2G+W+9wvh/WTnY5uv?=
 =?us-ascii?Q?7rtnv57FDBMiDLq67/v+ylYOQ+LKhEteNKEL9XaLB3ftKk2Z1GhL4qiwFYO/?=
 =?us-ascii?Q?RUh2EzQoxiTWn8T1ViLQIK+QsnaFlOVrO8d2ggGGb4blfeXbEBS3BfZAS9HI?=
 =?us-ascii?Q?kF38yDYQer94I9tlRjf4LsGJKUgGyEj+MFZX1NfdlDjiseQW4wIXnCtJ7SuQ?=
 =?us-ascii?Q?9xhyckJYeJTGKgWwC/GMXrw2SpmEdHvu13CdsqisdtT/zQek8nkgofUNguss?=
 =?us-ascii?Q?yhKaZL84Au+mZceBDstIQDZjvoEpyEJBP2PxelMmdLD+BJ5HHbxzvorHaodd?=
 =?us-ascii?Q?qtoGSUEbWCK0wnOFQSdu/aniU+YoIVmnw1pTInmLWyELTID13I2cTUUjfqqV?=
 =?us-ascii?Q?zGgRwuwJBlzbquvvbI5/LlI+CKWIvZ/0AVPoerWP5iQViw/0sitz7FbToS1y?=
 =?us-ascii?Q?3QZ+GTnjxQ6l7ZEYocGQL+oFl4PfpwtYbV7YWD7B80TbdzAn0PIqyYowCSj5?=
 =?us-ascii?Q?O6Z+wA8aMGnyitDw04VxZMVe03ZAzl49vFwdu3ypOqoXOVTcZiD/uC8ZeKYV?=
 =?us-ascii?Q?G+Kd6ufy2jLSm8Yy89w+O3G2eO2era0dg1ee/7rgzB/faSFd9tRsMxQnuR4V?=
 =?us-ascii?Q?TmBbw2qpoC+OoqT8YzJbRdWVPtIp4gTKjE3FtGvUNDMricAczT0pTzBq4YdJ?=
 =?us-ascii?Q?GmXXLbvM8uE7jRsnL+GYFx+zgknTLc+D1MwetSHZ8HSv/Scs22RotvgitM3m?=
 =?us-ascii?Q?+tYNnV4urUSQR0E9IlEtkOmNHetHHj1c8ae2IEatQQ5d/yKt5JtIOQfO8Dgq?=
 =?us-ascii?Q?UO7Nz5pzWO/bIBHQHlVkoHtJLZJ7Imaq2rw39ABBKeYWhUJ4pIY8m1egWC2h?=
 =?us-ascii?Q?qEg8PY8rUSasmi4aX/6NY/d/yp9pMNPC6PsxuDvWSrjGYclQG4up/xwh40AV?=
 =?us-ascii?Q?akRA/SvFN7Kmn2KzPMfsdZamcshinq3La13CCg8sUrbCXLwtYM5XLBohXtSg?=
 =?us-ascii?Q?CRHg8wmMXYPTnIrgjsfMpQUlGnhav8lRtJcYnX+au7A9BhvGW0uc/GDhFzus?=
 =?us-ascii?Q?/KLk+kWeE2DlaN8XXgLzRl/F1vipGpxdaK3ZvTz1c4AumQQfmHvEvev26r9B?=
 =?us-ascii?Q?us9kN8Iljq/xIhwt6P90LBwgbwIhQutvJrlCEtG8I70o2vEz2KKqCz5VWnwz?=
 =?us-ascii?Q?diVirB+fx7iGdeCIAaoVChXlBKnTwJ8eZ79GLfh0a/qT3GctK10AMA3dPTOu?=
 =?us-ascii?Q?af+x3MwRMdeA2trgkHfx2xBrf1+cM1vppFB86UxU5fWOvlG3Loxp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8908bcba-faa8-4f29-83d8-08dee0ee6b42
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 14:52:54.2310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBGWTwWMy35tgjEW8pR1z0uivZo9Y+ruhb1Wwcyr6LpCg7pAZ/WZWQcywWNBg/uh9hB7ri/OSj76oAI4gEACbmJYz3qzlYbwM5DASj0s2+RjHCuU+pRub+vt2nqr8r2n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8416

On Mon, Jul 13, 2026 at 12:39:03PM +0800, ziniu.wang_1@oss.nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
>
> Make pinctrl_pm_select_sleep_state() and mmc_gpio_set_cd_wake() failures
> non-fatal in the suspend path. These failures only mean slightly higher
> power consumption or missing CD wakeup capability, but should not block
> system suspend.
>
> Also change the function to always return 0 on the success path instead
> of propagating non-fatal warning return values.
>
> Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 7818f351a58a..6cb84690fde4 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -2097,10 +2097,12 @@ static int sdhci_esdhc_suspend(struct device *dev)
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
> @@ -2108,7 +2110,7 @@ static int sdhci_esdhc_suspend(struct device *dev)
>  	 */
>  	pm_runtime_force_suspend(dev);
>
> -	return ret;
> +	return 0;

if other error path set ret as not zero, the real error may missed, I suggest
don't set it let

	if (pinctrl_pm_select_sleep_state(dev))
		dev_warn(...)

	still leave ret here.

Frank

>  }
>
>  static int sdhci_esdhc_resume(struct device *dev)
> --
> 2.34.1
>
>
