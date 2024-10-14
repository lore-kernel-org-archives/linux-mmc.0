Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2084.outbound.protection.outlook.com [40.107.103.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFF61428F1;
	Mon, 14 Oct 2024 06:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728885649; cv=fail; b=qA4XvpnvSTlzDKN80/pQST1jd4GDXpMk2Cupboo9Uf6o+5rf3uq7vx16DjsWNRMRTRx2nUMNl9MVlUPWu1dx7nwH+3D27N2rBqavtXpjziu4GCMeH+UB9P51s5MrP1VtSicm5bDRzg7gdbYr0RJk4ghKZMuUrovKme2NB/QdmBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728885649; c=relaxed/simple;
	bh=XpzPxDFynOBgTh84+8z0cvsZTJyltgVl6OAlCQgIV7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BWaCbx23XeXUn2VmLA3TJFfUTs3US/V+2rK/hfPnlRIstPzwI0yE1SGjUUdKgpujwAKmqBhfsZxcoaoSncTkYMqFwIbhASMWN1HgIflEU8IYuufTNGygzaR2fgubInXJwvWxcacmD1pCVgauXRaYJO3n4xiy5DROQYLDe8XjUAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jTYDPl1u; arc=fail smtp.client-ip=40.107.103.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jTYDPl1u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Po7s5Biu6c/jpaaoUN6XIMwgRonvWYXwVNUDA+W4KWhOaIzXX/Pc7dAK8rCROe4HAFz9SJPdFIF+fnVRCoHZJaMNEnnmGv5iwRU8fQB+IDaNPwsncxafW1dmYICrMX8Q2tEGT96mj/5Yz9FdJpSnnOxHLTHpeCcxE8EkoGOpCTGJCkQZQdsDhzslB7OXG+ZqgWU+t/u+Jzzggubife8LhRkJ3OtsboBfx72mr/O9rpRmUIvsXZboYTrIyVWpyivJTme+nGgme0Ml+Kvigv3w90tAizS51garL9m03uhZf+DLevGriJkrrzy1flPzbm90mvjoSWvEgAsFPU2Y4cZeSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uvylZoVj2f5wE9XylQPvz8SlUsXond/T1pZkE8NnEU=;
 b=SeWF1C3ntLjU0BbC2lTxDQFjSI8XSjMoFkYVLb64y9GFNYG5GVb8l5jYnI+xMiNOBCTzBQJcWMT/GDod1P3CLw7K+LurThUandtTEmGIAsSJ3q14GjDD8pxMkJ2SccHqJMWDNTi1YxnXp7MyumDLNHwOE2FjRfZ10Yk1OhKUBQwZ5UMmiwUVhe4/IywXzlrJKtSMyZ/bPXt6yoRRzqXsqharVzhzUwX9AYNDnuE1wiNafmAbN7uBVUtunO+JFqHRMWBiDxEG4lFN2JDigEEph2elLb7VY6KaD29wuC2Sd6+hkwNbvXsU1dZxpY2l6IEyR4huuryVvCTukeMeZPhXoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uvylZoVj2f5wE9XylQPvz8SlUsXond/T1pZkE8NnEU=;
 b=jTYDPl1ucQc5LTCVZDB+Jyjro806LzzuUletKtL6EPifohRakbrDHf6Pas6Ys92QvrZ5t1Cc9SPVExnKT6pmJA7mzEyEjZYRHf8iheuLU7a+K6eePXKNgKssiVZS7BAlzzqyy+C5MLw+o/w3Xvql7Gr7VyjfzhyEoMMlvJIEj+aOWN2o4qL4f1/eOQRZ+jdtF23SUL7JAHojm5KCfZlwUyre6JRwtWF899HG9YUVKDn5wMUKsmCEG0RIT3gC8sEu+C0D0T9Ts1fczSNFYXXC2B8bxIEI1zTqQg6g8NG1SOAtXTaJoLcBnVLXrebIQKWazo4YE2E4TZC5g+/p38TRvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AS4PR04MB9459.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 06:00:37 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 06:00:36 +0000
From: haibo.chen@nxp.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org
Cc: imx@lists.linux.dev,
	haibo.chen@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] mmc: host: sdhci-esdhc-imx: save tuning value for the SDIO card as wakeup source
