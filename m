Return-Path: <SRS0=0j+4=CX=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04276C43461
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Sep 2020 05:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0E23214F1
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Sep 2020 05:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgINFPP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 14 Sep 2020 01:15:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:57559 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbgINFPF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 14 Sep 2020 01:15:05 -0400
IronPort-SDR: rxlcdfKVmp0mvLaz3hdEcg1ChM8sW5wiUIE3btVMsc3OIKI2M2uEkaX3aNXFqGzhRHzVnGvMTX
 EyY+E2ErD93A==
X-IronPort-AV: E=McAfee;i="6000,8403,9743"; a="156468456"
X-IronPort-AV: E=Sophos;i="5.76,424,1592895600"; 
   d="scan'208";a="156468456"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2020 22:15:04 -0700
IronPort-SDR: frHF+jSJnimuf5NPQhx+GIwwSstc9kPe7amjN4xJhaKzHG9xNz3i4mVMRJ0sY9/QvARvy56gBj
 pJ7Ry4kHrQsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,424,1592895600"; 
   d="scan'208";a="338162217"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by fmsmga002.fm.intel.com with ESMTP; 13 Sep 2020 22:15:02 -0700
From:   muhammad.husaini.zulkifli@intel.com
To:     adrian.hunter@intel.com, michal.simek@xilinx.com,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     lakshmi.bai.raja.subramanian@intel.com
Subject: [PATCH v1 1/1] mmc: sdhci-of-arasan: Enable UHS-1 support for Keem Bay SOC
Date:   Mon, 14 Sep 2020 13:12:14 +0800
Message-Id: <20200914051214.13918-2-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914051214.13918-1-muhammad.husaini.zulkifli@intel.com>
References: <20200914051214.13918-1-muhammad.husaini.zulkifli@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

Voltage switching sequence is needed to support UHS-1 interface
as Keem Bay EVM is using external voltage regulator to switch between
1.8V and 3.3V.

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 140 +++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index f186fbd016b1..c133408d0c74 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -16,7 +16,9 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mfd/syscon.h>
+#include <linux/arm-smccc.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/phy/phy.h>
@@ -41,6 +43,11 @@
 #define SDHCI_ITAPDLY_ENABLE		0x100
 #define SDHCI_OTAPDLY_ENABLE		0x40
 
+/* Setting for Keem Bay IO Pad 1.8 Voltage Selection */
+#define KEEMBAY_AON_SIP_FUNC_ID		0x8200ff26
+#define KEEMBAY_AON_SET_1V8_VOLT	0x01
+#define KEEMBAY_AON_SET_3V3_VOLT	0x00
+
 /* Default settings for ZynqMP Clock Phases */
 #define ZYNQMP_ICLK_PHASE {0, 63, 63, 0, 63,  0,   0, 183, 54,  0, 0}
 #define ZYNQMP_OCLK_PHASE {0, 72, 60, 0, 60, 72, 135, 48, 72, 135, 0}
@@ -150,6 +157,7 @@ struct sdhci_arasan_data {
 	struct regmap	*soc_ctl_base;
 	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
 	unsigned int	quirks;
+	struct gpio_desc *uhs_gpio;
 
 /* Controller does not have CD wired and will not function normally without */
 #define SDHCI_ARASAN_QUIRK_FORCE_CDTEST	BIT(0)
@@ -361,6 +369,121 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
 	return -EINVAL;
 }
 
