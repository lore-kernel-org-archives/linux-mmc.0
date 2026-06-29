Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013059.outbound.protection.outlook.com [52.101.83.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A443A874C;
	Mon, 29 Jun 2026 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726305; cv=fail; b=U67l+It8PFetLMTbFw8EOuLX2D9fRpAVruHhx38o47sb2x5JvdD3sReWiIGCbMCmhMtHYKgUJb1RFQ167TFWjAXojVeZukN84tblJigkjoHFj/m34esNY2XJQ+f+IO/47nF+w7NqLxN2H2TtiQPabK9XRJ/OmqvOEmp12uBJf+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726305; c=relaxed/simple;
	bh=R4tysGihDwk/hbuo+GcILmwavT5Oufs+QeMSJs0n9Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Onh37aCP/OKeqUOtntY1jGOn0bzfiGAdDqN9Od4RhSuwsx/CAyLJoPhA/U5nVfF95M9L7MeqgzmAgEBQZjyfhEEwvte+xNhM/c+9u/KEw6nCNh2M1kdTcy6QsGIWC0mz3eyd+Lgu9wlliaJZEB+kiT4DrqP22dW/mGsSlx+9FLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Zg08++ew; arc=fail smtp.client-ip=52.101.83.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Zg08++ew"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYrEcN+mGxrggAw+xKpyh8NsDEHXG0GUF5RGMzR7fcUZY0tQjPnM9S3arm8Q+qPZYH69722p7MCve5ZuJ//cig0hFbhQTuCR4tfW6iK1NmCwWHD0dTG4Jtt17g6C8NmU0ZklCjmtqLNd7Ru+LGo4F1nQMZay1IKVfcqauVavM91Eu/mRcSh0nf3UHaIw9DWX7EntSgHMENyPPp11FsBtBh0cWUv2E3RtMPKagLBawi4kgM+VYcjy/CWnHVopE0SCdlmUJP0tupk9rOR4+Y87V2ArEqv/F2u8FdqzvcDtVGmrcLo/LEqkVSdhwAi3mswje/QA2wL919J8ddi/cfstqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAskuW7YNLZbSrb6KKYMcM9G4tb5lmCN8XMAc2jTzFY=;
 b=wedK1jbiidG5Jonzdrrpw6xZUmqRRbVYQcFenkz8D8CcAt4syhqRXkht1mFLfMIwId6ZzwpD96GgCHWR1ht7kJJc/4Sw9mdnkQaWg2Y7Ene2Ik6oU6Vhn3yr+Ui9heURo3kdPSR0TSvV/9uxIj3iJGEs4T8iqKUo2RibM3FQy9X8B9ZYyzGoXRa7F7JxUGJgJMBFAQyuXK5h+urhOYLFPXWqpUI3TxHOAcsR8peAbp2QeJAnftSuliVqEy8uJ7lexWN3NXQJWe4YVY3myd3Y+TRLNAZF0dDoxOWBICZfq9eHv4NbmNNE62mWBDENSBtsVJSm+2sK1vTnHPKO+puu/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAskuW7YNLZbSrb6KKYMcM9G4tb5lmCN8XMAc2jTzFY=;
 b=Zg08++ewZJhJsxRjca5JiAN24HZjnA2sHB1LZc9NoJcmG5/x2CG3aYQrwl6e4+7RHwFZ+GTeY1JviW3DqmxBtBAByp/7rGf/PdimQoE0dsc4e9qxm4IjAgjITXVTDLdyFTo0Lgj93FkHEiKjIlc+7mihtEcFyRBfggCnnNz9cB8J6XvstBb08sZS3it3edYaYs4WEGz9nkFoEo5O2fANqIWR46pdjFZCuGwXjRSzdB1w0pg+KVc02EVxtmUx37578EIwhBXZIqEky1Dj/J21/C2iZcJ9lMA42uCyoHSgIxnkj+hbLPnmXA0U2fgHP2BPGnXVpJPMWpMw/CW38nzNPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by AM8PR04MB7378.eurprd04.prod.outlook.com
 (2603:10a6:20b:1d8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 09:44:58 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 09:44:58 +0000
Date: Mon, 29 Jun 2026 17:39:39 +0800
From: Bough Chen <haibo.chen@oss.nxp.com>
To: ziniu.wang_1@oss.nxp.com
Cc: adrian.hunter@intel.com, ulfh@kernel.org, haibo.chen@nxp.com,
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev, linux-mmc@vger.kernel.org,
	s32@nxp.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] mmc: sdhci-esdhc-imx: restore DLL override for
 DDR modes on resume
Message-ID: <20260629093939.m223hzc2luh3gysd@nxp.com>
References: <20260629091954.3227151-1-ziniu.wang_1@oss.nxp.com>
 <20260629091954.3227151-3-ziniu.wang_1@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629091954.3227151-3-ziniu.wang_1@oss.nxp.com>
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|AM8PR04MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 2efec9de-aa30-4ee7-9647-08ded5c314fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|23010399003|376014|56012099006|6133799003|3023799007|4143699003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	mRkgtMzby874fYCT8Zlxe7fNDoaXPeqw6h3+tXlYMNAmm61MKbMjajONwz2/xQsOslOy6Vi7CtyKwbGW7TfcjRmPCE2/DPEX785NfqtkNv5MHCPXwuuB0KzzZlk/b8BIX5pltCCYnKRRjtWcWhQDbmJ51/4HpZ6IwKLkMtCUjODoSf8lcbFVGSBDyzPAZRQOxNWGObtHRK/RGJcWTYebsL+ijzoswBtwZf0NlBos/gRIhgrzf1i35viRsTNDftrsi4BEXLxAurOc0mRX+WwewJ82xZ9c6N+M0UCsiy6MP1N3+PtjjTHajPy1rTaGLuG6Y84DVUcsE8O8kTOcO0B2Ut9Sa8J+Bn9o/0CWBFDlwC6PMAa4z9jvVd+0wAe5vQe3b8klLA0X7S540h4CzxRM3YmC8jA4ohk8M6TcwQ6trBk+I+wNfoQFt0LcIyOXdQts0Dwire7LCB6h33lenK8AMGuw/OhEZnoXr9OdrkGl3SKC9LXZmKH2xEnoSmWSEg47N4fRJacDzw7cg2vIdaI3nO1/6cyhSmzC6aCfn9TiRksaetNZo2g06VrMZz8YIdpyuThwayfpIx5QbEo1s+Cd4F8/hUoslDyJEhbQitoLN+JOeCB2hh2cxQCgn4ctBS44vN/nGUaDAVd1UcUERh+9sqVdCUuWfOEMCdoYhi3wRpU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(23010399003)(376014)(56012099006)(6133799003)(3023799007)(4143699003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ot6ESc3tqegdV3U3ti9hK91ZjJiS+AgwCb2PbNbJJf+k18SwXigXfvd7Bs/k?=
 =?us-ascii?Q?hEEhD2ZwJDQyS4SplpoogslrAUZ457iB/CfPFqAXnLJJNodwzU55r/ZGdFGL?=
 =?us-ascii?Q?hJiDNNvoImo1ojxImovyBs2dZ1FDM07m1MezYenJ/I+osMnH+xRiw6ckVzsq?=
 =?us-ascii?Q?znHSzby8+O6Ns2augf2AX3N1zwibeVUlk+V9UnI8AVGeb/hv2VaGp0IbtAwW?=
 =?us-ascii?Q?CViAmYmSMf6BE/GjBgI7fNHIqfyFEdJ+LYPCKHf2vnB10RSQHjgkMBSQeCQq?=
 =?us-ascii?Q?iIFFEA3WGtWqeTKssn0SLu8eCorEatF9ygcCHC/TIk8JVhGjWPBZlSq5Q2iM?=
 =?us-ascii?Q?ONmGh7UzU7wXlVHOvS6cYoPtrIhk2MBtNtcUD8Vf2Uz6R9hiExrdvW/y+J/H?=
 =?us-ascii?Q?Kwt6Vz80DjWsQfRRxsBgm3WHJ3Y2o3CbfIG0z2WdhdZuV+uG3ObNwwWmxIzF?=
 =?us-ascii?Q?Psd0eb2yR8H5ToH5M1Zn5qUpRaGrglKsOrKFmizjevwOcqtppyNRyhaPQ6/d?=
 =?us-ascii?Q?UIKa68cH9uDuTzhgBzI+4je68hONg7f/QD+2yzMKvst1cCzfJRPm2BCayTyT?=
 =?us-ascii?Q?17XmLasd2BTxUTP2d6aCXA+htXX0vtt1Xk9iXj8Pq3Q5EWuWtMwFa/JPUsWv?=
 =?us-ascii?Q?zufJlktm/zmWkfKDyTSc+MiA8AS2jabWphw5UJsC4sigULFalhumeuw31A3Q?=
 =?us-ascii?Q?rKEozKmljCFfauAhCVzYlJ9ld/Ot/1XOaR/BtHLIpieTnfmdty55kuzt/k7J?=
 =?us-ascii?Q?PPD2FaOFzROQBfS7yQS9Xjp3RFnhh9Afzx+a211aKoSvAOKaev18YXRsLST8?=
 =?us-ascii?Q?05CQuf1M4NXYz6bcKcg4ghaODG0DYAfrHC00l/Eg9lzT045lpBgBMr2iJKPh?=
 =?us-ascii?Q?Mgb43nqPbjINPtS/+8R5Iew0ldEjwRA5+dEL7lOTiSOoperIpAa9cX8nKJOJ?=
 =?us-ascii?Q?JayKLpu/KWcgtR0IIo3+skW6Ja2gUV+seG1DP8RWCNtzDt69VtmM9RFshu1W?=
 =?us-ascii?Q?hle54D9XaEkBBAFbJebdsEPawiB5/GP51uRDWx93cap/DeegzfQmco3T6oao?=
 =?us-ascii?Q?7E6ES5SumXCiyahdYpYDrlqFA0AsGCkzjtCCc/RcSLspvYEjI59Yi5t6RvAc?=
 =?us-ascii?Q?pDNZanb1jqK+cwVMWCcZ2dx/e7Nn5RuBLZaT5RT7X/6UgmZg/n4/OYcUkv3S?=
 =?us-ascii?Q?PWez1uzX7nR0iB7+DjNE78NBNgkyITLtQBgxeqHMoT6/UcdZ3RWLVwU+TQm6?=
 =?us-ascii?Q?NBB7qF5BWXEAnloqe6JzelPzWJvb803jXJKPZArTqq7K+x0xTh59/MHxDwM/?=
 =?us-ascii?Q?6q/kpH4YEdQglWv8BGI9QikwFjvul2TfpBMZ8J5t2QyfjoYwSitN+sKq5eYJ?=
 =?us-ascii?Q?MHlbvVVWfrk58BgQZqZyiGkD7qYt51SXtCmc/DUn89XZZVeF/laqR7/dBGek?=
 =?us-ascii?Q?R0HJGx4W6XiKVgJYWqQLDJNlyUeMND+u+nnGencvrT1ZCbDvcr9Zz17477C+?=
 =?us-ascii?Q?00vTCjwRBq8WRG6bPZkXnm/GYExjLJRwXtBQ+lgvzZbHzyZmjzatPMAriiQk?=
 =?us-ascii?Q?VhYOv2FwWEMLYR8SoUQXsemULp+t6V3CR92Qlb5pVCCS/GtZloM5pcJErHjx?=
 =?us-ascii?Q?UVFhp0jJxLPpeGiuT/SILYi7SBao8jytFekuwHoMty4xg1pxnWEneF7djPP4?=
 =?us-ascii?Q?YWC+6Ag0x0SoN5rB08wF9iL/D7bgANGHTd52Qhrz2AllBYWdWoTke4ETd8ry?=
 =?us-ascii?Q?9DdqMlUm20Bq2tll4eM0XiJnQkQ7A481/zoKNQtvaHwPUJebwggC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efec9de-aa30-4ee7-9647-08ded5c314fa
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:44:58.2507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yf6wMZ2Y8F6OqjUUHh1dpQWTxgqRiejwq4viwdhMhICX7SzCsG8lcHAaw5ujC/m1Acj0TW7ltokRpCDpuHCLreYDA+CwO6jRFNo0qJoEASpAL0y+02pYbdhrywH//Ron
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7378

On Mon, Jun 29, 2026 at 05:19:49PM +0800, ziniu.wang_1@oss.nxp.com wrote:
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
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>

Reviewed-by: Haibo Chen <haibo.chen@nxp.com>

Regards
Haibo Chen
> ---
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
