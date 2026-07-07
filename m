Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013047.outbound.protection.outlook.com [40.107.162.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1593F6C4F;
	Tue,  7 Jul 2026 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783422035; cv=fail; b=TfeHdYCJ9TKknxAl9+K81looplJWdc6fkQW6njgVtXDfFiPyqpNQsRNOEe1xZvda64OtgGaj+xr1ICf0Wh9DGWC2XaUL3D0LrZxzTqJhgtWRSNTstqH2Rjpfh9LgKO188OxwPPr4AbZhDu8hBkKxWos1kVU6lNOyLzBIEZ9D7q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783422035; c=relaxed/simple;
	bh=2OEDquF6HEXP0sxB0+sQAR8bFLwCWTw51d9L/0BGlEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W56hjgu5DrvCIVa8UVSP0trUBH9yKjzfRFapunZoI2LqE/04mV3CCMPLeLgl9EiozGZjhcYCLiIWiuZvZXSS15MgWhdCWNrufWPLyGp+aNhgwuEmm0L3fTeCNG92nLCPq1fN4qJte/Y2CmsH6/0xL907TU7qjt3IRN8rrBepfgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Ps/Lvsn9; arc=fail smtp.client-ip=40.107.162.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ps/Lvsn9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urdTEn84smi/3y2RKLCB/tVtSN6vwSVsLd0RLnOjL3fXS1wchaohMdvZfYTEMslSlHUkRZwvuj7Gn/18iMyLRp27AoIJT5s0m7LQREDCTeRElZECLZzy99rH+i2/pZO0VwM0m0WzyTCHMx3nM45Vr/V678DlQhbITKvSi/YdsjF/X8zWv5dX/g62SKBsvkl7btvH3MYeRcooplZosM2Ovu/kuyJnpcMueQCyK7Vjpsz9rCkI9rZG8miLbCLbbgvxHxgfEEM/3VjEs/Asg2gkDLpHma7YKC6+4Udb9wl475YDZGQpWCootW5xy6i1se98DnaJOQSduf0KZTQWdamHug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stNNZ0M5tcRj0eiH5J7xatsBtIVCcGsFGE5+YMHUE5s=;
 b=F9jXBtlIHB8hWnzqGQShXZZFJ8w0Cqy1rrvKgQ6PptjIutvzdWRdClTHj0YXGRMemII15iep4XNh5idfy9UfFdkdCLMcWMWs1URT33ruQOE2gPgKTLHwZeNLd0f8MUsb1LxkKZ1GN1LHBU1Bi3OxS/o0czrcJ5XwztcsgKU13gpDV7ccK7jT8hRBO9ypkHlMzla7rK/ZVrdBSNnYKI0sEwnD2lauLIcW22BQCtqDLqrWare2vJ2fV2stcs56jU+vBtqf9uej7L0jXkTED/vd2Jioc8dEAY+kEhMsRdu6/ORqZ8p3kLq6cYEE9aqRTdtTXFH2PFGM+2fLaiKC8Tfh/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stNNZ0M5tcRj0eiH5J7xatsBtIVCcGsFGE5+YMHUE5s=;
 b=Ps/Lvsn9VV7LouXG317n8CT7+Txy3AHl6jsQBzeW8x8BkFDrhLwagIxkQDthWef54W7GO37hmXbPkQB0dVj90So03dy5opYBRC+vg9CEuGxCO5XHakSp79qSTGShtfKsLSpgNd0jA/COVLH7qbV4KlCVeNX0GGZf7WRirR1voY94GHShHzRV+4waNtx8R3R5ohjGyvhyRKRdk6NSZ8dUGuo+Xx5PuustVQW8qEH/sF2DSZo24PMqS/rNo8/10Q+L3rQJuyDdIdThw0yWo3N0lyLCNXBg12LtiF8rO4kXeu6u5h2WQnkZWQ5rTKecjs5xf5qAGQj6X9/pnAgqzRIpzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by PA1PR04MB10673.eurprd04.prod.outlook.com (2603:10a6:102:480::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 11:00:30 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 11:00:30 +0000
From: ziniu.wang_1@oss.nxp.com
To: adrian.hunter@intel.com,
	ulfh@kernel.org,
	haibo.chen@nxp.com,
	Frank.Li@nxp.com
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/8] mmc: sdhci-esdhc-imx: restore DLL override for DDR modes on resume
Date: Tue,  7 Jul 2026 19:02:57 +0800
Message-Id: <20260707110303.3779799-3-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707110303.3779799-1-ziniu.wang_1@oss.nxp.com>
References: <20260707110303.3779799-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::16) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|PA1PR04MB10673:EE_
X-MS-Office365-Filtering-Correlation-Id: 45ebeeed-10c3-4699-9ac1-08dedc16f5f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|23010399003|376014|3023799007|56012099006|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	rd3uzdLZzIGtgQUjJeDhX4tEyweaghl3mS9wwuh4Ea4+h2y+GMrR4Q4a782TCXHUMvFh5TeDMrAPecjJxya5XkPSrmVzIZ0d6YVWa4hOrElABMtsPHSMPYUNKDIyLYNeI+/7eiglBvedAOB8kePid1DwbDgeu9OPHke5ayhP1xAlDmVO+3+5sCcC5QXMzM2wogM0PwKKgsSr8/wLoGlFXh3VFeULWyPNga2HbDviCJIH6UsYmHlxD1Qol2ZZ83057iVC+b8Bs6iYfpllwTUrj9w3DRSQzn+SGosoX4jFZHrVshC9xke9f8JpVlhvJv65KY4iHppTu7jiZ6bRvjqBHqB+buC+fJu5+qdzQY1Tfi7iVLusOBtgvo8iaa6KsXHQ14calIzhtKAwRQDT7DWcbIz38UIKb65KxqhBZXoEoj9Zj8MnmCyYImBhISChMAq0vhKzc9RLGP2NeJ2ntGHDu4A3tD2btpSgrby60KUisWjQWqIjZEOQx66s05KsJvGLJX+BLvoAZg+TABcrQuvhBpPRyZ+RqlRC+aeCXzRy3oum5Fh4ackLIQFeDjne0cOYDqIPewvXDikeGSLX7S8t9nv8Lvv65abGxDihvgg8YAn8AFSzweohfr3MwuF/Iy9XBAPDDfudqE4N485l6mejN08u8dbdu4J47DOSRKKV4Yg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(376014)(3023799007)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cIA73SgIkUGpVsRXIEdZJ6AuTUCL999D9+iZU7gvRQeLID77eGu/mRcA7+7+?=
 =?us-ascii?Q?sAEJYmdwso+buwYpb/NKTRz5TvLrTPSfw/vH1N/EbZ6yvMsUuOf1V5WTLGAj?=
 =?us-ascii?Q?1bLg9pWktMtHCZGjrnc496CsTdbDyOGEXhT3u97c8vE98Bb2J4asGEGrlsEV?=
 =?us-ascii?Q?L61z7Jl4Rt/oa5CdaoUvt3EcrDfkTL/US3Lfsr8i3K1bbXXUUTBWqjZpjw5O?=
 =?us-ascii?Q?LYC4uoNfZHJd7xA9SnrCnltmX5wpLogEqlgcAxqn4gFgMNH9ZhHa4dnfgA0w?=
 =?us-ascii?Q?wEh47g1tYd2xmnEUcXdcvqqNbXL6D0ItWpLO8DE+m4Qe/QoHyQzepmtqhJ+r?=
 =?us-ascii?Q?FmEa9cv5GuEKbIJVp3+1/hYqvl6U9qRLZMUXeHHAr5uABVtgRa6BVcIEukiP?=
 =?us-ascii?Q?NwY/pKZfjQY/NaEyIRr2T0WtC5QOTeP+EJ3a2DV1MiOn5nxEBpjUufBXOSE9?=
 =?us-ascii?Q?Sf+PSxr8g3jwtAAOtErYBUWygjLquoXnkpvwTxJ20iskMshJKx0MSAc+Btru?=
 =?us-ascii?Q?IYDrR+rQnK1qmLaub5RORkWvmBSfdjqPI5Y+FecwMa4m8BM4d4Fbxwdw6bRX?=
 =?us-ascii?Q?RcBNRcmhEehxjkpw00NRzXqeCEoMFmp2WuU3xhl1NOU8ZffbpCaiYO2AhqwH?=
 =?us-ascii?Q?QXHMU6CsggrYkQdtDPs4WUPTWWVo2e4UiXocjN/7CL4q6c641gHiVw7OksZ3?=
 =?us-ascii?Q?MdaJ0yBAy+mzKhnhqaZJx/ggaoOk2zPv0a7X8gWpPH4o5Gr7pR4RwBAfcYhp?=
 =?us-ascii?Q?fmIEKihqhaLjEk3aPbCVaK4EFFgyD9nL/YMhYz5HMBzOTDyIxdfQSdqCESa3?=
 =?us-ascii?Q?nQKoZ3JzvJOqNbvUjWeQ201n1CQbvAMyf1FygEO4cqPPr9hw1cTpH7rA7Cfu?=
 =?us-ascii?Q?26sqVJGJeTZeZDkL69lvKMburiIpdwUx8+Vylmr08tfSOY5LzKvqQnpLwBDX?=
 =?us-ascii?Q?JYw67vj/ED0m/YDErNYAEdAVy1MjPH8CPwqCutFkHXcjohhQat60FdpBH7Rj?=
 =?us-ascii?Q?dUhCprsHZbRtiEJr1H8QTklNnoiax3nejVMbafxJCx1l5JeUfjOmeNQoslu1?=
 =?us-ascii?Q?9Qro73cLdgOk4zi5FgbOB5haSeESpKKBAo54AbUxKsW3BAwEInShyGnIMzga?=
 =?us-ascii?Q?/6Q2MKLeHiaeOBTfFsbMWqU6JMTaxubMUUbgXEQsJjrw1Z7YrxA38D5XX5t/?=
 =?us-ascii?Q?gkg4/fVHOtjqGObHRktLH3dBG0K5zQV3PnGT2WTk/syBWlQ81nadq2dbhthj?=
 =?us-ascii?Q?ACKjEiTDIO8yB2HxDjC+R+eleDu2QNJtW6R8wCljRxZu3iheijJ9lXz8wOCz?=
 =?us-ascii?Q?SmW4NI+6mQhlEoGtmgNpu7mPtRP8O4VBV97xUnCOx1VtZqqrnE9XpgrFD1ES?=
 =?us-ascii?Q?0ydFvcHwkos65RPggkmuRSUyaonJkyJ8ah+q3KhpPZp1xcgXD3L3XovIESwT?=
 =?us-ascii?Q?FnVwvVpk8j3+s/6SbLN0g+6DanmBJGziUtLvj+623FrDLUlR6CHrw/aPCMBx?=
 =?us-ascii?Q?0Vl0ELINr96eqo68YIlDMkPrD+RXa8N0Iv6P3xT0ZM8nxWH3pW9Ele2WaaH+?=
 =?us-ascii?Q?FqkgaDBt1Gi1qXJky4Tjak6MZePL9PowcWrqIeyhGDZc3YV5z5CVQeiRqWxp?=
 =?us-ascii?Q?EyXU3WtMlsNEP+J4zRgIFGKyvPK7Kwtvv511SWotpnDws8hs7PcdY/3n2I9O?=
 =?us-ascii?Q?h5BzNCBdKDiratDWuVXtRQBgnfVLlEBDDVWAgB5tCPOdcBTRTOrTyZ+FLL3z?=
 =?us-ascii?Q?fyisIerosHN3ZV7tHwoMksT534+7hOgz2KUkR+a+USnjaWRRJxds?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ebeeed-10c3-4699-9ac1-08dedc16f5f1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 11:00:30.8042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+CStB7uSKFoiyC8K5r3GKyoIk3JYUKcGgYbl4J1E8fgvKHObAyrMYDNuhJrSCwaR2yQdIHX9IHsblS/S8vuGd71fCbB1HUecq4XHta32hvir/svPoHs55OTa1Gh9Zs6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10673

