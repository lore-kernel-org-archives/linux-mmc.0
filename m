Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2061.outbound.protection.outlook.com [40.107.249.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE65B194094;
	Tue, 25 Mar 2025 09:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895744; cv=fail; b=qxJb1mE8A/sqXIZfvlctL8gd++YGZGdyIFdbm6YqIiOdRZVnmGuYJRiXZeFZxcnAodqBxMqjp4aSZ2NRTvCqN8N4UZfrTEMKGtCggtaBLT5wg7XNmPp7kwwuUuclctO83H5BStxoF9pWdZ//B4sk32uJnMThpSERH4BaCkP0sVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895744; c=relaxed/simple;
	bh=9XT5/ZJQdjLkqpOIoxy3m0i99T5n3uwgeLGotvvisFs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tbBKNqwKF10SaWMGrTYpDy2a0UV9C58p2uHcaVedgXXkiZ3Eu06dCbAKbehKQbk7ldFen6N84a71I8mdYF1dQ39xb6HnPTCSyZZhj3deJ7BgnTHq78yXhUUu354Xu7b2B0U31Vfb/0Byemtgjbu0wqtxF7O1d+WNO0Whxg/Lfw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Sjc4+OS9; arc=fail smtp.client-ip=40.107.249.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Sjc4+OS9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKCfi4EPvR6lF5GI0ZZQsp9RwW9jiAHotuZ8WVktFqffWYF7lGWahSiLoGMHiM02yvogz/k8irxdHqMzA38g4aZ4VGGlPiHLHPBVO/Aq4Wqc1obDze3s3H3llTgwKkgyEa2nnjR3hXmDn8ltCchTXyQAjEyCvob5ZIZ/s9/OOealivmLqOxo44owFEzWuL8c77l6VD3CawSXS6MJ5H6Uv63e0qziMM9y5476nbz7D2uqU8R/eJPI8iQgcw7OKV7MAI2DkTPxxaubr0YMduDMnHRMcEYFbMbbs6JlQWrLirU68U+zRaf96RLQ2CK3XWdYuD55aGyvJEysIBB37WLnrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRU/fbttq2z7Xxxx+us2YBQPyJl2UoNSXQi6HBJW5z0=;
 b=HzAskVLFQttqd+wfAoxNyR9RMEHwrQ1T9f9UM4QDC9wJXs2r2b3BoOokACnbyUsDIxPiFSxz7N7P+jQyXFavlCqtusHVyl42hOY9wg8MF8hVPJOvgNO5gKTBwOE5TiljsPaXl76TcJGcsDUPr/tnlKvliThJ2LVRzQWIhtDMtATWVejLVBbewMSFFzrTr/OqZI/P8hF5UnjMEz4fEZsr/0bDow6EdmFGlXtc+AL2lZF6f4yzGFYp+jsfH7uL13/+4A/Phg+Rr4HfsQklEaJAQ3Gm+tR2hYDqpHekhI9DAzkObUvj1AO10EK9DmBnYhpeGXTKfIZ7p3HDfY3Xm/58gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRU/fbttq2z7Xxxx+us2YBQPyJl2UoNSXQi6HBJW5z0=;
 b=Sjc4+OS9ZFIuIrZhk1+jx92WK+dxtfpWo9H2XtSNwu4RzEsijFs06gzMN+pbbn3R7ebyt1+gQgYhs3lp8+GjNudIGcRQO8Lguk+t64L/Ndhw1MhfjcsveTQP+j0xIOeLwcFxjkvUeWhz6/7IHha1XOSAvXkqjKX+FJvaL29xDDUWI5M1YkrqYbOymJk2DFvqfOXWrOERZphGqPx2uSq9b0EbCtzREDBMC/yBRyHehSDlN07Awt4fLVYgIG7JnPWZPeB2NYSkmd317lrT5rVTlbxN8hrPTj4WdlVDHcefoYF6KD00KZ0gVOHcdSFwUw7JhW6wlZj6pR3b62er/9kP6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by AS1PR04MB9502.eurprd04.prod.outlook.com (2603:10a6:20b:4d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 09:42:19 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%6]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 09:42:18 +0000
From: ziniu.wang_1@nxp.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	haibo.chen@nxp.com
Cc: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: host: sdhci-esdhc-imx: save tuning value for the card which keep power in suspend
Date: Tue, 25 Mar 2025 17:43:30 +0800
Message-Id: <20250325094330.2242646-1-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P250CA0030.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::35) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|AS1PR04MB9502:EE_
X-MS-Office365-Filtering-Correlation-Id: 822d59b0-64d2-4852-e224-08dd6b815575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RROhDJm76jugiz4JesMC6uhj2U0AJUciyBaB7E3kDPNK8OzxEDCL6Gg985No?=
 =?us-ascii?Q?x6Gh29be3OACBBIt/lpPhjY3qfqVcEkaL63kxZDDF7Q0s/0DzvTqahv9Ohug?=
 =?us-ascii?Q?uAhtaX6gF7eGcHjuFabgZkzUlQeGl4fjbsCAGyFkQ1bid0jzmIX0SlkihClZ?=
 =?us-ascii?Q?piNgK5vB00gceJHRKy3/zKzilf9BPaLLy62XzTDwvYHW6+WMSN1vxVFguoim?=
 =?us-ascii?Q?9fJqc/KIDUTEr3PvK3BFw7Wkv5jy60Qmnrh4N2nhFTW2j5mQz2/56nFrQB3Z?=
 =?us-ascii?Q?/H29bhoVfjAydW7SahIyZoUSi77cpnQsBAgXE6j76ESJxtqLxe2aLuUZbq9p?=
 =?us-ascii?Q?rZWMXN77vFBCth2j9Q0VFnls6cjiVs2bvm6jIweudcXmpJnRgDnHI1nZdeBT?=
 =?us-ascii?Q?pTVvwvZDvyr/cIWDb+iiMaQeeJifn2wB7LNNmytE6cdzE6IOhVYAfZYeY906?=
 =?us-ascii?Q?a65QfJsvufXAnkeqqijkx1ROe+gEu1IybxLGAdZDRHk+ic5dRl34PHo0414l?=
 =?us-ascii?Q?Raj8SgM/vTpA8WQnu5XPqq+R+nFogBETbBxn6InZZiIdrCL/7AK/s3YYFlwX?=
 =?us-ascii?Q?ERgx9ejuL5a71VPO74uQeYOrEewnQE3uGaPw7yrbaH/uT1R5f1ISjAc6XIdm?=
 =?us-ascii?Q?GFVMvGR3PbNAZFbUCeRFj/qBUFdm8zqYN5Cd8mPUmQ+4J2RLormZAeWkzMT/?=
 =?us-ascii?Q?h7aSyjtvI7B94Ct4r5soss05ZbkUBcAIjXaldUnwh2v1YzpAE9SOYu/GzEiI?=
 =?us-ascii?Q?FYMXdOlJMNpRf46X+RDtReg2la9qImedRTzNA8GEREZWVggjlQF6wSnGSlwn?=
 =?us-ascii?Q?cyC4TAYCI1Q420ryCX4TUUZPQUJTwLMzY0duJcXdBh3NHt1KVxQUT+21fMlI?=
 =?us-ascii?Q?wFCW+jrnIPBfJ3Tx+GprwLc4gk5wfxIPnNv8WWuhYr7E003WoxYnueeWArR+?=
 =?us-ascii?Q?UbEHNUGoD/oet0DdG6u0VMpztjgaLmRDDNEi3CHBreXeCwrmRD+7yGlTkPD2?=
 =?us-ascii?Q?wrNO+2kPFEUeJM3Qw2fUxEH20w+UucMJGh+Yx9vow5xaAyzIQBC6KeexbMGL?=
 =?us-ascii?Q?j+taixuoaz7tVWNGD9D3rxgEKGX7Y5gvY6r6QsnBx/fHUBbBkCFaW0RfXsy+?=
 =?us-ascii?Q?cM+KYi/dGnjjuYLc8LY7fQHv4IQCsolAYh69LNWCUKEHCH4VVoRqM90QSZT1?=
 =?us-ascii?Q?iM9Pujz8iEropIFpohDsG6QlZFPodgqdEWJhPM9wDk3Fwa4w0nlUliFdYmqA?=
 =?us-ascii?Q?kb5k7tlvsjo0v4Bv0qXeFpf95iU4Y+v0WciWf0N41CGljrgOO291r1aYjzGj?=
 =?us-ascii?Q?96lqyHm0eTcVIHNTSpoOkD04RrQos+nV8N3iSCsu692d1Sf21qQR36raaT9t?=
 =?us-ascii?Q?uCmI7tOWnggkuOc0zTj1e8GwoX7fONH12WzN6pGYQXWCnG+RJwMNaNhbJtfj?=
 =?us-ascii?Q?nlca2n+U8ImAnAydjtHtLMvpu75vv8Ea?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WWfdiZA07k6LRhPDAqncmcmOGm8waUNHDuhjHU++BDJD63sQpGVLSBTv6g6C?=
 =?us-ascii?Q?KSwfBcNC7t4L1A1OdYmoXNhEgb9iJ9VXsWDwfamPH5eu4h83Czn6aJxv0P2F?=
 =?us-ascii?Q?q7Y0FyO1y10M8nSI99IgySvICtiWATGLQdmF3Akju/R/v/9alPKsFfoSAzOn?=
 =?us-ascii?Q?W4QdQL+MRyKatOolRpsB4leNHgZSATDXJYbAu+xx94+3fQFhl0aIcXKwx9qL?=
 =?us-ascii?Q?UPP7NFbCpZvfUVoE8XvFrP6RnV/tJtZR65HiLcNYTZDz+pW/mUSy285SPuNN?=
 =?us-ascii?Q?wjchZ1Y3Ew7IGFwZuMPPyYrRCXYJUTDKRPXqymMiYioYybqxmWXrh7HxTXb9?=
 =?us-ascii?Q?O1VyJb+eHZGDnHZfpPmz3ufRKoSn99mS5X+0/3vwWjcK9P2RMs7Ancqmb6Bo?=
 =?us-ascii?Q?85iJLJRh/07XrwqAGma6ZU0+z/PF+V8OX25CE6Rnfq9iP06F8lbqIfhptIWT?=
 =?us-ascii?Q?HPDx3xhmFuXOPIWbwhmtHLv0hDW6Eiwt4Q9FLOxI/O2Hw1PU/jFZ/5d/nFmt?=
 =?us-ascii?Q?UM4p/X0zaPM+6nhcxcCYQxkXNvCzLIpozpfTgCWvs4hItgkh07Dlnp7YPN50?=
 =?us-ascii?Q?JvBFlCvdHmhOxAwcbLR3Cx7BwGpupb3LPFp2+q/YJHfaNEptSx64rtcmEcgv?=
 =?us-ascii?Q?DnaGlnEEdJWi/mAnxgthoIvU7jOlQKENqbgA1RKkSfPp46Q2zJ1O8Ib+9VaM?=
 =?us-ascii?Q?jq6oi6Z5QE5zlVrJcVaVmtKQh7uXy6hlWBiTjh4MbGPeSi6pw1oG1simNE2C?=
 =?us-ascii?Q?31sBFhKITK7lDFtMEuWjDDElyxpwLloY55dYjeh9qPu3BurMxJCjFu8POEiF?=
 =?us-ascii?Q?gyZdjlxUZC04Bd6B12qFNRT4rLPRYUA6FuoYFNmJEglG180AEhRoT9LWfE7u?=
 =?us-ascii?Q?J3ies5mMX6Q/wFsx65Sjnv52OZjKB7dO5scPr6PtxYfAquVRTcXA5ie7aZJk?=
 =?us-ascii?Q?GRxGeYgfB6OCwhXpkuZayXUlXFyQkOUp14vXpXGMS2m1G8UZl3pC48P3Lkmg?=
 =?us-ascii?Q?iPI6IknVKPXoqVtaIQAtyhVz7t467IqLeChg7b+S02Np7Af7+KMdnlbSlA9Y?=
 =?us-ascii?Q?JYvR0NEnEh9Drj/BB8cQ3rgUomU++B9CqGBRNX6+ynxUtoX+q4v5i4l1QQqY?=
 =?us-ascii?Q?gKUrNr1H1CV5yNSFMp9Y5PgynvgplV6arb5cpbzSiqZbQHQ6dMX/lYCA2/kV?=
 =?us-ascii?Q?s0Zk7Pd3p6PxrGybb/IjO4mRAHHcCRExXgehoslq3UAV8WdvnEQsEEjhG2Ma?=
 =?us-ascii?Q?jSNTSGpY+r2xeZQqxcWsD1CobAj5QJAZGPvV8oWDcL7vXMf3CCPqPiVcrZ/E?=
 =?us-ascii?Q?QpPTvc5Ma3FQtUPhHcbtqhd1NkQs6on1aYxb/G7FCh6cG5but0c32L8nSBlR?=
 =?us-ascii?Q?bFfmIBJXreR4gOz8Il7xlhUZaCLqAnSYcZN/7V86w4FOyP9fDgEKCuBfpBkY?=
 =?us-ascii?Q?Fs5fGFwxYUrbm268IPc9TgMUloTW87wdSN2YudMW4ooTiLkctOH87+Hahe6n?=
 =?us-ascii?Q?Syyj5eGCdb5ffByCO9f4W61AdNdFXdiQ1SJy41B1lgrlJWYc1533LR4A8QnD?=
 =?us-ascii?Q?NcqZKALPnGaMXvaZ9pCWrkXMoDzjbt6XbDOkw0h6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822d59b0-64d2-4852-e224-08dd6b815575
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 09:42:18.9376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7fV2Jli9c/wE2c4UcqjjBDtqSGl4syjLAs2wTaQdPG2b3QjPZiOqij7DsMnUcno4d+Fz9kBZ7nqtzncGMpPEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9502