Date: Mon, 14 Oct 2024 14:01:29 +0800
Message-Id: <20241014060130.1162629-4-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014060130.1162629-1-haibo.chen@nxp.com>
References: <20241014060130.1162629-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:4:186::16) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|AS4PR04MB9459:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc3322d-c3a0-4a93-dc40-08dcec1585ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j3ymP+Xqp+YDWj99DEORqBH8cNLRoJO760AzB8ZSsqtFk2CUI6wGHYhd6ed8?=
 =?us-ascii?Q?b4Q9AqQxqROcCy8oFwNzTMIaiZe3eUwDyVJ1twsNl/2jDdXNxNQosLAU4OkB?=
 =?us-ascii?Q?NrCviyrPr2/FtTnxug7zUK6psYISQNxGD/5ihS3HBGUe3v0I/nt7tbZrEi+V?=
 =?us-ascii?Q?S+eGMAFsDbtkvFhOZ6UsnkoVGYcJHY1Tj7s4nfLAWKGokNHPgPE5yyqJCHq7?=
 =?us-ascii?Q?fYWjvvAuOgmDkzARaWWFW92YCjfpLarcGhunn0AKNmChKbFfIpHrjfO3trKh?=
 =?us-ascii?Q?Aa8MgRoSuygLfLaT32RIpaFKSXPKCmbZGrrXPvn1KxB1hfUpiLiiyBvFAbXw?=
 =?us-ascii?Q?RE2q6Eo2m0M5vCy+3lAZAL9uhvXfG4WFJIFPvSWPvezATCfVYHs6K7EVhwuP?=
 =?us-ascii?Q?n1ATwPodWVg/J0NEj9VAdWjcU9eGSJfP7wx5xxfYzv4o/wL1mMueE0q+QmNY?=
 =?us-ascii?Q?JZtLZ1WuE83ALi9eFe3dgqFw2Ad6ozTKWSsKxBhIm5MejUnjW7ihXoqjkGkY?=
 =?us-ascii?Q?z+9RF1+5jAxdWOCvlajjDNjD333AyM0BWFK0erD6eL5hfclZdi7fNMTYnnA8?=
 =?us-ascii?Q?drhb6E/pPfsenvsmXmyRrDSI1rxlptHxZXNQ02viJHuRqr5STWOKrEHaqL1/?=
 =?us-ascii?Q?JNByTbpvSv+DeHMT2Y8++RNTpYMqw1xKlbuvQcYIsTQ9NueVmCXWjp4ZUUR3?=
 =?us-ascii?Q?M5TsFbOFz4IQGsN5F8eT02G9MYwoQOUehud/otGW+rgMTIioTfh9Cx2m9BLQ?=
 =?us-ascii?Q?2PCkiOoGWlaGi7lZFJNWFi2dKfK5JpywPyiih7O+ceSrYDW1E1xp2awtCvt7?=
 =?us-ascii?Q?BMTXSliDeEz0a/dGsIu23bKvSja3bWkPzLtnrqXVl/CZaZoGxcH8YVSDjHo0?=
 =?us-ascii?Q?GucuG4mC9PVxkTF2ANoRnPyTnsSuetsnznSSDPX7UOoZDNlZgxwVEYTEVNWy?=
 =?us-ascii?Q?kly+YzUS+kFWyBClQQlLav5PHgqrB0nyyXA1jkzYmXwm/q/Zhh7J0ejq4GHT?=
 =?us-ascii?Q?w8SJpFhNCuiwFtyShWC7NPCdOx9Lgu5WSRDNRbykKW+dtfbvrdxT+/jqDS0z?=
 =?us-ascii?Q?GR6xq7v8euv7WbCIp0Jtjh8TVQeORySCr8lZEEN3a5n/OTaJ1Ta71Z95E48p?=
 =?us-ascii?Q?ZIjlzqRDLnBOM8focl7gFqAaYhLD1b5LMXv9jn9IrTUv7FxIxqrDfXaVBXLP?=
 =?us-ascii?Q?vybgquPAgbRkP/5FyqNNn9hOy8tkNAfXlya70o4H+DInbrnMBGcUBspNto9Y?=
 =?us-ascii?Q?9FbsbbeRirg/m+uZeK7UQLG9WpuA2r60cejfH0EZ7pFJGRbF4D4ahKD3lBg7?=
 =?us-ascii?Q?+h8yHIbAz/mQ8fnUgMPlLdgY473KUwP0ANws46ItOy0RlA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BkhAWneLOmKCoGjiJfBwIxv54E7fWLsmsbU9X/Ik7+PF0cpZhu9i1dTtqdbK?=
 =?us-ascii?Q?LYxGExpBJNcwVa3HvAMmd/2WlHexyZKZIfyYYDT7DjESn/PGEdv8AScVcTPo?=
 =?us-ascii?Q?bH0JgEV4VaBBJZNZ/YNjQWvDXtXzSAfR35MjL4PIiBRijtYLMr2ecMLCyuuB?=
 =?us-ascii?Q?NTYbPNV2i/Qi3xla+9+qsLNvWLHkzMK6/B4egWngbTFuqjV4DXb0JEnYxuqP?=
 =?us-ascii?Q?JhWhNlfBVtnMqWuQ+GNMy5KoWN4snasjob5AQUapqU84kgp3nZPDZ8hWAIrA?=
 =?us-ascii?Q?oADBOih3U/929WEegTsL+x3dYldWhniM4R41DuRPE1/oXUDYzCxUYKQL3CMr?=
 =?us-ascii?Q?oN70wysX+tYAyxcXDw2ZRxmJjrbRrYB57dxX+ulAEGvz8jGOoA6f48nkrjZJ?=
 =?us-ascii?Q?C/upCPIs1VC3LEmbM6VDsZccqMZdsHqx/0/gqxxfkXzKE7AL67Nnju7YJrh/?=
 =?us-ascii?Q?wkzD6OmEwLem/IJ/ss9NhHmH8w/4bdGXk6YW26BV118IoW1hCjqFRi+U8rp6?=
 =?us-ascii?Q?H0c5fZ73TgeVg/mTKnbectS6bND9wQgGeTFPu0ZuvuqzRCFdg67YNAkAtocW?=
 =?us-ascii?Q?ZvCTXtkRoQkJY9HtaeM/RLvdMxpB1MiTx709mDErFVSGeR3QtJUHE2s6tawG?=
 =?us-ascii?Q?lDk4DLZs0vBm6iCNe+7Ql4pN9gLVMiJzPNpMiP++iHRqbvJ0CGAe2IdzPo70?=
 =?us-ascii?Q?vCQT4x8gQ8p1g0aPsdLjvocVKGkDBdOR0FAG6R7DFnfhPOo2Q8llVECLpHHs?=
 =?us-ascii?Q?Gan5kX2eHOl1EhTYVZJwY2CN/LhkEBNwOvDtsuK73+2LVdEqOxVr0CeHq3XK?=
 =?us-ascii?Q?PhUav1G1a7PypLsv01UwoI8NFB1Ct7/lerMoeVGzNaHRjmP07JmOLMP/1n5u?=
 =?us-ascii?Q?oZYNnPUQhAzfgnE0fxEdqR5VZ31PWG8pMhX/XIh+JqD1Zu85gYvYF1CEIkbI?=
 =?us-ascii?Q?JiiA/fYiskg0/HILmt76NSPylH2o5zLweybpdShakjU82Ipo+674fUyJGDGq?=
 =?us-ascii?Q?d8BVLBpO7aOjkKTaOU+/5MXMdE1UvQuisDWRmBHPijpA3w4Ibx7tK+hottV5?=
 =?us-ascii?Q?vwa2kaglsQm8ozy7qOlAJF9MsZyqPaID+D5mT4awyswE6jpeTp0A6dE7mBIo?=
 =?us-ascii?Q?5IR3uDmczHFf3KVgbpqdVGuwguqtkOYLOYg4R97n/Co6nKFvUYenM3Iu09s8?=
 =?us-ascii?Q?gqMug9qzjY99O7TrpZrhAvwrIg2G+xUPDviMBvSnQ+Xr/dy/xxHR3ZhE8CPy?=
 =?us-ascii?Q?buXsXemudFnO22w+zTscy5mMSgimZjqaebpVcdqSVhgoP6v5SVtto0Sav3PL?=
 =?us-ascii?Q?HwLIIvNm2zUORbuGjXD5fEFX33ar05iaBQx9fY/GaABgfG59B/oO48iYKZpV?=
 =?us-ascii?Q?xtcunVbSEPhRU67EyUbIC60ktCZCFrG+3AS2psG8SrBMIXmKgUbmUBw3pykj?=
 =?us-ascii?Q?4t3KHMConG3ufOjHuDR2Ws97/k0/yNHzofav6H2Y8jwwaZCYEHk/O1rzrlRE?=
 =?us-ascii?Q?pki0AZDCvkzVpaRwy8cElWplssm2nubPmSLvpc6vn1JKYGNOqoyZpi9KMqtM?=
 =?us-ascii?Q?rKByke3r0YSvvvKVPYObODQc10q51612LR0me0mV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc3322d-c3a0-4a93-dc40-08dcec1585ea
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 06:00:36.6587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BxO6PDx2qFYkSGYm133fXJ7tCmCz59C+kOlyHLB9B2+xOL+NJbQNfv9gf1rHyZi9G0eQttuoEiUZdIawwlXdBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9459

