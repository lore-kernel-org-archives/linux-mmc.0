From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 6/10] mmc: sdhci-xenon: Add Marvell Xenon SDHC core functionality
Date: Mon, 31 Oct 2016 12:09:55 +0100
Message-ID: <0390e7a05b6163deabb545f93729ea615eeaaee2.1477911954.git-series.gregory.clement@free-electrons.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
In-Reply-To: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ziji Hu <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "Jack(SH) Zhu" <jmzhu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jimmy Xu <zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ryan Gao <ygao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Doug Jones <dougj-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shiwu Zhang <zhangshw-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "Wei(SOCP) Liu" <liuw-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Xueping Liu <xpliu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Hilbert Zhang <zzhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Ziji Hu <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

Add Xenon eMMC/SD/SDIO host controller core functionality.
Add Xenon specific intialization process.
Add Xenon specific mmc_host_ops APIs.
Add Xenon specific register definitions.

Add CONFIG_MMC_SDHCI_XENON support in drivers/mmc/host/Kconfig.

Marvell Xenon SDHC conforms to SD Physical Layer Specification
Version 3.01 and is designed according to the guidelines provided
in the SD Host Controller Standard Specification Version 3.00.

Signed-off-by: Hu Ziji <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 MAINTAINERS                    |   1 +-
 drivers/mmc/host/Kconfig       |   9 +-
 drivers/mmc/host/Makefile      |   3 +-
 drivers/mmc/host/sdhci-xenon.c | 594 ++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci-xenon.h | 142 ++++++++-
 5 files changed, 749 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-xenon.c
 create mode 100644 drivers/mmc/host/sdhci-xenon.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 850a0afb0c8d..d92f4175574b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7608,6 +7608,7 @@ MARVELL XENON MMC/SD/SDIO HOST CONTROLLER DRIVER
 M:	Ziji Hu <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
 L:	linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 S:	Supported
+F:	drivers/mmc/host/sdhci-xenon.*
 F:	Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
 
 MATROX FRAMEBUFFER DRIVER
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 5274f503a39a..85a53623526a 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -798,3 +798,12 @@ config MMC_SDHCI_BRCMSTB
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
index e2bdaaf43184..75eaf743486c 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -80,3 +80,6 @@ obj-$(CONFIG_MMC_SDHCI_BRCMSTB)		+= sdhci-brcmstb.o
 ifeq ($(CONFIG_CB710_DEBUG),y)
 	CFLAGS-cb710-mmc	+= -DDEBUG
 endif
