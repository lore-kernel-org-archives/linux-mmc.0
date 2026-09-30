Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2098.outbound.protection.partner.outlook.cn [139.219.17.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B227483BEE;
	Wed, 30 Sep 2026 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764410; cv=fail; b=jZN2LmoQ9JpFAy32Wkdqu6Dzt91z2BtQfy+QSO2BjqmgB9tmKBJ6nfglLI/TE4SsVNA/iG9pBYmiROqRgdQY3CJWpQ+JdJTD6iH+N7kUO5LtRmIaA0tiFnISyqh3MEC7OOJMTN2Kt/pzBJnq90ZWJtmQwJnlY0ncx2JP8DLD0ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764410; c=relaxed/simple;
	bh=hAohkShN9bf2/l3RD29N2DV0/qkkKszShN/EYNgw6Io=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZUtHLGMxscbCFo/M8hoogH5sV5XWlnhnphXbJqUUv9N9sSmi8u0VcYfg8jmvP10euusdRPYS9daRh3oerRTjFfIdyxwYKROHFY9hY76Uo0Rm1SaRY6el2HFMEKLVZUbU6fN8jA+u/9t0SSf65QjJYWhZSBT4Jhqp6QXQ/R/jKzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNATLpFNnc1aOSj8sGZDTUUCz75wjdA0pBE8ChlhBNDwzR9U8BrSQ75dQ3b+lsJFyOeS68+6aGupwwVqXHVBuzPryk+aKuc3uNeOeIv6Xsxu4bh7yU87OBHGIVqehjrpBsYpQx4CFNVVFVJxqs0oho9/zsVIgbw6sxxodkRW8lrFcrxkxjQAyZVw0AxPmPWZqBJLWpgl5pBNfIhSMDkqHrStz1ToFcTh9aR89GW55EdFH2gSSNZTYi41Rg6F7c5AAYUfh4d2L0cFprsRNlVveEjgLVkeeRFbbb4zmP7US3yDfVK+SkP6SP2mGUfyz9JOhJzpTO4WDFPouI9jeVISVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PXzClnPH0lYA8zOsoRPsYeiP3suk0fk+5XGVywoqa8=;
 b=geITuEeHDjACeVrK8tVogiWaEvjXO245CrgV8Mcp1WOr7NhEv0jvQsatvFEmFZ3M6DgZL3c/NJ89w9H3g9iqX7GHh8c+uFMB0xlhXDuzPfrKZttVH5iIKHAmtfkIyDesl7QPXwnXiE5tlr0maWUZQV1Wuyoa2BpgsdjfL7ZlMXRmntE7mtOd4IKF4idKmRIfw5HgP2rJ/+RhdHSDZ7M5bSFVQLsv9mSlxRoPJRS8+3fsMZLvD+r2U4v+hhItOZtJcBL0OJauvzgvcbXlMYFfhQl0BOEFKekZ50vJZ09penPlE234vywVX58zgGlu54+nnz9mtQAIxoBPX4rqw2Ss6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1138.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 10:33:11 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.026; Wed, 30 Sep 2026 10:33:11 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Chen Wang <chen.wang@linux.dev>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v2 2/2] mmc: sdhci-of-dwcmshc: Add support for StarFive JHB100
