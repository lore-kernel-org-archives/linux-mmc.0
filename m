Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8682FF9FE;
	Thu, 27 Mar 2025 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743095243; cv=fail; b=pkA5bVWlEJOmd4J+VYNyROJuGBHdWhpqv+9RdQGS1zqq/nzFk9daLCDp7EJIQ5sMvSl57Rye+zo56Y7QoIhHSCppLfKRKPNx0GMqixArsJ/CYXsqn0yPk8fYHNtT55cJggzf/+vm580b5OG8NR2u8pyXn99bBL1k2qZxeDohg3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743095243; c=relaxed/simple;
	bh=Cu0Jg1t3xKCHsVVCuo2J6g0cS9lKBPXyEsmFAy8vGZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y+IXr7tBtfETM5q290h/E40uE94cTYDrWQCowa8zx2OXFDJba4GTs9h+eZN4S162DuWrMb5IaubCArWGjdAZz2NbvTAXZJ2hdaPzrhw6UpSDd0z6P9+DoTXi+krYAN22GFWtAFbVYIPr9a/McyxU6doR4RV7/G3Os8FUvcpNYUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wwot9T12; arc=fail smtp.client-ip=40.107.22.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wwot9T12"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzK8RMZiR4zsIhJAlX+0Jed8TQTMP6PZcBzZ+EjYyCuCSU4EoJI30ajoalIAayPSNIPEOyTl9SL0Eyt5d7bjSUXaVWh+233YBvRvMGh9+NcAHZqe9FCdHdNDMnMMMNQF8tEvporoboYesm68IGUL6Gz4PP8GqdKpSOFbbnB6+gdu7Xt1LF2TCpF1N24QTd2OFeesCTivD/woEXfW5Qth3RPSNsJVZzHtQk9O8ulJr1LcsF/itYiNywW/uyapHb4yab/KcGi9WFZPsgPcQIROxO8/mDuipk09TtU40NOvjfXh1LIQX+rty2JvAz/RJlIVfaSKy5LgBzlzIcTiu4nd5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDXaNWv8H2h/VvqupCJWUq+3Mm9108S3he+tKJCxoQE=;
 b=cn+Wu96XXyhj8XSkV9LWYVZGFiDt0kiMeF8HpMY0anW7d2DWiwlhWAb553NlICN1WYR3fwu2boLrQzazg70RWUqhi7I0HVtZMxvLZugDNzjqw1LQ0wV2Ib189sKxt7clJtbmTmTV4JbNuz7yjSip7xNIjAOriPlGQlVZeCvqPLOfneSJhDufD911/am4dvmZ5TVKTdbGSNV12T3cKG8ofOF+VgcPgrDmOP18ikTqXRcb8wuelJdevxZllq4+pbECKnjlfMSLc10ZTVq4MC9G/+rhLROSjwhD1Jor80BGJSJVu/EduFh61duvsZqu/UhbgK3YHHr4Y9m/NaSqafXN4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDXaNWv8H2h/VvqupCJWUq+3Mm9108S3he+tKJCxoQE=;
 b=Wwot9T12uomXZKnwKWXePaABAem1yEzlQNbpWpKN0Xle2q19I8z3CHFhbmTyHqDazFV7WOyfixeUb0Wpf68vl03/amSuFMSoCnSIv8+QnwTd8bIlZnW1a/v7eo29gWnVkVq1wCnqgFQhpaXzYpzo/eAfipgZ+ovUg3PFoCDjAXlhU53o0aHOF1y5vVabfSlJFz/HZo6WdrNHS7NlTMQ1Zf5hgSGNKCQcmXXwRSiz17iHJ8uAU0j6DBSBtWFzQoecbd+obR+u4y1jsf1x8OE+m5uQktkki2/AXDeiQqgQ98poXpXoiMXmRlrdokejCMnPcuY96zCgBm/YVHCTG++PoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8921.eurprd04.prod.outlook.com (2603:10a6:20b:408::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 17:07:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.040; Thu, 27 Mar 2025
 17:07:17 +0000
Date: Thu, 27 Mar 2025 13:07:08 -0400
From: Frank Li <Frank.li@nxp.com>
To: ziniu.wang_1@nxp.com
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, haibo.chen@nxp.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev, linux-mmc@vger.kernel.org,
	s32@nxp.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: host: sdhci-esdhc-imx: save tuning value for the
 card which keep power in suspend
Message-ID: <Z+WFvMXKo8Vg18r3@lizhi-Precision-Tower-5810>
References: <20250325094330.2242646-1-ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325094330.2242646-1-ziniu.wang_1@nxp.com>
X-ClientProxiedBy: BYAPR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:a03:60::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8921:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e81019-f10c-44ca-54f1-08dd6d51d3e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BnrnMm/zOWrCsBg6R+7SZk4Dp8LtJZ2Wwoj3I31hdGs5W4IGLZI1P4tr24fo?=
 =?us-ascii?Q?WdD3sC7IQLIxTlMKLOQV8BllOweeqkoHeaFW8i2AtQ6J7kvMO7wKnHEH+7QN?=
 =?us-ascii?Q?iyUcDSpmgS0zqVUdRjFV3F1eazbL5HVC2iBijFl7tPgba5K4NysQIYXcGg3V?=
 =?us-ascii?Q?13WmilMSRtBEQXOygHrfovjs/rBAM3F5TkE9R9tNUFzTKG53ZSabwiPDCakp?=
 =?us-ascii?Q?DkO6ldkT8bPw3QpojKQqLa/T0gULUmgymOulHQmSjia6jsIGUGaw6t4Sia1p?=
 =?us-ascii?Q?eBejbjk28YAxw87CT03vcv5vFk1H6VDxBbec8DZISoCcHTYRFbUVUZcGFpBo?=
 =?us-ascii?Q?YhK/SdmC8AA5ASinob3KbHvCuAfSc4NkUnb/kMM2Flt7T9KGBS6s5/UI+E9r?=
 =?us-ascii?Q?zS1iUq6wAlBBjdwBi3VG0l5BELbOrWn7lbeNzy8HvlU6OyasO3kTpvhKUnIa?=
 =?us-ascii?Q?dvyc8MXKa2Kec8LJXJrFgU7GwD3bPYwn4TJecLdWnLKvyvDMoEV28OJUeby0?=
 =?us-ascii?Q?B08C0NYaC+TmRo9NEHK+bmoOGz+lP595ksiEsbVNEmOC+asRcN9Dzorf6T1O?=
 =?us-ascii?Q?PVIeW8hETtfh+kyOO6pzeAE1VGVEBlLkMyQJuGMhyB8cg5XEZRQ4pwTprO5A?=
 =?us-ascii?Q?Q0q4nXIvYzbzzJpnHohpke2iQ88YGYNQT+zJSnQbxGIF+QKZKYxtcNM5owNV?=
 =?us-ascii?Q?95jWxuXJdE30nE6wJCL2HAlPvnCndRmI/OOnTMLDNh86Z6tqZBESsnpGxOkP?=
 =?us-ascii?Q?tG+clK4I2J8gGn1uqMKvMZruF8tVheiydbLCsf0/ZJfJ7RSap6vfDigVeHLF?=
 =?us-ascii?Q?5MI074ACjiFDUceVX7XIBcHjEF6xvAMPNOrVVIRAHj5RtJzt1xxPygXszYp0?=
 =?us-ascii?Q?SreFxqbirvxVtNz7AOQRqjZzAHdSmFrab3m0fiG+9eJgMf3ku7UFvnB8F0I0?=
 =?us-ascii?Q?VMTgUdDRIQIUczkLq0wuQ7TTviC9jI/4M8MWccDubiIi0NqpqlCqVZI8HCNL?=
 =?us-ascii?Q?5MKFJjnya9zW8C/A7myJIUQbJqqbiJfP44hjpS3uYDPrsidOYWvR8Ii9m9ds?=
 =?us-ascii?Q?MC9DYvs/m/JWSkZvq/HM0bCIsBGlQC1frdtUE87diPkN1DB93sTlGuwesOCr?=
 =?us-ascii?Q?OsvoPIWB5DJ+iN0EQ7FkEPoJXpzHefIGHFW1xX0dw59tWAuUIY5Fu9pDV9X7?=
 =?us-ascii?Q?bjGuaal48g/yII/YffI5PPMGtNNlHKuizeps2D6834oNFFCn4xmwlmaqYxks?=
 =?us-ascii?Q?JQqm90oeorZri+1KqpK+Kc/SeFrN8M8AF19DHo5NmSCyrGr7StoWtgT/9tb7?=
 =?us-ascii?Q?N+oucMBqaYA9C500JZlpLgndaD/6wweheeqIsYoPFnajytU6vTjzFwcT5AAH?=
 =?us-ascii?Q?bP46e+es4TQLPjMj95jmECxT30EQyToiluUPfRXRf3PD0YcS1qIieRCRt/Jr?=
 =?us-ascii?Q?lBcH3f7Pcdd/MA/S63LJ0p3Jq+RpHexT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bhGEOFpyYpby/XOwWidrKDkR75Hn/kbwP0hq0CeQ4GPLIOUzJCZIxRb7fSzy?=
 =?us-ascii?Q?M389THoWU2PA8o/SLYWtWBphW01FUBcxIW923XDVzPCTe7F5sPrr7VcO9x9h?=
 =?us-ascii?Q?CRfXW0ikpTz1f05SgQuhz3YfChiQc9tZD2aUObHFpWPlsZssUklexKGArJnY?=
 =?us-ascii?Q?hHM/7IkEZANPmLjRLrikqyaPceQ5NIgjeigNCVcpTuMDW8dcD1/VCgoOYfxd?=
 =?us-ascii?Q?xcaTFRGvgc/4kvhWPZxREhm92o7rkrMgxgA9Rq3iSbm7U+LNbggmfRaTTiG4?=
 =?us-ascii?Q?JhYo1PsO9NdgC9Gp2Q9VQIBKUAOZ95pMb69BRghkgbnZqd6aJlUljP5JL3+7?=
 =?us-ascii?Q?aMf69wqmnt4ADFdKWoziqPccowNwoOG0R6zIVmlcKPPlg7CIEP/rgkhhaCMR?=
 =?us-ascii?Q?kSwq6KYcXuq+zfgSMdK0w7th8gIs/InsPCv5O9PQVq8vdWQHqk3tabVEtxHE?=
 =?us-ascii?Q?PlwBpHZmZnWFLNRm5eG5PLjRHLaZsa4qUfjewdvpKrObXL85ReATrW6ivHe1?=
 =?us-ascii?Q?F47ERk4dsynWTZ3CxObwPOfwkykoksGGsuECsIeDC8boPp06+PNX32BkOO3h?=
 =?us-ascii?Q?6hX+WEJlUYI/EfGQ587xJ6Oh7KExq6lOs46g2b4HR+CCRsmbVKOSAj6kKPA6?=
 =?us-ascii?Q?OgzQ721GS1CsfiOGubgUbGKmfwyIL9PITvJ7lq/byGB+CsSunvlwx8w6Zs6Y?=
 =?us-ascii?Q?qiAtL4O64OhHqG/C0VylhKyhhvD6X+VkzwMOago67rEMAvIc3jvPHkx5j8/D?=
 =?us-ascii?Q?ByzftGBBfqiX8yiANfRqExa9RcxxQBPogVEIKslu1HCFfz8LLt5fVyJ7C8Ax?=
 =?us-ascii?Q?1ytXmYQnfKU8kKBa9btkS8VPO7mwez181q0jgtBqspf43G0l2WEtGzGcuUan?=
 =?us-ascii?Q?3E/iH8/qXdH8gcDfUNZPUrxKXhNsr9dtVxWiyb6fk8HlIrMA+ujudVumNvsP?=
 =?us-ascii?Q?veoc2/FDC7MuiYe7blwOW1MFK40Srdgxz/6L9w1tPpZoBGUU+uiAOFkGOfpo?=
 =?us-ascii?Q?Cm0Q1i1ta//9A/Akq7ekhjubWyNNcvWR+6H8GsYVwsT2Q++Sx3+by8xqVFuv?=
 =?us-ascii?Q?LtQ+5E0AOYpupgtvznaEbRo7T/oG4Clb+1lIEyW3jqt6FtHe8nyOmPdZzNSk?=
 =?us-ascii?Q?BgKSCxhhHXd87UecfKRUsoalXso8L0T8jHzp1EeL9q8Uh+FXYkVMWSMyL/wN?=
 =?us-ascii?Q?OBPvWYwSYLlJYVt1xuJLgyV8jhweYy8BKAzWbXLqAyrfSLA0rsid4TFG8GgN?=
 =?us-ascii?Q?jO7vclKPd4MjACbzlKBJpxg8KOjrK69mtvLSVaYSU1Ti9iLa3UBEwciP3DBK?=
 =?us-ascii?Q?Y3sWcR8KAEDMZiXGJO2KP+pS6Ureuqjy67TRGoPlEflPed+n4mBPbtYmF/CB?=
 =?us-ascii?Q?CgAgcco2ZVsTipqq+Ai+Zn7SuX1XGTKkn3+QDKd3RMPdSiQ8LR+IJVOF9S39?=
 =?us-ascii?Q?fVK1MSjEUBgU5/vCFQTw9wmLtwdyXweIpyoBctaZBWzUPO+ucqD4wlydedN2?=
 =?us-ascii?Q?D7P9dCuqnNKdZp1jhhafnIOC4vqLSWUVhlOhM2QmlMERxQqH53E4U3DPTjVX?=
 =?us-ascii?Q?3Ek/f+2XlHjYyg+h1jyfW+hvTZVDhC27tYBAlXBW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e81019-f10c-44ca-54f1-08dd6d51d3e7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 17:07:17.4354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ME4bLcXVU+p3ZRiqsGbjxjz1UkSKsXlSiGW95GpORYVAHARyJdpQiIsLyQFwKWdAazRLGYOxJDIZ2aLW/VTgsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8921

On Tue, Mar 25, 2025 at 05:43:30PM +0800, ziniu.wang_1@nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
>
> For some SoCs like imx6ul(l/z) and imx7d, during system PM, usdhc will
> totally power off, so the internal tuning status will lost. Here add
> save/restore the tuning value for any command after system resume back
> when re-tuning hold.
>
> The tipical case is for the SDIO WIFI which contain flag MMC_PM_KEEP_POWER,

tipical? most like typo typical, you can run
./scripts/checkpatch.pl -g HEAD --strict --codespell


> it means this device will keep power during system PM. To save power, WIFI
> will switch to 1 bit mode, and switch back to 4 bit mode when resume back.
> According to spec, tuning command do not support in 1 bit mode. So when
> send cmd52 to switch back to 4 bit mode, need to hold re-tuning. But this
> cmd52 still need a correct sample point, otherwise will meet command CRC
> error, so need to keep the previous tuning value.

AI tuned commit message as reference.

"For SoCs like i.MX6UL(L/Z) and i.MX7D, USDHC powers off completely during
system power management (PM), causing the internal tuning status to be lost.
To address this, save and restore the tuning value for any command issued
after system resume when re-tuning is held.

A typical case involves SDIO WiFi devices with the MMC_PM_KEEP_POWER flag,
which retain power during system PM. To conserve power, WiFi switches to
1-bit mode and restores 4-bit mode upon resume. As per the specification,
tuning commands are not supported in 1-bit mode. When sending CMD52 to
restore 4-bit mode, re-tuning must be held. However, CMD52 still requires
a correct sample point to avoid CRC errors, necessitating preservation of
the previous tuning value."

>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 90 +++++++++++++++++++++++++++++-
>  1 file changed, 88 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index ff78a7c6a04c..d3ac5f38a9eb 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -81,6 +81,9 @@
>  #define  ESDHC_TUNE_CTRL_STEP		1
>  #define  ESDHC_TUNE_CTRL_MIN		0
>  #define  ESDHC_TUNE_CTRL_MAX		((1 << 7) - 1)
> +#define ESDHC_TUNE_CTRL_STATUS_TAP_SEL_PRE_MASK		0x7f000000

Use GEN_MASK

> +#define ESDHC_TUNE_CTRL_STATUS_TAP_SEL_PRE_SHIFT	24
> +#define ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_SHIFT	8
>
>  /* strobe dll register */
>  #define ESDHC_STROBE_DLL_CTRL		0x70
> @@ -235,6 +238,7 @@ struct esdhc_platform_data {
>  	unsigned int tuning_step;       /* The delay cell steps in tuning procedure */
>  	unsigned int tuning_start_tap;	/* The start delay cell point in tuning procedure */
>  	unsigned int strobe_dll_delay_target;	/* The delay cell for strobe pad (read clock) */
> +	unsigned int saved_tuning_delay_cell;	/* save the value of tuning delay cell */
>  };
>
>  struct esdhc_soc_data {
> @@ -1057,7 +1061,7 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> -	u32 ctrl;
> +	u32 ctrl, tuning_ctrl;
>  	int ret;
>
>  	/* Reset the tuning circuit */
> @@ -1071,6 +1075,16 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
>  			writel(0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
>  		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
>  			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
> +			/*
> +			 * enable the std tuning just in case it cleared in
> +			 * sdhc_esdhc_tuning_restore.
> +			 */
> +			tuning_ctrl = readl(host->ioaddr + ESDHC_TUNING_CTRL);
> +			if (!(tuning_ctrl & ESDHC_STD_TUNING_EN)) {
> +				tuning_ctrl |= ESDHC_STD_TUNING_EN;
> +				writel(tuning_ctrl, host->ioaddr + ESDHC_TUNING_CTRL);
> +			}
> +
>  			ctrl = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
>  			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
>  			ctrl &= ~ESDHC_MIX_CTRL_EXE_TUNE;
> @@ -1149,7 +1163,8 @@ static void esdhc_prepare_tuning(struct sdhci_host *host, u32 val)
>  	reg |= ESDHC_MIX_CTRL_EXE_TUNE | ESDHC_MIX_CTRL_SMPCLK_SEL |
>  			ESDHC_MIX_CTRL_FBCLK_SEL;
>  	writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
> -	writel(val << 8, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
> +	writel(val << ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_SHIFT,
> +				host->ioaddr + ESDHC_TUNE_CTRL_STATUS);

FIELD_PREP ?

>  	dev_dbg(mmc_dev(host->mmc),
>  		"tuning with delay 0x%x ESDHC_TUNE_CTRL_STATUS 0x%x\n",
>  			val, readl(host->ioaddr + ESDHC_TUNE_CTRL_STATUS));
> @@ -1569,6 +1584,58 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
>  	}
>  }
>
> +static void sdhc_esdhc_tuning_save(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> +	u32 reg;
> +
> +	/*
> +	 * SD/eMMC do not need this tuning save because it will re-init
> +	 * after system resume back.
> +	 * Here save the tuning delay value for SDIO device since it may
> +	 * keep power during system PM. And for usdhc, only SDR50 and
> +	 * SDR104 mode for SDIO devide need to do tuning, and need to
> +	 * save/restore.
> +	 */
> +	if ((host->timing == MMC_TIMING_UHS_SDR50) ||
> +			(host->timing == MMC_TIMING_UHS_SDR104)) {
> +		reg = readl(host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
> +		reg = (reg & ESDHC_TUNE_CTRL_STATUS_TAP_SEL_PRE_MASK) >>
> +				ESDHC_TUNE_CTRL_STATUS_TAP_SEL_PRE_SHIFT;

FILED_GET?

Frank

> +		imx_data->boarddata.saved_tuning_delay_cell = reg;
> +	}
> +}
> +
> +static void sdhc_esdhc_tuning_restore(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> +	u32 reg;
> +
> +	if ((host->timing == MMC_TIMING_UHS_SDR50) ||
> +			(host->timing == MMC_TIMING_UHS_SDR104)) {
> +		/*
> +		 * restore the tuning delay value actually is a
> +		 * manual tuning method, so clear the standard
> +		 * tuning enable bit here. Will set back this
> +		 * ESDHC_STD_TUNING_EN in esdhc_reset_tuning()
> +		 * when trigger re-tuning.
> +		 */
> +		reg = readl(host->ioaddr + ESDHC_TUNING_CTRL);
> +		reg &= ~ESDHC_STD_TUNING_EN;
> +		writel(reg, host->ioaddr + ESDHC_TUNING_CTRL);
> +
> +		reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
> +		reg |= ESDHC_MIX_CTRL_SMPCLK_SEL | ESDHC_MIX_CTRL_FBCLK_SEL;
> +		writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
> +
> +		writel(imx_data->boarddata.saved_tuning_delay_cell <<
> +				ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_SHIFT,
> +				host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
> +	}
> +}
> +
>  static void esdhc_cqe_enable(struct mmc_host *mmc)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> @@ -1900,6 +1967,15 @@ static int sdhci_esdhc_suspend(struct device *dev)
>  	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>  		mmc_retune_needed(host->mmc);
>
> +	/*
> +	 * For the device need to keep power during system PM, need
> +	 * to save the tuning delay value just in case the usdhc
> +	 * lost power during system PM.
> +	 */
> +	if (mmc_card_keep_power(host->mmc) &&
> +			(esdhc_is_usdhc(imx_data)))
> +		sdhc_esdhc_tuning_save(host);
> +
>  	ret = sdhci_suspend_host(host);
>  	if (ret)
>  		return ret;
> @@ -1916,6 +1992,8 @@ static int sdhci_esdhc_suspend(struct device *dev)
>  static int sdhci_esdhc_resume(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>  	int ret;
>
>  	ret = pinctrl_pm_select_default_state(dev);
> @@ -1929,6 +2007,14 @@ static int sdhci_esdhc_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>
> +	/*
> +	 * restore the saved tuning delay value for the device which keep
> +	 * power during system PM.
> +	 */
> +	if (mmc_card_keep_power(host->mmc) &&
> +			(esdhc_is_usdhc(imx_data)))
> +		sdhc_esdhc_tuning_restore(host);
> +
>  	if (host->mmc->caps2 & MMC_CAP2_CQE)
>  		ret = cqhci_resume(host->mmc);
>
> --
> 2.34.1
>