+
+obj-$(CONFIG_MMC_SDHCI_XENON)	+= sdhci-xenon-driver.o
+sdhci-xenon-driver-y		+= sdhci-xenon.o
diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
new file mode 100644
index 000000000000..3ea059f2aaab
--- /dev/null
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -0,0 +1,594 @@
+/*
+ * Driver for Marvell SOC Platform Group Xenon SDHC as a platform device
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
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/sdio.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+#include <linux/module.h>
+#include <linux/of.h>
+
+#include "sdhci-pltfm.h"
+#include "sdhci.h"
+#include "sdhci-xenon.h"
+
+/* Set SDCLK-off-while-idle */
+static void xenon_set_sdclk_off_idle(struct sdhci_host *host,
+				     unsigned char slot_idx, bool enable)
+{
+	u32 reg;
+	u32 mask;
+
+	reg = sdhci_readl(host, SDHC_SYS_OP_CTRL);
+	/* Get the bit shift basing on the slot index */
+	mask = (0x1 << (SDCLK_IDLEOFF_ENABLE_SHIFT + slot_idx));
+	if (enable)
+		reg |= mask;
+	else
+		reg &= ~mask;
+
+	sdhci_writel(host, reg, SDHC_SYS_OP_CTRL);
+}
+
+/* Enable/Disable the Auto Clock Gating function */
+static void xenon_set_acg(struct sdhci_host *host, bool enable)
+{
+	u32 reg;
+
+	reg = sdhci_readl(host, SDHC_SYS_OP_CTRL);
+	if (enable)
+		reg &= ~AUTO_CLKGATE_DISABLE_MASK;
+	else
+		reg |= AUTO_CLKGATE_DISABLE_MASK;
+	sdhci_writel(host, reg, SDHC_SYS_OP_CTRL);
+}
+
+/* Enable this slot */
+static void xenon_enable_slot(struct sdhci_host *host,
+			      unsigned char slot_idx)
+{
+	u32 reg;
+
+	reg = sdhci_readl(host, SDHC_SYS_OP_CTRL);
+	reg |= (BIT(slot_idx) << SLOT_ENABLE_SHIFT);
+	sdhci_writel(host, reg, SDHC_SYS_OP_CTRL);
+
+	/*
+	 * Manually set the flag which all the slots require,
+	 * including SD, eMMC, SDIO
+	 */
+	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
+}
+
+/* Disable this slot */
+static void xenon_disable_slot(struct sdhci_host *host,
+			       unsigned char slot_idx)
+{
+	u32 reg;
+
+	reg = sdhci_readl(host, SDHC_SYS_OP_CTRL);
+	reg &= ~(BIT(slot_idx) << SLOT_ENABLE_SHIFT);
+	sdhci_writel(host, reg, SDHC_SYS_OP_CTRL);
+}
+
+/* Enable Parallel Transfer Mode */
+static void xenon_enable_slot_parallel_tran(struct sdhci_host *host,
+					    unsigned char slot_idx)
+{
+	u32 reg;
+
+	reg = sdhci_readl(host, SDHC_SYS_EXT_OP_CTRL);
+	reg |= BIT(slot_idx);
+	sdhci_writel(host, reg, SDHC_SYS_EXT_OP_CTRL);
+}
+
+static void xenon_slot_tuning_setup(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	u32 reg;
+
+	/* Disable the Re-Tuning Request functionality */
+	reg = sdhci_readl(host, SDHC_SLOT_RETUNING_REQ_CTRL);
+	reg &= ~RETUNING_COMPATIBLE;
+	sdhci_writel(host, reg, SDHC_SLOT_RETUNING_REQ_CTRL);
+
+	/* Disable the Re-tuning Event Signal Enable */
+	reg = sdhci_readl(host, SDHCI_SIGNAL_ENABLE);
+	reg &= ~SDHCI_INT_RETUNE;
+	sdhci_writel(host, reg, SDHCI_SIGNAL_ENABLE);
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
+				   unsigned char slot_idx, u8 mask)
+{
+	/* Only SOFTWARE RESET ALL will clear the register setting */
+	if (!(mask & SDHCI_RESET_ALL))
+		return;
+
+	/* Disable tuning request and auto-retuning again */
+	xenon_slot_tuning_setup(host);
+
+	xenon_set_acg(host, true);
+
+	xenon_set_sdclk_off_idle(host, slot_idx, false);
+}
+
+static void sdhci_xenon_reset(struct sdhci_host *host, u8 mask)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+
+	sdhci_reset(host, mask);
+	sdhci_xenon_reset_exit(host, priv->slot_idx, mask);
+}
+
+/*
+ * Xenon defines different values for HS200 and SDR104
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
+		ctrl_2 |= XENON_SDHCI_CTRL_HS200;
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
+		ctrl_2 |= XENON_SDHCI_CTRL_HS400;
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
+	if (host->clock > DEFAULT_SDCLK_FREQ) {
+		spin_lock_irqsave(&host->lock, flags);
+		xenon_set_sdclk_off_idle(host, priv->slot_idx, true);
+		spin_unlock_irqrestore(&host->lock, flags);
+	}
+}
+
+static int __emmc_signal_voltage_switch(struct mmc_host *mmc,
+					const unsigned char signal_voltage)
+{
+	u32 ctrl;
+	unsigned char voltage_code;
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	if (signal_voltage == MMC_SIGNAL_VOLTAGE_330)
+		voltage_code = EMMC_VCCQ_3_3V;
+	else if (signal_voltage == MMC_SIGNAL_VOLTAGE_180)
+		voltage_code = EMMC_VCCQ_1_8V;
+	else
+		return -EINVAL;
+
+	/*
+	 * This host is for eMMC, XENON self-defined
+	 * eMMC slot control register should be accessed
+	 * instead of Host Control 2
+	 */
+	ctrl = sdhci_readl(host, SDHC_SLOT_EMMC_CTRL);
+	ctrl &= ~EMMC_VCCQ_MASK;
+	ctrl |= voltage_code;
+	sdhci_writel(host, ctrl, SDHC_SLOT_EMMC_CTRL);
+
+	/* There is no standard to determine this waiting period */
+	usleep_range(1000, 2000);
+
+	/* Check whether io voltage switch is done */
+	ctrl = sdhci_readl(host, SDHC_SLOT_EMMC_CTRL);
+	ctrl &= EMMC_VCCQ_MASK;
+	/*
+	 * This bit is set only when regulator feeds back the voltage switch
+	 * results to Xenon SDHC.
+	 * However, in actaul implementation, regulator might not provide
+	 * this feedback.
+	 * Thus we shall not rely on this bit to determine if switch failed.
+	 * If the bit is not set, just throw a message.
+	 * Besides, error code should not be returned.
+	 */
+	if (ctrl != voltage_code)
+		dev_info(mmc_dev(mmc), "fail to detect eMMC signal voltage stable\n");
+	return 0;
+}
+
+static int xenon_emmc_signal_voltage_switch(struct mmc_host *mmc,
+					    struct mmc_ios *ios)
+{
+	unsigned char voltage = ios->signal_voltage;
+
+	if ((voltage == MMC_SIGNAL_VOLTAGE_330) ||
+	    (voltage == MMC_SIGNAL_VOLTAGE_180))
+		return __emmc_signal_voltage_switch(mmc, voltage);
+
+	dev_err(mmc_dev(mmc), "Unsupported signal voltage: %d\n",
+		voltage);
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
+	if (priv->emmc_slot)
+		return xenon_emmc_signal_voltage_switch(mmc, ios);
+
+	return sdhci_start_signal_voltage_switch(mmc, ios);
+}
+
+/*
+ * After determining which slot is used for SDIO,
+ * some additional task is required.
+ */
+static void xenon_init_card(struct mmc_host *mmc, struct mmc_card *card)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u32 reg;
+	u8 slot_idx;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+
+	/* Link the card for delay adjustment */
+	priv->card_candidate = card;
+	/* Set tuning functionality of this slot */
+	xenon_slot_tuning_setup(host);
+
+	slot_idx = priv->slot_idx;
+	if (!mmc_card_sdio(card)) {
+		/* Clear SDIO Card Inserted indication */
+		reg = sdhci_readl(host, SDHC_SYS_CFG_INFO);
+		reg &= ~(1 << (slot_idx + SLOT_TYPE_SDIO_SHIFT));
+		sdhci_writel(host, reg, SDHC_SYS_CFG_INFO);
+
+		if (mmc_card_mmc(card)) {
+			mmc->caps |= MMC_CAP_NONREMOVABLE;
+			if (!(host->quirks2 & SDHCI_QUIRK2_NO_1_8_V))
+				mmc->caps |= MMC_CAP_1_8V_DDR;
+			/*
+			 * Force to clear BUS_TEST to
+			 * skip bus_test_pre and bus_test_post
+			 */
+			mmc->caps &= ~MMC_CAP_BUS_WIDTH_TEST;
+			mmc->caps2 |= MMC_CAP2_HC_ERASE_SZ |
+				      MMC_CAP2_PACKED_CMD;
+			if (mmc->caps & MMC_CAP_8_BIT_DATA)
+				mmc->caps2 |= MMC_CAP2_HS400_1_8V;
+		}
+	} else {
+		/*
+		 * Set SDIO Card Inserted indication
+		 * to inform that the current slot is for SDIO
+		 */
+		reg = sdhci_readl(host, SDHC_SYS_CFG_INFO);
+		reg |= (1 << (slot_idx + SLOT_TYPE_SDIO_SHIFT));
+		sdhci_writel(host, reg, SDHC_SYS_CFG_INFO);
+	}
+}
+
+static int xenon_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	if (host->timing == MMC_TIMING_UHS_DDR50)
+		return 0;
+
+	return sdhci_execute_tuning(mmc, opcode);
+}
+
+static void xenon_replace_mmc_host_ops(struct sdhci_host *host)
+{
+	host->mmc_host_ops.set_ios = xenon_set_ios;
+	host->mmc_host_ops.start_signal_voltage_switch =
+			xenon_start_signal_voltage_switch;
+	host->mmc_host_ops.init_card = xenon_init_card;
+	host->mmc_host_ops.execute_tuning = xenon_execute_tuning;
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
+	u32 slot_idx, nr_slot;
+	u32 tuning_count;
+	u32 reg;
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
+	 * emmc: explicitly indicate whether this slot is for eMMC
+	 * slotno: the index of slot. Refer to SDHC_SYS_CFG_INFO register
+	 * tun-count: the interval between re-tuning
+	 * PHY type: "sdhc phy", "emmc phy 5.0" or "emmc phy 5.1"
+	 */
+	if (of_property_read_bool(np, "marvell,xenon-emmc"))
+		priv->emmc_slot = true;
+	else
+		priv->emmc_slot = false;
+
+	if (!of_property_read_u32(np, "marvell,xenon-slotno", &slot_idx)) {
+		nr_slot = sdhci_readl(host, SDHC_SYS_CFG_INFO);
+		nr_slot &= NR_SUPPORTED_SLOT_MASK;
+		if (unlikely(slot_idx > nr_slot)) {
+			dev_err(mmc_dev(mmc), "Slot Index %d exceeds Number of slots %d\n",
+				slot_idx, nr_slot);
+			return -EINVAL;
+		}
+	} else {
+		priv->slot_idx = 0x0;
+	}
+
+	if (!of_property_read_u32(np, "marvell,xenon-tun-count",
+				  &tuning_count)) {
+		if (unlikely(tuning_count >= TMR_RETUN_NO_PRESENT)) {
+			dev_err(mmc_dev(mmc), "Wrong Re-tuning Count. Set default value %d\n",
+				DEF_TUNING_COUNT);
+			tuning_count = DEF_TUNING_COUNT;
+		}
+	} else {
+		priv->tuning_count = DEF_TUNING_COUNT;
+	}
+
+	if (of_property_read_bool(np, "marvell,xenon-mask-conflict-err")) {
+		reg = sdhci_readl(host, SDHC_SYS_EXT_OP_CTRL);
+		reg |= MASK_CMD_CONFLICT_ERROR;
+		sdhci_writel(host, reg, SDHC_SYS_EXT_OP_CTRL);
+	}
+
+	return err;
+}
+
+static int xenon_slot_probe(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	u8 slot_idx = priv->slot_idx;
+
+	/* Enable slot */
+	xenon_enable_slot(host, slot_idx);
+
+	/* Enable ACG */
+	xenon_set_acg(host, true);
+
+	/* Enable Parallel Transfer Mode */
+	xenon_enable_slot_parallel_tran(host, slot_idx);
+
+	priv->timing = MMC_TIMING_FAKE;
+	priv->clock = 0;
+
+	return 0;
+}
+
+static void xenon_slot_remove(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	u8 slot_idx = priv->slot_idx;
+
+	/* disable slot */
+	xenon_disable_slot(host, slot_idx);
+}
+
+static int sdhci_xenon_probe(struct platform_device *pdev)
+{
+	struct sdhci_pltfm_host *pltfm_host;
+	struct sdhci_host *host;
+	struct clk *clk, *axi_clk;
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
+	clk = devm_clk_get(&pdev->dev, "core");
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "Failed to setup input clk.\n");
+		err = PTR_ERR(clk);
+		goto free_pltfm;
+	}
+	clk_prepare_enable(clk);
+	pltfm_host->clk = clk;
+
+	/*
+	 * Some SOCs require additional clock to
+	 * manage AXI bus clock.
+	 * It is optional.
+	 */
+	axi_clk = devm_clk_get(&pdev->dev, "axi");
+	if (!IS_ERR(axi_clk)) {
+		clk_prepare_enable(axi_clk);
+		priv->axi_clk = axi_clk;
+	}
+
+	err = xenon_probe_dt(pdev);
+	if (err)
+		goto err_clk;
+
+	err = xenon_slot_probe(host);
+	if (err)
+		goto err_clk;
+
+	err = sdhci_add_host(host);
+	if (err)
+		goto remove_slot;
+
+	return 0;
+
+remove_slot:
+	xenon_slot_remove(host);
+err_clk:
+	clk_disable_unprepare(pltfm_host->clk);
+	if (!IS_ERR(axi_clk))
+		clk_disable_unprepare(axi_clk);
+free_pltfm:
+	sdhci_pltfm_free(pdev);
+	return err;
+}
+
+static int sdhci_xenon_remove(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xFFFFFFFF);
+
+	xenon_slot_remove(host);
+
+	sdhci_remove_host(host, dead);
+
+	clk_disable_unprepare(pltfm_host->clk);
+	clk_disable_unprepare(priv->axi_clk);
+
+	sdhci_pltfm_free(pdev);
+
+	return 0;
+}
+
+static const struct of_device_id sdhci_xenon_dt_ids[] = {
+	{ .compatible = "marvell,xenon-sdhci",},
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
index 000000000000..4601d0a4b22f
--- /dev/null
+++ b/drivers/mmc/host/sdhci-xenon.h
@@ -0,0 +1,142 @@
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
+#include <linux/clk.h>
+#include <linux/mmc/card.h>
+#include <linux/of.h>
+#include "sdhci.h"
+
+/* Register Offset of SD Host Controller SOCP self-defined register */
+#define SDHC_SYS_CFG_INFO			0x0104
+#define SLOT_TYPE_SDIO_SHIFT			24
+#define SLOT_TYPE_EMMC_MASK			0xFF
+#define SLOT_TYPE_EMMC_SHIFT			16
+#define SLOT_TYPE_SD_SDIO_MMC_MASK		0xFF
+#define SLOT_TYPE_SD_SDIO_MMC_SHIFT		8
+#define NR_SUPPORTED_SLOT_MASK			0x7
+
+#define SDHC_SYS_OP_CTRL			0x0108
+#define AUTO_CLKGATE_DISABLE_MASK		BIT(20)
+#define SDCLK_IDLEOFF_ENABLE_SHIFT		8
+#define SLOT_ENABLE_SHIFT			0
+
+#define SDHC_SYS_EXT_OP_CTRL			0x010C
+#define MASK_CMD_CONFLICT_ERROR			BIT(8)
+
+#define SDHC_SLOT_OP_STATUS_CTRL		0x0128
+#define DELAY_90_DEGREE_MASK_EMMC5		BIT(7)
+#define DELAY_90_DEGREE_SHIFT_EMMC5		7
+#define EMMC_5_0_PHY_FIXED_DELAY_MASK		0x7F
+#define EMMC_PHY_FIXED_DELAY_MASK		0xFF
+#define EMMC_PHY_FIXED_DELAY_WINDOW_MIN		(EMMC_PHY_FIXED_DELAY_MASK >> 3)
+#define SDH_PHY_FIXED_DELAY_MASK		0x1FF
+#define SDH_PHY_FIXED_DELAY_WINDOW_MIN		(SDH_PHY_FIXED_DELAY_MASK >> 4)
+
+#define TUN_CONSECUTIVE_TIMES_SHIFT		16
+#define TUN_CONSECUTIVE_TIMES_MASK		0x7
+#define TUN_CONSECUTIVE_TIMES			0x4
+#define TUNING_STEP_SHIFT			12
+#define TUNING_STEP_MASK			0xF
+#define TUNING_STEP_DIVIDER			BIT(6)
+
+#define FORCE_SEL_INVERSE_CLK_SHIFT		11
+
+#define SDHC_SLOT_EMMC_CTRL			0x0130
+#define ENABLE_DATA_STROBE			BIT(24)
+#define SET_EMMC_RSTN				BIT(16)
+#define DISABLE_RD_DATA_CRC			BIT(14)
+#define DISABLE_CRC_STAT_TOKEN			BIT(13)
+#define EMMC_VCCQ_MASK				0x3
+#define EMMC_VCCQ_1_8V				0x1
+#define EMMC_VCCQ_3_3V				0x3
+
+#define SDHC_SLOT_RETUNING_REQ_CTRL		0x0144
+/* retuning compatible */
+#define RETUNING_COMPATIBLE			0x1
+
+#define SDHC_SLOT_EXT_PRESENT_STATE		0x014C
+#define LOCK_STATE				0x1
+
+#define SDHC_SLOT_DLL_CUR_DLY_VAL		0x0150
+
+/* Tuning Parameter */
+#define TMR_RETUN_NO_PRESENT			0xF
+#define DEF_TUNING_COUNT			0x9
+
+#define MMC_TIMING_FAKE				0xFF
+
+#define DEFAULT_SDCLK_FREQ			(400000)
+
+/* Xenon specific Mode Select value */
+#define XENON_SDHCI_CTRL_HS200			0x5
+#define XENON_SDHCI_CTRL_HS400			0x6
+
+struct sdhci_xenon_priv {
+	/*
+	 * The bus_width, timing, and clock fields in below
+	 * record the current setting of Xenon SDHC.
+	 * Driver will call a Sampling Fixed Delay Adjustment
+	 * if any setting is changed.
+	 */
+	unsigned char	bus_width;
+	unsigned char	timing;
+	unsigned char	tuning_count;
+	unsigned int	clock;
+	struct clk	*axi_clk;
+
+	/* Slot idx */
+	u8		slot_idx;
+	/* Whether this slot is for eMMC */
+	bool		emmc_slot;
+
+	/*
+	 * When initializing card, Xenon has to determine card type and
+	 * adjust Sampling Fixed delay for the speed mode in which
+	 * DLL tuning is not support.
+	 * However, at that time, card structure is not linked to mmc_host.
+	 * Thus a card pointer is added here to provide
+	 * the delay adjustment function with the card structure
+	 * of the card during initialization.
+	 *
+	 * It is only valid during initialization after it is updated in
+	 * xenon_init_card().
+	 * Do not access this variable in normal transfers after
+	 * initialization completes.
+	 */
+	struct mmc_card *card_candidate;
+};
+
+static inline int enable_xenon_internal_clk(struct sdhci_host *host)
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
+#endif
-- 
git-series 0.8.10
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
