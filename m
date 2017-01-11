From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v5 07/12] mmc: sdhci-xenon: Add support to PHYs of Marvell Xenon SDHC.
Date: Wed, 11 Jan 2017 18:19:10 +0100
Message-ID: <130ccd5a0fe4f822b954e0256c9dccec0b6ca523.1484154449.git-series.gregory.clement@free-electrons.com>
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

Marvell Xenon eMMC/SD/SDIO Host Controller contains PHY.
Multiple types of PHYs are supported.

Add support to multiple types of PHYs init and configuration.
Add register definitions of PHYs.

Xenon PHY cannot fit in kernel common PHY framework.
Xenon SDHC PHY register is a part of Xenon SDHC register set.
Besides, MMC initialization has to call several PHY functions to
complete timing setting.
Those PHY setting functions have to access SDHC registers and know
current MMC setting, such as bus width, clock frequency and
speed mode.
As a result, implement Xenon PHY in MMC host directory.

Signed-off-by: Hu Ziji <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Tested-by: Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/mmc/host/Makefile          |   2 +-
 drivers/mmc/host/sdhci-xenon-phy.c | 790 ++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci-xenon.c     |   3 +-
 drivers/mmc/host/sdhci-xenon.h     |  37 +-
 4 files changed, 830 insertions(+), 2 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-xenon-phy.c

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index b0a2ab4b256e..893b48db5513 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -84,4 +84,4 @@ ifeq ($(CONFIG_CB710_DEBUG),y)
 endif
 
 obj-$(CONFIG_MMC_SDHCI_XENON)	+= sdhci-xenon-driver.o
