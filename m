Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013052.outbound.protection.outlook.com [52.101.72.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E502351C13;
	Mon, 13 Jul 2026 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783954698; cv=fail; b=rKIY0xCsT0efhjMWyt9bS4vNCrouARRY8v1U+8wQkcyaR6tEyVam5atBcxGS5aIpsp1aCY4AMRyu0Zf4pWG6PhOYE8jsu9Xz9dvm6rtX/sq9z+eLoyS9ASW2SXmKgnxGSPlMmfl3KRnmuAPuHrDHCn3ojZ9r/l7fBqUQAL9vOAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783954698; c=relaxed/simple;
	bh=3MRdJGfneRu1MEW5psCTklw8DILzBzKo+94bjRJjPrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CaZOq7/Un3fD1LFziqx+3EN39NznHfexyIzt+WEQNTta2sANa1qnVTW69ESa9oE+9FuCKbeJfA75XEUXyOiELEaXsrwkyNRa7YSGlazPHeyVCxn05cbZIbpNg+3iM2QbRdUjJbRCWPyv7yj6TpS4vYfP30qR0wc40uIT5BCUMP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=nQbs5j12; arc=fail smtp.client-ip=52.101.72.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nQbs5j12"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHmSMchIrbRR6hkq4etZ3UsSj0iTIzt+NLyYJHPuS/7rFKaH0xXzu4HDIHfF4CFKf3+OwYwdoMqm+JYuIse2oE3SAtgymHQAHQYkH3OCyPAeDfr2yDWOFnaVVuFYNGyI67UihFet32MXHfQLZtCslaCNbR2QBkpw6uTXFB5AStR1/q6xR1xiyeekuKMYVaI+Al0sOB1yl3dFNi+cEuL+3rg7lCvAZnmCeYB/dN5xrkylXBzcf0YfXGGjjDlpdA95NWBX9bTzJ55TAe5ZkYSvjCzQIDyZiNDN/XYUbTTuYZOGEZUKoghzHKjPM9Ksk/QaS3sRRHnxALNaBw74gwJJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LPPLYxhep/2UQJi5wbPA/nk3qQu9ZHf+sM/7O3Rfzw=;
 b=hSGViCHY+LDcuQbSrtDHXqJdPyoRTnkP47hMD+CfzpJaB9NKSqp9U6dN9ySsB7NLaXGDifg/JXbz+q2F/tLtzZdHEcXG+KwC1021NhfbTCS475wC7dN7IOqzTKS2JjY7ZELaqjeMujTsO8yDY5zceT9A/Wpw9JZWl4/miXKAqjK+tvzSh+Op7v/Huqu97+1Bu1NtNEwsx6VXJR9kM7ZDNF7Qr3G2AAnefklAatdqsuC4b2t6iGOqvvUx6PC9C61OdMxYzFUYfsh9KwZD56nwsV0kHV0XYtDaQFH2gIv2hC4e2I5UWJG0nw03Ie0lmsEko6yEp3tXTv+VabHt0TSHsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LPPLYxhep/2UQJi5wbPA/nk3qQu9ZHf+sM/7O3Rfzw=;
 b=nQbs5j12bZafVPVUs/Lq5oILgjhdgpryB2FbzzzuQ18P/DwI4tjmzsUM1aLGw2uginmgppzD+VexTVKr3BN/XoWW0aNAFfZY+viepi5WE0dU23gRtkEHFNk/hlnS3Ww+ZARXL1sAs27p8TtWSO560DIfsW5M6NNbTrWm829T6SktVYR3CaHMaaVIAgFKIcmHmz9KISw/vWFw5ZDrR7zzpRIoEuiN0BDFbuiytn2/z5UVsv1iIAihEdBLz1GIixN7xbEC3SJzxvU6SgTr6u5mADEnvmDGvldECc9UpJ0pKDDZY6kLJGx2cMFs56IgmJH6f4pi9Spq++eBiEJ6Mz5jAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU2PR04MB8853.eurprd04.prod.outlook.com (2603:10a6:10:2e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 14:58:11 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 14:58:11 +0000
Date: Mon, 13 Jul 2026 09:58:00 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: ziniu.wang_1@oss.nxp.com
Cc: adrian.hunter@intel.com, ulfh@kernel.org, haibo.chen@nxp.com,
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev, linux-mmc@vger.kernel.org,
	s32@nxp.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 8/8] mmc: sdhci-esdhc-imx: fix resume error handling
Message-ID: <alT8-DUlcLIcXCK1@SMW015318>
References: <20260713043904.4144172-1-ziniu.wang_1@oss.nxp.com>
 <20260713043904.4144172-9-ziniu.wang_1@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713043904.4144172-9-ziniu.wang_1@oss.nxp.com>
X-ClientProxiedBy: PH7P221CA0023.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::34) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU2PR04MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: 57388fb7-1bb7-419f-eeb5-08dee0ef283e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|19092799006|1800799024|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	uDSRIw215+yibhbVSGV0ab5uuGYaZjp07Pr+dJ7Ur2YIQSWlpC+L5uU0VVZjJHB9umseWTEkMRePAvftHzoa1ksi9UsHTFI90C2CrYuXpzcFCMzZz3xh8ujNcikwVwCB97W+/jhbM11ZbnYrS8jmcjk/Ahom7kOyhKI+esFLmuXsl4/67Fqg1uIuMleXTn5+A0nqXchq1S0ob9XUVgVA6+7GrunjRkqYKmwGjb25msHJSITQGeQSc1nI7GlSW10d18UgBr+i+fnvGvjphJGqJ1yANHmyS2sBU0OnblRLxQh3noJPEfMBxv5xhQ/4OtWHkNi4oti5J6jaE/sCNrso0HnthXjMdtASAK0X+/ixH7zA0ETLM0zwO/UtN0MwXZ63+11U1/i/894cZleCWHsSOP/1+5ZptZcFEuy/owNhVG7Ze9aEapqbxlHcByBZHq0zhhTPQrJh3PEL4Gd4lHEK/U8N0hgS3tcgSgQq8hIBJydC449TVwMrLe1oemkd9mWCCxjJ2MOqBrY1eAZNKa41aGF4ftb+TD7PWkHAGecQEcqgbJ4LzSv2Ag5WmmZv2d5ZLNBAkkvAxMYCAQBtt3TaoLWPseoe927mYMEiEefwsmAMK9Dbqa/R5fOMPvJQ9tqce5Mj1jzdpWjW4SydqrTyBL5kxeMRFG1nGXw3wR0N5BY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(19092799006)(1800799024)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GCR+n4fWHsQAEWJBU6mwbLZpZbMmOoAEvYz1nYBISmkkXN1IK+AqKQhCVzHQ?=
 =?us-ascii?Q?NqZ3FU+brSkFuFe+MBXRKhbq3koaf2wBpjLzx+7poXyD06DnMOahzFEcAPu0?=
 =?us-ascii?Q?+iKiIa3m/RLLxv0wfgnfz9uzb3H/lEWX3UzkTFurjRqWyM5NUyvrsbqvA1uE?=
 =?us-ascii?Q?cT3QamX6JeRlg5Wwh2PxZAWVV62ks3VjCIbRO+i4FTMYga49CTHc3UfzuoA4?=
 =?us-ascii?Q?DKdfBVXk80KhmzBSK6VG6vQEwYDDaaoGkraVUrcKWklhxVJKKeEm1qe6ILAw?=
 =?us-ascii?Q?ee6h3DpzRF9GjVLHhvNeGsAfIdosKb1sTYTxVn1jwhGuwvNuDpSM/0Vfn6+Y?=
 =?us-ascii?Q?mt5enpdRfdalkLKvpODi70JNJu58ep9hiq1r2+/FKIumRCV7bBvrj9BMv6tk?=
 =?us-ascii?Q?02Q8CLN2fzFrddD4Fjk0f8L++jL/lSMe3uwdoefURsD7WQ7SyVgA3aOU8ak2?=
 =?us-ascii?Q?CoDWfUNoB+r6Raic7BUoRx/DE9BtGv715OtckUTas5qiqcD6i15PgI8lRJ+U?=
 =?us-ascii?Q?oLzPN53/DlUKRj/uGZLSNZ4i/irl/W9NrjNZjvAn+dRfAqInvqTYR6OHmAsL?=
 =?us-ascii?Q?tjWrTEkZpMtcw/tNY7jyve17paWkZh5O/8r1zpP4rKigPhX/mqScS8g+FPoB?=
 =?us-ascii?Q?5cMoVEufEI5o0/qpLhCo+PyZL2Or7SHnlHHYwhw7JTmNU+igDAzXqhCWizju?=
 =?us-ascii?Q?blMNJmWWf9ffLXCNgUvxEtQr9LdniBy7j1BXYVAbYmOGMIaq5bhdsmPQztwd?=
 =?us-ascii?Q?tgMlORq0sqd57Y8CgvP4gDWvStnOB6TDvJPP5FHuJQTAAAlyQWYyZgKfamq4?=
 =?us-ascii?Q?KORaJw4Ait2YvBuUEiBkJ1vPalAzPhs2ZZsdnCt/jWDimwTsOfYKcFTksdex?=
 =?us-ascii?Q?7XEUM6YW3tgtgeJpRUnIn2DrGXlEWxWeTnlznR5nA182Hnqyg3Y47mxKvgXz?=
 =?us-ascii?Q?G9LepUPSSMn2I0szL2CjfMhvRN9bn6S1Xv4mFko9mqVA/QLaypkWFVUTRP/k?=
 =?us-ascii?Q?pX2Y+yIPBX++ULNpN+JCEWD3ASFjm9dN/xuL6X2KL7anZzCCST0nyvGRbVUQ?=
 =?us-ascii?Q?UluM3r++eKy1p+fTz3TxFO6HdoH4jV5/4bc/VCLOYt26kbvBjvtg0zu+OD1x?=
 =?us-ascii?Q?r3dZNqYi4AKcGnoRIXxPbmDSXnC4g8OUZDPg1pQrm11tOeyRf7BMWbLDh5FQ?=
 =?us-ascii?Q?1dwwJ/QG5J+RpNGc64wvnLXsmS+QPIDcTjPqYieTnGhfYpZmWvTEd1EC9nUD?=
 =?us-ascii?Q?DvDLNsV6+6ZCGQhI3U9u90pQjPfLnFkHtcdWBQ3YH3myN2QBPDcXo3Ip212m?=
 =?us-ascii?Q?We+vCdI79QKScwC5oXLOseB/FUZC7cO5/t29+q9y93Xgkuhafg9/VIaCh7cL?=
 =?us-ascii?Q?EfNwHVI4Uk5bsrHr9M8IZhF5xxWiSvQEHmwSIZ6FpKLOm0d4yBNQN0MF9psX?=
 =?us-ascii?Q?0mLFJFcUhes6bHDQR5S1OjUBlwwcZQ9xgWS3dkv7oEBBM8es3ckc3qlH0fc/?=
 =?us-ascii?Q?CDVFkfQhfjCoJtJVhJ1zzIUEbObFQIJeG5siAcV8gdQZ9Rbadtku3u5cgOQY?=
 =?us-ascii?Q?gzeFTTp/4y5XUsKGEoesNS46nE063rcqrVn2uZFp4VK9N5627+r9545tD08X?=
 =?us-ascii?Q?rXqPwCFlqS8qzFEMI1r+ZmCOpEvRr8NimqlfzyCr+uF3/h9FhXL4OOfq25FR?=
 =?us-ascii?Q?7dPculjpV3Vge/+KDTVVPOwti/HelWutrdPIBjcMEl96QfxJoxxJlgmWCZDd?=
 =?us-ascii?Q?DNKfDwlk2wxCt+SSv9ADKHMNWbr42DDxU8wj9pXyQoyV5k4BQdWs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57388fb7-1bb7-419f-eeb5-08dee0ef283e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 14:58:11.3783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZplgII4vXh2oWFWHD89Hr5CUxB6Gqls72QfpysBOFJJwInNO2CLPHtuqK4dtafUEc6b3emwPYdm9Puc81GaqU+RhYmtQlzrPNngcJHODrhNi64WnhAoT++Oh7Y+sxpi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8853

On Mon, Jul 13, 2026 at 12:39:04PM +0800, ziniu.wang_1@oss.nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
>
> Check pm_runtime_force_resume() return value in resume. If it fails
> (clock enable failure), return immediately since accessing hardware
> registers on an unclocked device would cause a kernel panic.
>
> The early return intentionally skips enable_irq() and
> sdhci_disable_irq_wakeups() because the IRQ handler reads
> SDHCI_INT_STATUS, which would also fault without clocks. The PM runtime
> usage counter leak only affects this already-broken device instance and
> is an acceptable tradeoff to preserve system stability.
>
> Remove the return value check for mmc_gpio_set_cd_wake(host->mmc, false)
> since disable_irq_wake() called internally always returns 0.
>
> Also return 0 explicitly on the success path instead of propagating
> stale return values.
>
> Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/mmc/host/sdhci-esdhc-imx.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 6cb84690fde4..f4bfb14423e4 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -2126,12 +2126,12 @@ static int sdhci_esdhc_resume(struct device *dev)
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
> @@ -2158,7 +2158,7 @@ static int sdhci_esdhc_resume(struct device *dev)
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