From: Luke Wang <ziniu.wang_1@nxp.com>

sdhci_esdhc_imx_hwinit() unconditionally clears ESDHC_DLL_CTRL by
writing zero. For SDIO devices that keep power during system suspend
and operate in DDR mode, the card remains in DDR timing while the host
DLL override configuration is lost.

Extract the DLL override setup from esdhc_set_uhs_signaling() into
a helper esdhc_set_dll_override(), and call it on the resume path
when the card kept power and is using a DDR timing mode.

Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 39 +++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 6526d65538de..7230d70e02ae 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1349,6 +1349,23 @@ static int esdhc_change_pinstate(struct sdhci_host *host,
 	return pinctrl_select_state(imx_data->pinctrl, pinctrl);
 }
 
+static void esdhc_set_dll_override(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
+	u32 v;
+
+	if (!boarddata->delay_line)
+		return;
+
+	v = boarddata->delay_line << ESDHC_DLL_OVERRIDE_VAL_SHIFT |
+	    (1 << ESDHC_DLL_OVERRIDE_EN_SHIFT);
+	if (is_imx53_esdhc(imx_data))
+		v <<= 1;
+	writel(v, host->ioaddr + ESDHC_DLL_CTRL);
+}
+
 /*
  * For HS400 eMMC, there is a data_strobe line. This signal is generated
  * by the device and used for data output and CRC status response output
@@ -1404,7 +1421,6 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 	u32 m;
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
-	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
 
 	/* disable ddr mode and disable HS400 mode */
 	m = readl(host->ioaddr + ESDHC_MIX_CTRL);