-sdhci-xenon-driver-y		+= sdhci-xenon.o
+sdhci-xenon-driver-y		+= sdhci-xenon.o sdhci-xenon-phy.o
diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
new file mode 100644
index 000000000000..f410712d24ea
--- /dev/null
+++ b/drivers/mmc/host/sdhci-xenon-phy.c
@@ -0,0 +1,790 @@
+/*
+ * PHY support for Xenon SDHC
+ *
+ * Copyright (C) 2016 Marvell, All Rights Reserved.
+ *
+ * Author:	Hu Ziji <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
+ * Date:	2016-8-24
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ */
+
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/of_address.h>
+
+#include "sdhci-pltfm.h"
+#include "sdhci-xenon.h"
+
+/* Register base for eMMC PHY 5.0 Version */
+#define XENON_EMMC_5_0_PHY_REG_BASE		0x0160
+/* Register base for eMMC PHY 5.1 Version */
+#define XENON_EMMC_PHY_REG_BASE			0x0170
+
+#define XENON_EMMC_PHY_TIMING_ADJUST		XENON_EMMC_PHY_REG_BASE
+#define XENON_EMMC_5_0_PHY_TIMING_ADJUST	XENON_EMMC_5_0_PHY_REG_BASE
+#define XENON_TIMING_ADJUST_SLOW_MODE		BIT(29)
+#define XENON_TIMING_ADJUST_SDIO_MODE		BIT(28)
+#define XENON_OUTPUT_QSN_PHASE_SELECT		BIT(17)
+#define XENON_SAMPL_INV_QSP_PHASE_SELECT	BIT(18)
+#define XENON_SAMPL_INV_QSP_PHASE_SELECT_SHIFT	18
+#define XENON_PHY_INITIALIZAION			BIT(31)
+#define XENON_WAIT_CYCLE_BEFORE_USING_MASK	0xF
+#define XENON_WAIT_CYCLE_BEFORE_USING_SHIFT	12
+#define XENON_FC_SYNC_EN_DURATION_MASK		0xF
+#define XENON_FC_SYNC_EN_DURATION_SHIFT		8
+#define XENON_FC_SYNC_RST_EN_DURATION_MASK	0xF
+#define XENON_FC_SYNC_RST_EN_DURATION_SHIFT	4
+#define XENON_FC_SYNC_RST_DURATION_MASK		0xF
+#define XENON_FC_SYNC_RST_DURATION_SHIFT	0
+
+#define XENON_EMMC_PHY_FUNC_CONTROL		(XENON_EMMC_PHY_REG_BASE + 0x4)
+#define XENON_EMMC_5_0_PHY_FUNC_CONTROL		\
+	(XENON_EMMC_5_0_PHY_REG_BASE + 0x4)
+#define XENON_ASYNC_DDRMODE_MASK		BIT(23)
+#define XENON_ASYNC_DDRMODE_SHIFT		23
+#define XENON_CMD_DDR_MODE			BIT(16)
+#define XENON_DQ_DDR_MODE_SHIFT			8
+#define XENON_DQ_DDR_MODE_MASK			0xFF
+#define XENON_DQ_ASYNC_MODE			BIT(4)
+
+#define XENON_EMMC_PHY_PAD_CONTROL		(XENON_EMMC_PHY_REG_BASE + 0x8)
+#define XENON_EMMC_5_0_PHY_PAD_CONTROL		\
+	(XENON_EMMC_5_0_PHY_REG_BASE + 0x8)
+#define XENON_REC_EN_SHIFT			24
+#define XENON_REC_EN_MASK			0xF
+#define XENON_FC_DQ_RECEN			BIT(24)
+#define XENON_FC_CMD_RECEN			BIT(25)
+#define XENON_FC_QSP_RECEN			BIT(26)
+#define XENON_FC_QSN_RECEN			BIT(27)
+#define XENON_OEN_QSN				BIT(28)
+#define XENON_AUTO_RECEN_CTRL			BIT(30)
+#define XENON_FC_ALL_CMOS_RECEIVER		0xF000
+
+#define XENON_EMMC5_FC_QSP_PD			BIT(18)
+#define XENON_EMMC5_FC_QSP_PU			BIT(22)
+#define XENON_EMMC5_FC_CMD_PD			BIT(17)
+#define XENON_EMMC5_FC_CMD_PU			BIT(21)
+#define XENON_EMMC5_FC_DQ_PD			BIT(16)
+#define XENON_EMMC5_FC_DQ_PU			BIT(20)
+
+#define XENON_EMMC_PHY_PAD_CONTROL1		(XENON_EMMC_PHY_REG_BASE + 0xC)
+#define XENON_EMMC5_1_FC_QSP_PD			BIT(9)
+#define XENON_EMMC5_1_FC_QSP_PU			BIT(25)
+#define XENON_EMMC5_1_FC_CMD_PD			BIT(8)
+#define XENON_EMMC5_1_FC_CMD_PU			BIT(24)
+#define XENON_EMMC5_1_FC_DQ_PD			0xFF
+#define XENON_EMMC5_1_FC_DQ_PU			(0xFF << 16)
+
+#define XENON_EMMC_PHY_PAD_CONTROL2		(XENON_EMMC_PHY_REG_BASE + 0x10)
+#define XENON_EMMC_5_0_PHY_PAD_CONTROL2		\
+	(XENON_EMMC_5_0_PHY_REG_BASE + 0xC)
+#define XENON_ZNR_MASK				0x1F
+#define XENON_ZNR_SHIFT				8
+#define XENON_ZPR_MASK				0x1F
+/* Perferred ZNR and ZPR value vary between different boards.
+ * The specific ZNR and ZPR value should be defined here
+ * according to board actual timing.
+ */
+#define XENON_ZNR_DEF_VALUE			0xF
+#define XENON_ZPR_DEF_VALUE			0xF
+
+#define XENON_EMMC_PHY_DLL_CONTROL		(XENON_EMMC_PHY_REG_BASE + 0x14)
+#define XENON_EMMC_5_0_PHY_DLL_CONTROL		\
+	(XENON_EMMC_5_0_PHY_REG_BASE + 0x10)
+#define XENON_DLL_ENABLE			BIT(31)
+#define XENON_DLL_UPDATE_STROBE_5_0		BIT(30)
+#define XENON_DLL_REFCLK_SEL			BIT(30)
+#define XENON_DLL_UPDATE			BIT(23)
+#define XENON_DLL_PHSEL1_SHIFT			24
+#define XENON_DLL_PHSEL0_SHIFT			16
+#define XENON_DLL_PHASE_MASK			0x3F
+#define XENON_DLL_PHASE_90_DEGREE		0x1F
+#define XENON_DLL_FAST_LOCK			BIT(5)
+#define XENON_DLL_GAIN2X			BIT(3)
+#define XENON_DLL_BYPASS_EN			BIT(0)
+
+#define XENON_EMMC_5_0_PHY_LOGIC_TIMING_ADJUST	\
+	(XENON_EMMC_5_0_PHY_REG_BASE + 0x14)
+#define XENON_EMMC_PHY_LOGIC_TIMING_ADJUST	(XENON_EMMC_PHY_REG_BASE + 0x18)
+#define XENON_LOGIC_TIMING_VALUE		0x00AA8977
+
+/*
+ * List offset of PHY registers and some special register values
+ * in eMMC PHY 5.0 or eMMC PHY 5.1
+ */
+struct xenon_emmc_phy_regs {
+	/* Offset of Timing Adjust register */
+	u16 timing_adj;
+	/* Offset of Func Control register */
+	u16 func_ctrl;
+	/* Offset of Pad Control register */
+	u16 pad_ctrl;
+	/* Offset of Pad Control register 2 */
+	u16 pad_ctrl2;
+	/* Offset of DLL Control register */
+	u16 dll_ctrl;
+	/* Offset of Logic Timing Adjust register */
+	u16 logic_timing_adj;
+	/* DLL Update Enable bit */
+	u32 dll_update;
+};
+
+static const char * const phy_types[] = {
+	"emmc 5.0 phy",
+	"emmc 5.1 phy"
+};
+
+enum phy_type_enum {
+	EMMC_5_0_PHY,
+	EMMC_5_1_PHY,
+	NR_PHY_TYPES
+};
+
+static struct xenon_emmc_phy_regs xenon_emmc_5_0_phy_regs = {
+	.timing_adj	= XENON_EMMC_5_0_PHY_TIMING_ADJUST,
+	.func_ctrl	= XENON_EMMC_5_0_PHY_FUNC_CONTROL,
+	.pad_ctrl	= XENON_EMMC_5_0_PHY_PAD_CONTROL,
+	.pad_ctrl2	= XENON_EMMC_5_0_PHY_PAD_CONTROL2,
+	.dll_ctrl	= XENON_EMMC_5_0_PHY_DLL_CONTROL,
+	.logic_timing_adj = XENON_EMMC_5_0_PHY_LOGIC_TIMING_ADJUST,
+	.dll_update	= XENON_DLL_UPDATE_STROBE_5_0,
+};
+
+static struct xenon_emmc_phy_regs xenon_emmc_5_1_phy_regs = {
+	.timing_adj	= XENON_EMMC_PHY_TIMING_ADJUST,
+	.func_ctrl	= XENON_EMMC_PHY_FUNC_CONTROL,
+	.pad_ctrl	= XENON_EMMC_PHY_PAD_CONTROL,
+	.pad_ctrl2	= XENON_EMMC_PHY_PAD_CONTROL2,
+	.dll_ctrl	= XENON_EMMC_PHY_DLL_CONTROL,
+	.logic_timing_adj = XENON_EMMC_PHY_LOGIC_TIMING_ADJUST,
+	.dll_update	= XENON_DLL_UPDATE,
+};
+
+/*
+ * eMMC PHY configuration and operations
+ */
+struct emmc_phy_params {
+	bool	slow_mode;
+
+	u8	znr;
+	u8	zpr;
+
+	/* Nr of consecutive Sampling Points of a Valid Sampling Window */
+	u8	nr_tun_times;
+	/* Divider for calculating Tuning Step */
+	u8	tun_step_divider;
+};
+
+static int alloc_emmc_phy(struct sdhci_xenon_priv *priv)
+{
+	struct emmc_phy_params *params;
+
+	params = kzalloc(sizeof(*params), GFP_KERNEL);
+	if (!params)
+		return -ENOMEM;
+
+	priv->phy_params = params;
+	if (priv->phy_type == EMMC_5_0_PHY)
+		priv->emmc_phy_regs = &xenon_emmc_5_0_phy_regs;
+	else
+		priv->emmc_phy_regs = &xenon_emmc_5_1_phy_regs;
+
+	return 0;
+}
+
+/*
+ * eMMC 5.0/5.1 PHY init/re-init.
+ * eMMC PHY init should be executed after:
+ * 1. SDCLK frequecny changes.
+ * 2. SDCLK is stopped and re-enabled.
+ * 3. config in emmc_phy_regs->timing_adj and emmc_phy_regs->func_ctrl
+ * are changed
+ */
+static int emmc_phy_init(struct sdhci_host *host)
+{
+	u32 reg;
+	u32 wait, clock;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	struct xenon_emmc_phy_regs *phy_regs = priv->emmc_phy_regs;
+
+	reg = sdhci_readl(host, phy_regs->timing_adj);
+	reg |= XENON_PHY_INITIALIZAION;
+	sdhci_writel(host, reg, phy_regs->timing_adj);
+
+	/* Add duration of FC_SYNC_RST */
+	wait = ((reg >> XENON_FC_SYNC_RST_DURATION_SHIFT) &
+			XENON_FC_SYNC_RST_DURATION_MASK);
+	/* Add interval between FC_SYNC_EN and FC_SYNC_RST */
+	wait += ((reg >> XENON_FC_SYNC_RST_EN_DURATION_SHIFT) &
+			XENON_FC_SYNC_RST_EN_DURATION_MASK);
+	/* Add duration of asserting FC_SYNC_EN */
+	wait += ((reg >> XENON_FC_SYNC_EN_DURATION_SHIFT) &
+			XENON_FC_SYNC_EN_DURATION_MASK);
+	/* Add duration of waiting for PHY */
+	wait += ((reg >> XENON_WAIT_CYCLE_BEFORE_USING_SHIFT) &
+			XENON_WAIT_CYCLE_BEFORE_USING_MASK);
+	/* 4 addtional bus clock and 4 AXI bus clock are required */
+	wait += 8;
+	wait <<= 20;
+
+	clock = host->clock;
+	if (!clock)
+		/* Use the possibly slowest bus frequency value */
+		clock = XENON_LOWEST_SDCLK_FREQ;
+	/* get the wait time */
+	wait /= clock;
+	wait++;
+	/* wait for host eMMC PHY init completes */
+	udelay(wait);
+
+	reg = sdhci_readl(host, phy_regs->timing_adj);
+	reg &= XENON_PHY_INITIALIZAION;
+	if (reg) {
+		dev_err(mmc_dev(host->mmc), "eMMC PHY init cannot complete after %d us\n",
+			wait);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+/*
+ * Enable eMMC PHY HW DLL
+ * DLL should be enabled and stable before HS200/SDR104 tuning,
+ * and before HS400 data strobe setting.
+ */
+static int emmc_phy_enable_dll(struct sdhci_host *host)
+{
+	u32 reg;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	struct xenon_emmc_phy_regs *phy_regs = priv->emmc_phy_regs;
+	u8 timeout;
+
+	if (WARN_ON(host->clock <= MMC_HIGH_52_MAX_DTR))
+		return -EINVAL;
+
+	reg = sdhci_readl(host, phy_regs->dll_ctrl);
+	if (reg & XENON_DLL_ENABLE)
+		return 0;
+
+	/* Enable DLL */
+	reg = sdhci_readl(host, phy_regs->dll_ctrl);
+	reg |= (XENON_DLL_ENABLE | XENON_DLL_FAST_LOCK);
+
+	/*
+	 * Set Phase as 90 degree, which is most common value.
+	 * Might set another value if necessary.
+	 * The granularity is 1 degree.
+	 */
+	reg &= ~((XENON_DLL_PHASE_MASK << XENON_DLL_PHSEL0_SHIFT) |
+		 (XENON_DLL_PHASE_MASK << XENON_DLL_PHSEL1_SHIFT));
+	reg |= ((XENON_DLL_PHASE_90_DEGREE << XENON_DLL_PHSEL0_SHIFT) |
+		(XENON_DLL_PHASE_90_DEGREE << XENON_DLL_PHSEL1_SHIFT));
+
+	reg &= ~XENON_DLL_BYPASS_EN;
+	reg |= phy_regs->dll_update;
+	if (priv->phy_type == EMMC_5_1_PHY)
+		reg &= ~XENON_DLL_REFCLK_SEL;
+	sdhci_writel(host, reg, phy_regs->dll_ctrl);
+
+	/* Wait max 32 ms */
+	timeout = 32;
+	while (!(sdhci_readw(host, XENON_SLOT_EXT_PRESENT_STATE) &
+		XENON_DLL_LOCK_STATE)) {
+		if (!timeout) {
+			dev_err(mmc_dev(host->mmc), "Wait for DLL Lock time-out\n");
+			return -ETIMEDOUT;
+		}
+		timeout--;
+		mdelay(1);
+	}
+	return 0;
+}
+
+/*
+ * Config to eMMC PHY to prepare for tuning.
+ * Enable HW DLL and set the TUNING_STEP
+ */
+static int emmc_phy_config_tuning(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	struct emmc_phy_params *params = priv->phy_params;
+	u32 reg, tuning_step;
+	int ret;
+	unsigned long flags;
+
+	if (WARN_ON(host->clock <= MMC_HIGH_52_MAX_DTR))
+		return -EINVAL;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	ret = emmc_phy_enable_dll(host);
+	if (ret) {
+		spin_unlock_irqrestore(&host->lock, flags);
+		return ret;
+	}
+
+	/* Achieve TUNGING_STEP with HW DLL help */
+	reg = sdhci_readl(host, XENON_SLOT_DLL_CUR_DLY_VAL);
+	tuning_step = reg / params->tun_step_divider;
+	if (unlikely(tuning_step > XENON_TUNING_STEP_MASK)) {
+		dev_warn(mmc_dev(host->mmc),
+			 "HS200 TUNING_STEP %d is larger than MAX value\n",
+			 tuning_step);
+		tuning_step = XENON_TUNING_STEP_MASK;
+	}
+
+	/* Set TUNING_STEP for later tuning */
+	reg = sdhci_readl(host, XENON_SLOT_OP_STATUS_CTRL);
+	reg &= ~(XENON_TUN_CONSECUTIVE_TIMES_MASK <<
+		 XENON_TUN_CONSECUTIVE_TIMES_SHIFT);
+	reg |= (params->nr_tun_times << XENON_TUN_CONSECUTIVE_TIMES_SHIFT);
+	reg &= ~(XENON_TUNING_STEP_MASK << XENON_TUNING_STEP_SHIFT);
+	reg |= (tuning_step << XENON_TUNING_STEP_SHIFT);
+	sdhci_writel(host, reg, XENON_SLOT_OP_STATUS_CTRL);
+
+	spin_unlock_irqrestore(&host->lock, flags);
+	return 0;
+}
+
+static void __emmc_phy_disable_data_strobe(struct sdhci_host *host)
+{
+	u32 reg;
+
+	/* Disable SDHC Data Strobe */
+	reg = sdhci_readl(host, XENON_SLOT_EMMC_CTRL);
+	reg &= ~XENON_ENABLE_DATA_STROBE;
+	sdhci_writel(host, reg, XENON_SLOT_EMMC_CTRL);
+}
+
+/* Set HS400 Data Strobe */
+static void emmc_phy_strobe_delay_adj(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	unsigned long flags;
+	u32 reg;
+
+	if (WARN_ON(host->timing != MMC_TIMING_MMC_HS400))
+		return;
+
+	if (host->clock <= MMC_HIGH_52_MAX_DTR)
+		return;
+
+	dev_dbg(mmc_dev(host->mmc), "starts HS400 strobe delay adjustment\n");
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	emmc_phy_enable_dll(host);
+
+	/* Enable SDHC Data Strobe */
+	reg = sdhci_readl(host, XENON_SLOT_EMMC_CTRL);
+	reg |= XENON_ENABLE_DATA_STROBE;
+	sdhci_writel(host, reg, XENON_SLOT_EMMC_CTRL);
+
+	/* Set Data Strobe Pull down */
+	if (priv->phy_type == EMMC_5_0_PHY) {
+		reg = sdhci_readl(host, XENON_EMMC_5_0_PHY_PAD_CONTROL);
+		reg |= XENON_EMMC5_FC_QSP_PD;
+		reg &= ~XENON_EMMC5_FC_QSP_PU;
+		sdhci_writel(host, reg, XENON_EMMC_5_0_PHY_PAD_CONTROL);
+	} else {
+		reg = sdhci_readl(host, XENON_EMMC_PHY_PAD_CONTROL1);
+		reg |= XENON_EMMC5_1_FC_QSP_PD;
+		reg &= ~XENON_EMMC5_1_FC_QSP_PU;
+		sdhci_writel(host, reg, XENON_EMMC_PHY_PAD_CONTROL1);
+	}
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
+static inline bool temp_stage_hs200_to_hs400(struct sdhci_host *host,
+					     struct sdhci_xenon_priv *priv)
+{
+	/*
+	 * Tmep stages from HS200 to HS400
+	 * from HS200 to HS in 200MHz
+	 * from 200MHz to 52MHz
+	 */
+	if (((priv->timing == MMC_TIMING_MMC_HS200) &&
+	     (host->timing == MMC_TIMING_MMC_HS)) ||
+	    ((host->timing == MMC_TIMING_MMC_HS) &&
+	     (priv->clock > host->clock)))
+		return true;
+
+	return false;
+}
+
+static inline bool temp_stage_hs400_to_h200(struct sdhci_host *host,
+					    struct sdhci_xenon_priv *priv)
+{
+	/*
+	 * Temp stages from HS400 t0 HS200:
+	 * from 200MHz to 52MHz in HS400
+	 * from HS400 to HS DDR in 52MHz
+	 * from HS DDR to HS in 52MHz
+	 * from HS to HS200 in 52MHz
+	 */
+	if (((priv->timing == MMC_TIMING_MMC_HS400) &&
+	     ((host->clock == MMC_HIGH_52_MAX_DTR) ||
+	      (host->timing == MMC_TIMING_MMC_DDR52))) ||
+	    ((priv->timing == MMC_TIMING_MMC_DDR52) &&
+	     (host->timing == MMC_TIMING_MMC_HS)) ||
+	    ((host->timing == MMC_TIMING_MMC_HS200) &&
+	     (host->clock == MMC_HIGH_52_MAX_DTR)))
+		return true;
+
+	return false;
+}
+
+/*
+ * If eMMC PHY Slow Mode is required in lower speed mode in SDR mode
+ * (SDLCK < 55MHz), enable Slow Mode to bypass eMMC PHY.
+ * SDIO slower SDR mode also requires Slow Mode.
+ *
+ * If Slow Mode is enabled, return true.
+ * Otherwise, return false.
+ */
+static bool emmc_phy_slow_mode(struct sdhci_host *host,
+			       unsigned char timing)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	struct emmc_phy_params *params = priv->phy_params;
+	struct xenon_emmc_phy_regs *phy_regs = priv->emmc_phy_regs;
+	u32 reg;
+
+	/* Skip temp stages from HS200 to HS400 */
+	if (temp_stage_hs200_to_hs400(host, priv))
+		return false;
+
+	/* Skip temp stages from HS400 t0 HS200 */
+	if (temp_stage_hs400_to_h200(host, priv))
+		return false;
+
+	reg = sdhci_readl(host, phy_regs->timing_adj);
+	/* Enable Slow Mode for SDIO in slower SDR mode */
+	if ((priv->init_card_type == MMC_TYPE_SDIO) &&
+	    ((timing == MMC_TIMING_UHS_SDR25) ||
+	     (timing == MMC_TIMING_UHS_SDR12) ||
+	     (timing == MMC_TIMING_SD_HS) ||
+	     (timing == MMC_TIMING_LEGACY))) {
+		reg |= XENON_TIMING_ADJUST_SLOW_MODE;
+		sdhci_writel(host, reg, phy_regs->timing_adj);
+		return true;
+	}
+
+	/* Check if Slow Mode is required in lower speed mode in SDR mode */
+	if (((timing == MMC_TIMING_UHS_SDR50) ||
+	     (timing == MMC_TIMING_UHS_SDR25) ||
+	     (timing == MMC_TIMING_UHS_SDR12) ||
+	     (timing == MMC_TIMING_SD_HS) ||
+	     (timing == MMC_TIMING_MMC_HS) ||
+	     (timing == MMC_TIMING_LEGACY)) && params->slow_mode) {
+		reg |= XENON_TIMING_ADJUST_SLOW_MODE;
+		sdhci_writel(host, reg, phy_regs->timing_adj);
+		return true;
+	}
+
+	reg &= ~XENON_TIMING_ADJUST_SLOW_MODE;
+	sdhci_writel(host, reg, phy_regs->timing_adj);
+	return false;
+}
+
+/*
+ * Set-up eMMC 5.0/5.1 PHY.
+ * Specific onfiguration depends on the current speed mode in use.
+ */
+static void emmc_phy_set(struct sdhci_host *host,
+			 unsigned char timing)
+{
+	u32 reg;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	struct emmc_phy_params *params = priv->phy_params;
+	struct xenon_emmc_phy_regs *phy_regs = priv->emmc_phy_regs;
+	unsigned long flags;
+
+	dev_dbg(mmc_dev(host->mmc), "eMMC PHY setting starts\n");
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	/* Setup pad, set bit[28] and bits[26:24] */
+	reg = sdhci_readl(host, phy_regs->pad_ctrl);
+	reg |= (XENON_FC_DQ_RECEN | XENON_FC_CMD_RECEN |
+		XENON_FC_QSP_RECEN | XENON_OEN_QSN);
+	/* All FC_XX_RECEIVCE should be set as CMOS Type */
+	reg |= XENON_FC_ALL_CMOS_RECEIVER;
+	sdhci_writel(host, reg, phy_regs->pad_ctrl);
+
+	/* Set CMD and DQ Pull Up */
+	if (priv->phy_type == EMMC_5_0_PHY) {
+		reg = sdhci_readl(host, XENON_EMMC_5_0_PHY_PAD_CONTROL);
+		reg |= (XENON_EMMC5_FC_CMD_PU | XENON_EMMC5_FC_DQ_PU);
+		reg &= ~(XENON_EMMC5_FC_CMD_PD | XENON_EMMC5_FC_DQ_PD);
+		sdhci_writel(host, reg, XENON_EMMC_5_0_PHY_PAD_CONTROL);
+	} else {
+		reg = sdhci_readl(host, XENON_EMMC_PHY_PAD_CONTROL1);
+		reg |= (XENON_EMMC5_1_FC_CMD_PU | XENON_EMMC5_1_FC_DQ_PU);
+		reg &= ~(XENON_EMMC5_1_FC_CMD_PD | XENON_EMMC5_1_FC_DQ_PD);
+		sdhci_writel(host, reg, XENON_EMMC_PHY_PAD_CONTROL1);
+	}
+
+	if (timing == MMC_TIMING_LEGACY)
+		goto phy_init;
+
+	/*
+	 * FIXME: should depends on the specific board timing.
+	 */
+	if ((timing == MMC_TIMING_MMC_HS400) ||
+	    (timing == MMC_TIMING_MMC_HS200) ||
+	    (timing == MMC_TIMING_UHS_SDR50) ||
+	    (timing == MMC_TIMING_UHS_SDR104) ||
+	    (timing == MMC_TIMING_UHS_DDR50) ||
+	    (timing == MMC_TIMING_UHS_SDR25) ||
+	    (timing == MMC_TIMING_MMC_DDR52)) {
+		reg = sdhci_readl(host, phy_regs->timing_adj);
+		reg &= ~XENON_OUTPUT_QSN_PHASE_SELECT;
+		sdhci_writel(host, reg, phy_regs->timing_adj);
+	}
+
+	/*
+	 * If SDIO card, set SDIO Mode
+	 * Otherwise, clear SDIO Mode
+	 */
+	reg = sdhci_readl(host, phy_regs->timing_adj);
+	if (priv->init_card_type == MMC_TYPE_SDIO)
+		reg |= XENON_TIMING_ADJUST_SDIO_MODE;
+	else
+		reg &= ~XENON_TIMING_ADJUST_SDIO_MODE;
+	sdhci_writel(host, reg, phy_regs->timing_adj);
+
+	if (emmc_phy_slow_mode(host, timing))
+		goto phy_init;
+
+	/*
+	 * Set preferred ZNR and ZPR value
+	 * The ZNR and ZPR value vary between different boards.
+	 * Define them both in sdhci-xenon-emmc-phy.h.
+	 */
+	reg = sdhci_readl(host, phy_regs->pad_ctrl2);
+	reg &= ~((XENON_ZNR_MASK << XENON_ZNR_SHIFT) | XENON_ZPR_MASK);
+	reg |= ((params->znr << XENON_ZNR_SHIFT) | params->zpr);
+	sdhci_writel(host, reg, phy_regs->pad_ctrl2);
+
+	/*
+	 * When setting EMMC_PHY_FUNC_CONTROL register,
+	 * SD clock should be disabled
+	 */
+	reg = sdhci_readl(host, SDHCI_CLOCK_CONTROL);
+	reg &= ~SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, reg, SDHCI_CLOCK_CONTROL);
+
+	reg = sdhci_readl(host, phy_regs->func_ctrl);
+	if ((timing == MMC_TIMING_UHS_DDR50) ||
+	    (timing == MMC_TIMING_MMC_HS400) ||
+	    (timing == MMC_TIMING_MMC_DDR52))
+		reg |= (XENON_DQ_DDR_MODE_MASK << XENON_DQ_DDR_MODE_SHIFT) |
+		       XENON_CMD_DDR_MODE;
+	else
+		reg &= ~((XENON_DQ_DDR_MODE_MASK << XENON_DQ_DDR_MODE_SHIFT) |
+			 XENON_CMD_DDR_MODE);
+
+	if (timing == MMC_TIMING_MMC_HS400)
+		reg &= ~XENON_DQ_ASYNC_MODE;
+	else
+		reg |= XENON_DQ_ASYNC_MODE;
+	sdhci_writel(host, reg, phy_regs->func_ctrl);
+
+	/* Enable bus clock */
+	reg = sdhci_readl(host, SDHCI_CLOCK_CONTROL);
+	reg |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, reg, SDHCI_CLOCK_CONTROL);
+
+	if (timing == MMC_TIMING_MMC_HS400)
+		/* Hardware team recommend a value for HS400 */
+		sdhci_writel(host, XENON_LOGIC_TIMING_VALUE,
+			     phy_regs->logic_timing_adj);
+	else
+		__emmc_phy_disable_data_strobe(host);
+
+phy_init:
+	emmc_phy_init(host);
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	dev_dbg(mmc_dev(host->mmc), "eMMC PHY setting completes\n");
+}
+
+static int emmc_phy_parse_param_dt(struct sdhci_host *host,
+				   struct device_node *np,
+				   struct emmc_phy_params *params)
+{
+	u32 value;
+
+	if (of_property_read_bool(np, "marvell,xenon-phy-slow-mode"))
+		params->slow_mode = true;
+	else
+		params->slow_mode = false;
+
+	if (!of_property_read_u32(np, "marvell,xenon-phy-znr", &value))
+		params->znr = value & XENON_ZNR_MASK;
+	else
+		params->znr = XENON_ZNR_DEF_VALUE;
+
+	if (!of_property_read_u32(np, "marvell,xenon-phy-zpr", &value))
+		params->zpr = value & XENON_ZPR_MASK;
+	else
+		params->zpr = XENON_ZPR_DEF_VALUE;
+
+	if (!of_property_read_u32(np, "marvell,xenon-phy-nr-success-tun",
+				  &value))
+		params->nr_tun_times = value & XENON_TUN_CONSECUTIVE_TIMES_MASK;
+	else
+		params->nr_tun_times = XENON_TUN_CONSECUTIVE_TIMES;
+
+	if (!of_property_read_u32(np, "marvell,xenon-phy-tun-step-divider",
+				  &value))
+		params->tun_step_divider = value & 0xFF;
+	else
+		params->tun_step_divider = XENON_TUNING_STEP_DIVIDER;
+
+	return 0;
+}
+
+/*
+ * Setting PHY when card is working in High Speed Mode.
+ * HS400 set data strobe line.
+ * HS200/SDR104 set tuning config to prepare for tuning.
+ */
+static int xenon_hs_delay_adj(struct sdhci_host *host)
+{
+	int ret = 0;
+
+	if (WARN_ON(host->clock <= XENON_DEFAULT_SDCLK_FREQ))
+		return -EINVAL;
+
+	if (host->timing == MMC_TIMING_MMC_HS400) {
+		emmc_phy_strobe_delay_adj(host);
+		return 0;
+	}
+
+	if ((host->timing == MMC_TIMING_MMC_HS200) ||
+	    (host->timing == MMC_TIMING_UHS_SDR104)) {
+		ret = emmc_phy_config_tuning(host);
+		if (!ret)
+			return 0;
+	}
+
+	/*
+	 * DDR Mode requires driver to scan Sampling Fixed Delay Line,
+	 * to find out a perfect operation sampling point.
+	 * It is hard to implement such a scan in host driver since initiating
+	 * commands by host driver is not safe.
+	 * Thus so far just keep PHY Sampling Fixed Delay in default value
+	 * in DDR mode.
+	 *
+	 * If any timing issue occrus in DDR mode on Marvell products,
+	 * please contact maintainer to ask for internal support in Marvell.
+	 */
+	if ((host->timing == MMC_TIMING_MMC_DDR52) ||
+	    (host->timing == MMC_TIMING_UHS_DDR50))
+		dev_warn(mmc_dev(host->mmc), "Timing issue might occur in DDR mode\n");
+	return ret;
+}
+
+/*
+ * Adjust PHY setting.
+ * PHY setting should be adjusted when SDCLK frequency, Bus Width
+ * or Speed Mode is changed.
+ * Addtional config are required when card is working in High Speed mode,
+ * after leaving Legacy Mode.
+ */
+int xenon_phy_adj(struct sdhci_host *host, struct mmc_ios *ios)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	int ret = 0;
+
+	if (!host->clock) {
+		priv->clock = 0;
+		return 0;
+	}
+
+	/*
+	 * The timing, frequency or bus width is changed,
+	 * better to set eMMC PHY based on current setting
+	 * and adjust Xenon SDHC delay.
+	 */
+	if ((host->clock == priv->clock) &&
+	    (ios->bus_width == priv->bus_width) &&
+	    (ios->timing == priv->timing))
+		return 0;
+
+	emmc_phy_set(host, ios->timing);
+
+	/* Update the record */
+	priv->bus_width = ios->bus_width;
+
+	/* Skip temp stages from HS200 to HS400 */
+	if (temp_stage_hs200_to_hs400(host, priv))
+		return 0;
+
+	/* Skip temp stages from HS400 t0 HS200 */
+	if (temp_stage_hs400_to_h200(host, priv))
+		return 0;
+
+	priv->timing = ios->timing;
+	priv->clock = host->clock;
+
+	/* Legacy mode is a special case */
+	if (ios->timing == MMC_TIMING_LEGACY)
+		return 0;
+
+	if (host->clock > XENON_DEFAULT_SDCLK_FREQ)
+		ret = xenon_hs_delay_adj(host);
+	return ret;
+}
+
+static int add_xenon_phy(struct device_node *np, struct sdhci_host *host,
+			 const char *phy_name)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	int i, ret;
+
+	for (i = 0; i < NR_PHY_TYPES; i++) {
+		if (!strcmp(phy_name, phy_types[i])) {
+			priv->phy_type = i;
+			break;
+		}
+	}
+	if (i == NR_PHY_TYPES) {
+		dev_err(mmc_dev(host->mmc),
+			"Unable to determine PHY name %s. Use default eMMC 5.1 PHY\n",
+			phy_name);
+		priv->phy_type = EMMC_5_1_PHY;
+	}
+
+	ret = alloc_emmc_phy(priv);
+	if (ret)
+		return ret;
+
+	return emmc_phy_parse_param_dt(host, np, priv->phy_params);
+}
+
+int xenon_phy_parse_dt(struct device_node *np, struct sdhci_host *host)
+{
+	const char *phy_type = NULL;
+
+	if (!of_property_read_string(np, "marvell,xenon-phy-type", &phy_type))
+		return add_xenon_phy(np, host, phy_type);
+
+	dev_info(mmc_dev(host->mmc), "Fail to get Xenon PHY type. Use default eMMC 5.1 PHY\n");
+	return add_xenon_phy(np, host, "emmc 5.1 phy");
+}
diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 0e0c60892f72..e51079b2d01c 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -257,6 +257,7 @@ static void xenon_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	sdhci_set_ios(mmc, ios);
+	xenon_phy_adj(host, ios);
 
 	if (host->clock > XENON_DEFAULT_SDCLK_FREQ) {
 		spin_lock_irqsave(&host->lock, flags);
@@ -502,7 +503,7 @@ static int xenon_probe_dt(struct platform_device *pdev)
 	}
 	priv->tuning_count = tuning_count;
 