From: Haibo Chen <haibo.chen@nxp.com>

For some SoCs like imx6ul(l/z)/imx7d/imx93, during system PM, usdhc will
totally power off, so the internal tuning status will lost. Here add
save/restore the tuning value for any command after system resume back
when re-tuning hold.

The tipical case is for the SDIO which contain flag MMC_PM_KEEP_POWER,
and contain pm_flags MMC_PM_WAKE_SDIO_IRQ. in mmc_sdio_suspend(), SDIO
will switch to 1 bit mode, and switch back to 4 bit mode when resume back.
According to spec, tuning command do not support in 1 bit mode. So when
send cmd52 to switch back to 4 bit mode, need to hold re-tuning. But this
cmd52 still need a correct sample point, otherwise will meet command CRC
error, so need to keep the previous tuning value.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 94 +++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 18febfeb60cf..4173967022d0 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -80,6 +80,9 @@
 #define  ESDHC_TUNE_CTRL_STEP		1
 #define  ESDHC_TUNE_CTRL_MIN		0
 #define  ESDHC_TUNE_CTRL_MAX		((1 << 7) - 1)
+#define ESDHC_TUNE_CTRL_STATUS_TAP_SEL_PRE_MASK		0x7f000000
+#define ESDHC_TUNE_CTRL_STATUS_TAP_SEL_PRE_SHIFT	24
+#define ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_SHIFT	8
 
 /* strobe dll register */
 #define ESDHC_STROBE_DLL_CTRL		0x70
