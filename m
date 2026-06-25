Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011048.outbound.protection.outlook.com [52.101.65.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD225314A8E;
	Thu, 25 Jun 2026 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782405480; cv=fail; b=uB0WwsnDOvbv75DkJnKDXGzxTMuygnCXWtPCi5ts2bE7Qui+uVREn0dUf34JEjWvPxgV3jPfGYrC3GVN3n75/YDIlxLHfVJKzGJ9sZjNmQGi5xjbXQpsg01/rFcs9pfz3SOUyjek0YngiEivK/87/WJDM3WSekWWb6670caP9vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782405480; c=relaxed/simple;
	bh=kaq/vLczf49FqEwdXIPB7oWo7wJHOO50L7hEqTp1ZRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eEhy7DidtTu/wWWeZuSW2AiQ6hVWTvIH7XxOSYIpSwRnsw0qVLo4d1Lcj1SzG+yeQwKy/h5UfThlOkLPkh8SHV//Ob8CJXs6mOD33dTddsmM5krxzk4B2ezyTDkq14XiPQEMnQoxTUsvhz+STJH83chveJZp/LziV+3t6HVkuZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=uF0KS8g9; arc=fail smtp.client-ip=52.101.65.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uF0KS8g9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czYu/wvsnE8NG5hhmuVHR3PETMrGAhGmn2HeKlhxpA2m0QSG1HLkL+gZnALyKgzpZD/abCLvt+IgO5FFiC2sshYCYzfvzByptNX1k92/oAkg/AkIddAfpiI7wjnHEXiKvoefA6QGPdIxc1avBwCvpbiJ13lQspEyIdnXBZMT/LAEidMfgvBIXLrKsptPUcJMc4+5cee6IVtM4Dlo9Y3lY5lugHoSKRH2xYiZBhDEolYOfu0gyEzLNLUXV8uXqyf8NOMRBGD5Xh/qeRxfgRPt+z+Z93BwPtk0d3zN8gUnoL+GGKoo0yKzwfvoaFrbokzVi7p0bH7bAZyCx1OtS1cWSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZIRy1yPnJAye1Z+rBtRaflaYbkxwpgU1teITnodpgY=;
 b=gjPR3EKLgdVjCsvneQ8VwuCpYpQ3Z4nudQNdLpNVzcqzycqpABVH9ThqpVZ/0MtTm3m7PM0CLV5P3A4MWx17u4o49lyXPGnnniHDDYP+maIBpO3hElP7y4CDk7/4fSEAbGMTxBJ57l60BqJU67KUi6ng4xFArxiG2luAig+CtCJKeZOQfmO1MSD9+hAaD8e4aVMdxqejQEReKjLbxnQMoteZPuP33vkQUojOp7wqI90i6dp1uKxuQWWcLVsJAseEd0sM6SPpzD90iPV6WNVFHIv2eW10Vr+t33yUZQVT/7Jl5ZfEH6vvRxTkJpOc5qpVYGHC529iv6HTWXTpEw4yJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZIRy1yPnJAye1Z+rBtRaflaYbkxwpgU1teITnodpgY=;
 b=uF0KS8g93qTfygP8F5gSRLwke1cU7FMxv9op06AOw6iMRI0WbocL2lQQF6yXlMeNXvlll66jnM1j0zextnFPF3Zx6o82+hGpDrozSkxwdgb1SqNOTRt7DPo8v2HP2CWVQgdWDAo1+EAEfXuRC3SGO3wR3VXKAm4ytyfFKh4TvHjRfnszsdcwe5gpz+Z0nefpGWUU5Ebs2HZMRc+uhIuP+7vvTNQEWSMfbUUmT3HAYoLThrKhNl5JORVUeisTIL3f/ibvEaddAzmlCXY8astHD99JDQ+n36KFuTEyuEEZtVUYEnd9HXPjinXxa3YhzRdr7fuWm1cqTPs2xdEMQb95FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI1PR04MB9811.eurprd04.prod.outlook.com (2603:10a6:800:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 16:37:55 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 25 Jun 2026
 16:37:55 +0000
Date: Thu, 25 Jun 2026 11:37:45 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: ziniu.wang_1@oss.nxp.com
Cc: adrian.hunter@intel.com, ulfh@kernel.org, haibo.chen@nxp.com,
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev, linux-mmc@vger.kernel.org,
	s32@nxp.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] mmc: sdhci-esdhc-imx: disable irq during suspend
 to fix unhandled interrupt
Message-ID: <aj1ZWZo_9MLUWDBD@SMW015318>
References: <20260625105934.2890635-1-ziniu.wang_1@oss.nxp.com>
 <20260625105934.2890635-5-ziniu.wang_1@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625105934.2890635-5-ziniu.wang_1@oss.nxp.com>
X-ClientProxiedBy: PH8PR21CA0022.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::7) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI1PR04MB9811:EE_
X-MS-Office365-Filtering-Correlation-Id: 43bc89b9-f907-44c8-277e-08ded2d81ba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|19092799006|366016|1800799024|6133799003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	v2VBwwn2Rvxkj3n/SZsR8xEHIr80P/1I/yOJ4kP4O6776BIrzL9by20cFXRoh80/mTyk0ofmF7az/YNvUxnmjsCSdk5eppFLZClBuy92SIL8qAAYjArdqhp4ehKhwgdnvw+sfSxiVzLdGM8Itk7QqmTIdAUGuAwTxBPoK9MjnojNPf+uXodBfcI7kCm5+aKurIMoe5ONBPsMQgsvRpEqsCJM9zWTavzQSgMeAOG/yL5TvELv1EBg9GLTX8/YYp0ZhVKASBHs81aNrEHCiKYpfMFWa5vVFR0aqyCmvBhHDffOdsmAa+2Z79A94WoMfuh5lvjky8uOLktmVEZsUN15sVWdnS0Y3h5xWB2AMzITEGGJsswNfnoFyrO07NrKZk7zex1ClgsXmO+88KGDAIVKm83F1SZvr1JLs0LKVA2qxApFGkF4owm76Qew+S/6b9P+nRWisKTN5f9MQt1IHYz2ti0Z50ruFHa1SZo12e4EcW83nZHHNgFnUTL+oSof6CI+3clXKeu9tFbJKDjDlHfqwwm5kbA6pvJqOXSd1DectJ8bfFlJ1pyIwEU+nmXlTPROsNBQfSsSP09MJ1q9lZi9AHGqd0kOIUk/+zJRn3+Ia90hVQjbhn2IeXlNIjpdsWV9y1bHcL5V2Sd/MuP2p/uJYHgqH3ApS4sBa40JGfQVYeg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(19092799006)(366016)(1800799024)(6133799003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?91CvNEUePBIvLunMctDvp9937J5FHmTzql7Z2mCN5thuIfkDIIJqY+Bt/QVI?=
 =?us-ascii?Q?LfMb4lvah0xFAG7qgSlQswKR7Se0neuaXDUe5LwWGC+c67YqADVwHwrGnS8P?=
 =?us-ascii?Q?sODYYlZQVfQnHmVUZAUDV/1uZV7uSjGYix9y4Of7qO55eC4scoAUNvDipeko?=
 =?us-ascii?Q?GRom3NrbZdChLFdSaYXyp4JwsKsEXbeQL5/SmC09TXsowjbyaXMi1unFnU3x?=
 =?us-ascii?Q?2nxjFSGYMVZPr3yAdAFTf9kxzJp7AX4GdR3wqaXH6ic43v9TtC+XH+F4jo3V?=
 =?us-ascii?Q?c5TG7am4Knk8bqJM88wgpWBv0QkOf2VP61nyd9kZuedVAHa16AL2vF8D4Qhi?=
 =?us-ascii?Q?UF14fG8qExeMa8e78k+3+VT9oqeLa1hUYg2BCEw3S32bm9NQfbg5fEVd5fqF?=
 =?us-ascii?Q?3NkpiSbAIr6cMt/AKTR9w5UulNp2HawO+03zvdjSudqE1YqyQU4OK3BJBM0Z?=
 =?us-ascii?Q?wEBmtspxC/5CrRDjKnRZb3a6zFBZkXb/y1sOP831B80xW7FXcosxsFwS+cVN?=
 =?us-ascii?Q?fSyV8ceu6bE8SQCCIMvWwgQsFuJv773QD9LBcpS7AyEBGbKdgBYTwcLAO0Xg?=
 =?us-ascii?Q?W8SXGp+8mq6XEofjlPIQUjTEJk2YyRnTPURpgmvyIn9ZRkwjV7YIlNnzMFU3?=
 =?us-ascii?Q?RWlFnhSp9vdtvti3CVfSAS2THVbk0Iq1V9QJOar1ltlyzoH/Wk2LfIQQNfdI?=
 =?us-ascii?Q?qWT7bXx5N330jU+lWdqKpt6axVobyht0A9q65UOI6lnhk+yh5Ng+d52HGOsn?=
 =?us-ascii?Q?8uCeFxBPz4VAcFvYTqRbyx4JEqyH4h3/i69ESbjcfdFBJBvHKhFHr9HOI/74?=
 =?us-ascii?Q?k9DpQsPSGFWILvoNaRgBxSKfz7Gt1rfRp7Il32EiGtGdUnY8GWXLgt7HiAdY?=
 =?us-ascii?Q?AeOOdbSqXzbzyMMjvvJioJprlSDqC+i9HnKcp+LamZgaNpzQLclzxYlCNvlB?=
 =?us-ascii?Q?2q3KDX4r7zKCuXXb1hTG/lpzMgDFmTXtPrdiNGX7PoKcHHvJVXdCVfqRReGE?=
 =?us-ascii?Q?I3/hM/E99hRdG4kxls6UJGmjtbTPvn2AHAZiuq4Ox92g/m9THj0Y1D5FYF9d?=
 =?us-ascii?Q?Xzd1rv3991upr30LDPjorx7mRbIqmBC43TDJVBIsB+Pch0VR6Z7Pb8qmbcST?=
 =?us-ascii?Q?kWahzzLFi38GglHyT56mfwy4J6YHR1MQbPzhE4W7PDXJD8a35yhxiyHXmp2d?=
 =?us-ascii?Q?9pPl0hjX8KeR3Q5f101A9UVW6qhxsDvHvAgkjIiSE9aC1c9j1H1Sj69/K9yg?=
 =?us-ascii?Q?5/7dy0TuBpIS1MZHxfm3aIIwtmLYdMJK48TY58DxEzc5MSMH0ZhWT7hcT+Ql?=
 =?us-ascii?Q?3BCQzVE7ywGKi1QUgNh+p5PdZaB9+jhWJ46SoFDY89fk3Yfr60z+Qd8IE1F1?=
 =?us-ascii?Q?FCqUZPuY1H9GC2ztmeVR7X0c6TBTgSVKubh7FE4T0Ns37D/860L3pZZ3o/9/?=
 =?us-ascii?Q?MwM0kVAEjRJqTL7Kjj3lkxLDIf0OA3+DGlcVQjzFTox8K7tHGCl9UbeMz52z?=
 =?us-ascii?Q?XHEkmqBYk0/s9Sh9eEyZO01q9woCOSA5fnsXB9pco4SvPgPBk6IIciUfpr2T?=
 =?us-ascii?Q?RhbZpa6hTRdhG+0L9fa9yNe2RKKmwFS3MOQ2HZCMBP0PlKdGZZXDORH7iUwB?=
 =?us-ascii?Q?DYHrVro7I+hQj+QMKLHDbmF7qg1RpfoBNtET0eo973U0U+lazX7sKDQUTXlr?=
 =?us-ascii?Q?ejHFyAPc+qlgagliMB45QlR7v757247Smwaxa0YlIeKoWfMnVL2ZaD6hfG8r?=
 =?us-ascii?Q?qZZ1rMa7XPkShk5VFcVrxTIdyDOSazRaaGPLqRcVn9UGTvqT2g+d?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bc89b9-f907-44c8-277e-08ded2d81ba2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 16:37:55.3788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UoUOzzXXkvh9+rB7C7v1bSy1mXN9GyzCDQ9Ek/OKsoMEKSnRRCBj86lbczCv9jB7nnlKSI7qjZmajQwqbowm3/+kiIk5I3n7n1WAmdTwjugOC0wNP5XyRVBC3AQaxlpx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9811

On Thu, Jun 25, 2026 at 06:59:33PM +0800, ziniu.wang_1@oss.nxp.com wrote:
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

Does it impact the case if WIFI don't use out-of-band wakeup?

Frank
>
> Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
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
>
