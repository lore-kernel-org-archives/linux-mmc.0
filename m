Return-Path: <SRS0=Kjhy=DI=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC79C4727C
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Oct 2020 14:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAB5C2087D
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Oct 2020 14:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732495AbgJAOZM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Oct 2020 10:25:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:5353 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732298AbgJAOZG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 1 Oct 2020 10:25:06 -0400
IronPort-SDR: 2zexqBrLr11c8GKZPj6kfW6VhNBiRRyilsz7Qvw6SWnA6za1UJNjhygrVpOiBVXl9nRePjd4XR
 zOyUbHaF+Nbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="161975973"
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="161975973"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 07:25:02 -0700
IronPort-SDR: d1RdrHM6/Deez09SqKaThnoyRd0FMP+vs/mOyPHo7zAOD6oVijwEcY9C1/IrjeE6v/8HaYUpnP
 ACIeInAbs1ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="294992537"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by fmsmga008.fm.intel.com with ESMTP; 01 Oct 2020 07:24:59 -0700
From:   muhammad.husaini.zulkifli@intel.com
To:     adrian.hunter@intel.com, michal.simek@xilinx.com,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        muhammad.husaini.zulkifli@intel.com, arnd@arndb.de
Subject: [PATCH v2 3/3] mmc: sdhci-of-arasan: Enable UHS-1 support for Keem Bay SOC
Date:   Thu,  1 Oct 2020 22:21:49 +0800
Message-Id: <20201001142149.23445-4-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001142149.23445-1-muhammad.husaini.zulkifli@intel.com>
References: <20201001142149.23445-1-muhammad.husaini.zulkifli@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

Voltage switching sequence is needed to support UHS-1 interface.
There are 2 places to control the voltage.
1) By setting the AON register using firmware driver calling
system-level platform management layer (SMC) to set the register.
2) By controlling the GPIO expander value to drive either 1.8V or 3.3V
for power mux input.

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 127 +++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index f186fbd016b1..73941418eaa7 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
@@ -23,6 +24,7 @@
 #include <linux/regmap.h>
 #include <linux/of.h>
 #include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/firmware/intel/keembay_smc.h>
 
 #include "cqhci.h"
 #include "sdhci-pltfm.h"
@@ -150,6 +152,7 @@ struct sdhci_arasan_data {
 	struct regmap	*soc_ctl_base;
 	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
 	unsigned int	quirks;
+	struct gpio_desc *uhs_gpio;
 
 /* Controller does not have CD wired and will not function normally without */
 #define SDHCI_ARASAN_QUIRK_FORCE_CDTEST	BIT(0)
@@ -361,6 +364,113 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
 	return -EINVAL;
 }
 
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
+		/*
+		 * Set VDDIO_B voltage to Low for 1.8V
+		 * which is controlling by GPIO Expander.
+		 */
+		gpiod_set_value_cansleep(sdhci_arasan->uhs_gpio, 0);
+
+		/*
+		 * This is like final gatekeeper. Need to ensure changed voltage
+		 * is settled before and after turn on this bit.
+		 */
+		usleep_range(1000, 1100);
+
+		ret = keembay_sd_voltage_selection(KEEMBAY_SET_1V8_VOLT);
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
+		/*
+		 * Set VDDIO_B voltage to High for 3.3V
+		 * which is controlling by GPIO Expander.
+		 */
+		gpiod_set_value_cansleep(sdhci_arasan->uhs_gpio, 1);
+
+		/*
+		 * This is like final gatekeeper. Need to ensure changed voltage
+		 * is settled before and after turn on this bit.
+		 */
+		usleep_range(1000, 1100);
+
+		ret = keembay_sd_voltage_selection(KEEMBAY_SET_3V3_VOLT);
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
@@ -1521,6 +1631,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_arasan_data *sdhci_arasan;
 	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
 	const struct sdhci_arasan_of_data *data;
 
 	match = of_match_node(sdhci_arasan_of_match, pdev->dev.of_node);
@@ -1600,6 +1711,22 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
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