From: Luke Wang <ziniu.wang_1@nxp.com>

For some SoCs like imx6ul(l/z) and imx7d, during system PM, usdhc will
totally power off, so the internal tuning status will lost. Here add
save/restore the tuning value for any command after system resume back
when re-tuning hold.

The tipical case is for the SDIO WIFI which contain flag MMC_PM_KEEP_POWER,
it means this device will keep power during system PM. To save power, WIFI
will switch to 1 bit mode, and switch back to 4 bit mode when resume back.
According to spec, tuning command do not support in 1 bit mode. So when
send cmd52 to switch back to 4 bit mode, need to hold re-tuning. But this
cmd52 still need a correct sample point, otherwise will meet command CRC
error, so need to keep the previous tuning value.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 90 +++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index ff78a7c6a04c..d3ac5f38a9eb 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -81,6 +81,9 @@
 #define  ESDHC_TUNE_CTRL_STEP		1
 #define  ESDHC_TUNE_CTRL_MIN		0
 #define  ESDHC_TUNE_CTRL_MAX		((1 << 7) - 1)
+#define ESDHC_TUNE_CTRL_STATUS_TAP_SEL_PRE_MASK		0x7f000000
+#define ESDHC_TUNE_CTRL_STATUS_TAP_SEL_PRE_SHIFT	24
+#define ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_SHIFT	8
 
 /* strobe dll register */
 #define ESDHC_STROBE_DLL_CTRL		0x70