-	return err;
+	return xenon_phy_parse_dt(np, host);
 }
 
 static int xenon_sdhc_probe(struct sdhci_host *host)
diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
index 69de711db9eb..e87639774bca 100644
--- a/drivers/mmc/host/sdhci-xenon.h
+++ b/drivers/mmc/host/sdhci-xenon.h
@@ -24,7 +24,17 @@
 #define XENON_SYS_EXT_OP_CTRL			0x010C
 #define XENON_MASK_CMD_CONFLICT_ERR		BIT(8)
 
+#define XENON_SLOT_OP_STATUS_CTRL		0x0128
+
+#define XENON_TUN_CONSECUTIVE_TIMES_SHIFT	16
+#define XENON_TUN_CONSECUTIVE_TIMES_MASK	0x7
+#define XENON_TUN_CONSECUTIVE_TIMES		0x4
+#define XENON_TUNING_STEP_SHIFT			12
+#define XENON_TUNING_STEP_MASK			0xF
+#define XENON_TUNING_STEP_DIVIDER		BIT(6)
+
 #define XENON_SLOT_EMMC_CTRL			0x0130
+#define XENON_ENABLE_DATA_STROBE		BIT(24)
 #define XENON_EMMC_VCCQ_MASK			0x3
 #define XENON_EMMC_VCCQ_1_8V			0x1
 #define XENON_EMMC_VCCQ_3_3V			0x3
