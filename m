Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277F6C64E8A
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 07:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB573221FB
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 07:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387622AbgLBHDi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Dec 2020 02:03:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:44051 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387511AbgLBHDh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 2 Dec 2020 02:03:37 -0500
IronPort-SDR: X733h72U+IqZcPLoyaegdGqp70tA6uX0YZogNq8usbLMGbec6KTkCV4LV5EN1hFpNhoy3ccJs4
 QWP0m0owPdOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="169461826"
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="169461826"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 23:02:46 -0800
IronPort-SDR: 4SC9ziNrhq4S2fUKDLefuSmXn4qw9CUKx/v09rUf5B2bGyYu9xh0sPPlAEei2evNax/8ugNX/h
 RzEgkmFjkERQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="481430058"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by orsmga004.jf.intel.com with ESMTP; 01 Dec 2020 23:02:43 -0800
From:   muhammad.husaini.zulkifli@intel.com
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        michal.simek@xilinx.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        muhammad.husaini.zulkifli@intel.com, mgross@linux.intel.com
Subject: [PATCH v6 4/4] mmc: sdhci-of-arasan: Enable UHS-1 support for Keem Bay SOC
Date:   Wed,  2 Dec 2020 23:02:04 +0800
Message-Id: <20201202150205.20150-5-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202150205.20150-1-muhammad.husaini.zulkifli@intel.com>
References: <20201202150205.20150-1-muhammad.husaini.zulkifli@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

Keem Bay SOC can support dual voltage operations for GPIO SD Pins to
either 1.8V or 3.3V for bus IO line power. In order to operate the GPIOs
line for Clk,Cmd and Data on Keem Bay Hardware, it is important to
configure the supplied voltage applied to their I/O Rail and the output
of the i2c expander pin. Final Voltage applied on the GPIOs Line are
dependent by both supplied voltage rail and expander pin output as it is
been set after passing through the voltage sense resistor.

The Keem Bay HW is somewhat unique in the way of how IO bus line voltage
are been controlled. Output of the Expander pins is been configured using
regulator. Voltage rail output is being configured using
keembay_io_rail_supplied_voltage() API in the sdhci driver directly.
Pin control based implementation becomes problematic to control the
voltage rail due to the base address of Always On Register is
different from the base address of GPIO(Pinctrl). Thus, there is
no way to control the I/O Rail using GPIO Pad configuration.
On the other hand, using ARM SMC (Secure Monitor Call) directly from
pin control driver for the sake of implement it as pin control model
is not a good approach.

This patch was tested with Keem Bay EVM.

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 244 +++++++++++++++++++++++++++++
 1 file changed, 244 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 196e3d65277e..00ecdf54128c 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -23,6 +23,7 @@
 #include <linux/regmap.h>
 #include <linux/of.h>
 #include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/firmware/intel/keembay.h>
 
 #include "cqhci.h"
 #include "sdhci-pltfm.h"
@@ -79,6 +80,8 @@ struct sdhci_arasan_soc_ctl_field {
  * @baseclkfreq:	Where to find corecfg_baseclkfreq
  * @clockmultiplier:	Where to find corecfg_clockmultiplier
  * @support64b:		Where to find SUPPORT64B bit
+ * @otap_delay:		Where to find otap_delay
+ * @sel_clk_buffer:	Where to find clock buffer delay
  * @hiword_update:	If true, use HIWORD_UPDATE to access the syscon
  *
  * It's up to the licensee of the Arsan IP block to make these available
@@ -89,6 +92,8 @@ struct sdhci_arasan_soc_ctl_map {
 	struct sdhci_arasan_soc_ctl_field	baseclkfreq;
 	struct sdhci_arasan_soc_ctl_field	clockmultiplier;
 	struct sdhci_arasan_soc_ctl_field	support64b;
+	struct sdhci_arasan_soc_ctl_field	otap_delay;
+	struct sdhci_arasan_soc_ctl_field	sel_clk_buffer;
 	bool					hiword_update;
 };
 
@@ -189,6 +194,8 @@ static const struct sdhci_arasan_soc_ctl_map intel_keembay_soc_ctl_map = {
 	.baseclkfreq = { .reg = 0x0, .width = 8, .shift = 14 },
 	.clockmultiplier = { .reg = 0x4, .width = 8, .shift = 14 },
 	.support64b = { .reg = 0x4, .width = 1, .shift = 24 },
+	.otap_delay = { .reg = 0x24, .width = 5, .shift = 23 },
+	.sel_clk_buffer = { .reg = 0x2c, .width = 3, .shift = 25 },
 	.hiword_update = false,
 };
 
@@ -364,6 +371,144 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
 	return -EINVAL;
 }
 
