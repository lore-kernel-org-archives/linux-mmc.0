Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010046.outbound.protection.outlook.com [52.101.69.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3448EACE;
	Mon, 25 Nov 2024 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732556789; cv=fail; b=LslsoBhV8PQkLQr8i7DxOTM2tEmE5TzXh1EelmEbAKplDpp/w6E1lOKNZFyOMi4Nzo+SwDptvPLgU2LOlnwesL0CSPWnBLpM3Aji2DLDTRfYa7VNo9bela/T79wzn+kwHXdyE/TBbvGZEOhOVyGBeEviM/0bSAQAzAeKZDgWOIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732556789; c=relaxed/simple;
	bh=OHWtBw2X+0S/BxOeH0Jd34790cXeMv+hMe+jt0FNbN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZMjHF08cSP5rKkXimBTHORVGadLe5IJ6X1dIxl6XGZz0k5Uc4ftZ+gXbTO6QKCIOx9A39f9e7r7xczHp4zcSloKQokjKdUhExZaW8I+6QNt6X45Y3prEvyuCBxDf4Es+fvgAWoicXWo0wouJ8EuJYWPi6Zur4u5K+mqBhOpcoGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Iu1dt14N; arc=fail smtp.client-ip=52.101.69.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Iu1dt14N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QVoO0avx63xhkfjGCFF7IGtAJeXoEGMGV7QInrRkGGBjsuVSbUdL4ydrw7VU3nzm7jCCr1LSr9ZvEf7Ogi4UQfNtK3QlCGrPHey3cExOSuscpWmoWCio0Hn1H5zM0q1SOEe4wUg5xcSdxiUPHcjQufV3UpAuLmlOSj+LD2/kq/T8aqtkrv1hxM5LREIPcJzYf9r0FXDZdqomZtPgQS4b84FBXA2XtIkxe40KUZ/q0X5UdL61Emly42Q/7GmtpNHO+kUBG2BHtjmUSQDCnAx57ZL3MkitwKVP6/2Nf3vYL5q/ovYK+ALWx+HXzt4S0M+L9Ljwf3POmYyyNZ7TbdCteQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plGmYD2AOeEY4idvVD+K7psY0RnLKvbXzVA+CrGtu6A=;
 b=sjGZmgt9OR0UgheEFD0OHq40QVCIItZRS8Gu8bQvZIcbJUhWqnvjB1ZOXR7c+PFvWeAGSmCZ1L6AUeXK4uNhcOo9qSKrO5uhR0aI8KGb+IuXCIx9R/w8VvK6ssq4lg3wYGJ37KzDvzpeJ6x5jQ5ppZu1kn5YljQ3Z5oB+tzSpdQsJuRRyR9ccdnWEa4Y+ECObbWd/TrwpOV4vJfqh53+i5nF/n4HyoYVEKgjilJcVSWSXkK5GA+fFa3p/ElNRRrVWQHO19XmUP5kVY8LrTM8P0Y77ptyXzjE9MqG1NWsMnCmAJXSxvvAbIkas6mpXP0Zs8tSoOWzSdnEN7k/2ci8yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plGmYD2AOeEY4idvVD+K7psY0RnLKvbXzVA+CrGtu6A=;
 b=Iu1dt14NIT5izBsIVXWjOhuj0xDSfQXTY2bWr9Hhp+AeXIMAGcaKL+pbMfkxskcO+ngkYdwlVz2sv5iEajWfR/B3kDM2O5x+RoYK4VxlHWzg0uTSjJISFT7XSXZm4f0LB0vzuzCWOE0mAScFCQjDRB94MZdvOkt57p+p6LBwJS+MUL0+D7nJFM/o8954maDNCgLjcHbJxdOPm70vTh/ivkG3Y74hj8h05Xt2oYR702NXOzvDDdJum06EGwsntF1jkic6nXjCP6Q37f1y5XZyeh5nu3KmCR9kJgCmGAt5BCkmLFVNPXl8d5jZDHYoNzTC5Rr+iWmb9Y91zCM+Q0msmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7362.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 17:46:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 17:46:25 +0000
Date: Mon, 25 Nov 2024 12:46:07 -0500
From: Frank Li <Frank.li@nxp.com>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Haibo Chen <haibo.chen@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev, linux-mmc@vger.kernel.org, s32@nxp.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: enable 'SDHCI_QUIRK_NO_LED' quirk
 for S32G
Message-ID: <Z0S3390FbRn7/Qke@lizhi-Precision-Tower-5810>
References: <20241125083357.1041949-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125083357.1041949-1-ciprianmarian.costea@oss.nxp.com>
X-ClientProxiedBy: DM6PR08CA0036.namprd08.prod.outlook.com
 (2603:10b6:5:80::49) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b2072a1-2814-44fc-0615-08dd0d79149a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HhtY0ySSKVTxCQ+zplpG4GyjdgGNqwHdx7Qzz9S+5qJKt0yBv75rXMLBNkJ2?=
 =?us-ascii?Q?BoXvlG0ZQIHO83jpqsRuaKNjrk4SOS3Cuu/9WrlP3W4DhcjxT9BtYb0ax8yl?=
 =?us-ascii?Q?EE9lMCL2Tqs2+6P2zcE1oXyT84vGXBG3yFXpbtAybsg674kMHZEwCzqKAg8r?=
 =?us-ascii?Q?lvJiQdBqBCYv2XukS6x1APB+l93QG3hm7Adz0QHBSYLIUuBwAuyBcfJYNXiE?=
 =?us-ascii?Q?LoOdhXHqp/JKLKOAQl+qHR6AOl94gj1XLLdaoJqAfiW3SeKgUr7ayRmFsAXc?=
 =?us-ascii?Q?ZDYQVjdygxTtGJgcuLHGF5aVbXZY0CyIa6Vl2L1ceshkUQgQ45aiU7I22EMQ?=
 =?us-ascii?Q?OP6ei1mdx8CdcDXS0eHJj9ci7hGt0edn9H3Gx7Xyy4gcmxtnS9lzfQ0sELwk?=
 =?us-ascii?Q?iyOQODpoXErzH+BevgPz/PTfjM6qHjc3YaiTsZ/ORWLcgelte427jDmdScnx?=
 =?us-ascii?Q?ZiVhGvOcoO+H5wztJvlbc6Jjwgbzvhi+dlZ8py0/9uc7J9VvzEufAVPejAO3?=
 =?us-ascii?Q?U0tI3+3+jLXuCkeDeZdmixV+MFAHRdgqsBLr19bVo2axP+byEelFOSzMuPE0?=
 =?us-ascii?Q?hGq35UnSgt9CwPEupHK9kqO7TC5fO/jWZdO/br7Trg8ochBCmEwIUJi3dCmc?=
 =?us-ascii?Q?6izRe98jmq7jdSkcYgTHuXLWxMqHYFmIib8DLyLvkBMVoOwzZrFK0p5DguxK?=
 =?us-ascii?Q?CAvsirFRJ9SwVbmf62E+Yjt0BK+cqU6E1wc+rwYjuWw+1FN8a5bxitUfeFfA?=
 =?us-ascii?Q?NjbJsydLHpvZHMMKU9f0JpA8D0p6teFnjRT46wMItZZE7uhAmtPSb4D1dmag?=
 =?us-ascii?Q?r1558bQDNmh4AZv/0D/pMMyqbTfPuipP8x75wp2Y1mRoukfXgy0fNKJI4ts9?=
 =?us-ascii?Q?NC6JURplCcEjfj3ws7mxDgBhkZp7z5KNpGPa0C0gwWPHwnsTNsTyymnJ9Xo6?=
 =?us-ascii?Q?h8NV9WoG52VJqWBvFORKXFcChZUYT1ppWphfVQ7gjX3Z55LuypJZGs4YF5Mz?=
 =?us-ascii?Q?3VawusgvL4W0xqUeSmE4QYgd7OVv/T+ci8rSPtkz6SHIOVfBOebzgPZhdmkm?=
 =?us-ascii?Q?wNc+ZmKVJ++MSWWKCymDbmjLnQzGXjeeqL9JjbmT70vJnV8Abt+oOADvMW6/?=
 =?us-ascii?Q?GqGE3rVIemXQ4p06jDSUuj597ItOfpKspHQ0O+GS9uTGGOFOjc6s0w6Eom4Q?=
 =?us-ascii?Q?mPHrh2+UixSooWQB3XKGkom0Tsi59R/0Hfl2Tb2B71zUs9uAYUMra2dID4L6?=
 =?us-ascii?Q?tbZfjvov07WPLllp9Xz1aDELxiEbQNzZRgKp3Jb/hsfgFwBPi8Y4mstDap3g?=
 =?us-ascii?Q?JkVXD2IJu0N+5mh92bynMGYT2gt0RAZUC+Rwc646nXLQYeDX9XMvuOidqJ5h?=
 =?us-ascii?Q?QCSvsX6H7OkkKDCSBMTefO1buXuTkQszjwcmoT9ELkz2WqfivA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JZC1BnrSAM3p65Cxg2Uy8RvBwB2ik69TCpz+zW7+mwWmEOpgeawqOf+HcaHR?=
 =?us-ascii?Q?ip2/s65A/YUN1vqk54xsxwhGT+6z6jkK7xHuRAA/767rqNiJSRQykThUdfLp?=
 =?us-ascii?Q?0otPEF8abtLEZ2Tv7GgP+dA/E1vqDkc18givAtAt0/Fg5qi4ceNKY3SNbRR0?=
 =?us-ascii?Q?N2vWrvxAR6n9TDYqOI+H9OrBcwKEEC1ycQ/8qF6Y8u+jodBxcenm54pYMPxk?=
 =?us-ascii?Q?PJiZLcDvBUlqMe9pZPTWCojCWBNsaVwyZytUwsapEdADiAkPPsHGAXf98U5s?=
 =?us-ascii?Q?lvZwMwBOwAWJigZSq0yVcgWN1Q6V147cTMVI1Sh4izBMKLstY6OEmp+mJU5f?=
 =?us-ascii?Q?R/oT+3SX+1YgIEfPR5cdb5HuhZlRFBq8tqcktj4HttoZFZx30GPo+EoK0hcH?=
 =?us-ascii?Q?GOJUka9JpPdhYV7HqQ30JUec8LJyneSiRh9f6nXvE0v5Pi+82z5fzaLsnnbi?=
 =?us-ascii?Q?FPxTk5A7KWelRdRUBFa8ckBEvINuBKt+UC9Rp6SFkjfozm2JvmzyzylY00w+?=
 =?us-ascii?Q?xMrbOyBEFWATnXfvfiKcxJCJ1feNpGATRWpxsBn6larKhu8+OHLEa27f3gYF?=
 =?us-ascii?Q?sxWc38GJa8sJwacFhqHu8NFtVAlDOUAjisIOMTkX19UjKEjQkRY910OHOTLw?=
 =?us-ascii?Q?285Dnq6TbdRl2hYPb/9hD1CGvThg9pHq3CIJoXo+NIZKCwGWWlHGnKI2h6GT?=
 =?us-ascii?Q?pmpgML8a8IPGmdjL7dB8Ixzhj+I+rHIizmabk7KG2bVuPFeraZXqOPYQzQ24?=
 =?us-ascii?Q?bUpNQYUKmklDLWwatC36InpFImKNWC/iE9OEGa328eicUcooPLGG6qwoGjCL?=
 =?us-ascii?Q?9eaEOfTPMWEDxrO8O12pAECqeNxD4nJKAGXRxM9PYFGGFdeKZDvlKQ9ahbk8?=
 =?us-ascii?Q?8kLwPuLfsniqtadvLsGvoXd05xKxl+aCH4t8wAyTy1Hxh1Op7ET7hf9vtg7c?=
 =?us-ascii?Q?srkNQ5nTRNuGqsPS6tPoyQjhTVAVVVkrDub6pLlYhYHrLzviaZC7uqmGCyKz?=
 =?us-ascii?Q?5yanTsz/3n5mFPFGBN1Dr+5CoXUaluknhxX+lSlQArDEmbRGQ6J+G8b6+yjD?=
 =?us-ascii?Q?FbG+RXRsSBw7MEVfP2C6sI+o8G+nj8uHvW8eRhqZTqaDIp92NtdNmu0PEoCl?=
 =?us-ascii?Q?xCKGNmAV94T6ZIDSloczD5TfXmAri4TYp1vUNP8EmPFEhGceudJlVODPO8Jf?=
 =?us-ascii?Q?qboE4PHeuvqWxioZGp/d06g8ScvvE+h6495NprCcEeD2TLOsHi0G5D2HwLEZ?=
 =?us-ascii?Q?F6lg7SMqDuYs6kRBoSPjKrJKxv7EvZr0CPB3Kt8Ui1naROfn8+zzh9x78CDs?=
 =?us-ascii?Q?EJiNwqhKVsdWLEE4AkFqYxKMeFYV8vHyITzZTeAHTYLxtxA7tYKqb1w1HAua?=
 =?us-ascii?Q?EqagowfhtwrTXVdZuDfI5XG4SCz4s5fHMGr7Woea8u2wWG7JgrB25oOglmeb?=
 =?us-ascii?Q?ZEr+Qp78k6b0jlsqXDQcxRzyx+Ntx6pzom1mtzmIHJwLamZVkjAHLXMcT0Kd?=
 =?us-ascii?Q?TZ/cT5sL8tIvo/JHxmILy23lrisECP75/3pDANNO9SoYfVdpL0yJ8+934DC8?=
 =?us-ascii?Q?s1waCkVFj2qEf6GHuPxWclPa/tmmEBvw4WePEJ7K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2072a1-2814-44fc-0615-08dd0d79149a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 17:46:24.9450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CAnUw49JwjmeurgNYv1bRwQy6pEN3EOuIhnE8raBS/c9Ae6sxbadvPvb4BYgS5ufLvpxnNlTR/O0o/iEQQv2tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7362

On Mon, Nov 25, 2024 at 10:33:56AM +0200, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>
> Enable 'SDHCI_QUIRK_NO_LED' quirk for S32G2/S32G3 SoCs.
> S32G SDHCI controller does not have a LED signal line.

nit: wrap at 75
Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index d55d045ef236..e23177ea9d91 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -304,6 +304,7 @@ static struct esdhc_soc_data usdhc_s32g2_data = {
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>  			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
>  			| ESDHC_FLAG_SKIP_ERR004536 | ESDHC_FLAG_SKIP_CD_WAKE,
> +	.quirks = SDHCI_QUIRK_NO_LED,
>  };
>
>  static struct esdhc_soc_data usdhc_imx7ulp_data = {
> --
> 2.45.2
>