@@ -1425,15 +1441,7 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 		m |= ESDHC_MIX_CTRL_DDREN;
 		writel(m, host->ioaddr + ESDHC_MIX_CTRL);
 		imx_data->is_ddr = 1;
-		if (boarddata->delay_line) {
-			u32 v;
-			v = boarddata->delay_line <<
-				ESDHC_DLL_OVERRIDE_VAL_SHIFT |
-				(1 << ESDHC_DLL_OVERRIDE_EN_SHIFT);
-			if (is_imx53_esdhc(imx_data))
-				v <<= 1;
-			writel(v, host->ioaddr + ESDHC_DLL_CTRL);
-		}
+		esdhc_set_dll_override(host);
 		break;
 	case MMC_TIMING_MMC_HS400:
 		m |= ESDHC_MIX_CTRL_DDREN | ESDHC_MIX_CTRL_HS400_EN;
@@ -2123,9 +2131,18 @@ static int sdhci_esdhc_resume(struct device *dev)
 	 * restore the saved tuning delay value for the device which keep
 	 * power during system PM.
 	 */
-	if (mmc_card_keep_power(host->mmc) && esdhc_is_usdhc(imx_data))
+	if (mmc_card_keep_power(host->mmc) && esdhc_is_usdhc(imx_data)) {
 		sdhc_esdhc_tuning_restore(host);
 
+		/*
+		 * Restore DLL override for DDR modes. hwinit unconditionally
+		 * clears ESDHC_DLL_CTRL, but the card is still in DDR mode.
+		 */
+		if (host->timing == MMC_TIMING_UHS_DDR50 ||
+		    host->timing == MMC_TIMING_MMC_DDR52)
+			esdhc_set_dll_override(host);
+	}
+
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
-- 
2.34.1

