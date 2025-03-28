Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013064.outbound.protection.outlook.com [40.107.162.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DE5145B27;
	Fri, 28 Mar 2025 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743161059; cv=fail; b=aWh2KRtq257Ty87kvCT5GdTI9tFvA/M8A7k50LwDazPrEtziQzdThUTbuxpKSeiB0eJJXMnpRtLgFDKzq+VTQeRMAP0UY/PI4RkkSvASf9kk4a2P512clldDG1alNhLm/R99vW/0KRetwiGGq0J1Ym6YXe71LXQ9scVizAjA9vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743161059; c=relaxed/simple;
	bh=iGaqc5ZN3jcEZ/pci/SsUBYoetgcyuUtvNcPWQbJsOc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=B6eNGtxOPtH8dAQk8z1ybUm/S4v6cwlbjOnDE0xuOoMWvA/fhR5VEWDSKew3XZIa6pLCS+SQT6hXsMfDWrqeI/ML9KwxuUC/VOVhgrktWvoGysb2LM8h2VsVC9WqZJf5cEIditoeghhBhNwkySqj5KcmHGpTsBVikI3j/NkoBPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BZrKIFCe; arc=fail smtp.client-ip=40.107.162.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BZrKIFCe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfCCvGwIQwkkUgrznXveDQ4QookWM/4DV37QPb48tD1zKkQF7hLRXLVkmuhuc2VcgDx0PKn4df4W5vSvJxXNESz7TQkX9alqcQ9yZ0u5ke9T8v9PppHKYEHQhbwIHsBxDrwYI81vyvpLKasrrwPXuqbQkm5zMv4ZM7cdchR1TE4l3lkYcXn9dWCOAlHG5EkT9YYqtXGQxAL8EwGfi1otdqj7aO/yDHI0GEH+JfELsI4YksKakVLsmgP/AivGSlgW8YgnJtKqjkAuL5nMy3J3CEG/ioQ5IN1a6ZHGtmwDc0MoNRFLPoZcsIAU7wp8EXv/FJT+UL2gSRYBZPsALvenEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBU6qFeYZdStbXCNl1ED5QjFnKS8F/0zT3hhI3iTodM=;
 b=emsYxzXAiAJ75z77qP5Fh+svr8Zw3hQ51SJXuuVDbXviaPK/TRHEOp6pgKrc9nO70JbGbSXszllxt8Ntd+0si+DqquWX/3OtzRBbXDPWhtmZ3KWgd2mXzNIx8110x7CFd09aDG4Ru4pxUmTZ1SZsAqS8Nj4NoKX/07OoZXy1oN9uSzs84YAqRlC6WhddCVeVVLh4PsZH+uzE/nPtBV80fgWKSQtcU9Lp/PLFy6RXI0JaqHaN7fS0yZl5kDrBIGQCeOKG4kjgxlGfhP+jbQ+PQJWv/PR6y/WLNdtsxyomw0Q6x0pUsK5TZA3uiXOS4zNtP03pTGFsiNGT5S5G4RiJFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBU6qFeYZdStbXCNl1ED5QjFnKS8F/0zT3hhI3iTodM=;
 b=BZrKIFCeQWVcfvI55pvisdM1UnAAUzJGnJWFzK7WDMcNwo+woxtTl/JtAt0jB2JiwSVbdOPJ8tq4uWOuLfYl3tB4XcVl5hYAzTADlCC+j4QfmyhExvI3rY6O/eoTLDWntBW+iLAtOyB0fdXREToPjOvRkjqT1bV3Wzff2zyntlE5AFzmOjLs76znAT45XE0nVEoim9abU/gmC352AXsn1ezh4TxVTIkYj6hSNHm+lRhQXfTCrWoIbEnf0To4KFS9ky2GYneiAoNukKUtWcwuthjJlWsajJdqcxTaw84gaWVVDhpOpuG0p+we3cdhuqkpwlkRCwZ/ivI6r7W0pJGc/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by PR3PR04MB7435.eurprd04.prod.outlook.com (2603:10a6:102:88::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 11:24:13 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%6]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 11:24:13 +0000
From: ziniu.wang_1@nxp.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	haibo.chen@nxp.com
Cc: frank.li@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mmc: host: sdhci-esdhc-imx: save tuning value for the card which keep power in suspend
Date: Fri, 28 Mar 2025 19:25:17 +0800
Message-Id: <20250328112517.2624806-1-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|PR3PR04MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: a07c80b1-4219-4991-d224-08dd6deb1121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xwjp8JAgHi5+9US46+r3y6k7J1DLjDGP8c06YI8DFUPHQMowJ1I3EtP7mfvA?=
 =?us-ascii?Q?7kDVFXx8DDM8193makNeaDMkNWghVj7FQMwZm1aProyRDkc0AzS7tQXqI8fK?=
 =?us-ascii?Q?vwEtvOA64tpaO2iuOvuIbC6HRvETpnJPtP4bfsf5xX41z9Z81GgXSwjeJenU?=
 =?us-ascii?Q?irk7FMvVPBWBrZ2XoBd9VZL6M/jRPrNcFViJLQqQc0kwHdEFMPGgWlKEVQQZ?=
 =?us-ascii?Q?bzFdZ/a/v8oNnNFUELlqFtFaH5G01QTEIj1fYPXgjYpFetrM9cl2hyEbwDL4?=
 =?us-ascii?Q?/jqzg+N2uDemXryGUjLpRksRnuCk2Me4nCRvHLaao0kOyD1APyY0Fj5KBA60?=
 =?us-ascii?Q?c2H37u8cxB4ORX3YXGszFxxM9THWWwF2t7TjgKtJd0+8rx3Ldvll+lOTHV8/?=
 =?us-ascii?Q?1cPPwXYBffvUlf5y+A98HCXXQ34lDR8sQC/ga4Z9O+3D6QHamKmEvqt9IL7h?=
 =?us-ascii?Q?Mm/vJaRBUoVpphWgz5YdIi3Jz5cxvgPnjMyQV9LCzN+L63PPvofmUToTbJrz?=
 =?us-ascii?Q?JzxVy4gZo87Iu3I0vLWvnIYQAzdChkBqVRGXhLESbd502wJ+fXmmy1uNJkNl?=
 =?us-ascii?Q?KZ1GeHCxIfDLCsxt6xauaQRhZLGbT11U8QzpA1Qflg9CYu2w8LI/QI/arpmk?=
 =?us-ascii?Q?K7YQS+JU3F3uoRw+m9BUW9ZDXsDLD6xUKkKga0CZJNPApKXYYGZv/jdc1QSQ?=
 =?us-ascii?Q?6AvsB4FdU2xz6Oe5HKA4/kmgTk00FRJxQLi4BYpRhbRfbhJCblv2/A2rUaUu?=
 =?us-ascii?Q?7/d3PRweD6i+BSBSahhLeNboE5m7bxlttVtumllORedv9+03fAmi7mFnbnqs?=
 =?us-ascii?Q?WJCShS7fLtKZfzkxDWz6PWeOdK/JEUpDF8DCVO7Ev446mr8hATc/DIs5Q72u?=
 =?us-ascii?Q?V9ywyX/FoGd/1c7r89J1W17+G0HDpMAYKDXFVHQ/5M98czgBSoviJmp6Ztkh?=
 =?us-ascii?Q?8/StZlEyD1AbPKqRBhed9Q5lAUqGiUKbf3mf8iIiGsq8ERCzgEb6ee7tuMTh?=
 =?us-ascii?Q?JM/9H06VcQp1NWFi4yc3jrS61Xuxh/roNl4YWDioCnRD5ifuBzI0obCsfu9g?=
 =?us-ascii?Q?AT3zOkWiG67PUCFSOd4utCsuiAqTHvMtO5C9T4V2VIuBzDpGGRloeNDIYGZP?=
 =?us-ascii?Q?RYNnrC9XAN4JmQmBC60+ITi3dgKWNdIXpOqxcON06wvsxFtFi9nfcd31hpeK?=
 =?us-ascii?Q?tLzptgAP4o0ZckuiQhkysaZ0+1o5SWQXT8c2FgSbtTXmlP8YNd7GE7rXjOwc?=
 =?us-ascii?Q?GdiENhUWVeOtcBBcIYTfaFRTfxn5kGslnyyNXZC0pTB5o9Ot0JOdGpt7wYlD?=
 =?us-ascii?Q?erw8eiAis5pyAp1ETcbQzXsXJ+8nisuVOivJSotIFv4aBkdA3TtS8betZHHZ?=
 =?us-ascii?Q?8tJIObPZvnQv/oYTdqWqz6FtMDaogW6iytABQQzMYjHgnGTxAg7neT36Uq4o?=
 =?us-ascii?Q?SUUNp7rvVO41Hiuy5n9gH8xtrTSwCyVV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8o7/pS+Ci+0xL2DeLdIeI1Z/ALj0k0pSr6MxCIfEbc6e+GCsIa3ShDhfHqko?=
 =?us-ascii?Q?Jbs0SvVxmBlj/VWIxHG/52MbmouoEEAtqyOLj1hPKoquRc2/2JumWVImGgIS?=
 =?us-ascii?Q?yP4dQdGaXdg5CyOzP2bbvB2tWFjOQzFy2d5tXOPUi6tKgwJLCKucGovK7URL?=
 =?us-ascii?Q?5Kto2sqn8Z0EW3NaShK3b5ry8jq8FzHDlitugKitsTPQOtzXDJEQ4A0QBEDE?=
 =?us-ascii?Q?NQrQXXj+x5YYC7LX66A50T2dJUDFbe/8t9kY953UQNT2v0fBzCKFOc7Uc3+4?=
 =?us-ascii?Q?E/zjzQVMu1bQ3mJXHASIXFK+YVxPzDESmFAxZFY3zgsVBMxgo9/rnqYulDEr?=
 =?us-ascii?Q?trvcmjCLel9/5/QSAiz7dsN1COKrZbDP+EF7wbKRuvOfCCmHDjjbSTEgeGQI?=
 =?us-ascii?Q?rbE5p0Mv2ZwP7izgDBi1smlsVwYaDnpIKP1/zuvFuanJjumSE7LiHCGBV/B8?=
 =?us-ascii?Q?U8f2aGLnTWi31I0sCMDqUql8sNX9KmWnzX9ju2YfkIhRCTFhwZmHmKAUK9bs?=
 =?us-ascii?Q?/Rx9DcBLWoR+m5RAdy/TUq/nDDdX19pzBcWeOt57DVG6QaUUEaZpy8CXtVqt?=
 =?us-ascii?Q?yF8sZz34hOPU7SertpEdjAcIbjR2b5Sxjclr6WpxIkpdxtg8G6ckoHaaQX/7?=
 =?us-ascii?Q?GSoHoLxUZvjxh4+cYBF/x90n7Zgcl/raMWFYTJAK4KVepMmoB3DaE46NDMwi?=
 =?us-ascii?Q?/tRuHom7M+KYdoS3toYJy7+/DU6OcPdr2TDQZljGcgnMWl+qEgD7rSLpGIEE?=
 =?us-ascii?Q?RBW73UGdiT5mWdhytfasvFopND8zGGzmyFH7Snx0cZp3wTj9xupy0Y2KGA8U?=
 =?us-ascii?Q?S1d9hkR2kaj1fLFLJtkjUEm1KjWS16WioDY+rcNNNqFMKcbp1JjNsh8tvDzj?=
 =?us-ascii?Q?LZw9MtAOBlQdl6QmqBfH5ZaawBKN4ZGH6sLG4EsrngKRk1g6nPZ0/ugS28rp?=
 =?us-ascii?Q?75ce0pbaqbM+fjFPw7L1kryI8sZwWnI0Y4ozbGdGlzDfwTrda1HPR26fMgZP?=
 =?us-ascii?Q?UJ70O4TwH5TRy2wzkN6Yo0wjC06lKiVBQJzBgXsg2k3CZbgu5c8LlY97RGTa?=
 =?us-ascii?Q?L2TG09zM6odbepH++B/5UOjwx0SEoGn3SmKkqCx30wsn/LH9kZtOqKpq3oU2?=
 =?us-ascii?Q?nQxykDpFs031NyF9Tx8dGEYguhV20eSyGKEh7YZm6kVccTjK3JktGT6aNn8E?=
 =?us-ascii?Q?muqCjI+p5BXib5jcNNpFbV7KJcb2Pmi+EM8i/XXLI0e7Ot3dWoFXhk+SVJkO?=
 =?us-ascii?Q?7Bh4mtGBtH8/lVGiMNoDEDSWcKe9pRovaBi88HDIRB+rtNegvASFYkA2NkII?=
 =?us-ascii?Q?5RTczw2TxbIxHYzV3IVf+agJBnA76pdkquf7UkAguxlaGtI96bCpyw78uknZ?=
 =?us-ascii?Q?tRZo4ykaY5rIhHvZ2nQf7oBvPtnPtm3iKHG/14w7JhdSNdVPpPK8XjbFjo5H?=
 =?us-ascii?Q?LbryEKP51/Pd38agmJTYM/HVExW66TbAHu3bhvUcGrpmf2aYkw22Qs2MJZvw?=
 =?us-ascii?Q?O0HT30kKm/0Y2N3buqxXY2GQXskpCZ3lJ2CRxL2/1ZzpTO5UpB8r/acVZq/n?=
 =?us-ascii?Q?5YFSFibL0E4/fYk/qEuNRltRn6YvV+AfOuHq5zjj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a07c80b1-4219-4991-d224-08dd6deb1121
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 11:24:13.2359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDJCHqr1HmO0uK6ubWw/X3wNwlNulZNJPpEwYPxI7vHcP0pZbkz1m85cOV+UT3pxWCNvUt2KwbVMrwqSkVrebA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7435

From: Luke Wang <ziniu.wang_1@nxp.com>

For SoCs like i.MX6UL(L/Z) and i.MX7D, USDHC powers off completely during
system power management (PM), causing the internal tuning status to be
lost. To address this, save the tuning value when system suspend and
restore it for any command issued after system resume when re-tuning is
held.

A typical case involves SDIO WiFi devices with the MMC_PM_KEEP_POWER and
MMC_PM_WAKE_SDIO_IRQ flag, which retain power during system PM. To
conserve power, WiFi switches to 1-bit mode and restores 4-bit mode upon
resume. As per the specification, tuning commands are not supported in
1-bit mode. When sending CMD52 to restore 4-bit mode, re-tuning must be
held. However, CMD52 still requires a correct sample point to avoid CRC
errors, necessitating preservation of the previous tuning value.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
v1->v2:
 * Used GENMASK/FIELD_GET/FIELD_PREP macro
 * Added check MMC_PM_WAKE_SDIO_IRQ for save/restore tuning value
 * Fixed typo and tune commit message
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 88 +++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index ff78a7c6a04c..7e8addaed697 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -81,6 +81,8 @@
 #define  ESDHC_TUNE_CTRL_STEP		1
 #define  ESDHC_TUNE_CTRL_MIN		0
 #define  ESDHC_TUNE_CTRL_MAX		((1 << 7) - 1)
+#define  ESDHC_TUNE_CTRL_STATUS_TAP_SEL_PRE_MASK	GENMASK(30, 24)
+#define  ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_MASK	GENMASK(14, 8)
 
 /* strobe dll register */
 #define ESDHC_STROBE_DLL_CTRL		0x70
@@ -235,6 +237,7 @@ struct esdhc_platform_data {
 	unsigned int tuning_step;       /* The delay cell steps in tuning procedure */
 	unsigned int tuning_start_tap;	/* The start delay cell point in tuning procedure */
 	unsigned int strobe_dll_delay_target;	/* The delay cell for strobe pad (read clock) */
+	unsigned int saved_tuning_delay_cell;	/* save the value of tuning delay cell */
 };
 
 struct esdhc_soc_data {
@@ -1057,7 +1060,7 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
-	u32 ctrl;
+	u32 ctrl, tuning_ctrl;
 	int ret;
 
 	/* Reset the tuning circuit */
@@ -1071,6 +1074,16 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
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
@@ -1149,7 +1162,8 @@ static void esdhc_prepare_tuning(struct sdhci_host *host, u32 val)
 	reg |= ESDHC_MIX_CTRL_EXE_TUNE | ESDHC_MIX_CTRL_SMPCLK_SEL |
 			ESDHC_MIX_CTRL_FBCLK_SEL;
 	writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
-	writel(val << 8, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
+	writel(FIELD_PREP(ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_MASK, val),
+	       host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
 	dev_dbg(mmc_dev(host->mmc),
 		"tuning with delay 0x%x ESDHC_TUNE_CTRL_STATUS 0x%x\n",
 			val, readl(host->ioaddr + ESDHC_TUNE_CTRL_STATUS));
@@ -1569,6 +1583,57 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
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
+	 * SDR104 mode for SDIO device need to do tuning, and need to
+	 * save/restore.
+	 */
+	if (host->timing == MMC_TIMING_UHS_SDR50 ||
+	    host->timing == MMC_TIMING_UHS_SDR104) {
+		reg = readl(host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
+		reg = FIELD_GET(ESDHC_TUNE_CTRL_STATUS_TAP_SEL_PRE_MASK, reg);
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
+	if (host->timing == MMC_TIMING_UHS_SDR50 ||
+	    host->timing == MMC_TIMING_UHS_SDR104) {
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
+		writel(FIELD_PREP(ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_MASK,
+				  imx_data->boarddata.saved_tuning_delay_cell),
+		       host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
+	}
+}
+
 static void esdhc_cqe_enable(struct mmc_host *mmc)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
@@ -1900,6 +1965,15 @@ static int sdhci_esdhc_suspend(struct device *dev)
 	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
 		mmc_retune_needed(host->mmc);
 
+	/*
+	 * For the device need to keep power during system PM, need
+	 * to save the tuning delay value just in case the usdhc
+	 * lost power during system PM.
+	 */
+	if (mmc_card_keep_power(host->mmc) && mmc_card_wake_sdio_irq(host->mmc) &&
+	    esdhc_is_usdhc(imx_data))
+		sdhc_esdhc_tuning_save(host);
+
 	ret = sdhci_suspend_host(host);
 	if (ret)
 		return ret;
@@ -1916,6 +1990,8 @@ static int sdhci_esdhc_suspend(struct device *dev)
 static int sdhci_esdhc_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
 	ret = pinctrl_pm_select_default_state(dev);
@@ -1929,6 +2005,14 @@ static int sdhci_esdhc_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	/*
+	 * restore the saved tuning delay value for the device which keep
+	 * power during system PM.
+	 */
+	if (mmc_card_keep_power(host->mmc) && mmc_card_wake_sdio_irq(host->mmc) &&
+	    esdhc_is_usdhc(imx_data))
+		sdhc_esdhc_tuning_restore(host);
+
 	if (host->mmc->caps2 & MMC_CAP2_CQE)
 		ret = cqhci_resume(host->mmc);
 
-- 
2.34.1

