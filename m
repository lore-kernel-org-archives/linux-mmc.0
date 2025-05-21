Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6654D211710;
	Wed, 21 May 2025 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747843810; cv=fail; b=aJ+c+31eQxSImq4bEqELGqcN01oX0tXQeMia2ZpMYjQX6nzStvkok6uDYKozU/Gt10DCFbMo8gNXlA4rn8I4plsKWONopznX3bOz9SBAJgTHaY6otTdr5fyDFh8z8EAlQ0H5+XO5mg30coSlD3yYLW2+i5GSIRw5TrwT6MANga0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747843810; c=relaxed/simple;
	bh=rSXFtopIZSV2gG9KWSwl8PTetaLw3CYOlfAXx0CDGYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bnSDwcTlSYIcm/kTI+ytFFM4fZL3b1HRUkIHWrLtnlARYR8vPv11InEijR+DkkxbTpuO9n+4fZy55dPj4TqHPbapQuywz4QAYXPexB82+5E2FAWcLud37AHDaXdNyT0bScMnpoPFyHDuB70G2TFjTlTcvTbIg9OaOdAp1tfNW3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AakecKak; arc=fail smtp.client-ip=40.107.22.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AakecKak"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDHWmDb/p6ErLW9RhQ//KEfsGWnjbeGOL+0ysVgIm6WmGicCqF73ypmyiaFxLLS0bmJG/0uOnNIjoZrOVmi/EhcqtUepcvX2zbOaw039DTXWW5WcywaQlAMbg3Jbl88LIQqOUAGpjjvsWwkv0iaXpder2jP4pb/dWRswY2EasOWpyu1U52XJWJ6BUiLCALv6wV9e3WF6FihHyN4HMi3psi6gf0DO2Pz8ciMPHayvLYFLGmr0y08q2Jk7MDElaVVuzfSl2GajGKcC2hpeprD8NpWSCnidk8bJIoeSDRqedAS/8j4dbH0JuN9ukl43OQSTQiyhVcchh+JNZULzDq19aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkLxPhK0GaqsWuORYfQN6nF3N1D+WVbBIRveHJ52xis=;
 b=hwP65QhQSplQKnrYewiVSIAa609uZTxgLgzH4t1C23wFzRdSABqv/RFAzU2LrOs8TgkP/2CpzQ2fGY6JQNZzFdCfpjXsxdiL2itbQcRYNdLMCdBzrLVNKy7KcwGr1qg4Gx9nZwQnVVRRHyK9ZhyWvSYTR78+m2cxMRQXMBouEfRSS9yylBSKWevwzU5Df9vpHLUM+oVTtQUTH+N3n3SO2PmZORLogSND2LKk22oCfv0YIh0txo3k5Ljo4FK6MjWWO7htM/jF9TVfHyc1/+HHG7W1gL25/+F7c46dNAnxArSnO527in4ULawNUzNboETE+Q4S/rG0B4S6l4YWUQu9rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkLxPhK0GaqsWuORYfQN6nF3N1D+WVbBIRveHJ52xis=;
 b=AakecKakFRwiAL6hXx+ABzLcnsOp6FcYdHiMu1mnBy6a3UQnR/cybX1faV54Xqnxde/hVBmxvmhjzSzU9vvKLtz9op0Ef7xgV0djjDu/1Doq7iTsIlyqswrlO9jlETtHvWdYwfPqPG8nLybNJp93kIE2brMRKyl/aT9VHl9W0GGgl4Xgod8n9iVMEd+K+7ScgUwBWeSOQ7WpVhk1KaWetsLMo5ifH8RGeSe35UauBLsWoRsAYQWUAF8wXgJl3V8MJjOEJuPPV9vyfsz2JNTwELtSWVFKp3o0gyGqSW6N6NCEG6Oa10qtNFr3xmqa2R8eRXxnDBehQnDmSuDZja9EVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7957.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 21 May
 2025 16:10:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 16:10:05 +0000
Date: Wed, 21 May 2025 12:09:54 -0400
From: Frank Li <Frank.li@nxp.com>
To: ziniu.wang_1@nxp.com
Cc: haibo.chen@nxp.com, adrian.hunter@intel.com, ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	imx@lists.linux.dev, s32@nxp.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mmc: sdhci-esdhc-imx: refactor clock loopback
 selection logic