@@ -235,6 +238,7 @@ struct esdhc_platform_data {
 	unsigned int tuning_step;       /* The delay cell steps in tuning procedure */
 	unsigned int tuning_start_tap;	/* The start delay cell point in tuning procedure */
 	unsigned int strobe_dll_delay_target;	/* The delay cell for strobe pad (read clock) */
+	unsigned int saved_tuning_delay_cell;	/* save the value of tuning delay cell */
 };
 
 struct esdhc_soc_data {
@@ -1057,7 +1061,7 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
-	u32 ctrl;
+	u32 ctrl, tuning_ctrl;
 	int ret;
 
 	/* Reset the tuning circuit */
@@ -1071,6 +1075,16 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
 			writel(0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
 		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
 			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
+			/*
+			 * enable the std tuning just in case it cleared in
+			 * sdhc_esdhc_tuning_restore.
+			 */
+			tuning_ctrl = readl(host->ioaddr + ESDHC_TUNING_CTRL);
+			if (!(tuning_ctrl & ESDHC_STD_TUNING_EN)) {
+				tuning_ctrl |= ESDHC_STD_TUNING_EN;
+				writel(tuning_ctrl, host->ioaddr + ESDHC_TUNING_CTRL);
+			}
+
 			ctrl = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
 			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
 			ctrl &= ~ESDHC_MIX_CTRL_EXE_TUNE;
@@ -1149,7 +1163,8 @@ static void esdhc_prepare_tuning(struct sdhci_host *host, u32 val)
 	reg |= ESDHC_MIX_CTRL_EXE_TUNE | ESDHC_MIX_CTRL_SMPCLK_SEL |
 			ESDHC_MIX_CTRL_FBCLK_SEL;
 	writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
-	writel(val << 8, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
+	writel(val << ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_SHIFT,
+				host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
 	dev_dbg(mmc_dev(host->mmc),
 		"tuning with delay 0x%x ESDHC_TUNE_CTRL_STATUS 0x%x\n",
 			val, readl(host->ioaddr + ESDHC_TUNE_CTRL_STATUS));
@@ -1569,6 +1584,58 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
 	}
 }
 
+static void sdhc_esdhc_tuning_save(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	u32 reg;
+
+	/*
+	 * SD/eMMC do not need this tuning save because it will re-init
+	 * after system resume back.
+	 * Here save the tuning delay value for SDIO device since it may
+	 * keep power during system PM. And for usdhc, only SDR50 and
+	 * SDR104 mode for SDIO devide need to do tuning, and need to
+	 * save/restore.
+	 */
+	if ((host->timing == MMC_TIMING_UHS_SDR50) ||
+			(host->timing == MMC_TIMING_UHS_SDR104)) {
+		reg = readl(host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
+		reg = (reg & ESDHC_TUNE_CTRL_STATUS_TAP_SEL_PRE_MASK) >>
+				ESDHC_TUNE_CTRL_STATUS_TAP_SEL_PRE_SHIFT;
+		imx_data->boarddata.saved_tuning_delay_cell = reg;
+	}
+}
+
+static void sdhc_esdhc_tuning_restore(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	u32 reg;
+
+	if ((host->timing == MMC_TIMING_UHS_SDR50) ||
+			(host->timing == MMC_TIMING_UHS_SDR104)) {
+		/*
+		 * restore the tuning delay value actually is a
+		 * manual tuning method, so clear the standard
+		 * tuning enable bit here. Will set back this
+		 * ESDHC_STD_TUNING_EN in esdhc_reset_tuning()
+		 * when trigger re-tuning.
+		 */
+		reg = readl(host->ioaddr + ESDHC_TUNING_CTRL);
+		reg &= ~ESDHC_STD_TUNING_EN;
+		writel(reg, host->ioaddr + ESDHC_TUNING_CTRL);
+
+		reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
+		reg |= ESDHC_MIX_CTRL_SMPCLK_SEL | ESDHC_MIX_CTRL_FBCLK_SEL;
+		writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
+
+		writel(imx_data->boarddata.saved_tuning_delay_cell <<
+				ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_SHIFT,
+				host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
+	}
+}
+
 static void esdhc_cqe_enable(struct mmc_host *mmc)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
@@ -1900,6 +1967,15 @@ static int sdhci_esdhc_suspend(struct device *dev)
 	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
 		mmc_retune_needed(host->mmc);
 
+	/*
+	 * For the device need to keep power during system PM, need
+	 * to save the tuning delay value just in case the usdhc
+	 * lost power during system PM.
+	 */
+	if (mmc_card_keep_power(host->mmc) &&
+			(esdhc_is_usdhc(imx_data)))
+		sdhc_esdhc_tuning_save(host);
+
 	ret = sdhci_suspend_host(host);
 	if (ret)
 		return ret;
@@ -1916,6 +1992,8 @@ static int sdhci_esdhc_suspend(struct device *dev)
 static int sdhci_esdhc_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
 	ret = pinctrl_pm_select_default_state(dev);
@@ -1929,6 +2007,14 @@ static int sdhci_esdhc_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	/*
+	 * restore the saved tuning delay value for the device which keep
+	 * power during system PM.
+	 */
+	if (mmc_card_keep_power(host->mmc) &&
+			(esdhc_is_usdhc(imx_data)))
+		sdhc_esdhc_tuning_restore(host);
+
 	if (host->mmc->caps2 & MMC_CAP2_CQE)
 		ret = cqhci_resume(host->mmc);
 
-- 
2.34.1

