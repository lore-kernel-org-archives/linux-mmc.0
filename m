Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2076.outbound.protection.outlook.com [40.107.104.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6106F25A358;
	Wed,  9 Apr 2025 07:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744185294; cv=fail; b=Wp2va7M00Tf7Kv9/LQ+u2exDvV+rTkRG6Q9st95/DakK1/kohGKP6erWQ4AeaiqUkaYObk+rsRugZdcRov9OCZSOvjwqiFEsmQuekw7LCOMXWONrYuTyTSwer4IkDKm06Q40xDIWWt5qmZlvhAQZmcAgqD3bW78+eNlFNMxzLN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744185294; c=relaxed/simple;
	bh=Rnj8umttkvraD3/lMYBNuYOrTaJdecaQspzACvcceS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qGO8UX+bUeUFJU6gGlVp/ahBZN+k9q1USdT/RRI31EJGybDv+dqVv/YlnmlYpBGeO4n4yJI2ajsUKJFPmS5SonIkE0foJL2L2tC9FTf5Ih1gsvJv/VEalXzTWv/8jh8srXDtdfXcRIaMDjQqtEtvqJsrqnlyizNnGXbNrrzGMoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pjn1rMjV; arc=fail smtp.client-ip=40.107.104.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pjn1rMjV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHbpBM9OYG9mElRl/8Cn5y0hrHTSk/ClLiNkLqPJP23+A3EmeVvWTmCa9uLQBHi6vUS19oMzWP1847ATRfEdpAj7MpBK823ehPq+Qg6VpNpMWccV8qSbRUgM6yIGX5PWJ9GqDCURBxewMqvQr0RWXaYIaEClC9z8Gw0QBw0O+BYaPLVGU+DHAos8TgKOcQHBXwAfs3pAQM10Eo2aSQM0ueEcGMfvDzmx/SnCw2KRspLX2/LQIcRuv1S4xgxB/EJpebhiWLvuu75kAnRCZ73hn0Z3d58ch1OojpzVvb6WWagOGnnGw2pnnk74efUOzBKWUfr8IeuriWwqP5DlDpBwjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTuyzc9U1C6Boc+qIbTkLH3c7yT8ijUJKDCwlR24/AA=;
 b=yvXK/w6Gx3pbyjygIC+LVnvXiacrmjXz7HdsqRrMVdUWEvXUC4N5rAyzGM4DFOX/U2KiYLYGC9/IH0NfauChU+qVpYAOYA9zEt+2uVigTTgDgN4Yc2Nb50WrGlXYLELSVgZH6FdRCFGfXIWibRVAe6f35NPa6KTOXptw9NE+gPn3yGm6/GkoufMGXKLL7s/4FFo/l7oBmeBBpbotg9G4Pp/0Xo0NRBsvr4/AKECSxJvwy1BvtOM53VtU/TwKpja76VkYBAfaQlD4xRrca/YLeSlbQYnETfcnftjfk+kr1soP1MaN48LdkmmYXMY5aciwV1I0gEFpBSHrH/GC7XPzLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTuyzc9U1C6Boc+qIbTkLH3c7yT8ijUJKDCwlR24/AA=;
 b=Pjn1rMjVQSGxyLj2PTPfTh8RAJ/dT3AWS6tNA+dVOyR4oMeh8chnfmGN/ew71JgIAuDNqfzye3fCx2VAdRYLaQVwvNTScXrqR8mLaNbtFproE3j9C5KR7LPZ8MuySFBIS1MN4y5xqFntxFtO29JSp+74ejE9abPkFQsMKaMpkiMMSRc0TOge9kreJLnOX4EriXNzKvU5YMbMHYA8jERmNH18Us/Wpxijbpkv6Y86vHuCoTU7hthKMTtUncwSyBFuRXlysoym6g20b/cnlxgEPoFo6euo5N5m7aOyugn22TPEkeGyIpjzSm+ByAEeQZY2brejbhPs3FjLW7R75Tssqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by AM9PR04MB8196.eurprd04.prod.outlook.com (2603:10a6:20b:3e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Wed, 9 Apr
 2025 07:54:49 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 07:54:49 +0000
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
Subject: [PATCH 1/6] mmc: sdhci-esdhc-imx: explicitly reset tuning circuit via RSTT bit
Date: Wed,  9 Apr 2025 15:55:45 +0800
Message-Id: <20250409075550.3413032-2-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250409075550.3413032-1-ziniu.wang_1@nxp.com>
References: <20250409075550.3413032-1-ziniu.wang_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|AM9PR04MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: ef6b5bd6-5a87-43cc-6cb7-08dd773bcd9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sjNi6vmsKj7klwfxCeWbeqqBzyDcTizRQJ2sP1Gaiej5bmHVlzFyMKK3zf0N?=
 =?us-ascii?Q?gOpXq6N/WfC47IOHNrDV3B+RmcksNtwc2zhNY88BMSWkifgNE4q89KNh3OnY?=
 =?us-ascii?Q?7wRA05cPzxmjpeFi8dgOLPJvQBI+U7HTRxHSE6z/w+BO1auzKegK3rwG26ip?=
 =?us-ascii?Q?RbI0OZjujoIarbDG3oSL4k333592n7eC6iALgkWQLH7Yee3QAv/CbeMtjXjv?=
 =?us-ascii?Q?pLnVdm6pguGckuz/JXXlcIf90tTsGilvauYG5T3LvCnvbMc1zW2w1WPT5f2C?=
 =?us-ascii?Q?1KUVC8Z6LLYhMdQRCXHZgpQHNNxC0jbnnlUFtKxqoOEMU3ZlLeqBk2W5pFr+?=
 =?us-ascii?Q?ECoOQsL97SKNMvVVA+QKsuHGyX3rnO6wWk2Q0XWyAxVbkPWCRZ+ShMyZst/Y?=
 =?us-ascii?Q?QEGASmeMMbvbAQ9HMZwbVQ2sqwUL0EyIqHS6cximYLZymcvEbpV1oVV9i8AV?=
 =?us-ascii?Q?LJJT5p+cHLNvBve4vaOal/iChink4ZIjVgxv9aHOgTcbgpiN1INm/7cdK4K0?=
 =?us-ascii?Q?5Ey6TRMKWeF1MKWlRA2YPn3Quxtkz1xMjUEhUh3rSOpCmdvMy8sZ9/8RiMOQ?=
 =?us-ascii?Q?wMyIo8F8iW3oix1PFiVDeSipgodaVZryJ51cBbV+nwi1i3PrjC7wkVShQ996?=
 =?us-ascii?Q?lJ6TebijvVJSbbUhRSDX+pYNbit9tNheATELlYcl6K7/LFMuVQDLIYKatctl?=
 =?us-ascii?Q?+xcttk6F8SxjZkoLe+bQob4L3lCmzDiB75gAU9pPVugR0BuYCmTgi0ua1OsE?=
 =?us-ascii?Q?7kmrYjGr5CTaGnVg6rvSPJd33IkimnzhBg8Xw9o2lj14+47thDmq8PW0zv+h?=
 =?us-ascii?Q?BDv98oyYkFwpXlqcfTLu+qJnu6t6A2v8J1xXdgyohn8+LRaA95XAIgP3M9An?=
 =?us-ascii?Q?HvNrh4z588tM06vGWzZubpg8bf4Duf5sKQTCaeG7/MhGvGqwolmKlwIpF3rQ?=
 =?us-ascii?Q?nHO+G1/jTqP8U5Ssn4m1bczOuUEVXgaS1hTgA+RzbBqShEVbrBM3pbuYmLAL?=
 =?us-ascii?Q?zoLxCBip8FpSotyezncjnhSLZX2mkdXvMDA6FZ1Zjv9qfo2llmj6hb0PGm3P?=
 =?us-ascii?Q?paXgiqIXOtNGE+RhPsxicg5B/Ns4DJBiERd70jeELg4DybqP9bki0xeTGAX4?=
 =?us-ascii?Q?622AoJPjzDFjoiTk3ctkrxJ38NJ7nrMQNTolmPoGWIoIBmsE/npzG/8FRXow?=
 =?us-ascii?Q?qVc8tiRPYn2+eORAeQd4PeySG+rIx97v1wrnM+u+uEf/NoBZi1ctYZsJO8Qi?=
 =?us-ascii?Q?fljvXbKBvVwZjbuMEuBKj3ATK8jtgbPXNz1K6jbBP5YfaYnCX96FTb9Q60G+?=
 =?us-ascii?Q?uHPK3m6XWeDuvyn8Z4gjlqUHWGqRswM6chgrP4S+VO9jKk2TRm81GdDsG1Aq?=
 =?us-ascii?Q?Gy7fRW800icshgIeriW5MZS89PL930lJaMELhgq5NDT5cCO435ypsHASuRzM?=
 =?us-ascii?Q?vw0o/cKvgaRxh7EQ2AGThce7POQIT3nJtB8G712AhZ8yvlYTSuWrMA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4z9FBu/emDeRHRucse8XYYHnZkbKeM7mxIM1ei1Z4Iqi7KQM9WfbH2ByK5uD?=
 =?us-ascii?Q?miMLFvgKok4NcIOjSZB5ydIVkSDeNd59bBi7tx4Y32q9de7xCRbLcSje9o7v?=
 =?us-ascii?Q?wX0uKHz52OA4r+SoluNgio0/6gLHfi6F/gLrttMpAHPXWhDVgxv7OfGV7dOd?=
 =?us-ascii?Q?Odt20VTXF/5AqgDp3Ytu3YFjKizavF6fbuVW6S6KGR55N97vvI+60f+6FtbU?=
 =?us-ascii?Q?eRQDBuyIxVTfhxj3CTcMILXlltH7sxMEqP8z6j5JYQH4v6BZqhVXV/b3A9sY?=
 =?us-ascii?Q?+Pp2X95FHS8sKuKINDDIYeYgr6qdCoYZMNiP18IyOZFYavzvi4G1EwHU21gG?=
 =?us-ascii?Q?qQoEK8jyJC8OnWXVt+OnpuA3Ibf2GH92HKbTvEhYHcNdjYepezLg7l21YfNW?=
 =?us-ascii?Q?c3dQYd1v2/jpXBDYd8TO3g3MfQr6exCk+TK/OEBmxQIr4+zIKa8YovT3/j1x?=
 =?us-ascii?Q?67ZBaWCN2CiRiMYzKLQ+lBxMxAYGkFONB38jfxn6fKYrZzEUKrqAgK6ln1dW?=
 =?us-ascii?Q?JptCOcdFHYJHc2sl2Nzgc4OlJtec6iMU5+SZQcFXfvI4dlrznotjp7nvY8kx?=
 =?us-ascii?Q?yZdTtY1j1MLFdO9cAcE+Ga/toVeCwXJ9hQUf8+5wEwkBaNyrNZEsYk1yqjjP?=
 =?us-ascii?Q?xkFOu7YB4758LHHhxQje11456SWQYqo5sPmoko5b/StffeocQ4VVQwdfuCd8?=
 =?us-ascii?Q?7aSMPa6Q1q844Gwq8gLHOB0grXsvLEAGKdnu9EljhhQ5fqJaJeVfwTI/cRFX?=
 =?us-ascii?Q?hbsMS/ZrgwUBrliqpZA36oPHqKubR/9gew1r2n0bN+L1/k5HQO2FeGZoEiw5?=
 =?us-ascii?Q?8PWatK9vjRg0VHwYu/5aw9GFov3haNxc9dZypUfOVvBvc3tTRXMx3iq4v/+8?=
 =?us-ascii?Q?c5dSjQ+X89pHomAFUJHBTfLc2EaR+BuxdVs49hQqUPyistPti1NsKX7wzBL/?=
 =?us-ascii?Q?X3BD1+GCtc7qNK6jfXw0WGTnoswTF+rMLouMxxyOBqFDnECIEBJxpMyMJmBq?=
 =?us-ascii?Q?x6srjRfBEqPMMnICgLgVPTGkxqOEzBLQzdRos7Xr8+m2xbLDOOlC8i5m0/ha?=
 =?us-ascii?Q?rmKjqkonSIi8obUeyoE0A0b1Ns5FXo8jznh3JsLQS9tn7MuDmq7E5RvFXGDC?=
 =?us-ascii?Q?F/dKVQ+oXfk+Kcs5KFIYvJvkf7RjWF41TNsPiytkqnXjoKxSJrncGrV3sMlB?=
 =?us-ascii?Q?z2brLNnXWkyDrIITI1kWP0b8kNad86pbIu/RVZ/JUW3g/82BqCPD6ISNY0aN?=
 =?us-ascii?Q?fDZvP3CuypJPWmzE2berhKz+uXKRkS9weqv4rb6x89p1q+dje5QQbW0rinj/?=
 =?us-ascii?Q?0yZq3dBfRBVWb5yDJ/1M0wnHVhWXF3eutziqs5AvX47Q7zV9V1xt5MorBFpG?=
 =?us-ascii?Q?e/jJummTuO1FMlupVbkHMFsU/jo0Y4kDbyjWSqwIl/ptZ68+MtDXk4tIKqqR?=
 =?us-ascii?Q?Cxtv/sZEuG8k7rSNnIJbf3fIEb2OemXlLF/9JIGfBU9eja1X9C4Pi5Eg6RMV?=
 =?us-ascii?Q?pstPsB3MmuY+zmWjk5sgrqZKrXJoVu6oDxog3EjxUYSnZeNmOxds7c9VbGvc?=
 =?us-ascii?Q?gNnjKcdqe7ByuGjZncDNOgPbFeOaZajGNQQobno3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6b5bd6-5a87-43cc-6cb7-08dd773bcd9f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 07:54:49.5945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnlXFdhGn3jn+LacPei2W0WSlUYNRJNtLOPQGsVdhPMmhH76LZE+hAP4OimhNyAzc6sQiq4GnrEgSAXYUygEFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8196

From: Haibo Chen <haibo.chen@nxp.com>

According to the i.MX Reference Manual, the RSTT bit (SYS_CTRL[28]) is
designed to reset the tuning circuit. While the Reference Manual states
that clearing EXECUTE_TUNING bit from 1 to 0 in AUTOCMD12_ERR_STATUS
can also set RSTT, this mechanism only works when the original
EXECUTE_TUNING bit was 1. When the bit is already 0, the tuning circuit
reset will not be triggered.

This explicit reset approach strengthens the tuning reliability and
aligns with the Reference Manual recommendations.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 7e8addaed697..8c2f5ae949ae 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -32,6 +32,7 @@
 
 #define ESDHC_SYS_CTRL_DTOCV_MASK	GENMASK(19, 16)
 #define ESDHC_SYS_CTRL_IPP_RST_N	BIT(23)
+#define ESDHC_SYS_CTRL_RESET_TUNING	BIT(28)
 #define	ESDHC_CTRL_D3CD			0x08
 #define ESDHC_BURST_LEN_EN_INCR		(1 << 27)
 /* VENDOR SPEC register */
@@ -1060,7 +1061,7 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
-	u32 ctrl, tuning_ctrl;
+	u32 ctrl, tuning_ctrl, sys_ctrl;
 	int ret;
 
 	/* Reset the tuning circuit */
@@ -1084,6 +1085,11 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
 				writel(tuning_ctrl, host->ioaddr + ESDHC_TUNING_CTRL);
 			}
 
+			/* set the reset tuning bit */
+			sys_ctrl = readl(host->ioaddr + ESDHC_SYSTEM_CONTROL);
+			sys_ctrl |= ESDHC_SYS_CTRL_RESET_TUNING;
+			writel(sys_ctrl, host->ioaddr + ESDHC_SYSTEM_CONTROL);
+
 			ctrl = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
 			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
 			ctrl &= ~ESDHC_MIX_CTRL_EXE_TUNE;
-- 
2.34.1