Date: Wed, 30 Sep 2026 03:32:58 -0700
Message-Id: <20260930103258.13375-3-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260930103258.13375-1-changhuang.liang@starfivetech.com>
References: <20260930103258.13375-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::29) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1138:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c49235f-2715-40d5-3068-08df1ede39ee
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|52116014|18002099003|22082099003|38350700014|6133799003|10067099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	SJ6TY60J6pdISuIbOWQVfXmOUyZvEctZd+KBTsRXSSNL9cBJR36pg9b1Pi6B68UwdA1DkXr0eJLJ5Ap4nfqZJ6/WuIm2BZDafCoBi88jQLnz0FnXaEDD+SOnTr5Updr86AQKyeBGB6aHH2CHAsYg7Wc55QYKITcblfmse405jZq22Tb30Q2GiAbCGtHzctNmAHh+hRdPUyxvtCEgFPTv5a2oWTXJxZCD6ouH6/1jPjEW/jUcvD7QfJsWoAO/BtP5bNslBsQvDuAo2ArD2ixddr0Jt/kIxISHwCBx6IIPo3CJfq1BTC0RIlYZ1iGCUk7gcbL7nA+acpZcWDVmzrGyHH0eihY9i4BVVIqh1F499sH+zb+nNWCKkWww+MGOhbR0JlgeZX+m7NE5N4o87PPdjPDEpCVf7iXNxYwP8bkgJ46JQM9L2Hkzq4jGtINFHrFmxPwMzM6A8kWUDE23iBOI/wdZ9Vva9G2m6AU9UZnlrJqIjhfVCguS7Xjpv6gaOB2ZZ3RXabcE9Pyp4ZC4OYtuDDU7j98QfjxaN6Rd1Ibq7M+2JlavKCDEqD1ac6O1cir/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(52116014)(18002099003)(22082099003)(38350700014)(6133799003)(10067099003)(56012099006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/ndxtXTUNXHv6V3QIIOl9uVxvGzs+D5q0IVEyAWGXHiivzODG3CsWh307ICm?=
 =?us-ascii?Q?qznLI/lnMwjx7NggiHfu/XwMdiPISCWaOB0qzF+EZjGYD9gNut6BH81S1xfm?=
 =?us-ascii?Q?SirqcRAeo2qV+I41A2S22gzd59C5dTdjSl8qsba2ndzhzZ8yfQSbN8APrSmj?=
 =?us-ascii?Q?jioZebbzG8bWDviIkX68Cm32RdILik9D5EsYTSIEeTM2MTDeP39xfw4SlJXU?=
 =?us-ascii?Q?jmUXMFpIbU/F5x0dsnO/yT3KNjv7KuVHWPnl7RlxXA9pw7Qdw2Jo0Ga8wzAD?=
 =?us-ascii?Q?uQLBZbITyQew3X8KR9PpX93fdFe1kXeDGvGfVwYGt7rL8VM0uwKn5h4fJdst?=
 =?us-ascii?Q?VpIQBPGPjHXq+4d9J7g02J1fK8LG+V8ugHQZ0StPcjmV/TXRUTG2uDfV7rJ9?=
 =?us-ascii?Q?z5bJtOa2qY35TCievYFllYezJGBXE2zWwZEkouaLaSCZUqQ5e1p08C5vpMzj?=
 =?us-ascii?Q?8LQjLXV2Zyb5s6KtLmLsvMcyGYeqeycj8bxixkDjunzx0q1Zqk1q+pA7k87L?=
 =?us-ascii?Q?Nw1JDZoHlbztCMu1DPOs66YCeySMy4efRxkkdKmq+5GZWWrjBzXMJ1GIGi7b?=
 =?us-ascii?Q?esit4DFijJMupaQ79Tdv807fKrztMHYfh4MJsYk8Rlgc5whXBVTXPP4VWge3?=
 =?us-ascii?Q?7gfK7xNt7RE4S2OEQtjMU+cDq24gO766c4MK12duy8DZ3ogRmfr7aakmwgZE?=
 =?us-ascii?Q?PoaEsJm3IpPqU7S6538y5ysw8nkOW95RlUZkWiTpFOD1yoWYq8sbvw1Wy4Fj?=
 =?us-ascii?Q?GhVoTwIF1+QtIowqYlOfzpUhOQP3w1Lh7NCMinsGG8Vi1gAEFej7yX6RwXEU?=
 =?us-ascii?Q?tQQlDb0kbsn/bIQmtMQgH+EaqlrUx+qAdnOpXQClwyNnwFckXL7XikCmMdX5?=
 =?us-ascii?Q?mIjca3+XRYuZ50h/DfCdf6sDP/6czoJJfVVo4csqf938pXktVbm3nNTLkDmO?=
 =?us-ascii?Q?IxTz/DGsQHMnjCLnPhbpex8JpSQxJAUyvXeRZ4OZsp4e8jdGB6IHnY41+sNt?=
 =?us-ascii?Q?eWLI7vWavJLx20N8gYq41qF/RGQEvi8ZAFbcxWi54VT625XOgxBp49DysJkb?=
 =?us-ascii?Q?QrSaAI+lSFHfHZurKVzq09hb/D59/+EDBwTwHE0e4007Z7HYQujMFVUGYswz?=
 =?us-ascii?Q?FSsqjqbAUTx6AmcnPWclFzQJM1WMY9QpBruVD2Nm0Sd6Cfu4xr8zVFMb6e4E?=
 =?us-ascii?Q?2jYRhvTuU1XYVlvGx3Xw3D0WooveOFGjREiBgIBSI5KT9UAiND0rWMXUxPgl?=
 =?us-ascii?Q?WVkEdDX5Er7t+HY2EJCqvugDjaJt4aWN/VVo9nfCbw4F7+mpj/y6HwdcJi16?=
 =?us-ascii?Q?32X6cLIgJlxjPF8y7e7zk+1tm7dPVXOmro7tPvwTo8o8FRem91cbXAXrfM4K?=
 =?us-ascii?Q?RVyyHG8lIX9YzkC5KjL16ErBg4CbR0OPoUI12ACzyZOuOQnDxFkHk9PcFqIP?=
 =?us-ascii?Q?8IOcx32oMaVf1/JzNohXgrbzlD7+WZTVid+TH2dip8M6ic1yBBb6UfaawwCa?=
 =?us-ascii?Q?4Znwf8jk5PeJQRaLVEBAAgq6ch1ibIrYFZO/h4kl161lOCSPk9sP2rCS6g2M?=
 =?us-ascii?Q?QhWRXMVpnWnq57W7ui4RL4GLRrCm4nWyUJ882pQgOUiPcTHpFDziTgqepdZ6?=
 =?us-ascii?Q?9SrA6xWD9Hh6Cf2kRFNsQHh4Pu1//wRp9DLOdOGmfD5pR/thOv9vAo4mFw9w?=
 =?us-ascii?Q?+/4+IklS0LCO59d1MP2XzS9yYR5h6rE/kS9tFlqa8Pma3tYOM8N5zEjzVaJL?=
 =?us-ascii?Q?h80LbBN6OEGAK8NmyjpkoKDbOCUiiTwr5vpeX+8VoRLKL0w/sYtH?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c49235f-2715-40d5-3068-08df1ede39ee
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:33:11.4281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUwrDDJBCTY/7m7cCIWtdAIxQU+9E4gfYnARp6Y+hdcyhb7++AY5cLCRjakqbpsmFAyOqHc2atfqKHoGVJgRvZ917CCFS3p5My1sdr8KEnGq09u4csRw3RC/nPU/Vf5H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1138

Add support for the DWCMSHC controller found on the StarFive JHB100
SoC.

The JHB100 CMSHC controller only drives 32 DMA address bits. The higher
DMA address bits [35:32] are supplied by the PER1 SYSCON, so the DMA
mask is set to 36 bits to describe this hardware capability. Fix these
bits to 4, which limits the DMA range to [0x400000000 - 0x4ffffffff].
The dma-ranges of the parent bus are expected to restrict DMA to this
window, so that any address outside of it fails to map instead of
being passed to the hardware.

The cclk_tx clock must be disabled before sdhci_set_clock() to
eliminate glitches, and re-enabled afterwards unless the card clock is
turned off, so that cclk_tx stays gated during suspend. The 15us delay
after disabling cclk_tx is a JHB100 specific requirement from the SoC
simulation. cclk_tx is enabled during probe and disabled in the
platform deinit callback, which is invoked from dwcmshc_remove().

Additionally, clear the PHY_DLLDL_CNFG_R register and re-initialize
the PHY when setting UHS signaling, and force 1.8V fixed I/O when the
DT specifies a DDR/HS200/HS400 1.8V mode.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 169 ++++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 1baa2379c9c3..249055f14162 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -48,6 +48,9 @@
 #define DWCMSHC_ENHANCED_STROBE		BIT(8)
 #define DWCMSHC_EMMC_ATCTRL		0x40
 #define DWCMSHC_AT_STAT			0x44
+/* StarFive JHB100 SoC MSHCCS register */
+#define DWCMSHC_ARWADDR			GENMASK(3, 0)
+#define DWCMSHC_ARWADDR_DEFAULT		4
 /* Tuning and auto-tuning fields in AT_CTRL_R control register */
 #define AT_CTRL_AT_EN			BIT(0) /* autotuning is enabled */
 #define AT_CTRL_CI_SEL			BIT(1) /* interval to drive center phase select */
@@ -184,6 +187,7 @@
 #define PHY_SDCLKDL_DC_INITIAL		0x40 /* initial delay code */
 #define PHY_SDCLKDL_DC_DEFAULT		0x32 /* default delay code */
 #define PHY_SDCLKDL_DC_HS400		0x18 /* delay code for HS400 mode */
+#define PHY_SDCLKDL_DC_JHB100		0x10 /* delay code for StarFive JHB100 */
 
 #define PHY_SMPLDL_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x20)
 #define PHY_SMPLDL_CNFG_EXTDLY_EN	BIT(0)
@@ -294,6 +298,11 @@ struct k230_priv  {
 	struct regmap *hi_sys_regmap;
 };
 
+struct jhb100_priv {
+	struct clk *cclk_tx;
+	bool cclk_tx_on;
+};
+
 #define DWCMSHC_MAX_OTHER_CLKS 3
 
 struct dwcmshc_priv {
@@ -314,6 +323,7 @@ struct dwcmshc_pltfm_data {
 	const struct sdhci_pltfm_data pdata;
 	const struct cqhci_host_ops *cqhci_host_ops;
 	int (*init)(struct device *dev, struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
+	void (*deinit)(struct dwcmshc_priv *dwc_priv);
 	void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
 };
 
@@ -2257,6 +2267,155 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_hpe_gsc_pdata = {
 	.init = dwcmshc_hpe_gsc_init,
 };
 
+static int sdhci_jhb100_set_dma_mask(struct sdhci_host *host)
+{
+	struct mmc_host *mmc = host->mmc;
+	struct device *dev = mmc_dev(mmc);
+	int ret;
+
+	/*
+	 * The StarFive JHB100's CMSHC controller only drives 32 DMA address
+	 * bits, the higher DMA address bits [35:32] are supplied by the
+	 * ARWADDR field in the PER1 SYSCON. The 36-bit mask describes this
+	 * hardware capability. As ARWADDR is fixed to 4, the controller can
+	 * only reach [0x400000000 - 0x4ffffffff]. The dma-ranges of the
+	 * parent bus must restrict DMA to this window, so that any address
+	 * outside of it fails to map and is never passed to the hardware.
+	 */
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(36));
+	if (ret)
+		dev_err(dev, "Failed to set 36-bit DMA mask.\n");
+
+	return ret;
+}
+
+static void sdhci_jhb100_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
+	struct jhb100_priv *priv = dwc_priv->priv;
+
+	/*
+	 * The cclk_tx clock is disabled before sdhci_set_clock(), and then a
+	 * 15us delay is required, This delay is determined by SoC simulation
+	 * and is a special requirement on JHB100 SoC, mainly used to eliminate
+	 * glitches caused by frequency switching.
+	 */
+	if (priv->cclk_tx_on) {
+		clk_disable_unprepare(priv->cclk_tx);
+		priv->cclk_tx_on = false;
+		fsleep(15);
+	}
+
+	sdhci_set_clock(host, clock);
+
+	/* keep cclk_tx gated while the card clock is off, e.g. during suspend */
+	if (!clock)
+		return;
+
+	if (clk_prepare_enable(priv->cclk_tx))
+		dev_err(mmc_dev(host->mmc), "failed to re-enable cclk_tx\n");
+	else
+		priv->cclk_tx_on = true;
+}
+
+static void sdhci_jhb100_set_uhs_signaling(struct sdhci_host *host,
+					   unsigned int timing)
+{
+	dwcmshc_set_uhs_signaling(host, timing);
+	sdhci_writeb(host, 0, PHY_DLLDL_CNFG_R);
+	th1520_sdhci_set_phy(host);
+}
+
+static const struct sdhci_ops starfive_jhb100_ops = {
+	.set_dma_mask		= sdhci_jhb100_set_dma_mask,
+	.set_clock		= sdhci_jhb100_set_clock,
+	.set_uhs_signaling	= sdhci_jhb100_set_uhs_signaling,
+	.set_bus_width		= sdhci_set_bus_width,
+	.reset			= dwcmshc_reset,
+	.get_max_clock		= dwcmshc_get_max_clock,
+	.adma_write_desc	= dwcmshc_adma_write_desc,
+	.irq			= dwcmshc_cqe_irq_handler,
+	.voltage_switch		= dwcmshc_phy_init,
+	.platform_execute_tuning = th1520_execute_tuning,
+};
+
+static int dwcmshc_starfive_jhb100_init(struct device *dev, struct sdhci_host *host,
+					struct dwcmshc_priv *dwc_priv)
+{
+	struct reset_control *reset;
+	struct jhb100_priv *priv;
+	unsigned int reg_offset;
+	struct regmap *syscon;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(struct jhb100_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	syscon = syscon_regmap_lookup_by_phandle_args(dev->of_node,
+						      "starfive,jhb100-per1-syscon",
+						      1, &reg_offset);
+	if (IS_ERR(syscon))
+		return PTR_ERR(syscon);
+
+	/* configure the higher DMA address bits [35:32] */
+	ret = regmap_update_bits(syscon, reg_offset, DWCMSHC_ARWADDR,
+				 DWCMSHC_ARWADDR_DEFAULT);
+	if (ret)
+		return ret;
+
+	reset = devm_reset_control_get_exclusive_deasserted(mmc_dev(host->mmc), NULL);
+	if (IS_ERR(reset))
+		return dev_err_probe(mmc_dev(host->mmc), PTR_ERR(reset),
+				     "Failed to get&deassert reset control\n");
+
+	priv->cclk_tx = devm_clk_get(dev, "cclk_tx");
+	if (IS_ERR(priv->cclk_tx))
+		return dev_err_probe(dev, PTR_ERR(priv->cclk_tx),
+				     "Failed to get cclk_tx clock\n");
+
+	ret = clk_prepare_enable(priv->cclk_tx);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable cclk_tx clock\n");
+
+	priv->cclk_tx_on = true;
+
+	if (host->mmc->caps & MMC_CAP_1_8V_DDR ||
+	    host->mmc->caps2 & (MMC_CAP2_HS400_1_8V | MMC_CAP2_HS200_1_8V_SDR))
+		dwc_priv->flags |= FLAG_IO_FIXED_1V8;
+	else
+		dwc_priv->flags &= ~FLAG_IO_FIXED_1V8;
+
+	dwc_priv->delay_line = PHY_SDCLKDL_DC_JHB100;
+	dwc_priv->priv = priv;
+
+	if (dwc_priv->flags & FLAG_IO_FIXED_1V8) {
+		host->flags &= ~SDHCI_SIGNALING_330;
+		host->flags |=  SDHCI_SIGNALING_180;
+	}
+
+	return 0;
+}
+
+static void dwcmshc_starfive_jhb100_deinit(struct dwcmshc_priv *dwc_priv)
+{
+	struct jhb100_priv *priv = dwc_priv->priv;
+
+	if (priv->cclk_tx_on)
+		clk_disable_unprepare(priv->cclk_tx);
+}
+
+static const struct dwcmshc_pltfm_data sdhci_dwcmshc_jhb100_pdata = {
+	.pdata = {
+		.ops = &starfive_jhb100_ops,
+		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	},
+	.init = dwcmshc_starfive_jhb100_init,
+	.deinit = dwcmshc_starfive_jhb100_deinit,
+};
+
 static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
 	.enable		= dwcmshc_sdhci_cqe_enable,
 	.disable	= sdhci_cqe_disable,
@@ -2377,6 +2536,10 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
 		.compatible = "hpe,gsc-dwcmshc",
 		.data = &sdhci_dwcmshc_hpe_gsc_pdata,
 	},
+	{
+		.compatible = "starfive,jhb100-dwcmshc",
+		.data = &sdhci_dwcmshc_jhb100_pdata,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
@@ -2503,6 +2666,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
 err_rpm:
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
+	if (pltfm_data->deinit)
+		pltfm_data->deinit(priv);
 err_bus_clk:
 	clk_disable_unprepare(priv->bus_clk);
 err_clk:
@@ -2527,6 +2692,7 @@ static void dwcmshc_remove(struct platform_device *pdev)
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	const struct dwcmshc_pltfm_data *pltfm_data = priv->dwcmshc_pdata;
 
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -2534,6 +2700,9 @@ static void dwcmshc_remove(struct platform_device *pdev)
 
 	sdhci_remove_host(host, 0);
 
+	if (pltfm_data->deinit)
+		pltfm_data->deinit(priv);
+
 	dwcmshc_disable_card_clk(host);
 
 	clk_disable_unprepare(pltfm_host->clk);
-- 
2.25.1