+/**
+ * sdhci_arasan_keembay_io_line_supply_operation - Supply for the bus IO line power
+ *
+ * @mmc:	Pointer to sdhci_host
+ * @ios:	Pointer to IO bus setting
+ *
+ * For Keem Bay HW, in order to operate the GPIOs line for Clk,Cmd and Data,
+ * it is important to configure the supplied voltage applied to their I/O Rail
+ * and the output of the i2c expander Pin.
+ *
+ * Note that to configure the voltage rail setting, specific bits in AON_CFG
+ * register must be set. While to configure the i2c expander pin output,
+ * gpio regulator modelling is been used to control the pin state.
+ *
+ * Always on Domain register having different base address from GPIO base address
+ * and it is a secure register. There is no way to control the I/O Voltage Rail
+ * from the GPIO Pad. SMC CALL is been used to set the bits in AON_CFG1 register.
+ *
+ * Final Voltage applied on the GPIOs Line are dependent by both supplied voltage
+ * I/O Rail and expander pin output as it is been set after passing through the
+ * voltage sense resistor.
+ *
+ * Return: 0 on success and error value on error
+ */
+static int sdhci_arasan_keembay_io_line_supply_operation(struct mmc_host *mmc,
+						  struct mmc_ios *ios)
+{
+	int ret, min_uV, max_uV, volt_rail;
+
+	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
+		min_uV = IOV_1V8;
+		max_uV = IOV_1V8;
+		volt_rail = KEEMBAY_SET_1V8_IO_RAIL;
+	} else {
+		min_uV = IOV_3V3;
+		max_uV = IOV_3V3;
+		volt_rail = KEEMBAY_SET_3V3_IO_RAIL;
+	}
+
+	/* If no vqmmc supply then we can't change the voltage */
+	if (IS_ERR(mmc->supply.vqmmc))
+		return -EINVAL;
+
+	ret = regulator_set_voltage(mmc->supply.vqmmc, min_uV, max_uV);
+	if (ret)
+		return ret;
+
+	/*
+	 * This is like a final gatekeeper. Need to ensure changed voltage
+	 * is settled before and after turn on this bit.
+	 */
+	usleep_range(1000, 1100);
+
+	ret = keembay_io_rail_supplied_voltage(volt_rail);
+	if (ret)
+		return ret;
+
+	usleep_range(1000, 1100);
+
+	return 0;
+}
+
+static int sdhci_arasan_keembay_voltage_switch(struct mmc_host *mmc,
+				       struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u16 ctrl_2, clk;
+	int ret;
+
+	switch (ios->signal_voltage) {
+	case MMC_SIGNAL_VOLTAGE_180:
+		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		clk &= ~SDHCI_CLOCK_CARD_EN;
+		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		if (clk & SDHCI_CLOCK_CARD_EN)
+			return -EAGAIN;
+
+		sdhci_writeb(host, SDHCI_POWER_ON | SDHCI_POWER_180,
+				   SDHCI_POWER_CONTROL);
+
+		ret = sdhci_arasan_keembay_io_line_supply_operation(mmc, ios);
+		if (ret)
+			return ret;
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
+		ret = sdhci_arasan_keembay_io_line_supply_operation(mmc, ios);
+		if (ret)
+			return ret;
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
@@ -964,6 +1109,77 @@ static void sdhci_arasan_update_baseclkfreq(struct sdhci_host *host)
 	sdhci_arasan_syscon_write(host, &soc_ctl_map->baseclkfreq, mhz);
 }
 
+/**
+ * sdhci_arasan_update_otap_delay - Set otap delay
+ *
+ * This is used to manualy control the txclk Tap Delay,
+ * for flopping the final stage flops.
+ *
+ * NOTES:
+ * - Many existing devices don't seem to do this and work fine.  To keep
+ *   compatibility for old hardware where the device tree doesn't provide a
+ *   register map, this function is a noop if a soc_ctl_map hasn't been provided
+ *   for this platform.
+ *
+ * @host:		The sdhci_host
+ */
+static void sdhci_arasan_update_otap_delay(struct sdhci_host *host,
+						u32 value)
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
+	sdhci_arasan_syscon_write(host, &soc_ctl_map->otap_delay, value);
+}
+
+/**
+ * sdhci_arasan_update_clk_sel_buff - Clock buffer select
+ *
+ * This is used to delay the clock buffer
+ *
+ * NOTES:
+ * - Many existing devices don't seem to do this and work fine.  To keep
+ *   compatibility for old hardware where the device tree doesn't provide a
+ *   register map, this function is a noop if a soc_ctl_map hasn't been provided
+ *   for this platform.
+ *
+ * @host:		The sdhci_host
+ */
+static void sdhci_arasan_update_sel_clkbuf(struct sdhci_host *host,
+						u32 value)
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
+	sdhci_arasan_syscon_write(host, &soc_ctl_map->sel_clk_buffer, value);
+}
+
 static void sdhci_arasan_set_clk_delays(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1587,6 +1803,34 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
 	}
 
+	if (of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sd")) {
+		struct device_node *phys;
+		u32 otap_delay, sel_clk_buffer;
+
+		phys = of_parse_phandle(dev->of_node, "phys", 0);
+		if (!phys) {
+			dev_err(dev, "Can't get phys for sd0\n");
+			ret = -ENODEV;
+			goto err_pltfm_free;
+		}
+
+		of_property_read_u32(phys,
+			"intel,keembay-emmc-phy-otap-dly", &otap_delay);
+		of_property_read_u32(phys,
+			"intel,keembay-emmc-phy-sel-clkbuf", &sel_clk_buffer);
+
+		of_node_put(phys);
+
+		sdhci_arasan_update_otap_delay(host, otap_delay);
+		sdhci_arasan_update_sel_clkbuf(host, sel_clk_buffer);
+
+		host->mmc_host_ops.start_signal_voltage_switch =
+			sdhci_arasan_keembay_voltage_switch;
+
+		host->mmc_host_ops.select_drive_strength =
+			sdhci_arasan_keembay_select_drive_strength;
+	}
+
 	sdhci_arasan_update_baseclkfreq(host);
 
 	ret = sdhci_arasan_register_sdclk(sdhci_arasan, clk_xin, dev);
-- 
2.17.1

