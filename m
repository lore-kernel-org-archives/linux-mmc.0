Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013041.outbound.protection.outlook.com [52.101.83.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FC378C9C;
	Thu, 25 Jun 2026 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404806; cv=fail; b=J6/jAnA8I1OFar16EDGLr1VH9mj0LjyaH/mgfLdyr4OaC2c2gXhfCDP3VTuB7HO+sauxE21imzZNtzU3XD+DxCEi5a7beqO0rHIa0bUrqs1TeVUN4fQ56IH3fmzZfq4EuaXOmXm5qMHEm5bemJVTbNW8ybCwmPFskc7a2K55Y7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404806; c=relaxed/simple;
	bh=4ZqkxmvlQsLVsItGBh3fPqGP2lfqaibLUiNzjIUEfa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ERgTRUgp5m9lZDaNov7hTIG8lV+MwVRVrOAcxzFeH9unpQ5mrtWH8d0rZzV68ycpD9W1zG4ohzz0KFvfH9H5whlS6hHo05+oEhpk844Wydbm0xkdRbbOAyPgMSDzcrPD1UfUw0U01EVVBuNLv9+gaWy3yJh0nWmZprshN+laAGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cpVHS7Oh; arc=fail smtp.client-ip=52.101.83.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cpVHS7Oh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUzEZ0Bk2HAypICdUvJBHV7JkKiyeIjBquNRu8DZHr1e9uu1KbtoC4He3bGtQg9S4wH/3jJMpSvcFPNKblEurIaZ8oYkNb4N00HTfPsLAQ11DnWf7tYlGV7eZpoZDIlIS4ZpuyGtyxdrxOeL89GliSd5me2ckSB4d5A2994a/5wXOPsBs+kCoMMX/dzjMkiVvBxgMFJ4yaQ6VNVP4Ean/VQNQNa16+6+ZQXWlQxs+73jSnk9rraSxefmudtPMG05N87VKKu7Z2JmVKaxToUb9Up2U2YDx1Ge420nd2OoKPyjiPSFlKGUYEeR4AexKKrgAWOg5gsJj/ZelW+ifxaEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/qUuySUP5X73d9RjT6LN4JM1jTe2UT2ivULeVpJCHU=;
 b=RRiAisxDz/KnEwngXMEa3zqxnhmq9w9v/AuQtuqTe9GeGX2ggDS6DD86WVwZo/OMUBDByyD9m7Wo9eSeAZOvJN7YBaPwPLzj4J25SW/Hwx1Sj4sn6WJroTVEz3eZX3bWRfGsse3vnDd1pFz1+B77n+nLaLeWWkXeHqBNB9YyjlmDLiGE46OOftM5NmK5570g32YV5UOodeOdH7FVpmmHl+AjZpwig49lLFHMEbMfhMSZIWAcguLkJ8rgR+wSqfPqb8md75eDIdBjvWVOpCHqZKLOHnpOxR9vfpCBcZn2B8/7//dLE+GZDXgJ3Uq6ACTqKKHvP5Ky+O8OclE/4X4RLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/qUuySUP5X73d9RjT6LN4JM1jTe2UT2ivULeVpJCHU=;
 b=cpVHS7OhpAWpV9vE3gopGL1M1Su257QIvh1iK7A3MrAkvOxn8GjxBnjO7PORsYKF/ehLKYgaPA3tzRgIh6tUAvtp9FA/0KaIMyUMbJz0RcVEAQ6e4WYGDHScvFQETFbsR2yvhUlQ8C+CqQyF5sdRat2tNt3sjd1woza+AJkzafVcR1uXnO5F9y6q0l07Rrm9bWMKbRtjHtwrj9j7hMj6CW1OpIYqivkM+44BJQVr2BRC8nlqPvvaXTW6HnjcQ2f4CSi/tyk61VtAkyFRBoIHupVW50R44pa5Y71MrcLCk6f6InBMzxz2dT+77l1HJ7SUm0wPwcLzCTmUl3ybM/XmUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV4PR04MB11329.eurprd04.prod.outlook.com (2603:10a6:150:29d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 16:26:39 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 25 Jun 2026
 16:26:39 +0000
Date: Thu, 25 Jun 2026 11:26:30 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: ziniu.wang_1@oss.nxp.com
Cc: adrian.hunter@intel.com, ulfh@kernel.org, haibo.chen@nxp.com,
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev, linux-mmc@vger.kernel.org,
	s32@nxp.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] mmc: sdhci-esdhc-imx: remove unnecessary
 mmc_card_wake_sdio_irq check for tuning save/restore
Message-ID: <aj1WtoGc-43LYWrs@SMW015318>
References: <20260625105934.2890635-1-ziniu.wang_1@oss.nxp.com>
 <20260625105934.2890635-2-ziniu.wang_1@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625105934.2890635-2-ziniu.wang_1@oss.nxp.com>
X-ClientProxiedBy: SN7PR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:806:120::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV4PR04MB11329:EE_
X-MS-Office365-Filtering-Correlation-Id: 647e20ed-e8cc-4c92-c7a2-08ded2d688e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	JVNR7Oaf7pnaRnAveyhnmg04PlH6MXLTjimd330X7CTD5IJOP3bLRbpcDUClE38B0zALVlLVbxdrnW6JoUgtw8TcgkOA0qXF/W3emEyLe3fU9pO8Jc9bOnhDJNrSe3As7q7lMdWle7l38wn2WGycBtSl+e8oEP+PU8SzrCPWASCDS0JhqJ46sCP669GX9JnHaTGOZ4b/IDQnZOKLv2IBtC+/R/fbgKbb5WBR8DisC4OzPwePcdv9CiPMfN/gCFvL1Xk2MuuUtg0QNRXzJF6BiUIDDQ9sL4XOtnWIAv+P9SIwzCZkKLJGB7MSZspEgbl49xi+1nbl+vqrKmdntybsC4WvSnQfCamvtpMD8pD52k/n4k4Ts23rz7cMoQSYferUJk1lGLgYAnKEiixm79cJeRY3JT8AkO11AbK403wQlNW2BVZO9zucpjycMr/E81rEcEdGbLbPkpIR1PEGiTJjeARGkl4mqOJyy0r11FniKhgb+FnnSoOLDfWc1WB6TUfOFYr+8PIJ0rjJpldhvWXjdZTMgB+ulGwlvvxr/++txeleiXaG3QDdnIOMTkBNGn0OsKNc5v6I8E24wdeA0b/MFquIXHPwThtSEbVJoUsjQF7cwiXv8F+1A0jpFJg466DUOzirCOx/FK1cdiP4nQdFQZrFUX4rkpsZv9qhVcxs/44=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q5+b+axUDGst7zUVq7n4LE0ERn3mnClYB1/TYrLwrdAyAmqxOUiJHBW+xCH6?=
 =?us-ascii?Q?Zo/N1Umr5pNwWoX8tf3nM5SdghxAt44StxqLJ03pj675N9hbcmZI2LxK6RQv?=
 =?us-ascii?Q?zLSmB4UAD+cogh0LE2Q6AEW3Zylc5eW3GuuJWvCxxZQXx331SkbuudCYpQDC?=
 =?us-ascii?Q?Yk61LvFZCSwCtJ9yZ+i4myfoLyPTco8u/bUEZM22sO7wLUc4CeKhDYA8/AId?=
 =?us-ascii?Q?WYRf0fRPQmyFRXvU5VKanQEqoPW2Rh5xZ0U300+H93cQRZ2dzK5EcvDEBtRD?=
 =?us-ascii?Q?KMDhPFgEUgqjhHsXqO3pX6iQu5NvmK97ikdOSnAmVDf7iQKS/9fnC7n13pdE?=
 =?us-ascii?Q?yPEDTI3LGZlOtTXA36nTIfaJTbuxTO3l6Kf1f6SmzR1yo0+iXchUzegSPTNC?=
 =?us-ascii?Q?W+aSGFypQyeIwYzuwFhenlc9XV1k/YzRtXYDbsaPso7Q7XU4PqqqvrBBsxcL?=
 =?us-ascii?Q?n3Eu/J0fw/u97FhNIQ7j6G515mFTUhVbDMuj2gE1jnbPtKtGbh2LQQFF6hct?=
 =?us-ascii?Q?jp/jmJQgBSUrnA2QGJ7t3NbY8MdjJ345m+zL2Lbs4gCTb2pmphYv94iV5O3Q?=
 =?us-ascii?Q?4cKmOPseTilbC7RjfjYzO/AfXxf6dhqJtdcIod3//V2VproakOe+FOl48GJv?=
 =?us-ascii?Q?9BdA2TPa9C8WvNuJszKGEU3AbDvyCIXXCUBTg5JqKclx6be521dYqdC9WVGo?=
 =?us-ascii?Q?3SEvg32saVfmV3esg22f1Or4aOtGoSrDd8zYchYZ0MCcwQHJ9EfQbg8/gWp9?=
 =?us-ascii?Q?PLw+SUEPczvr6unys4b1e2uJGQ7a49WyrQCT4aR/dt/r0v+54khC++ffWeKF?=
 =?us-ascii?Q?Q0wn6DaDSqw2ID88h9yDpBHm2hW2XtCOdSLROeoWCx6uG8fTFlA7PDeEu6HT?=
 =?us-ascii?Q?hxKsiZ2TvlduwLKrc+w1xDWPw45/uD0G+I4vOT4yAIsWE1qK3gvlH5rDB3zX?=
 =?us-ascii?Q?P4nUGZmmGslJPEHT+yVhG6KFx4fYrg7Z7RoSMZMITUU9/sVbzzmRYCnOMd9Y?=
 =?us-ascii?Q?zaMRvsCF8cH4duTw2SeaQBWldCoOLO7IwaPFn5/8JN2lrzdOMme2ebhJoVn9?=
 =?us-ascii?Q?11V6UR7OJRcAX6oEYeC8PmOTMCSN4lCUyYrg0RZbZECv2ttpPnwnl7ORAs6q?=
 =?us-ascii?Q?gi8Ap26xXyiYOIIzHw2AHOM7c+pXgSSsKnLqskuy0zO8rCVKjPCJ7ncHqQ8Y?=
 =?us-ascii?Q?pwyQRbqqoJnPJhDt8uN3a2+VltjMRerVRYfG8OfjNxAszKKd083sfsoU/Y4n?=
 =?us-ascii?Q?N0/2wE6+cJvFHgJ1TnIyvOPOBOuY5+xjjsIN4ZyEshaSFfS1rWKAbwwKqV95?=
 =?us-ascii?Q?bSm6eEQUOJkSul02+8DCHQfLVrhtN23KDunHDYsrUUx8SmN0/pv0p6FlR650?=
 =?us-ascii?Q?oHouRMCTFCisV47snUtMa4i11+QZR8X6x5+CE45vQSspwi6jfo5a3JPDp5Xt?=
 =?us-ascii?Q?z68p7Ko6Bl2rhYu98PkPTtE+5umevUio0942JapKAIzHNTOWFD0HSctr0eFS?=
 =?us-ascii?Q?ay51OS3/DDZ89BIM06TNRpVqDyjC7C/s34094+YnakQr4AsmkF5UpUaHWrka?=
 =?us-ascii?Q?qd7YAm3CYr4DTckyPBU0y35RXaaUbJIzYdYKYlsQK11eTKVMOEbGhD2QRLr7?=
 =?us-ascii?Q?DQZ0NdsMYeZ5RvIPVZBjE+iF+mShBT3J3V99Ho00b8aGKJb/Kr/PgEl+BWaX?=
 =?us-ascii?Q?oUmPoG+IgFK854aSLD798P2d8QQSaRA9C1wokU0n3GDpIZ95uf0DBD5zJIep?=
 =?us-ascii?Q?xzft0LOPwGlWsVfku5iGbARWo/D7aCF7Yc26usvNrafXEO6k02Ln?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647e20ed-e8cc-4c92-c7a2-08ded2d688e2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 16:26:39.7588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94JeUCDqwJyF+JSDfSe1aJrFRgp0k1ojytCStIKCUNA4uFc0LQQFvMKRXvkRXUrIphypGTRnsLxBKqogVysGl0DtSHIQuJ0Y9NfzTV0P/HlV5MUHPHpxUDABB6OhBAic
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11329

On Thu, Jun 25, 2026 at 06:59:30PM +0800, ziniu.wang_1@oss.nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
>
> The tuning save/restore during system PM is conditioned on
> mmc_card_wake_sdio_irq(), but this check is unrelated to whether
> tuning values need to be preserved. The actual requirement is that
> the card keeps power during suspend and the controller is a uSDHC.
>
> SDIO devices using out-of-band GPIO wakeup maintain power during
> suspend but do not set the SDIO IRQ wake flag. In this case the
> tuning delay values are not saved/restored.
>
> Remove the unnecessary mmc_card_wake_sdio_irq() condition from both
> the suspend save and resume restore paths.
>
> Fixes: c63d25cdc59a ("mmc: sdhci-esdhc-imx: Save tuning value when card stays powered in suspend")
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 18ecddd6df6f..6526d65538de 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -2064,8 +2064,7 @@ static int sdhci_esdhc_suspend(struct device *dev)
>  	 * to save the tuning delay value just in case the usdhc
>  	 * lost power during system PM.
>  	 */
> -	if (mmc_card_keep_power(host->mmc) && mmc_card_wake_sdio_irq(host->mmc) &&
> -	    esdhc_is_usdhc(imx_data))
> +	if (mmc_card_keep_power(host->mmc) && esdhc_is_usdhc(imx_data))
>  		sdhc_esdhc_tuning_save(host);
>
>  	if (device_may_wakeup(dev)) {
> @@ -2124,8 +2123,7 @@ static int sdhci_esdhc_resume(struct device *dev)
>  	 * restore the saved tuning delay value for the device which keep
>  	 * power during system PM.
>  	 */
> -	if (mmc_card_keep_power(host->mmc) && mmc_card_wake_sdio_irq(host->mmc) &&
> -	    esdhc_is_usdhc(imx_data))
> +	if (mmc_card_keep_power(host->mmc) && esdhc_is_usdhc(imx_data))
>  		sdhc_esdhc_tuning_restore(host);
>
>  	pm_runtime_put_autosuspend(dev);
> --
> 2.34.1
>
>
