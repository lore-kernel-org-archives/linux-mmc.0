From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v5 06/12] mmc: sdhci-xenon: Add Marvell Xenon SDHC core functionality
Date: Wed, 11 Jan 2017 18:19:09 +0100
Message-ID: <3546f143091c121face8ecbcbf7f6a4c41d2cec7.1484154449.git-series.gregory.clement@free-electrons.com>
References: <cover.8527229dae6c124f24c5e637430c2cdc86f80392.1484154449.git-series.gregory.clement@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.8527229dae6c124f24c5e637430c2cdc86f80392.1484154449.git-series.gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
In-Reply-To: <cover.8527229dae6c124f24c5e637430c2cdc86f80392.1484154449.git-series.gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
References: <cover.8527229dae6c124f24c5e637430c2cdc86f80392.1484154449.git-series.gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ziji Hu <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jimmy Xu <zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ryan Gao <ygao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Doug Jones <dougj-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "Wei(SOCP) Liu" <liuw-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda
List-Id: linux-mmc@vger.kernel.org

From: Hu Ziji <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

Add Xenon eMMC/SD/SDIO host controller core functionality.
Add Xenon specific intialization process.
Add Xenon specific mmc_host_ops APIs.
Add Xenon specific register definitions.

Add CONFIG_MMC_SDHCI_XENON support in drivers/mmc/host/Kconfig.

Marvell Xenon SDHC conforms to SD Physical Layer Specification
Version 3.01 and is designed according to the guidelines provided
in the SD Host Controller Standard Specification Version 3.00.

Signed-off-by: Hu Ziji <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Tested-by: Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/mmc/host/Kconfig       |   9 +-
 drivers/mmc/host/Makefile      |   3 +-
 drivers/mmc/host/sdhci-xenon.c | 631 ++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci-xenon.h |  70 ++++-
 4 files changed, 713 insertions(+)
 create mode 100644 drivers/mmc/host/sdhci-xenon.c
 create mode 100644 drivers/mmc/host/sdhci-xenon.h

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 2eb97014dc3f..8d2d08de14a0 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -819,3 +819,12 @@ config MMC_SDHCI_BRCMSTB
 	  Broadcom STB SoCs.
 
 	  If unsure, say Y.
+
+config MMC_SDHCI_XENON
+	tristate "Marvell Xenon eMMC/SD/SDIO SDHCI driver"
+	depends on MMC_SDHCI && MMC_SDHCI_PLTFM
+	help
+	  This selects Marvell Xenon eMMC/SD/SDIO SDHCI.
+	  If you have a machine with integrated Marvell Xenon SDHC IP,
+	  say Y or M here.
+	  If unsure, say N.
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index ccc9c4cba154..b0a2ab4b256e 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -82,3 +82,6 @@ obj-$(CONFIG_MMC_SDHCI_BRCMSTB)		+= sdhci-brcmstb.o
 ifeq ($(CONFIG_CB710_DEBUG),y)
 	CFLAGS-cb710-mmc	+= -DDEBUG
 endif