+static int sdhci_arasan_keembay_set_voltage(int volt)
+{
+#if IS_ENABLED(CONFIG_HAVE_ARM_SMCCC)
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(KEEMBAY_AON_SIP_FUNC_ID, volt, 0, 0, 0, 0, 0, 0, &res);
+	if (res.a0)
+		return -EINVAL;
+	return 0;
+#else
+	return -EINVAL;
+#endif
+}
+
+static int sdhci_arasan_keembay_voltage_switch(struct mmc_host *mmc,
+				       struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+	u16 ctrl_2;
+	u16 clk;
+	int ret;
+
+	switch (ios->signal_voltage) {
+	case MMC_SIGNAL_VOLTAGE_180:
+		clk  = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		clk &= ~SDHCI_CLOCK_CARD_EN;
+		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+		clk  = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		if (clk & SDHCI_CLOCK_CARD_EN)
+			return -EAGAIN;
+
+		sdhci_writeb(host, SDHCI_POWER_ON | SDHCI_POWER_180,
+				   SDHCI_POWER_CONTROL);
+
+		/* Set VDDIO_B voltage to Low for 1.8V */
+		gpiod_set_value_cansleep(sdhci_arasan->uhs_gpio, 0);
+
+		/*
+		 * This is like final gatekeeper. Need to ensure changed voltage
+		 * is settled before and after turn on this bit.
+		 */
+		usleep_range(1000, 1100);
+
+		ret = sdhci_arasan_keembay_set_voltage(KEEMBAY_AON_SET_1V8_VOLT);
+		if (ret)
+			return ret;
+
+		usleep_range(1000, 1100);
+
+		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		ctrl_2 |= SDHCI_CTRL_VDD_180;
+		sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+
+		/* Sleep for 5ms to stabilize 1.8V regulator */
+		usleep_range(5000, 5500);
+
+		/* 1.8V regulator output should be stable within 5 ms */
+		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		if (!(ctrl_2 & SDHCI_CTRL_VDD_180))
+			return -EAGAIN;
+
+		clk  = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		clk |= SDHCI_CLOCK_CARD_EN;
+		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+		break;
+	case MMC_SIGNAL_VOLTAGE_330:
+		/* Set VDDIO_B voltage to High for 3.3V */
+		gpiod_set_value_cansleep(sdhci_arasan->uhs_gpio, 1);
+
+		/*
+		 * This is like final gatekeeper. Need to ensure changed voltage
+		 * is settled before and after turn on this bit.
+		 */
+		usleep_range(1000, 1100);
+
+		ret = sdhci_arasan_keembay_set_voltage(KEEMBAY_AON_SET_3V3_VOLT);
+		if (ret)
+			return ret;
+
+		usleep_range(1000, 1100);
+
+		/* Set 1.8V Signal Enable in the Host Control2 register to 0 */
+		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		ctrl_2 &= ~SDHCI_CTRL_VDD_180;
+		sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+
+		/* Sleep for 5ms to stabilize 3.3V regulator */
+		usleep_range(5000, 5500);
+
+		/* 3.3V regulator output should be stable within 5 ms */
+		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		if (ctrl_2 & SDHCI_CTRL_VDD_180)
+			return -EAGAIN;
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int sdhci_arasan_keembay_select_drive_strength(struct mmc_card *card,
+					unsigned int max_dtr, int host_drv,
+					int card_drv, int *drv_type)
+{
+	if (card->host->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_180)
+		*drv_type = MMC_SET_DRIVER_TYPE_C;
+
+	return 0;
+}
+
 static const struct sdhci_ops sdhci_arasan_ops = {
 	.set_clock = sdhci_arasan_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
@@ -1521,6 +1644,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_arasan_data *sdhci_arasan;
 	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
 	const struct sdhci_arasan_of_data *data;
 
 	match = of_match_node(sdhci_arasan_of_match, pdev->dev.of_node);
@@ -1600,6 +1724,22 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
 	}
 
+	if (of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sd")) {
+		struct gpio_desc *uhs;
+
+		uhs = devm_gpiod_get_optional(dev, "uhs", GPIOD_OUT_HIGH);
+		if (IS_ERR(uhs))
+			return dev_err_probe(dev, PTR_ERR(uhs), "can't get uhs gpio\n");
+
+		sdhci_arasan->uhs_gpio = uhs;
+
+		host->mmc_host_ops.start_signal_voltage_switch =
+			sdhci_arasan_keembay_voltage_switch;
+
+		host->mmc_host_ops.select_drive_strength =
+			sdhci_arasan_keembay_select_drive_strength;
+	}
+
 	sdhci_arasan_update_baseclkfreq(host);
 
 	ret = sdhci_arasan_register_sdclk(sdhci_arasan, clk_xin, &pdev->dev);
-- 
2.17.1

