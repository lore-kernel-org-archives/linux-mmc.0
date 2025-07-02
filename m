Received: from mail-m3275.qiye.163.com (mail-m3275.qiye.163.com [220.197.32.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF32DBE5E;
	Wed,  2 Jul 2025 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462154; cv=none; b=P2kvmC4H4+M6bB1MmxK1rBXpH7P12Wfj4eVBYjxJM+51dJHl1HmQQ/9RwtcnOzQ6ZtBnv2CJ/gGNFXFxVURHdbwxs0CSo9hdp3I/VjZgg8T37NRAajPjlAXOZP983d9aGnNRYBdDZBeh0jy62PBzRRrK9afVshDJP22ILYqaFko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462154; c=relaxed/simple;
	bh=lyJA7jn2CT+qkCbKJrZqu2aUXKif/tITdkzhxFD+InM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qWZTY5PKk6kJIUX/zBhbrNmHPPb0ocv22G26PqIXTtzbkVapDhAKu9VnjdDrTSmNTvRUClh6IccqRPOXYVbCyeX9dw/wqFFHsidj166HjU2Vw7wDY14hNsI6q2opvgFK4GtYUjY0hBFtb63FOBRATplW8rmEJfzJyK55xbZkgms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=YZ+gg0I1; arc=none smtp.client-ip=220.197.32.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="YZ+gg0I1"
Received: from localhost.localdomain (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1aaa9ed53;
	Wed, 2 Jul 2025 17:46:37 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	krzk@kernel.org,
	conor+dt@kernel.org,
	gordon.ge@bst.ai,
	catalin.marinas@arm.com,
	geert.uytterhoeven@gmail.com,
	will@kernel.org,
	ulf.hansson@linaro.org,
	adrian.hunter@intel.com,
	arnd@arndb.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	soc@lists.linux.dev,
	bst-upstream@bstai.top,
	neil.armstrong@linaro.org,
	jonathan.cameron@huawei.com,
	bigfoot@classfun.cn,
	kever.yang@rock-chips.com,
	mani@kernel.org,
	geert+renesas@glider.be,
	andersson@kernel.org,
	nm@ti.com,
	nfraprado@collabora.com,
	quic_tdas@quicinc.com,
	ebiggers@google.com,
	victor.shih@genesyslogic.com.tw,
	shanchun1218@gmail.com,
	ben.chuang@genesyslogic.com.tw,
	Albert Yang <yangzh0906@thundersoft.com>
Subject: [PATCH v2 5/8] mmc: sdhci: add Black Sesame Technologies BST C1200 controller driver
Date: Wed,  2 Jul 2025 17:44:41 +0800
Message-Id: <20250702094444.3523973-6-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250702094444.3523973-1-yangzh0906@thundersoft.com>
References: <20250528085403.481055-1-yangzh0906@thundersoft.com>
 <20250702094444.3523973-1-yangzh0906@thundersoft.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDT00aVkMfHUpPT0sdSB1OSlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCS0NVSk
	tLVUpCWQY+
X-HM-Tid: 0a97ca87f57c09cckunmee1cabff3ebb6b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mjo6HRw6FTEwDk9MHSIdHUIe
	HjoKCQpVSlVKTE5KT09CTkJCSEpLVTMWGhIXVQIaFRwBE0tCS007DxMOFR8eCQgUHQ9VGBQWRVlX
	WRILWUFZSkpMVUpDT1VKSUJVSkhPWVdZCAFZQUlKSEpMNwY+
DKIM-Signature:a=rsa-sha256;
	b=YZ+gg0I13tP/zaaF1VsRnGYMrsM7x8Xr1kPKy3uzt36Y3l+1w+tj/YR9ZIEhkNzn3fRaEz7VlniDkCu5MDUpvBp8O8CqUF/EZSKWnX1M3jEXdHXsiPdhmFlfOgiUq+xTK2VOaH0vZGQYVP7yRF+9A34UM9VGxtCnVpMJ+AE8oI4=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=zviMpMe/GKMuDeXucGk8dIUIyAzyPbzHcM5/aawzXlY=;
	h=date:mime-version:subject:message-id:from;

Add a driver for the DesignWare Mobile Storage Host Controller (DWCMSHC)
SDHCI controller found in Black Sesame Technologies C1200 SoCs.

The driver provides specialized clock configuration, tuning, voltage
switching, and power management for the BST DWCMSHC controller. It also
includes support for eMMC boot and memory-mapped I/O for CRM registers.

---
Changes for v2:
1.  Dependency Simplification :
   - Removed COMMON_CLK dependency from Kconfig (MMC_SDHCI_BST)
   - Add ARCH_BST || COMPILE_TEST dependency from Kconfig (MMC_SDHCI_BST)

2.  Resource Management Improvements :
   - Replaced temporary ioremap with persistent mapping
     * Mapped CRM registers once during probe instead of per-access
     * Added proper cleanup in remove callback
   - Refactored bounce buffer allocation:
     * Simplified error handling and memory management
     * Removed unnecessary DMA configuration layers

3.  Code Cleanup & Optimization :
   - Pruned unused headers and legacy vendor debug code
   - Removed deprecated sdhci_bst_print_vendor() export
   - Converted internal functions to static scope
   - Standardized naming conventions:
     * Renamed DRIVER_NAME to match kernel standards
     * Changed default_max_freq to DEFAULT_MAX_FREQ
   - Optimized clock configuration routines

4.  Hardware Integration Fixes :
   - Fixed register access macros for EMMC_CTRL
     * Added proper offset calculation via SDHCI_VENDOR_PTR_R
   - Corrected device tree compatibility string to:
     "bst,c1200-dwcmshc-sdhci"

5.  Error Handling Enhancements :
   - Added robust ioremap error checking
   - Improved bounce buffer allocation failure handling
   - Streamlined probe/remove flow

6.  Maintainability :
   - Updated MODULE_DESCRIPTION and AUTHOR fields
   - Added explanatory comments for hardware limitations
   - Removed redundant multi-host setup infrastructure

7. fix build warnings from lkp
  | Reported-by: kernel test robot <lkp@intel.com>
  | Closes:
  https://lore.kernel.org/oe-kbuild-all/202505290615.GZzN5rNL-lkp@intel.com/

Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
Signed-off-by: Ge Gordon <gordon.ge@bst.ai>
---
 drivers/mmc/host/Kconfig              |  11 +
 drivers/mmc/host/Makefile             |   1 +
 drivers/mmc/host/sdhci-of-bst-c1200.c | 557 ++++++++++++++++++++++++++
 3 files changed, 569 insertions(+)
 create mode 100644 drivers/mmc/host/sdhci-of-bst-c1200.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index c3f0f41a426d..a93ea150dcbf 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -1126,3 +1126,14 @@ config MMC_LITEX
 	  module will be called litex_mmc.
 
 	  If unsure, say N.
+
+config MMC_SDHCI_BST
+	tristate "SDHCI OF support for the BST DWC MSHC"
+	depends on ARCH_BST || COMPILE_TEST
+	depends on MMC_SDHCI_PLTFM
+	depends on OF
+	help
+	  This selects Synopsys DesignWare Cores Mobile Storage Controller
+	  support.
+	  If you have a controller with this interface, say Y or M here.
+	  If unsure, say N.
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 75bafc7b162b..bb5df05c3174 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
 obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
 obj-$(CONFIG_MMC_SDHCI_UHS2)	+= sdhci-uhs2.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
+obj-$(CONFIG_MMC_SDHCI_BST)	        += sdhci-of-bst-c1200.o
 sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o \
 				   sdhci-pci-dwc-mshc.o sdhci-pci-gli.o
 obj-$(CONFIG_MMC_SDHCI_ACPI)	+= sdhci-acpi.o
diff --git a/drivers/mmc/host/sdhci-of-bst-c1200.c b/drivers/mmc/host/sdhci-of-bst-c1200.c
new file mode 100644
index 000000000000..233ad959e6e5
--- /dev/null
+++ b/drivers/mmc/host/sdhci-of-bst-c1200.c
@@ -0,0 +1,557 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Black Sesame Technologies SDHCI driver
+ *
+ * Copyright (C) 2024 Black Sesame Technologies. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include "sdhci.h"
+#include "sdhci-pltfm.h"
+
+struct dwcmshc_priv {
+	void __iomem *crm_reg_base;
+	u32 phy_crm_reg_base;
+	u32 phy_crm_reg_size;
+};
+
+#define SDHCI_CLOCK_PLL_EN		0x0008
+#define SDHCI_TUNING_COUNT		0x20
+#define SDHCI_VENDOR_PTR_R		0xE8
+#define MBIU_CTRL			0x510
+#define BURST_INCR16_EN			BIT(3)
+#define BURST_INCR8_EN			BIT(2)
+#define BURST_INCR4_EN			BIT(1)
+#define BURST_EN			(BURST_INCR16_EN | BURST_INCR8_EN | BURST_INCR4_EN)
+
+/* Synopsys vendor specific registers */
+#define SDHC_EMMC_CTRL_R_OFFSET		0x2C
+
+#define SDEMMC_CRM_BCLK_DIV_CTRL	0x08
+#define SDEMMC_CRM_RX_CLK_CTRL		0x14
+#define SDEMMC_CRM_TIMER_DIV_CTRL	0x0C
+#define SDEMMC_CRM_VOL_CTRL			0x1C
+#define REG_WR_PROTECT			0x88
+#define REG_WR_PROTECT_KEY		0x1234abcd
+#define DELAY_CHAIN_SEL			0x94
+#define BST_VOL_STABLE_ON		BIT(7)
+#define DEFAULT_MAX_FREQ		200000UL
+
+static u32 bst_read_phys_bst(void __iomem *addr)
+{
+	return ioread32(addr);
+}
+
+static void bst_write_phys_bst(void __iomem *addr, u32 value)
+{
+	iowrite32(value, addr);
+}
+
+static unsigned int bst_get_max_clock(struct sdhci_host *host)
+{
+	return host->mmc->f_max;
+}
+
+static unsigned int bst_get_min_clock(struct sdhci_host *host)
+{
+	return host->mmc->f_min;
+}
+
+struct rx_ctrl {
+	struct {
+		u32 rx_revert:1;
+		u32 rx_clk_sel_sec:1;
+		u32 rx_clk_div:4;
+		u32 rx_clk_phase_inner:2;
+		u32 rx_clk_sel_first:1;
+		u32 rx_clk_phase_out:2;
+		u32 rx_clk_en:1;
+		u32 res0:20;
+	} bit;
+	u32 reg;
+};
+
+struct sdmmc_iocfg {
+	struct {
+		u32 res0:16;
+		u32 SC_SDMMC0_PVDD18POCSD0:2;
+		u32 SC_SDMMC0_PVDD18POCSD1:2;
+		u32 SC_SDMMC0_PVDD18POCSD2:2;
+		u32 SC_SDMMC1_PVDD18POCSD0:2;
+		u32 SC_SDMMC1_PVDD18POCSD1:2;
+		u32 SC_SDMMC1_PVDD18POCSD2:2;
+		u32 res1:4;
+	} bit;
+	u32 reg;
+};
+
+static void sdhci_enable_bst_clk(struct sdhci_host *host, unsigned int clk)
+{
+	struct sdhci_pltfm_host *pltfm_host;
+	struct dwcmshc_priv *priv;
+	unsigned int div;
+	u32 val;
+	struct rx_ctrl rx_reg;
+
+	pltfm_host = sdhci_priv(host);
+	priv = sdhci_pltfm_priv(pltfm_host);
+	if (clk == 0) {
+		div = clk;
+	} else if (clk > DEFAULT_MAX_FREQ) {
+		div = clk / 1000;
+		div = DEFAULT_MAX_FREQ / div;
+	} else if (clk < 1500) {
+		div = clk;
+	} else {
+		div = DEFAULT_MAX_FREQ * 100;
+		div = div / clk;
+		div /= 100;
+	}
+
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	clk &= ~SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	clk &= ~SDHCI_CLOCK_PLL_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	val = bst_read_phys_bst(priv->crm_reg_base + SDEMMC_CRM_TIMER_DIV_CTRL);
+	val &= ~BIT(8);
+	bst_write_phys_bst(priv->crm_reg_base + SDEMMC_CRM_TIMER_DIV_CTRL, val);
+
+	val = bst_read_phys_bst(priv->crm_reg_base + SDEMMC_CRM_TIMER_DIV_CTRL);
+	val &= ~0xff;
+	val |= 0x20;
+	bst_write_phys_bst(priv->crm_reg_base + SDEMMC_CRM_TIMER_DIV_CTRL, val);
+
+	val = bst_read_phys_bst(priv->crm_reg_base + SDEMMC_CRM_TIMER_DIV_CTRL);
+	val |= BIT(8);
+	bst_write_phys_bst(priv->crm_reg_base + SDEMMC_CRM_TIMER_DIV_CTRL, val);
+
+	val = bst_read_phys_bst(priv->crm_reg_base + SDEMMC_CRM_RX_CLK_CTRL);
+	val &= ~BIT(11);
+	bst_write_phys_bst(priv->crm_reg_base + SDEMMC_CRM_RX_CLK_CTRL, val);
+
+	rx_reg.reg = bst_read_phys_bst(priv->crm_reg_base + SDEMMC_CRM_RX_CLK_CTRL);
+
+	rx_reg.bit.rx_revert = 0;
+	rx_reg.bit.rx_clk_sel_sec = 1;
+	rx_reg.bit.rx_clk_div = 4;
+	rx_reg.bit.rx_clk_phase_inner = 2;
+	rx_reg.bit.rx_clk_sel_first = 0;
+	rx_reg.bit.rx_clk_phase_out = 2;
+
+	bst_write_phys_bst(priv->crm_reg_base + SDEMMC_CRM_RX_CLK_CTRL, rx_reg.reg);
+
+	val = bst_read_phys_bst(priv->crm_reg_base + SDEMMC_CRM_RX_CLK_CTRL);
+	val |= BIT(11);
+	bst_write_phys_bst(priv->crm_reg_base + SDEMMC_CRM_RX_CLK_CTRL, val);
+
+	/* Disable clock first */
+	val = bst_read_phys_bst(priv->crm_reg_base + SDEMMC_CRM_BCLK_DIV_CTRL);
+	val &= ~BIT(10);
+	bst_write_phys_bst(priv->crm_reg_base + SDEMMC_CRM_BCLK_DIV_CTRL, val);
+
+	/* Setup clock divider */
+	val = bst_read_phys_bst(priv->crm_reg_base + SDEMMC_CRM_BCLK_DIV_CTRL);
+	val &= ~GENMASK(9, 0);
+	val |= div;
+	bst_write_phys_bst(priv->crm_reg_base + SDEMMC_CRM_BCLK_DIV_CTRL, val);
+
+	/* Enable clock */
+	val = bst_read_phys_bst(priv->crm_reg_base + SDEMMC_CRM_BCLK_DIV_CTRL);
+	val |= BIT(10);
+	bst_write_phys_bst(priv->crm_reg_base + SDEMMC_CRM_BCLK_DIV_CTRL, val);
+
+	sdhci_writew(host, (div & 0xff) << 8, SDHCI_CLOCK_CONTROL);
+
+	sdhci_writew(host, (div & 0xff) << 8, SDHCI_CLOCK_CONTROL);
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	clk |= SDHCI_CLOCK_PLL_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	clk |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	clk |= SDHCI_CLOCK_INT_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+}
+
+static void sdhci_set_bst_clock(struct sdhci_host *host, unsigned int clock)
+{
+	if (clock == 0)
+		return;
+	sdhci_enable_bst_clk(host, clock);
+}
+
+/**
+ * sdhci_bst_reset - Reset the SDHCI host controller
+ * @host: SDHCI host controller
+ * @mask: Reset mask
+ *
+ * Performs a reset of the SDHCI host controller with special handling for eMMC.
+ */
+static void sdhci_bst_reset(struct sdhci_host *host, u8 mask)
+{
+	u16 vendor_ptr, emmc_ctrl_reg;
+
+	if (host->mmc->caps2 & MMC_CAP2_NO_SD) {
+		vendor_ptr = sdhci_readw(host, SDHCI_VENDOR_PTR_R);
+		emmc_ctrl_reg = vendor_ptr + SDHC_EMMC_CTRL_R_OFFSET;
+
+		sdhci_writew(host,
+			     sdhci_readw(host, emmc_ctrl_reg) & (~BIT(2)),
+			     emmc_ctrl_reg);
+		sdhci_reset(host, mask);
+		usleep_range(10, 20);
+		sdhci_writew(host,
+			     sdhci_readw(host, emmc_ctrl_reg) | BIT(2),
+			     emmc_ctrl_reg);
+	} else {
+		sdhci_reset(host, mask);
+	}
+}
+
+/**
+ * sdhci_bst_timeout - Set timeout value for commands
+ * @host: SDHCI host controller
+ * @cmd: MMC command
+ *
+ * Sets the timeout control register to maximum value (0xE).
+ */
+static void sdhci_bst_timeout(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	sdhci_writeb(host, 0xE, SDHCI_TIMEOUT_CONTROL);
+}
+
+/**
+ * sdhci_bst_set_power - Set power mode and voltage
+ * @host: SDHCI host controller
+ * @mode: Power mode to set
+ * @vdd: Voltage to set
+ *
+ * Sets power mode and voltage, also configures MBIU control register.
+ */
+static void sdhci_bst_set_power(struct sdhci_host *host, unsigned char mode,
+				unsigned short vdd)
+{
+	sdhci_set_power(host, mode, vdd);
+	sdhci_writeb(host, 0xF, SDHCI_POWER_CONTROL);
+	sdhci_writew(host,
+		     (sdhci_readw(host, MBIU_CTRL) & (~0xf)) | BURST_EN,
+		     MBIU_CTRL);
+}
+
+/**
+ * bst_sdhci_execute_tuning - Execute tuning procedure
+ * @host: SDHCI host controller
+ * @opcode: Opcode to use for tuning
+ *
+ * Performs tuning procedure by trying different values and selecting the best one.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int bst_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
+{
+	struct sdhci_pltfm_host *pltfm_host;
+	struct dwcmshc_priv *priv;
+	unsigned int clk = 0, timeout;
+	int ret = 0, error;
+	int start0 = -1, end0 = -1, best = 0;
+	int start1 = -1, end1 = -1, flag = 0;
+	int i;
+
+	pltfm_host = sdhci_priv(host);
+	priv = sdhci_pltfm_priv(pltfm_host);
+
+	for (i = 0; i < SDHCI_TUNING_COUNT; i++) {
+		/* Protected write */
+		bst_write_phys_bst(priv->crm_reg_base + REG_WR_PROTECT, REG_WR_PROTECT_KEY);
+		/* Write tuning value */
+		bst_write_phys_bst(priv->crm_reg_base + DELAY_CHAIN_SEL,
+				   (1ul << i) - 1);
+
+		timeout = 20;
+		while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL)) &
+			SDHCI_CLOCK_INT_STABLE)) {
+			if (timeout == 0) {
+				dev_err(mmc_dev(host->mmc), "Internal clock never stabilised\n");
+				return -EBUSY;
+			}
+			timeout--;
+			usleep_range(1000, 1100);
+		}
+
+		ret = mmc_send_tuning(host->mmc, opcode, &error);
+		if (ret != 0) {
+			flag = 1;
+		} else {
+			if (flag == 0) {
+				if (start0 == -1)
+					start0 = i;
+				end0 = i;
+			} else {
+				if (start1 == -1)
+					start1 = i;
+				end1 = i;
+			}
+		}
+	}
+
+	/* Calculate best tuning value */
+	if (end0 - start0 >= end1 - start1)
+		best = ((end0 - start0) >> 1) + start0;
+	else
+		best = ((end1 - start1) >> 1) + start1;
+
+	if (best < 0)
+		best = 0;
+
+	bst_write_phys_bst(priv->crm_reg_base + DELAY_CHAIN_SEL, (1ul << best) - 1);
+	timeout = 20;
+
+	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL)) &
+		SDHCI_CLOCK_INT_STABLE)) {
+		if (timeout == 0) {
+			dev_err(mmc_dev(host->mmc), "Internal clock never stabilised\n");
+			return -EBUSY;
+		}
+		timeout--;
+		usleep_range(1000, 1100);
+	}
+
+	return 0;
+}
+
+/**
+ * sdhci_bst_voltage_switch - Perform voltage switch
+ * @host: SDHCI host controller
+ *
+ * Enables voltage stable power.
+ */
+static void sdhci_bst_voltage_switch(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+
+	/* vol stable power on */
+	bst_write_phys_bst(priv->crm_reg_base + SDEMMC_CRM_VOL_CTRL,
+			   BST_VOL_STABLE_ON);
+}
+
+static const struct sdhci_ops sdhci_dwcmshc_ops = {
+	.set_clock		= sdhci_set_bst_clock,
+	.set_bus_width		= sdhci_set_bus_width,
+	.set_uhs_signaling	= sdhci_set_uhs_signaling,
+	.get_min_clock		= bst_get_min_clock,
+	.get_max_clock		= bst_get_max_clock,
+	.reset			= sdhci_bst_reset,
+	.set_power		= sdhci_bst_set_power,
+	.set_timeout		= sdhci_bst_timeout,
+	.platform_execute_tuning = bst_sdhci_execute_tuning,
+	.voltage_switch		= sdhci_bst_voltage_switch,
+};
+
+static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
+	.ops = &sdhci_dwcmshc_ops,
+	.quirks = SDHCI_QUIRK_DELAY_AFTER_POWER |
+		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+		  SDHCI_QUIRK_INVERTED_WRITE_PROTECT,
+	.quirks2 = SDHCI_QUIRK2_BROKEN_DDR50 |
+		   SDHCI_QUIRK2_TUNING_WORK_AROUND |
+		   SDHCI_QUIRK2_ACMD23_BROKEN,
+};
+
+static int bst_sdhci_reallocate_bounce_buffer(struct sdhci_host *host)
+{
+	struct mmc_host *mmc = host->mmc;
+	unsigned int max_blocks;
+	unsigned int bounce_size;
+	int ret;
+
+	/*
+	 * Cap the bounce buffer at 64KB. Using a bigger bounce buffer
+	 * has diminishing returns, this is probably because SD/MMC
+	 * cards are usually optimized to handle this size of requests.
+	 */
+	bounce_size = SZ_32K;
+	/*
+	 * Adjust downwards to maximum request size if this is less
+	 * than our segment size, else hammer down the maximum
+	 * request size to the maximum buffer size.
+	 */
+	if (mmc->max_req_size < bounce_size)
+		bounce_size = mmc->max_req_size;
+	max_blocks = bounce_size / 512;
+
+	ret = of_reserved_mem_device_init_by_idx(mmc_dev(mmc), mmc_dev(mmc)->of_node, 0);
+	if (ret) {
+		dev_err(mmc_dev(mmc), "Failed to initialize reserved memory\n");
+		return ret;
+	}
+
+	host->bounce_buffer = dma_alloc_coherent(mmc_dev(mmc), bounce_size,
+						 &host->bounce_addr, GFP_KERNEL);
+	if (!host->bounce_buffer)
+		return -ENOMEM;
+
+	host->bounce_buffer_size = bounce_size;
+
+	/* Lie about this since we're bouncing */
+	mmc->max_segs = max_blocks;
+	mmc->max_seg_size = bounce_size;
+	mmc->max_req_size = bounce_size;
+
+	dev_info(mmc_dev(mmc), "BST reallocate %s bounce up to %u segments into one, max segment size %u bytes\n",
+		 mmc_hostname(mmc), max_blocks, bounce_size);
+
+	return 0;
+}
+
+/**
+ * dwcmshc_probe - Platform driver probe
+ * @pdev: Platform device
+ *
+ * Initializes the SDHCI host controller and registers it.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int dwcmshc_probe(struct platform_device *pdev)
+{
+	struct sdhci_pltfm_host *pltfm_host;
+	struct sdhci_host *host;
+	struct dwcmshc_priv *priv;
+	struct resource *crm_res;
+	int err;
+
+	host = sdhci_pltfm_init(pdev, &sdhci_dwcmshc_pdata,
+				sizeof(struct dwcmshc_priv));
+	if (IS_ERR(host))
+		return PTR_ERR(host);
+
+	pltfm_host = sdhci_priv(host);
+	priv = sdhci_pltfm_priv(pltfm_host);
+
+	err = mmc_of_parse(host->mmc);
+	if (err)
+		goto err;
+
+	sdhci_get_of_property(pdev);
+
+	/* Get CRM registers from the second reg entry */
+	crm_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!crm_res) {
+		dev_err(&pdev->dev, "Failed to get CRM register resource\n");
+		err = -ENODEV;
+		goto err;
+	}
+
+	priv->phy_crm_reg_base = crm_res->start;
+	priv->phy_crm_reg_size = resource_size(crm_res);
+
+	priv->crm_reg_base = ioremap(priv->phy_crm_reg_base, priv->phy_crm_reg_size);
+	if (!priv->crm_reg_base) {
+		dev_err(&pdev->dev, "Failed to ioremap CRM registers\n");
+		err = -ENOMEM;
+		goto err;
+	}
+
+	err = sdhci_add_host(host);
+	if (err)
+		goto err_iounmap;
+
+	/*
+	 * Hardware limitation workaround:
+	 *
+	 * Our platform supports 64-bit physical addressing, but the eMMC
+	 * controller's SRAM-based DMA engine is constrained to a 32-bit
+	 * address space. When using the standard SDHCI interface, which
+	 * allocates DDR-based DMA buffers with 64-bit addresses, the
+	 * dma_map_single() operation fails because the DMA engine cannot
+	 * handle addresses beyond 32 bits.
+	 *
+	 * To resolve this hardware limitation, we implement a bounce buffer
+	 * allocated via dma_alloc_coherent() to satisfy DMA addressing
+	 * constraints.
+	 */
+	err = bst_sdhci_reallocate_bounce_buffer(host);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to allocate bounce buffer: %d\n", err);
+		goto err_remove_host;
+	}
+
+	return 0;
+
+err_remove_host:
+	sdhci_remove_host(host, 1);
+err_iounmap:
+	if (priv->crm_reg_base)
+		iounmap(priv->crm_reg_base);
+err:
+	sdhci_pltfm_free(pdev);
+	return err;
+}
+
+/**
+ * dwcmshc_remove - Platform driver remove
+ * @pdev: Platform device
+ *
+ * Removes the SDHCI host controller.
+ *
+ * Return: 0 on success
+ */
+static void dwcmshc_remove(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *pltfm_host;
+	struct dwcmshc_priv *priv;
+
+	pltfm_host = sdhci_priv(host);
+	priv = sdhci_pltfm_priv(pltfm_host);
+
+	/* Free bounce buffer if allocated */
+	if (host->bounce_buffer) {
+		dma_free_coherent(mmc_dev(host->mmc), host->bounce_buffer_size,
+				  host->bounce_buffer, host->bounce_addr);
+		host->bounce_buffer = NULL;
+	}
+
+	/* Release reserved memory */
+	of_reserved_mem_device_release(mmc_dev(host->mmc));
+
+	iounmap(priv->crm_reg_base);
+
+	sdhci_remove_host(host, 0);
+	sdhci_pltfm_free(pdev);
+}
+
+static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
+	{ .compatible = "bst,c1200-dwcmshc-sdhci" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
+
+static struct platform_driver sdhci_dwcmshc_driver = {
+	.driver = {
+		.name = "sdhci-dwcmshc",
+		.of_match_table = sdhci_dwcmshc_dt_ids,
+	},
+	.probe = dwcmshc_probe,
+	.remove = dwcmshc_remove,
+};
+module_platform_driver(sdhci_dwcmshc_driver);
+
+MODULE_DESCRIPTION("Black Sesame Technologies DWCMSHC SDHCI driver");
+MODULE_AUTHOR("Black Sesame Technologies Co., Ltd.");
+MODULE_LICENSE("GPL");
-- 
2.25.1