Message-ID: <aC360rN4h3smTAj7@lizhi-Precision-Tower-5810>
References: <20250521025502.112030-1-ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521025502.112030-1-ziniu.wang_1@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0233.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: 3689c240-9df3-43f4-08bb-08dd9881f2cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?paxIUOoJab9ngR/0RfWhP2LITxAtiD9qG/VUp0ZftGjaMSF1XFt08yzHljix?=
 =?us-ascii?Q?34qejdMGgeT5gf1fhckHOkYc6U/dHxZm1R3A86HGjlpTMud7sIbI6juEXq8b?=
 =?us-ascii?Q?O6aVibhsdPbXMRwM6pzuq5GQDvq0gknITX+ghYVJfbvUxjc6ekTjss7uniMu?=
 =?us-ascii?Q?whgv7VR4D1LP/twMBXvLO74EFlPMb4hNpjOi8R1Xm57ArTN12dRT4Vlcz16s?=
 =?us-ascii?Q?F6yFzn1p2ce4riy8IpNV4HB2gDR05DImDZ1HyqXZ5iktHH3RKeiwJ5MalmkQ?=
 =?us-ascii?Q?PtftsyESZjW1b0sP6X8EM7WG6C+Bq7WTSKlqs/i5zym8nbi9fofhVN35ruvc?=
 =?us-ascii?Q?lzr2Kc+2kYCJexQBVg5WUzats3knQzBjUcoNNyvJuGa+h+kKooYYMZZdg604?=
 =?us-ascii?Q?cqhY9IGl8WsXqH1BDMrVN/iCJ6GiwMe4sjoc5nJG5yF2ng1gP9/7G06zGHNR?=
 =?us-ascii?Q?GzWKsGN4fnKIOGoVDbl3onNMB4bjbYoEFc4HJe01tWJUW3F6SiSmPaUi4jIA?=
 =?us-ascii?Q?JkwX/hhSzqkDaPBVDnZJxaFwbUqrRuj5Tupt19kZjL5DbS9NKPkPtX2VyhWo?=
 =?us-ascii?Q?vvxUuQfsezJyJ0GQGYWLOjG8MG2PXDyqEvZIOSxcwXPSOiYD6IJXgfd0kt7r?=
 =?us-ascii?Q?5V0A4W7JSYE3KBMNomPI8dT1z48bR8FLhF2YHLwPLFLUyXFRMpMyn1ZFXbe8?=
 =?us-ascii?Q?rjHd4JidP1BQWuW6LQS1UWWCMWumF5Od0Hxy70UoqKKi+8tgaCnHPCv7zsKG?=
 =?us-ascii?Q?yu7lAGiSlr73Bp+wfwsXkL8NMFsLw14fkMk7EQWKWI2ulXma8ptB8gtM8v6o?=
 =?us-ascii?Q?w6m6NKDZ1CudV6afqm9EDQk9ScJVGebbj/C5+jdDNASH3U3Jn353Zk2mTGvX?=
 =?us-ascii?Q?qtBD0tdmovunOgD5mAhTqsXrRj8J074KH8SUlb9jj3ZeuEFkTzmH2tbQxMF8?=
 =?us-ascii?Q?WQb6leT3eLub2McElRHHSgs2DUpyrHq9Kyl0xeyWOLEq0eaIHWEt6Gc/9XiE?=
 =?us-ascii?Q?crLB79xVU1qTOoB8nLC3aHhv+wB0zQxogUfA2GO4zdQSFzzkv+PrMfDaj5DO?=
 =?us-ascii?Q?2vSlRE1J6XxCvQzoYr/vmh/kwoaAiw+zpkk1WVyU4Pu8yK48hrb+hJalgEYt?=
 =?us-ascii?Q?39XX1eMh7a34pM9UeBAAi2+fM6TcsifAZrnv2z1ozi3Nnk9Yayp7W0Vz158Q?=
 =?us-ascii?Q?J1VBmV0MUAqKrRcm2ZdysayW6gdoR6ua3Enmf93nGfAYL5hLKoG8Ki7ZVAj/?=
 =?us-ascii?Q?hRG6gf2SRWxDiuKLj03U/yqqfqRHKjpngkCC7AEH7GYHypCzQqaKdXznJBh3?=
 =?us-ascii?Q?ml/Axo+BBQIP1IrRw+5Ad8iuOOp+6qRV6FGgi8rPm4CmuEQ+8KdVMtsovy7k?=
 =?us-ascii?Q?N4DMe2Rl/QGgHeF/p5UbPqEFU28aWSKsmEYfJ/YjeOnou1CFTxIrijiMs7Vx?=
 =?us-ascii?Q?IcyiX8PHbsp9ODWCasBI6JLvq2dyrzFVxHJbCvONQJqJXwxSj7RYvQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+bAA4xJYnbSEQWqdrvt3cvsQjLlJHP4PvyiA8A39LDy9FhEcXO2zSAs0q8sL?=
 =?us-ascii?Q?22GMKZYdsUeG1R2vo2jMDwgIXELvANNdFTdmalGGdEV4OvFkq0UiM/E8/12c?=
 =?us-ascii?Q?UnSan6oJbnNMXIW+032GSlu4nnV/5xnAYzsR6DdcXbYzDuRJTefufYoUQwUv?=
 =?us-ascii?Q?cVyaatDSmfnacWTE49JQ1qjVefCLAhGS+3kk0MkNyG6c3f4w+L/wpcvXo4KS?=
 =?us-ascii?Q?Q5AVJHG/rIXGUR9W/XchD6XkLWA0yXmm8r4eT+fSSwZ/Q5eT/m9FqmKZrYsy?=
 =?us-ascii?Q?u3YRVoMNab9JxGJ09hlUBWJQqn+rqgh4ERYexxU5l5wnsOET4mrrHrrCHgcU?=
 =?us-ascii?Q?9sbHpSbymP+3cxNXcnCdyOw5LN+704HTJr2QuXtibxPHG1CuLH+LqCEw35vQ?=
 =?us-ascii?Q?ZR31+9+gEbJn88fjHYbIvu3vXNbKo/ZkAZ3X6rxQe7UtDhRr+/f8798TJjkP?=
 =?us-ascii?Q?QSAN3E6QW9nloKPjpoQ8RjRDWGZi8613X6Uz5iKmuGhov6HnL8ipSnwdgABm?=
 =?us-ascii?Q?dYJ3TytLrQbPRJTbQe+H2HcVwZ6wz4D6Y0NALQkwz/Cttus6wrRJplhq4/bK?=
 =?us-ascii?Q?zX+oinx+olD1Uq8EwLdAY+kVj6C9qsTJLV/V0CI37lzx6RAaoGK01M5BiDU8?=
 =?us-ascii?Q?5RvSJ+Ims5yYP2hbTBiKPnR5NdqXnMjVu2eay8rJy6wYfmCvizdb2/jN+p56?=
 =?us-ascii?Q?1PrN04lYrkXZH8eR3X4HcVqohicYFV1vPdtxwOg3FC+Tubym2N3M3ndyLW08?=
 =?us-ascii?Q?rBzRAsbYFEJphGytKlY6c22Yyh4MO5GPrKe7qYKUgLg1CWNuo/elKYkuWmwJ?=
 =?us-ascii?Q?Jpj7ebEhCmjTsQbO4AeiPmKi2sjr/JSl1nBpu6e3q1er7FJmKI97TwDdC+U2?=
 =?us-ascii?Q?B18dsnuXMQuiOSpMu18enLfDrXYM1WTb/XVkwVm88qvZ/snC6kHLaJ9KvUKv?=
 =?us-ascii?Q?5rCQFAky73HahPuOBrRsJWYTftZWRskZ3/cbRkOJ4LHcrBY/fbzLy36djaVO?=
 =?us-ascii?Q?EXPih36zefncdpCePcp9vifI6jNcd1p8XhP1PTBZizXqf86qzwMvGmUUW/7C?=
 =?us-ascii?Q?0SZ05feAdnd6QL1sNUHgFJ6xTrdP2M1rhl+ZrU0fAhZjILCnIRy4UQhwSxdf?=
 =?us-ascii?Q?QANItTyNsmTYe6oNnZPPqpycXrWeL8xWaAbART4xM3aqf+Or7fBOWt9Iz8uF?=
 =?us-ascii?Q?smGKWFfEgN7RIH7Ir0EzpNmdnm1g2lXvvCcsR60vPnkcWtABZG2e8zQgGKBR?=
 =?us-ascii?Q?u2pC0xtNNCB6XLlHsukvAk8PXm2I4dGUkdYr9VHrtRe+MeWdEyYC9A4A+jGp?=
 =?us-ascii?Q?0OgYUr+ASvsUsqjy3lzxGylqDJ1r6yFuUBnWJQSYUTy5RIaZ6XC/IHP9vQHb?=
 =?us-ascii?Q?ssH3vsGayCRonD/EbsluAOwJ9Zu2I6pMCs67ZfPsdOWX/Bc8V0zM7J6mOl+u?=
 =?us-ascii?Q?zL7mf2Gn9VpECXi1fOqqF7uIAcJgHePKrE4+4X+DiF8K472se8P6zYBOIpna?=
 =?us-ascii?Q?oi4gsYxVmF7fTuG9eNQ/hOGCJqZeaJLRp3yUw/FzgRrImB/rcCxXaxDyIhVZ?=
 =?us-ascii?Q?7IJOALhoY0981PP1ldKEF3O2n9f72WYaORiXf1v1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3689c240-9df3-43f4-08bb-08dd9881f2cc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 16:10:04.9905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQGpKLT+rgC0pZEPwB9u5YzcRvDTAjErccWNS3xvNCb649ThlTkhCwx8DIl9YusydaelGu2UqJjFKtKGfA50GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7957