@@ -33,11 +43,17 @@
 /* retuning compatible */
 #define XENON_RETUNING_COMPATIBLE		0x1
 
+#define XENON_SLOT_EXT_PRESENT_STATE		0x014C
+#define XENON_DLL_LOCK_STATE			0x1
+
+#define XENON_SLOT_DLL_CUR_DLY_VAL		0x0150
+
 /* Tuning Parameter */
 #define XENON_TMR_RETUN_NO_PRESENT		0xF
 #define XENON_DEF_TUNING_COUNT			0x9
 
 #define XENON_DEFAULT_SDCLK_FREQ		400000
+#define XENON_LOWEST_SDCLK_FREQ			100000
 
 /* Xenon specific Mode Select value */
 #define XENON_CTRL_HS200			0x5
@@ -65,6 +81,27 @@ struct sdhci_xenon_priv {
 	 * initialization completes.
 	 */
 	unsigned int	init_card_type;
+
+	/*
+	 * The bus_width, timing, and clock fields in below
+	 * record the current ios setting of Xenon SDHC.
+	 * Driver will adjust PHY setting if any change to
+	 * ios affects PHY timing.
+	 */
+	unsigned char	bus_width;
+	unsigned char	timing;
+	unsigned int	clock;
+
+	int		phy_type;
+	/*
+	 * Contains board-specific PHY parameters
+	 * passed from device tree.
+	 */
+	void		*phy_params;
+	struct xenon_emmc_phy_regs *emmc_phy_regs;
 };
 
+int xenon_phy_adj(struct sdhci_host *host, struct mmc_ios *ios);
+int xenon_phy_parse_dt(struct device_node *np,
+		       struct sdhci_host *host);
 #endif
-- 
git-series 0.9.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