@@ -234,6 +237,7 @@ struct esdhc_platform_data {
 	unsigned int tuning_step;       /* The delay cell steps in tuning procedure */
 	unsigned int tuning_start_tap;	/* The start delay cell point in tuning procedure */
 	unsigned int strobe_dll_delay_target;	/* The delay cell for strobe pad (read clock) */
+	unsigned int saved_tuning_delay_cell;	/* save the value of tuning delay cell */
 };
 
 struct esdhc_soc_data {
@@ -1055,7 +1059,7 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
-	u32 ctrl;
+	u32 ctrl, tuning_ctrl;
 	int ret;
 
 	/* Reset the tuning circuit */
@@ -1069,6 +1073,17 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
 			writel(0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
 		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
 			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
+
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
@@ -1147,7 +1162,8 @@ static void esdhc_prepare_tuning(struct sdhci_host *host, u32 val)
 	reg |= ESDHC_MIX_CTRL_EXE_TUNE | ESDHC_MIX_CTRL_SMPCLK_SEL |
 			ESDHC_MIX_CTRL_FBCLK_SEL;
 	writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
-	writel(val << 8, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
+	writel(val << ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_SHIFT,
+				host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
 	dev_dbg(mmc_dev(host->mmc),
 		"tuning with delay 0x%x ESDHC_TUNE_CTRL_STATUS 0x%x\n",
 			val, readl(host->ioaddr + ESDHC_TUNE_CTRL_STATUS));
@@ -1555,6 +1571,58 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
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
+	if ((host->timing == MMC_TIMING_UHS_SDR50) |
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
+	if ((host->timing == MMC_TIMING_UHS_SDR50) |
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
@@ -1883,7 +1951,17 @@ static int sdhci_esdhc_suspend(struct device *dev)
 		(host->tuning_mode != SDHCI_TUNING_MODE_1)) {
 		mmc_retune_timer_stop(host->mmc);
 		mmc_retune_needed(host->mmc);
-	}
+
+		/*
+		 * For the SDIO device need to keep power during system PM, and enable
+		 * wakeup, need to save the tuning delay value just in case the retuning
+		 * is hold when SDIO resume, but still need to switch to 4 bit bus width.
+		 */
+		if (host->mmc->sdio_irqs && mmc_card_keep_power(host->mmc) &&
+				(esdhc_is_usdhc(imx_data)))
+			sdhc_esdhc_tuning_save(host);
+
+		}
 
 	if (device_may_wakeup(dev)) {
 		ret = sdhci_enable_irq_wakeups(host);
@@ -1903,6 +1981,8 @@ static int sdhci_esdhc_suspend(struct device *dev)
 static int sdhci_esdhc_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
 	ret = mmc_gpio_set_cd_wake(host->mmc, false);
@@ -1915,6 +1995,14 @@ static int sdhci_esdhc_resume(struct device *dev)
 	if (host->irq_wake_enabled)
 		sdhci_disable_irq_wakeups(host);
 
+	/*
+	 * Restore the saved tuning delay value for the SDIO device
+	 * which enabled wakeup and keep power during system PM.
+	 */
+	if ((imx_data->socdata->flags & ESDHC_FLAG_STATE_LOST_IN_LPMODE) &&
+	    mmc_card_keep_power(host->mmc) && mmc_card_wake_sdio_irq(host->mmc))
+		sdhc_esdhc_tuning_restore(host);
+
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
-- 
2.34.1