On Wed, May 21, 2025 at 10:55:01AM +0800, ziniu.wang_1@nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
>
> i.MX reference manual specifies that internal clock loopback should be
> used for SDR104/HS200/HS400 modes. Move ESDHC_MIX_CTRL_FBCLK_SEL
> configuration into the timing selection function to:
>
> 1. Explicitly set internal loopback path for SDR104/HS200/HS400 modes
> 2. Avoid redundant bit manipulation across multiple functions
>
> Preserve ESDHC_MIX_CTRL_FBCLK_SEL during system resume for SDIO devices
> with MMC_PM_KEEP_POWER and MMC_PM_WAKE_SDIO_IRQ flag, as the controller
> might lose register state during suspend while skipping card
> re-initialization.

what's means?

controller lost power during suspend, so
u32 m = readl(host->ioaddr + ESDHC_MIX_CTRL) to get reset value and miss

set ~ESDHC_MIX_CTRL_FBCLK_SEL?

Frank

>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 7611682f10c3..c448a53530a5 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -728,23 +728,17 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
>  		writel(new_val, host->ioaddr + ESDHC_VENDOR_SPEC);
>  		if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
>  			u32 v = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
> -			u32 m = readl(host->ioaddr + ESDHC_MIX_CTRL);
> -			if (val & SDHCI_CTRL_TUNED_CLK) {
> +			if (val & SDHCI_CTRL_TUNED_CLK)
>  				v |= ESDHC_MIX_CTRL_SMPCLK_SEL;
> -			} else {
> +			else
>  				v &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
> -				m &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
> -			}
>
> -			if (val & SDHCI_CTRL_EXEC_TUNING) {
> +			if (val & SDHCI_CTRL_EXEC_TUNING)
>  				v |= ESDHC_MIX_CTRL_EXE_TUNE;
> -				m |= ESDHC_MIX_CTRL_FBCLK_SEL;
> -			} else {
> +			else
>  				v &= ~ESDHC_MIX_CTRL_EXE_TUNE;
> -			}
>
>  			writel(v, host->ioaddr + SDHCI_AUTO_CMD_STATUS);
> -			writel(m, host->ioaddr + ESDHC_MIX_CTRL);
>  		}
>  		return;
>  	case SDHCI_TRANSFER_MODE:
> @@ -1082,7 +1076,6 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
>  		ctrl &= ~ESDHC_MIX_CTRL_AUTO_TUNE_EN;
>  		if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
>  			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
> -			ctrl &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
>  			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
>  			writel(0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
>  		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
> @@ -1177,8 +1170,7 @@ static void esdhc_prepare_tuning(struct sdhci_host *host, u32 val)
>  		"warning! RESET_ALL never complete before sending tuning command\n");
>
>  	reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
> -	reg |= ESDHC_MIX_CTRL_EXE_TUNE | ESDHC_MIX_CTRL_SMPCLK_SEL |
> -			ESDHC_MIX_CTRL_FBCLK_SEL;
> +	reg |= ESDHC_MIX_CTRL_EXE_TUNE | ESDHC_MIX_CTRL_SMPCLK_SEL;
>  	writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
>  	writel(FIELD_PREP(ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_MASK, val),
>  	       host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
> @@ -1432,6 +1424,15 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>  		break;
>  	}
>
> +	if (timing == MMC_TIMING_UHS_SDR104 ||
> +	    timing == MMC_TIMING_MMC_HS200 ||
> +	    timing == MMC_TIMING_MMC_HS400)
> +		m |= ESDHC_MIX_CTRL_FBCLK_SEL;
> +	else
> +		m &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
> +
> +	writel(m, host->ioaddr + ESDHC_MIX_CTRL);
> +
>  	esdhc_change_pinstate(host, timing);
>  }
>
> --
> 2.34.1
>