+
+obj-$(CONFIG_MMC_SDHCI_XENON)	+= sdhci-xenon-driver.o
+sdhci-xenon-driver-y		+= sdhci-xenon.o
diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
new file mode 100644
index 000000000000..0e0c60892f72
--- /dev/null
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -0,0 +1,631 @@
+/*
+ * Driver for Marvell Xenon SDHC as a platform device
+ *
+ * Copyright (C) 2016 Marvell, All Rights Reserved.
+ *
+ * Author:	Hu Ziji <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
+ * Date:	2016-8-24
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * Inspired by Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
+ * Special thanks to Video BG4 project team.
+ */
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/of.h>
+
+#include "sdhci-pltfm.h"
+#include "sdhci-xenon.h"
+
+static int enable_xenon_internal_clk(struct sdhci_host *host)
+{
+	u32 reg;
+	u8 timeout;
+
+	reg = sdhci_readl(host, SDHCI_CLOCK_CONTROL);
+	reg |= SDHCI_CLOCK_INT_EN;
+	sdhci_writel(host, reg, SDHCI_CLOCK_CONTROL);
+	/* Wait max 20 ms */
+	timeout = 20;
+	while (!((reg = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
+			& SDHCI_CLOCK_INT_STABLE)) {
+		if (timeout == 0) {
+			pr_err("%s: Internal clock never stabilised.\n",
+			       mmc_hostname(host->mmc));
+			return -ETIMEDOUT;
+		}
+		timeout--;
+		mdelay(1);
+	}
+
+	return 0;
+}
+
+/* Set SDCLK-off-while-idle */
+static void xenon_set_sdclk_off_idle(struct sdhci_host *host,
+				     unsigned char sdhc_id, bool enable)
+{
+	u32 reg;
+	u32 mask;
+
+	reg = sdhci_readl(host, XENON_SYS_OP_CTRL);
+	/* Get the bit shift basing on the SDHC index */
+	mask = (0x1 << (XENON_SDCLK_IDLEOFF_ENABLE_SHIFT + sdhc_id));
+	if (enable)
+		reg |= mask;
+	else
+		reg &= ~mask;
+
+	sdhci_writel(host, reg, XENON_SYS_OP_CTRL);
+}
+
+/* Enable/Disable the Auto Clock Gating function */
+static void xenon_set_acg(struct sdhci_host *host, bool enable)
+{
+	u32 reg;
+
+	reg = sdhci_readl(host, XENON_SYS_OP_CTRL);
+	if (enable)
+		reg &= ~XENON_AUTO_CLKGATE_DISABLE_MASK;
+	else
+		reg |= XENON_AUTO_CLKGATE_DISABLE_MASK;
+	sdhci_writel(host, reg, XENON_SYS_OP_CTRL);
+}
+
+/* Enable this SDHC */
+static void xenon_enable_sdhc(struct sdhci_host *host,
+			      unsigned char sdhc_id)
+{
+	u32 reg;
+
+	reg = sdhci_readl(host, XENON_SYS_OP_CTRL);
+	reg |= (BIT(sdhc_id) << XENON_SLOT_ENABLE_SHIFT);
+	sdhci_writel(host, reg, XENON_SYS_OP_CTRL);
+
+	/*
+	 * Manually set the flag which all the card types require,
+	 * including SD, eMMC, SDIO
+	 */
+	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
+}
+
+/* Disable this SDHC */
+static void xenon_disable_sdhc(struct sdhci_host *host,
+			       unsigned char sdhc_id)
+{
+	u32 reg;
+
+	reg = sdhci_readl(host, XENON_SYS_OP_CTRL);
+	reg &= ~(BIT(sdhc_id) << XENON_SLOT_ENABLE_SHIFT);
+	sdhci_writel(host, reg, XENON_SYS_OP_CTRL);
+}
+
+/* Enable Parallel Transfer Mode */
+static void xenon_enable_sdhc_parallel_tran(struct sdhci_host *host,
+					    unsigned char sdhc_id)
+{
+	u32 reg;
+
+	reg = sdhci_readl(host, XENON_SYS_EXT_OP_CTRL);
+	reg |= BIT(sdhc_id);
+	sdhci_writel(host, reg, XENON_SYS_EXT_OP_CTRL);
+}
+
+/* Mask command conflict error */
+static void xenon_mask_cmd_conflict_err(struct sdhci_host *host)
+{
+	u32  reg;
+
+	reg = sdhci_readl(host, XENON_SYS_EXT_OP_CTRL);
+	reg |= XENON_MASK_CMD_CONFLICT_ERR;
+	sdhci_writel(host, reg, XENON_SYS_EXT_OP_CTRL);
+}
+
+static void xenon_sdhc_retune_setup(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	u32 reg;
+
+	/* Disable the Re-Tuning Request functionality */
+	reg = sdhci_readl(host, XENON_SLOT_RETUNING_REQ_CTRL);
+	reg &= ~XENON_RETUNING_COMPATIBLE;
+	sdhci_writel(host, reg, XENON_SLOT_RETUNING_REQ_CTRL);
+
+	/* Disable the Re-tuning Interrupt */
+	reg = sdhci_readl(host, SDHCI_SIGNAL_ENABLE);
+	reg &= ~SDHCI_INT_RETUNE;
+	sdhci_writel(host, reg, SDHCI_SIGNAL_ENABLE);
+	reg = sdhci_readl(host, SDHCI_INT_ENABLE);
+	reg &= ~SDHCI_INT_RETUNE;
+	sdhci_writel(host, reg, SDHCI_INT_ENABLE);
+
+	/* Force to use Tuning Mode 1 */
+	host->tuning_mode = SDHCI_TUNING_MODE_1;
+	/* Set re-tuning period */
+	host->tuning_count = 1 << (priv->tuning_count - 1);
+}
+
+/*
+ * Operations inside struct sdhci_ops
+ */
+/* Recover the Register Setting cleared during SOFTWARE_RESET_ALL */
+static void sdhci_xenon_reset_exit(struct sdhci_host *host,
+				   unsigned char sdhc_id, u8 mask)
+{
+	/* Only SOFTWARE RESET ALL will clear the register setting */
+	if (!(mask & SDHCI_RESET_ALL))
+		return;
+
+	/* Disable tuning request and auto-retuning again */
+	xenon_sdhc_retune_setup(host);
+
+	xenon_set_acg(host, true);
+
+	xenon_set_sdclk_off_idle(host, sdhc_id, false);
+}
+
+static void sdhci_xenon_reset(struct sdhci_host *host, u8 mask)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+
+	sdhci_reset(host, mask);
+	sdhci_xenon_reset_exit(host, priv->sdhc_id, mask);
+}
+
+/*
+ * Xenon defines different values for HS200 and HS400
+ * in Host_Control_2
+ */
+static void xenon_set_uhs_signaling(struct sdhci_host *host,
+				    unsigned int timing)
+{
+	u16 ctrl_2;
+
+	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	/* Select Bus Speed Mode for host */
+	ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
+	if (timing == MMC_TIMING_MMC_HS200)
+		ctrl_2 |= XENON_CTRL_HS200;
+	else if (timing == MMC_TIMING_UHS_SDR104)
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
+	else if (timing == MMC_TIMING_UHS_SDR12)
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
+	else if (timing == MMC_TIMING_UHS_SDR25)
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
+	else if (timing == MMC_TIMING_UHS_SDR50)
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
+	else if ((timing == MMC_TIMING_UHS_DDR50) ||
+		 (timing == MMC_TIMING_MMC_DDR52))
+		ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
+	else if (timing == MMC_TIMING_MMC_HS400)
+		ctrl_2 |= XENON_CTRL_HS400;
+	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+}
+
+static const struct sdhci_ops sdhci_xenon_ops = {
+	.set_clock		= sdhci_set_clock,
+	.set_bus_width		= sdhci_set_bus_width,
+	.reset			= sdhci_xenon_reset,
+	.set_uhs_signaling	= xenon_set_uhs_signaling,
+	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
+};
+
+static const struct sdhci_pltfm_data sdhci_xenon_pdata = {
+	.ops = &sdhci_xenon_ops,
+	.quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
+		  SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER |
+		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+};
+
+/*
+ * Xenon Specific Operations in mmc_host_ops
+ */
+static void xenon_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	unsigned long flags;
+	u32 reg;
+
+	/*
+	 * HS400/HS200/eMMC HS doesn't have Preset Value register.
+	 * However, sdhci_set_ios will read HS400/HS200 Preset register.
+	 * Disable Preset Value register for HS400/HS200.
+	 * eMMC HS with preset_enabled set will trigger a bug in
+	 * get_preset_value().
+	 */
+	spin_lock_irqsave(&host->lock, flags);
+	if ((ios->timing == MMC_TIMING_MMC_HS400) ||
+	    (ios->timing == MMC_TIMING_MMC_HS200) ||
+	    (ios->timing == MMC_TIMING_MMC_HS)) {
+		host->preset_enabled = false;
+		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
+
+		reg = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		reg &= ~SDHCI_CTRL_PRESET_VAL_ENABLE;
+		sdhci_writew(host, reg, SDHCI_HOST_CONTROL2);
+	} else {
+		host->quirks2 &= ~SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
+	}
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	sdhci_set_ios(mmc, ios);
+
+	if (host->clock > XENON_DEFAULT_SDCLK_FREQ) {
+		spin_lock_irqsave(&host->lock, flags);
+		xenon_set_sdclk_off_idle(host, priv->sdhc_id, true);
+		spin_unlock_irqrestore(&host->lock, flags);
+	}
+}
+
+static int xenon_emmc_signal_voltage_switch(struct mmc_host *mmc,
+					    struct mmc_ios *ios)
+{
+	unsigned char voltage = ios->signal_voltage;
+	struct sdhci_host *host = mmc_priv(mmc);
+	unsigned char voltage_code;
+	u32 ctrl;
+
+	if ((voltage == MMC_SIGNAL_VOLTAGE_330) ||
+	    (voltage == MMC_SIGNAL_VOLTAGE_180)) {
+		if (voltage == MMC_SIGNAL_VOLTAGE_330)
+			voltage_code = XENON_EMMC_VCCQ_3_3V;
+		else if (voltage == MMC_SIGNAL_VOLTAGE_180)
+			voltage_code = XENON_EMMC_VCCQ_1_8V;
+
+		/*
+		 * This host is for eMMC, XENON self-defined
+		 * eMMC control register should be accessed
+		 * instead of Host Control 2
+		 */
+		ctrl = sdhci_readl(host, XENON_SLOT_EMMC_CTRL);
+		ctrl &= ~XENON_EMMC_VCCQ_MASK;
+		ctrl |= voltage_code;
+		sdhci_writel(host, ctrl, XENON_SLOT_EMMC_CTRL);
+
+		/* There is no standard to determine this waiting period */
+		usleep_range(1000, 2000);
+
+		/* Check whether io voltage switch is done */
+		ctrl = sdhci_readl(host, XENON_SLOT_EMMC_CTRL);
+		ctrl &= XENON_EMMC_VCCQ_MASK;
+		/*
+		 * This bit is set only when regulator feeds back
+		 * the voltage switch results to Xenon SDHC.
+		 * However, in actaul implementation, regulator might not
+		 * provide this feedback.
+		 * Thus we shall not rely on this bit to determine
+		 * if switch failed.
+		 * If the bit is not set, just throw a message.
+		 * Besides, error code should not be returned.
+		 */
+		if (ctrl != voltage_code)
+			dev_info(mmc_dev(mmc), "fail to detect eMMC signal voltage stable\n");
+		return 0;
+	}
+
+	dev_err(mmc_dev(mmc), "Unsupported signal voltage: %d\n", voltage);
+	return -EINVAL;
+}
+
+static int xenon_start_signal_voltage_switch(struct mmc_host *mmc,
+					     struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+
+	/*
+	 * Before SD/SDIO set signal voltage, SD bus clock should be
+	 * disabled. However, sdhci_set_clock will also disable the Internal
+	 * clock in mmc_set_signal_voltage().
+	 * If Internal clock is disabled, the 3.3V/1.8V bit can not be updated.
+	 * Thus here manually enable internal clock.
+	 *
+	 * After switch completes, it is unnecessary to disable internal clock,
+	 * since keeping internal clock active obeys SD spec.
+	 */
+	enable_xenon_internal_clk(host);
+
+	if (priv->init_card_type == MMC_TYPE_MMC)
+		return xenon_emmc_signal_voltage_switch(mmc, ios);
+
+	return sdhci_start_signal_voltage_switch(mmc, ios);
+}
+
+/*
+ * Update card type.
+ * priv->init_card_type will be used in PHY timing adjustment.
+ */
+static void xenon_init_card(struct mmc_host *mmc, struct mmc_card *card)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+
+	/* Update card type*/
+	priv->init_card_type = card->type;
+}
+
+static int xenon_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	if (host->timing == MMC_TIMING_UHS_DDR50)
+		return 0;
+
+	/*
+	 * Currently force Xenon driver back to support mode 1 only,
+	 * even though Xenon might claim to support mode 2 or mode 3.
+	 * It requires more time to test mode 2/mode 3 on more platforms.
+	 */
+	if (host->tuning_mode != SDHCI_TUNING_MODE_1)
+		xenon_sdhc_retune_setup(host);
+
+	return sdhci_execute_tuning(mmc, opcode);
+}
+
+static void xenon_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	u32 reg;
+	u8 sdhc_id = priv->sdhc_id;
+
+	sdhci_enable_sdio_irq(mmc, enable);
+
+	if (enable) {
+		/*
+		 * Set SDIO Card Inserted indication
+		 * to enable detecting SDIO async irq.
+		 */
+		reg = sdhci_readl(host, XENON_SYS_CFG_INFO);
+		reg |= (1 << (sdhc_id + XENON_SLOT_TYPE_SDIO_SHIFT));
+		sdhci_writel(host, reg, XENON_SYS_CFG_INFO);
+	} else {
+		/* Clear SDIO Card Inserted indication */
+		reg = sdhci_readl(host, XENON_SYS_CFG_INFO);
+		reg &= ~(1 << (sdhc_id + XENON_SLOT_TYPE_SDIO_SHIFT));
+		sdhci_writel(host, reg, XENON_SYS_CFG_INFO);
+	}
+}
+
+static void xenon_replace_mmc_host_ops(struct sdhci_host *host)
+{
+	host->mmc_host_ops.set_ios = xenon_set_ios;
+	host->mmc_host_ops.start_signal_voltage_switch =
+			xenon_start_signal_voltage_switch;
+	host->mmc_host_ops.init_card = xenon_init_card;
+	host->mmc_host_ops.execute_tuning = xenon_execute_tuning;
+	host->mmc_host_ops.enable_sdio_irq = xenon_enable_sdio_irq;
+}
+
+/*
+ * Parse child node in Xenon DT.
+ * Search for the following item(s):
+ * - eMMC card type
+ */
+static int xenon_child_node_of_parse(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct mmc_host *mmc = host->mmc;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	struct device_node *child;
+	int nr_child;
+
+	priv->init_card_type = XENON_CARD_TYPE_UNKNOWN;
+
+	nr_child = of_get_child_count(np);
+	if (!nr_child)
+		return 0;
+
+	for_each_child_of_node(np, child) {
+		if (of_device_is_compatible(child, "mmc-card"))	{
+			priv->init_card_type = MMC_TYPE_MMC;
+			mmc->caps |= MMC_CAP_NONREMOVABLE;
+
+			/*
+			 * Force to clear BUS_TEST to
+			 * skip bus_test_pre and bus_test_post
+			 */
+			mmc->caps &= ~MMC_CAP_BUS_WIDTH_TEST;
+			mmc->caps2 |= MMC_CAP2_HC_ERASE_SZ |
+				      MMC_CAP2_PACKED_CMD |
+				      MMC_CAP2_NO_SD |
+				      MMC_CAP2_NO_SDIO;
+		}
+	}
+
+	return 0;
+}
+
+static int xenon_probe_dt(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct mmc_host *mmc = host->mmc;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	int err;
+	u32 sdhc_id, nr_sdhc;
+	u32 tuning_count;
+
+	/* Standard MMC property */
+	err = mmc_of_parse(mmc);
+	if (err)
+		return err;
+
+	/* Standard SDHCI property */
+	sdhci_get_of_property(pdev);
+
+	/*
+	 * Xenon Specific property:
+	 * init_card_type: check whether this SDHC is for eMMC
+	 * sdhc-id: the index of current SDHC.
+	 *	    Refer to XENON_SYS_CFG_INFO register
+	 * tun-count: the interval between re-tuning
+	 */
+	/* Parse child node, including checking emmc type */
+	err = xenon_child_node_of_parse(pdev);
+	if (err)
+		return err;
+
+	priv->sdhc_id = 0x0;
+	if (!of_property_read_u32(np, "marvell,xenon-sdhc-id", &sdhc_id)) {
+		nr_sdhc = sdhci_readl(host, XENON_SYS_CFG_INFO);
+		nr_sdhc &= XENON_NR_SUPPORTED_SLOT_MASK;
+		if (unlikely(sdhc_id > nr_sdhc)) {
+			dev_err(mmc_dev(mmc), "SDHC Index %d exceeds Number of SDHCs %d\n",
+				sdhc_id, nr_sdhc);
+			return -EINVAL;
+		}
+	}
+
+	tuning_count = XENON_DEF_TUNING_COUNT;
+	if (!of_property_read_u32(np, "marvell,xenon-tun-count",
+				  &tuning_count)) {
+		if (unlikely(tuning_count >= XENON_TMR_RETUN_NO_PRESENT)) {
+			dev_err(mmc_dev(mmc), "Wrong Re-tuning Count. Set default value %d\n",
+				XENON_DEF_TUNING_COUNT);
+			tuning_count = XENON_DEF_TUNING_COUNT;
+		}
+	}
+	priv->tuning_count = tuning_count;
+
+	return err;
+}
+
+static int xenon_sdhc_probe(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	u8 sdhc_id = priv->sdhc_id;
+
+	/* Enable SDHC */
+	xenon_enable_sdhc(host, sdhc_id);
+
+	/* Enable ACG */
+	xenon_set_acg(host, true);
+
+	/* Enable Parallel Transfer Mode */
+	xenon_enable_sdhc_parallel_tran(host, sdhc_id);
+
+	xenon_mask_cmd_conflict_err(host);
+
+	return 0;
+}
+
+static void xenon_sdhc_remove(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	u8 sdhc_id = priv->sdhc_id;
+
+	/* disable SDHC */
+	xenon_disable_sdhc(host, sdhc_id);
+}
+
+static int sdhci_xenon_probe(struct platform_device *pdev)
+{
+	struct sdhci_pltfm_host *pltfm_host;
+	struct sdhci_host *host;
+	struct sdhci_xenon_priv *priv;
+	int err;
+
+	host = sdhci_pltfm_init(pdev, &sdhci_xenon_pdata,
+				sizeof(struct sdhci_xenon_priv));
+	if (IS_ERR(host))
+		return PTR_ERR(host);
+
+	pltfm_host = sdhci_priv(host);
+	priv = sdhci_pltfm_priv(pltfm_host);
+
+	xenon_set_acg(host, false);
+
+	/*
+	 * Link Xenon specific mmc_host_ops function,
+	 * to replace standard ones in sdhci_ops.
+	 */
+	xenon_replace_mmc_host_ops(host);
+
+	pltfm_host->clk = devm_clk_get(&pdev->dev, "core");
+	if (IS_ERR(pltfm_host->clk)) {
+		err = PTR_ERR(pltfm_host->clk);
+		dev_err(&pdev->dev, "Failed to setup input clk: %d\n", err);
+		goto free_pltfm;
+	}
+	err = clk_prepare_enable(pltfm_host->clk);
+	if (err)
+		goto free_pltfm;
+
+	err = xenon_probe_dt(pdev);
+	if (err)
+		goto err_clk;
+
+	err = xenon_sdhc_probe(host);
+	if (err)
+		goto err_clk;
+
+	err = sdhci_add_host(host);
+	if (err)
+		goto remove_sdhc;
+
+	return 0;
+
+remove_sdhc:
+	xenon_sdhc_remove(host);
+err_clk:
+	clk_disable_unprepare(pltfm_host->clk);
+free_pltfm:
+	sdhci_pltfm_free(pdev);
+	return err;
+}
+
+static int sdhci_xenon_remove(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	xenon_sdhc_remove(host);
+
+	sdhci_remove_host(host, 0);
+
+	clk_disable_unprepare(pltfm_host->clk);
+
+	sdhci_pltfm_free(pdev);
+
+	return 0;
+}
+
+static const struct of_device_id sdhci_xenon_dt_ids[] = {
+	{ .compatible = "marvell,armada-8k-sdhci",},
+	{ .compatible = "marvell,armada-3700-sdhci",},
+	{}
+};
+MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
+
+static struct platform_driver sdhci_xenon_driver = {
+	.driver	= {
+		.name	= "xenon-sdhci",
+		.of_match_table = sdhci_xenon_dt_ids,
+		.pm = &sdhci_pltfm_pmops,
+	},
+	.probe	= sdhci_xenon_probe,
+	.remove	= sdhci_xenon_remove,
+};
+
+module_platform_driver(sdhci_xenon_driver);
+
+MODULE_DESCRIPTION("SDHCI platform driver for Marvell Xenon SDHC");
+MODULE_AUTHOR("Hu Ziji <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
new file mode 100644
index 000000000000..69de711db9eb
--- /dev/null
+++ b/drivers/mmc/host/sdhci-xenon.h
@@ -0,0 +1,70 @@
+/*
+ * Copyright (C) 2016 Marvell, All Rights Reserved.
+ *
+ * Author:	Hu Ziji <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
+ * Date:	2016-8-24
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ */
+#ifndef SDHCI_XENON_H_
+#define SDHCI_XENON_H_
+
+/* Register Offset of Xenon SDHC self-defined register */
+#define XENON_SYS_CFG_INFO			0x0104
+#define XENON_SLOT_TYPE_SDIO_SHIFT		24
+#define XENON_NR_SUPPORTED_SLOT_MASK		0x7
+
+#define XENON_SYS_OP_CTRL			0x0108
+#define XENON_AUTO_CLKGATE_DISABLE_MASK		BIT(20)
+#define XENON_SDCLK_IDLEOFF_ENABLE_SHIFT	8
+#define XENON_SLOT_ENABLE_SHIFT			0
+
+#define XENON_SYS_EXT_OP_CTRL			0x010C
+#define XENON_MASK_CMD_CONFLICT_ERR		BIT(8)
+
+#define XENON_SLOT_EMMC_CTRL			0x0130
+#define XENON_EMMC_VCCQ_MASK			0x3
+#define XENON_EMMC_VCCQ_1_8V			0x1
+#define XENON_EMMC_VCCQ_3_3V			0x3
+
+#define XENON_SLOT_RETUNING_REQ_CTRL		0x0144
+/* retuning compatible */
+#define XENON_RETUNING_COMPATIBLE		0x1
+
+/* Tuning Parameter */
+#define XENON_TMR_RETUN_NO_PRESENT		0xF
+#define XENON_DEF_TUNING_COUNT			0x9
+
+#define XENON_DEFAULT_SDCLK_FREQ		400000
+
+/* Xenon specific Mode Select value */
+#define XENON_CTRL_HS200			0x5
+#define XENON_CTRL_HS400			0x6
+
+/* Indicate Card Type is not clear yet */
+#define XENON_CARD_TYPE_UNKNOWN			0xF
+
+struct sdhci_xenon_priv {
+	unsigned char	tuning_count;
+	/* idx of SDHC */
+	u8		sdhc_id;
+
+	/*
+	 * eMMC/SD/SDIO require different PHY settings or
+	 * voltage control. It's necessary for Xenon driver to
+	 * recognize card type during, or even before initialization.
+	 * However, mmc_host->card is not available yet at that time.
+	 * This field records the card type during init.
+	 * For eMMC, it is updated in dt parse. For SD/SDIO, it is
+	 * updated in xenon_init_card().
+	 *
+	 * It is only valid during initialization after it is updated.
+	 * Do not access this variable in normal transfers after
+	 * initialization completes.
+	 */
+	unsigned int	init_card_type;
+};
+
+#endif
-- 
git-series 0.9.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
