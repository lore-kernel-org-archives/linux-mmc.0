Return-Path: <SRS0=LLi2=7I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E49C433E1
	for <linux-mmc@archiver.kernel.org>; Tue, 26 May 2020 06:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11D0420888
	for <linux-mmc@archiver.kernel.org>; Tue, 26 May 2020 06:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbgEZG3c (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 May 2020 02:29:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:47652 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbgEZG3c (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 26 May 2020 02:29:32 -0400
IronPort-SDR: KQbwUuAHUjGf3+IaDLbw5+VhfrxLIf2TfZTjexsIp1MwJrc2YZq13uTiGTHs9fV36gBb/oLDa+
 813/3ZrioInQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 23:29:31 -0700
IronPort-SDR: JMy9buBLiZUTdS0oYacjYseUsdvvtpgH1EWC18gJyw+1klraq93SxdvDgquVD1KY+b1+0ucrOv
 EwzBHhqZmewg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,436,1583222400"; 
   d="scan'208";a="255301194"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga007.jf.intel.com with ESMTP; 25 May 2020 23:29:29 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        adrian.hunter@intel.com, michal.simek@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v2 2/3] mmc: sdhci-of-arasan: Add support for Intel Keem Bay
Date:   Tue, 26 May 2020 14:27:57 +0800
Message-Id: <20200526062758.17642-3-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526062758.17642-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200526062758.17642-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Intel Keem Bay SoC eMMC/SD/SDIO controller is based on
Arasan SD 3.0 / eMMC 5.1 host controller IP.

However, it does not support 64-bit access as its AXI interface
has 32-bit address ports.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 123 +++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 2fe2c4dcc280..db9b544465cd 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -75,6 +75,7 @@ struct sdhci_arasan_soc_ctl_field {
  *
  * @baseclkfreq:	Where to find corecfg_baseclkfreq
  * @clockmultiplier:	Where to find corecfg_clockmultiplier
+ * @support64b:		Where to find SUPPORT64B bit
  * @hiword_update:	If true, use HIWORD_UPDATE to access the syscon
  *
  * It's up to the licensee of the Arsan IP block to make these available
@@ -84,6 +85,7 @@ struct sdhci_arasan_soc_ctl_field {
 struct sdhci_arasan_soc_ctl_map {
 	struct sdhci_arasan_soc_ctl_field	baseclkfreq;
 	struct sdhci_arasan_soc_ctl_field	clockmultiplier;
+	struct sdhci_arasan_soc_ctl_field	support64b;
 	bool					hiword_update;
 };
 
@@ -180,6 +182,13 @@ static const struct sdhci_arasan_soc_ctl_map intel_lgm_sdxc_soc_ctl_map = {
 	.hiword_update = false,
 };
 
+static const struct sdhci_arasan_soc_ctl_map intel_keembay_soc_ctl_map = {
+	.baseclkfreq = { .reg = 0x0, .width = 8, .shift = 14 },
+	.clockmultiplier = { .reg = 0x4, .width = 8, .shift = 14 },
+	.support64b = { .reg = 0x4, .width = 1, .shift = 24 },
+	.hiword_update = false,
+};
+
 /**
  * sdhci_arasan_syscon_write - Write to a field in soc_ctl registers
  *
@@ -1095,6 +1104,50 @@ static struct sdhci_arasan_of_data sdhci_arasan_generic_data = {
 	.clk_ops = &arasan_clk_ops,
 };
 
+static const struct sdhci_pltfm_data sdhci_keembay_emmc_pdata = {
+	.ops = &sdhci_arasan_cqe_ops,
+	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+		SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
+		SDHCI_QUIRK_NO_LED |
+		SDHCI_QUIRK_32BIT_DMA_ADDR |
+		SDHCI_QUIRK_32BIT_DMA_SIZE |
+		SDHCI_QUIRK_32BIT_ADMA_SIZE,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
+		SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400 |
+		SDHCI_QUIRK2_STOP_WITH_TC |
+		SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
+};
+
+static const struct sdhci_pltfm_data sdhci_keembay_sd_pdata = {
+	.ops = &sdhci_arasan_ops,
+	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+		SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
+		SDHCI_QUIRK_NO_LED |
+		SDHCI_QUIRK_32BIT_DMA_ADDR |
+		SDHCI_QUIRK_32BIT_DMA_SIZE |
+		SDHCI_QUIRK_32BIT_ADMA_SIZE,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
+		SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON |
+		SDHCI_QUIRK2_STOP_WITH_TC |
+		SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
+};
+
+static const struct sdhci_pltfm_data sdhci_keembay_sdio_pdata = {
+	.ops = &sdhci_arasan_ops,
+	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+		SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
+		SDHCI_QUIRK_NO_LED |
+		SDHCI_QUIRK_32BIT_DMA_ADDR |
+		SDHCI_QUIRK_32BIT_DMA_SIZE |
+		SDHCI_QUIRK_32BIT_ADMA_SIZE,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
+		SDHCI_QUIRK2_HOST_OFF_CARD_ON |
+		SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
+};
+
 static struct sdhci_arasan_of_data sdhci_arasan_rk3399_data = {
 	.soc_ctl_map = &rk3399_soc_ctl_map,
 	.pdata = &sdhci_arasan_cqe_pdata,
@@ -1140,6 +1193,21 @@ static struct sdhci_arasan_of_data sdhci_arasan_versal_data = {
 	.clk_ops = &versal_clk_ops,
 };
 
+static struct sdhci_arasan_of_data intel_keembay_emmc_data = {
+	.soc_ctl_map = &intel_keembay_soc_ctl_map,
+	.pdata = &sdhci_keembay_emmc_pdata,
+};
+
+static struct sdhci_arasan_of_data intel_keembay_sd_data = {
+	.soc_ctl_map = &intel_keembay_soc_ctl_map,
+	.pdata = &sdhci_keembay_sd_pdata,
+};
+
+static struct sdhci_arasan_of_data intel_keembay_sdio_data = {
+	.soc_ctl_map = &intel_keembay_soc_ctl_map,
+	.pdata = &sdhci_keembay_sdio_pdata,
+};
+
 static const struct of_device_id sdhci_arasan_of_match[] = {
 	/* SoC-specific compatible strings w/ soc_ctl_map */
 	{
@@ -1154,6 +1222,18 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
 		.compatible = "intel,lgm-sdhci-5.1-sdxc",
 		.data = &intel_lgm_sdxc_data,
 	},
+	{
+		.compatible = "intel,keembay-sdhci-5.1-emmc",
+		.data = &intel_keembay_emmc_data,
+	},
+	{
+		.compatible = "intel,keembay-sdhci-5.1-sd",
+		.data = &intel_keembay_sd_data,
+	},
+	{
+		.compatible = "intel,keembay-sdhci-5.1-sdio",
+		.data = &intel_keembay_sdio_data,
+	},
 	/* Generic compatible below here */
 	{
 		.compatible = "arasan,sdhci-8.9a",
@@ -1297,6 +1377,40 @@ static void sdhci_arasan_unregister_sdclk(struct device *dev)
 	of_clk_del_provider(dev->of_node);
 }
 
+/**
+ * sdhci_arasan_update_support64b - Set SUPPORT_64B (64-bit System Bus Support)
+ *
+ * This should be set based on the System Address Bus.
+ * 0: the Core supports only 32-bit System Address Bus.
+ * 1: the Core supports 64-bit System Address Bus.
+ *
+ * NOTES:
+ * - For Keem Bay, it is required to clear this bit. Its default value is 1'b1.
+ *   Keem Bay does not support 64-bit access.
+ *
+ * @host		The sdhci_host
+ */
+static void sdhci_arasan_update_support64b(struct sdhci_host *host, u32 value)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map =
+		sdhci_arasan->soc_ctl_map;
+
+	/* Having a map is optional */
+	if (!soc_ctl_map)
+		return;
+
+	/* If we have a map, we expect to have a syscon */
+	if (!sdhci_arasan->soc_ctl_base) {
+		pr_warn("%s: Have regmap, but no soc-ctl-syscon\n",
+			mmc_hostname(host->mmc));
+		return;
+	}
+
+	sdhci_arasan_syscon_write(host, &soc_ctl_map->support64b, value);
+}
+
 /**
  * sdhci_arasan_register_sdclk - Register the sdcardclk for a PHY to use
  *
@@ -1469,6 +1583,15 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 				    "rockchip,rk3399-sdhci-5.1"))
 		sdhci_arasan_update_clockmultiplier(host, 0x0);
 
+	if (of_device_is_compatible(np, "intel,keembay-sdhci-5.1-emmc") ||
+	    of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sd") ||
+	    of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sdio")) {
+		sdhci_arasan_update_clockmultiplier(host, 0x0);
+		sdhci_arasan_update_support64b(host, 0x0);
+
+		host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
+	}
+
 	sdhci_arasan_update_baseclkfreq(host);
 
 	ret = sdhci_arasan_register_sdclk(sdhci_arasan, clk_xin, &pdev->dev);
-- 
2.17.1

