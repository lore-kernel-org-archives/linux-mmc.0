From: Yi Sun <yi.y.sun@intel.com>
Subject: [RFC 2/2] mmc: sdhci: support UHS-II in SDHCI host.
Date: Sat, 27 Dec 2014 17:27:59 +0800
Message-ID: <1419672479-30852-3-git-send-email-yi.y.sun@intel.com>
References: <1419672479-30852-1-git-send-email-yi.y.sun@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:4210 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751362AbaL0JfY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 27 Dec 2014 04:35:24 -0500
In-Reply-To: <1419672479-30852-1-git-send-email-yi.y.sun@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: yi.y.sun@intel.com

This patch adds the UHS-II support in host layer. This is a RFC patch for
community review.

Signed-off-by: Yi Sun <yi.y.sun@intel.com>
---
 drivers/mmc/host/Makefile     |    2 +-
 drivers/mmc/host/sdhci-pci.c  |    6 +
 drivers/mmc/host/sdhci-uhs2.c |  703 +++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |   36 +++
 drivers/mmc/host/sdhci.c      |  259 ++++++++++++---
 drivers/mmc/host/sdhci.h      |  313 +++++++++++++++++-
 include/linux/mmc/sdhci.h     |    2 +
 7 files changed, 1269 insertions(+), 52 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-uhs2.c
 create mode 100644 drivers/mmc/host/sdhci-uhs2.h

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index f7b0a77..254ab40 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_MMC_QCOM_DML)	+= mmci_qcom_dml.o
 obj-$(CONFIG_MMC_PXA)		+= pxamci.o
 obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
 obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
-obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
+obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o sdhci-uhs2.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
 obj-$(subst m,y,$(CONFIG_MMC_SDHCI_PCI))	+= sdhci-pci-data.o
 obj-$(subst m,y,$(CONFIG_MMC_SDHCI_PCI))	+= sdhci-pci-o2micro.o
diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 0342775..b20a2e7 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -255,6 +255,12 @@ static void sdhci_pci_int_hw_reset(struct sdhci_host *host)
 {
 	u8 reg;
 
+	/* Since SDHC 4.0, bit 4 of is used to enable VDD2 for
+	 * UHS2.
+	 */
+	if (host->version >= SDHCI_SPEC_400)
+		return;
+
 	reg = sdhci_readb(host, SDHCI_POWER_CONTROL);
 	reg |= 0x10;
 	sdhci_writeb(host, reg, SDHCI_POWER_CONTROL);
diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
new file mode 100644
index 0000000..3f3184f
--- /dev/null
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -0,0 +1,703 @@
+/*
+ *  linux/drivers/mmc/host/sdhci_uhs2.c - Secure Digital Host Controller
+ *  Interface driver
+ *
+ *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ */
+
+#include <linux/delay.h>
+#include <linux/regulator/consumer.h>
+
+#include <linux/mmc/mmc.h>
+
+#include "sdhci.h"
+#include "sdhci-uhs2.h"
+
+#define DRIVER_NAME "sdhci_uhs2"
+#define DBG(f, x...) \
+	pr_debug(DRIVER_NAME " [%s()]: " f, __func__, ## x)
+
+static void sdhci_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set)
+{
+	u32 ier;
+
+	ier = sdhci_readl(host, SDHCI_INT_ENABLE);
+	ier &= ~clear;
+	ier |= set;
+	sdhci_writel(host, ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
+}
+
+static void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear,
+					u32 set)
+{
+	u32 ier;
+
+	ier = sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS_EN);
+	ier &= ~clear;
+	ier |= set;
+	sdhci_writel(host, ier, SDHCI_UHS2_ERR_INT_STATUS_EN);
+	sdhci_writel(host, ier, SDHCI_UHS2_ERR_INT_SIG_EN);
+}
+
+void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
+{
+	unsigned long timeout;
+	u32 uninitialized_var(ier);
+	u32 uninitialized_var(ier2);
+
+	if (!(host->mmc->caps & MMC_CAP_UHS2))
+		return;
+
+	sdhci_writew(host, mask, SDHCI_UHS2_SW_RESET);
+
+	if (mask & SDHCI_UHS2_SW_RESET_FULL) {
+		host->clock = 0;
+		/* Reset-all turns off SD Bus Power */
+		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
+			sdhci_runtime_pm_bus_off(host);
+	}
+
+	/* Wait max 100 ms */
+	timeout = 10000;
+
+	/* hw clears the bit when it's done */
+	while (sdhci_readw(host, SDHCI_UHS2_SW_RESET) & mask) {
+		if (timeout == 0) {
+			pr_err("%s: Reset 0x%x never completed.\n",
+				mmc_hostname(host->mmc), (int)mask);
+			sdhci_dumpregs(host);
+			return;
+		}
+		timeout--;
+		udelay(10);
+	}
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
+
+static u8 sdhci_calc_timeout_uhs2(struct sdhci_host *host,
+				u8 *cmd_res,
+				u8 *dead_lock)
+{
+	u8 count;
+	unsigned cmd_res_timeout, dead_lock_timeout, current_timeout;
+
+	/*
+	 * If the host controller provides us with an incorrect timeout
+	 * value, just skip the check and use 0xE.  The hardware may take
+	 * longer to time out, but that's much better than having a too-short
+	 * timeout value.
+	 */
+	if (host->quirks & SDHCI_QUIRK_BROKEN_TIMEOUT_VAL) {
+		*cmd_res = 0xE;
+		*dead_lock = 0xE;
+		return 0xE;
+	}
+
+	/* timeout in us */
+	cmd_res_timeout = 5 * 1000;
+	dead_lock_timeout = 1 * 1000 * 1000;
+
+	/*
+	 * Figure out needed cycles.
+	 * We do this in steps in order to fit inside a 32 bit int.
+	 * The first step is the minimum timeout, which will have a
+	 * minimum resolution of 6 bits:
+	 * (1) 2^13*1000 > 2^22,
+	 * (2) host->timeout_clk < 2^16
+	 *     =>
+	 *     (1) / (2) > 2^6
+	 */
+	count = 0;
+	current_timeout = (1 << 13) * 1000 / host->timeout_clk;
+	while (current_timeout < cmd_res_timeout) {
+		count++;
+		current_timeout <<= 1;
+		if (count >= 0xF)
+			break;
+	}
+
+	if (count >= 0xF) {
+		DBG("%s: Too large timeout 0x%x requested for CMD_RES!\n",
+			mmc_hostname(host->mmc), count);
+		count = 0xE;
+	}
+	*cmd_res = count;
+
+	count = 0;
+	current_timeout = (1 << 13) * 1000 / host->timeout_clk;
+	while (current_timeout < dead_lock_timeout) {
+		count++;
+		current_timeout <<= 1;
+		if (count >= 0xF)
+			break;
+	}
+
+	if (count >= 0xF) {
+		DBG("%s: Too large timeout 0x%x requested for DEADLOCK!\n",
+			mmc_hostname(host->mmc), count);
+		count = 0xE;
+	}
+	*dead_lock = count;
+
+	return count;
+}
+
+void sdhci_uhs2_set_transfer_mode(struct sdhci_host *host,
+	struct mmc_command *cmd)
+{
+	u16 mode;
+	struct mmc_data *data = cmd->data;
+
+	if (data == NULL) {
+		/* clear Auto CMD settings for no data CMDs */
+		mode = sdhci_readw(host, SDHCI_UHS2_TRANS_MODE);
+		if (cmd->opcode == MMC_STOP_TRANSMISSION)
+			mode |= SDHCI_UHS2_TRNS_WAIT_EBSY;
+#ifdef CONFIG_MMC_DEBUG
+		DBG("UHS2 no data trans mode is 0x%x.\n", mode);
+#endif
+		sdhci_writew(host, mode, SDHCI_UHS2_TRANS_MODE);
+		return;
+	}
+
+	WARN_ON(!host->data);
+
+	mode = SDHCI_UHS2_TRNS_BLK_CNT_EN | SDHCI_UHS2_TRNS_WAIT_EBSY;
+	if (data->flags & MMC_DATA_WRITE)
+		mode |= SDHCI_UHS2_TRNS_DATA_TRNS_WRT;
+
+	if (data->blocks == 1 &&
+	    cmd->opcode != MMC_READ_SINGLE_BLOCK &&
+	    cmd->opcode != MMC_WRITE_BLOCK) {
+		mode &= ~SDHCI_UHS2_TRNS_BLK_CNT_EN;
+		mode |= SDHCI_UHS2_TRNS_BLK_BYTE_MODE;
+	}
+
+	if (host->flags & SDHCI_REQ_USE_DMA)
+		mode |= SDHCI_UHS2_TRNS_DMA;
+
+	if (host->mmc->flags & MMC_UHS2_2L_HD)
+		mode |= SDHCI_UHS2_TRNS_2L_HD;
+
+	sdhci_writew(host, mode, SDHCI_UHS2_TRANS_MODE);
+
+#ifdef CONFIG_MMC_DEBUG
+	DBG("UHS2 trans mode is 0x%x.\n", mode);
+#endif
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_set_transfer_mode);
+
+void sdhci_uhs2_send_command(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	int i, j;
+	int cmd_reg;
+
+	if (host->mmc->flags & MMC_UHS2_INITIALIZED) {
+		if (cmd->uhs2_cmd == NULL) {
+			pr_err("%s: fatal error, no uhs2_cmd!\n",
+				mmc_hostname(host->mmc));
+			BUG();
+			return;
+		}
+	}
+
+	for (i = 0; i < SDHCI_UHS2_CMD_PACK_MAX_LEN; i++)
+		sdhci_writeb(host, 0, SDHCI_UHS2_CMD_PACKET);
+
+	i = 0;
+	sdhci_writeb(host, cmd->uhs2_cmd->header,
+			SDHCI_UHS2_CMD_PACKET + i++);
+	sdhci_writeb(host, (cmd->uhs2_cmd->header >> 8) & 0xFF,
+			SDHCI_UHS2_CMD_PACKET + i++);
+	sdhci_writeb(host, cmd->uhs2_cmd->arg,
+			SDHCI_UHS2_CMD_PACKET + i++);
+	sdhci_writeb(host, (cmd->uhs2_cmd->arg >> 8) & 0xFF,
+			SDHCI_UHS2_CMD_PACKET + i++);
+
+	/* TODO: Per spec, playload (config) should be MSB before sending out.
+	 * But we don't need convert here because I will set payload as
+	 * MSB when preparing config read/write commands.
+	 */
+	for (j = 0; j < cmd->uhs2_cmd->payload_len/sizeof(u32); j++) {
+		sdhci_writeb(host,
+			(*(cmd->uhs2_cmd->payload + j) & 0xFF),
+			SDHCI_UHS2_CMD_PACKET + i++);
+		sdhci_writeb(host,
+			((*(cmd->uhs2_cmd->payload + j)) >> 8) & 0xFF,
+			SDHCI_UHS2_CMD_PACKET + i++);
+		sdhci_writeb(host,
+			((*(cmd->uhs2_cmd->payload + j)) >> 16) & 0xFF,
+			SDHCI_UHS2_CMD_PACKET + i++);
+		sdhci_writeb(host,
+			((*(cmd->uhs2_cmd->payload + j)) >> 24) & 0xFF,
+			SDHCI_UHS2_CMD_PACKET + i++);
+	}
+
+#ifdef CONFIG_MMC_DEBUG
+	DBG("UHS2 CMD packet_len = %d.\n", cmd->uhs2_cmd->packet_len);
+	for (i = 0; i < cmd->uhs2_cmd->packet_len; i++)
+		DBG("UHS2 CMD_PACKET[%d] = 0x%x.\n", i,
+			sdhci_readb(host, SDHCI_UHS2_CMD_PACKET + i));
+#endif
+
+	cmd_reg = cmd->uhs2_cmd->packet_len <<
+			SDHCI_UHS2_COMMAND_PACK_LEN_SHIFT;
+	if (cmd->flags & MMC_CMD_ADTC)
+		cmd_reg |= SDHCI_UHS2_COMMAND_DATA;
+	if (cmd->opcode == MMC_STOP_TRANSMISSION)
+		cmd_reg |= SDHCI_UHS2_COMMAND_CMD12;
+
+	/* UHS2 Native ABORT */
+	if ((cmd->uhs2_cmd->header & UHS2_NATIVE_PACKET) &&
+	    ((((cmd->uhs2_cmd->arg & 0xF) << 8) |
+	    ((cmd->uhs2_cmd->arg >> 8) & 0xFF)) == UHS2_DEV_CMD_TRANS_ABORT))
+		cmd_reg |= SDHCI_UHS2_COMMAND_TRNS_ABORT;
+
+	/* UHS2 Native DORMANT */
+	if ((cmd->uhs2_cmd->header & UHS2_NATIVE_PACKET) &&
+		((((cmd->uhs2_cmd->arg & 0xF) << 8) |
+		((cmd->uhs2_cmd->arg >> 8) & 0xFF)) ==
+		UHS2_DEV_CMD_GO_DORMANT_STATE))
+		cmd_reg |= SDHCI_UHS2_COMMAND_DORMANT;
+
+	DBG("0x%x is set to UHS2 CMD register.\n", cmd_reg);
+	sdhci_writew(host, cmd_reg, SDHCI_UHS2_COMMAND);
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_send_command);
+
+void sdhci_uhs2_finish_command(struct sdhci_host *host)
+{
+	int i;
+	u8 resp;
+
+	if (host->mmc->flags & MMC_UHS2_INITIALIZED) {
+		resp = sdhci_readb(host, SDHCI_UHS2_RESPONSE + 2);
+		if (resp & UHS2_RES_NACK_MASK)
+			pr_err("%s: NACK is got, ECODE=0x%x.\n",
+				mmc_hostname(host->mmc),
+				resp & UHS2_RES_ECODE_MASK);
+	}
+
+	if (host->cmd->uhs2_resp &&
+	    host->cmd->uhs2_resp_len &&
+	    host->cmd->uhs2_resp_len <= 20)
+		/* Get whole response of some native CCMD, like
+		 * DEVICE_INIT, ENUMERATE.
+		 */
+		for (i = 0; i < host->cmd->uhs2_resp_len; i++)
+			host->cmd->uhs2_resp[i] = sdhci_readb(host,
+				SDHCI_UHS2_RESPONSE + i);
+	else
+		/* Get SD CMD response and Payload for some read
+		 * CCMD, like INQUIRY_CFG.
+		 */
+		/* Per spec (p136), payload field is divided into
+		 * a unit of DWORD and transmission order within
+		 * a DWORD is big endian.
+		 */
+		for (i = 4; i < 20; i += 4)
+			host->cmd->resp[i/4-1] = (sdhci_readb(host,
+				SDHCI_UHS2_RESPONSE + i) << 24) |
+					(sdhci_readb(host,
+				SDHCI_UHS2_RESPONSE + i + 1) << 16) |
+					(sdhci_readb(host,
+				SDHCI_UHS2_RESPONSE + i + 2) << 8) |
+					sdhci_readb(host,
+				SDHCI_UHS2_RESPONSE + i + 3);
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_finish_command);
+
+void sdhci_uhs2_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
+{
+	u8 cmd_res, dead_lock;
+	u16 ctrl_2;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+	/* Preset register: no need to handle */
+	/* Asynchronous interrupt enable */
+	/* TODO: as async interrupt is same as SDHC 3.0
+	 * I think we don't need handle it here.
+	 */
+
+	/* UHS2 Timeout Control */
+	sdhci_calc_timeout_uhs2(host, &cmd_res, &dead_lock);
+	cmd_res |= dead_lock << SDHCI_UHS2_TIMER_CTRL_DEADLOCK_SHIFT;
+	sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
+
+	/* UHS2 timing */
+	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	if (ios->timing == MMC_TIMING_UHS2)
+		ctrl_2 |= SDHCI_CTRL_UHS_2 | SDHCI_CTRL_UHS2_INTERFACE_EN;
+	else
+		ctrl_2 &= ~(SDHCI_CTRL_UHS_2 | SDHCI_CTRL_UHS2_INTERFACE_EN);
+	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+
+	if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN))
+		sdhci_enable_preset_value(host, true);
+
+	/* Set VDD2 */
+	sdhci_set_power(host, ios->power_mode, ios->vdd, ios->vdd2);
+
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_do_set_ios);
+
+static int sdhci_uhs2_interface_detect(struct sdhci_host *host)
+{
+	int timeout = 20;
+
+	while (!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
+		SDHCI_UHS2_IF_DETECT)) {
+		if (timeout == 0) {
+			pr_warn("%s: not detect UHS2 interface in 200us.\n",
+				mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			return -EIO;
+		}
+		timeout--;
+		udelay(10);
+	}
+
+	/* Enable UHS2 error interrupts */
+	sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
+			SDHCI_UHS2_ERR_INT_STATUS_MASK);
+
+	timeout = 150;
+	while (!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
+		SDHCI_UHS2_LANE_SYNC)) {
+		if (timeout == 0) {
+			pr_warn("%s: UHS2 Lane sync fail in 150ms.\n",
+				mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			return -EIO;
+		}
+		timeout--;
+		mdelay(1);
+	}
+
+	DBG("%s: UHS2 Lane synchronized in UHS2 mode, PHY is initializaed.\n",
+		mmc_hostname(host->mmc));
+	return 0;
+}
+
+static int sdhci_uhs2_init(struct sdhci_host *host)
+{
+	u16 caps_ptr = 0;
+	u32 caps_gen = 0;
+	u32 caps_phy = 0;
+	u32 caps_tran[2] = {0, 0};
+	struct mmc_host *mmc = host->mmc;
+
+	/* TODO: may add corresponding members in sdhci_host to
+	 * keep these caps.
+	 */
+	caps_ptr = sdhci_readw(host, SDHCI_UHS2_HOST_CAPS_PTR);
+	if (caps_ptr < 0x100 || caps_ptr > 0x1FF) {
+		pr_err("%s: SDHCI_UHS2_HOST_CAPS_PTR(%d) is wrong.\n",
+			mmc_hostname(mmc), caps_ptr);
+		return -ENODEV;
+	}
+	caps_gen = sdhci_readl(host,
+		caps_ptr + SDHCI_UHS2_HOST_CAPS_GEN_OFFSET);
+	caps_phy = sdhci_readl(host,
+		caps_ptr + SDHCI_UHS2_HOST_CAPS_PHY_OFFSET);
+	caps_tran[0] = sdhci_readl(host,
+		caps_ptr + SDHCI_UHS2_HOST_CAPS_TRAN_OFFSET);
+	caps_tran[1] = sdhci_readl(host,
+		caps_ptr + SDHCI_UHS2_HOST_CAPS_TRAN_1_OFFSET);
+
+	/* Geneneral Caps */
+	mmc->uhs2_caps.dap = caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_DAP_MASK;
+	mmc->uhs2_caps.gap = caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_GAP_MASK;
+	mmc->uhs2_caps.n_lanes = (caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_LANE_MASK)
+			>> SDHCI_UHS2_HOST_CAPS_GEN_LANE_SHIFT;
+	mmc->uhs2_caps.addr64 =
+		(caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_ADDR_64) ? 1 : 0;
+	mmc->uhs2_caps.card_type =
+		(caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_MASK) >>
+		SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_SHIFT;
+
+	/* PHY Caps */
+	mmc->uhs2_caps.phy_rev = caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_REV_MASK;
+	mmc->uhs2_caps.speed_range =
+		(caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_RANGE_MASK)
+		>> SDHCI_UHS2_HOST_CAPS_PHY_RANGE_SHIFT;
+	mmc->uhs2_caps.n_lss_sync =
+		(caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_MASK)
+		>> SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_SHIFT;
+	mmc->uhs2_caps.n_lss_dir =
+		(caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_MASK)
+		>> SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_SHIFT;
+	if (mmc->uhs2_caps.n_lss_sync == 0)
+		mmc->uhs2_caps.n_lss_sync = 16 << 2;
+	else
+		mmc->uhs2_caps.n_lss_sync <<= 2;
+	if (mmc->uhs2_caps.n_lss_dir == 0)
+		mmc->uhs2_caps.n_lss_dir = 16 << 3;
+	else
+		mmc->uhs2_caps.n_lss_dir <<= 3;
+
+	/* LINK/TRAN Caps */
+	mmc->uhs2_caps.link_rev =
+		caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_LINK_REV_MASK;
+	mmc->uhs2_caps.n_fcu =
+		(caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_MASK)
+		>> SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_SHIFT;
+	if (mmc->uhs2_caps.n_fcu == 0)
+		mmc->uhs2_caps.n_fcu = 256;
+	mmc->uhs2_caps.host_type =
+		(caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_MASK)
+		>> SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_SHIFT;
+	mmc->uhs2_caps.maxblk_len =
+		(caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_MASK)
+		>> SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_SHIFT;
+	mmc->uhs2_caps.n_data_gap =
+		caps_tran[1] & SDHCI_UHS2_HOST_CAPS_TRAN_1_N_DATA_GAP_MASK;
+
+	return 0;
+}
+
+int sdhci_uhs2_do_detect_init(struct sdhci_host *host)
+{
+	unsigned long flags;
+	int ret = -EIO;
+
+	DBG("%s: begin UHS2 init.\n", __func__);
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (sdhci_uhs2_interface_detect(host)) {
+		pr_warn("%s: cannot detect UHS2 interface.\n",
+				mmc_hostname(host->mmc));
+		goto out;
+	}
+
+	if (sdhci_uhs2_init(host)) {
+		pr_warn("%s: UHS2 init fail.\n",
+				mmc_hostname(host->mmc));
+		goto out;
+	}
+
+	/* TODO: is this necessary? */
+	/* Init complete, do soft reset and enable UHS2 error irqs. */
+	sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
+	sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
+			SDHCI_UHS2_ERR_INT_STATUS_MASK);
+
+	ret = 0;
+out:
+	/* TODO: do some clear work here? */
+	mmiowb();
+	spin_unlock_irqrestore(&host->lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_do_detect_init);
+
+static void sdhci_uhs2_set_config(struct sdhci_host *host)
+{
+	u32 value;
+
+	/* Set Gen Settings */
+	sdhci_writel(host, host->mmc->uhs2_caps.n_lanes_set <<
+		SDHCI_UHS2_GEN_SET_N_LANES_POS, SDHCI_UHS2_GEN_SET);
+
+	/* Set PHY Settings */
+	value = (host->mmc->uhs2_caps.n_lss_dir_set <<
+			SDHCI_UHS2_PHY_SET_N_LSS_DIR_POS) |
+		(host->mmc->uhs2_caps.n_lss_sync_set <<
+			SDHCI_UHS2_PHY_SET_N_LSS_SYN_POS);
+	if (host->mmc->flags & MMC_UHS2_SPEED_B)
+		value |= 1 << SDHCI_UHS2_PHY_SET_SPEED_POS;
+	sdhci_writel(host, value, SDHCI_UHS2_PHY_SET);
+
+	/* Set LINK-TRAN Settings */
+	value = (host->mmc->uhs2_caps.max_retry_set <<
+			SDHCI_UHS2_TRAN_SET_RETRY_CNT_POS) |
+		(host->mmc->uhs2_caps.n_fcu_set <<
+			SDHCI_UHS2_TRAN_SET_N_FCU_POS);
+	sdhci_writel(host, value, SDHCI_UHS2_TRAN_SET);
+	sdhci_writel(host, host->mmc->uhs2_caps.n_data_gap_set,
+			SDHCI_UHS2_TRAN_SET_1);
+}
+
+static int sdhci_uhs2_check_dormant(struct sdhci_host *host)
+{
+	int timeout = 100;
+
+	while (!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
+		SDHCI_UHS2_IN_DORMANT_STATE)) {
+		if (timeout == 0) {
+			pr_warn("%s: UHS2 IN_DORMANT fail in 100ms.\n",
+				mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			return -EIO;
+		}
+		timeout--;
+		mdelay(1);
+	}
+	return 0;
+}
+
+int sdhci_uhs2_do_set_reg(struct sdhci_host *host, enum uhs2_act act)
+{
+	unsigned long flags;
+	int err = 0;
+
+	DBG("Begin sdhci_uhs2_set_reg, act %d.\n", act);
+	spin_lock_irqsave(&host->lock, flags);
+
+	switch (act) {
+	case SET_CONFIG:
+		sdhci_uhs2_set_config(host);
+		break;
+	case ENABLE_INT:
+		sdhci_clear_set_irqs(host, 0, SDHCI_INT_CARD_INT);
+		break;
+	case DISABLE_INT:
+		sdhci_clear_set_irqs(host, SDHCI_INT_CARD_INT, 0);
+		break;
+	case SET_SPEED_B:
+		sdhci_writel(host, 1 << SDHCI_UHS2_PHY_SET_SPEED_POS,
+				SDHCI_UHS2_PHY_SET);
+		break;
+	case CHECK_DORMANT:
+		err = sdhci_uhs2_check_dormant(host);
+		break;
+	default:
+		pr_err("%s: input action %d is wrong!\n",
+			mmc_hostname(host->mmc), act);
+		err = -EIO;
+		break;
+	}
+
+	mmiowb();
+	spin_unlock_irqrestore(&host->lock, flags);
+	return err;
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_do_set_reg);
+
+void sdhci_uhs2_irq(struct sdhci_host *host)
+{
+	u32 uhs2mask;
+
+	uhs2mask = sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS);
+	DBG("*** %s got UHS2 interrupt: 0x%08x\n",
+		mmc_hostname(host->mmc), uhs2mask);
+
+	sdhci_writel(host, uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_MASK,
+		SDHCI_UHS2_ERR_INT_STATUS);
+
+	if (!(uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_MASK))
+		return;
+
+	if (uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_CMD_MASK) {
+		host->cmd->error = -EILSEQ;
+		if (uhs2mask &
+		    SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT)
+			host->cmd->error = -ETIMEDOUT;
+	} else if (uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_DATA_MASK) {
+		if (!host->data) {
+			pr_err("%s: Got data interrupt 0x%08x even "
+				"though no data operation was in progress.\n",
+				mmc_hostname(host->mmc), (unsigned)uhs2mask);
+			sdhci_dumpregs(host);
+			return;
+		}
+
+		if (uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT)
+			host->data->error = -ETIMEDOUT;
+		else if (uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_ADMA) {
+			pr_err("%s: ADMA error = 0x %x\n",
+				mmc_hostname(host->mmc),
+				sdhci_readb(host, SDHCI_ADMA_ERROR));
+			host->data->error = -EIO;
+		} else
+			host->data->error = -EILSEQ;
+	} else
+		/* TODO: not sure if this is required. */
+		host->cmd->error = -EILSEQ;
+
+	/* TODO: per spec, below codes should be executed when data error
+	 * found. But the codes will be executed in sdhci_tasklet_finish()
+	 * finally. So remove them first.
+	 */
+#if 0
+	if (host->mmc->flags & MMC_UHS2_INITIALIZED)
+		sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
+#endif
+
+	if (host->data->error)
+		sdhci_finish_data(host);
+	else
+		tasklet_schedule(&host->finish_tasklet);
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_irq);
+
+int sdhci_uhs2_add_host(struct sdhci_host *host, u32 caps1)
+{
+	struct mmc_host *mmc;
+	u32 max_current_caps2;
+
+	if (host->version < SDHCI_SPEC_400)
+		return 0;
+
+	mmc = host->mmc;
+
+	/* Support UHS2 */
+	if (caps1 & SDHCI_SUPPORT_UHS2) {
+		mmc->caps |= MMC_CAP_UHS2;
+		mmc->flags |= MMC_UHS2_SUPPORT;
+	}
+
+	max_current_caps2 = sdhci_readl(host, SDHCI_MAX_CURRENT_1);
+	if (!max_current_caps2 && !IS_ERR(mmc->supply.vmmc2)) {
+		/* TODO: UHS2 - VDD2 */
+		int curr = regulator_get_current_limit(mmc->supply.vmmc2);
+
+		if (curr > 0) {
+			/* convert to SDHCI_MAX_CURRENT format */
+			curr = curr/1000;  /* convert to mA */
+			curr = curr/SDHCI_MAX_CURRENT_MULTIPLIER;
+			curr = min_t(u32, curr,
+				SDHCI_MAX_CURRENT_LIMIT);
+			max_current_caps2 = curr;
+		}
+	}
+
+	if (caps1 & SDHCI_SUPPORT_VDD2_180) {
+		mmc->ocr_avail_uhs2 |= MMC_VDD2_165_195;
+		/* UHS2 doesn't require this. Only UHS-I bus needs to set
+		 * max current.
+		 */
+		mmc->max_current_180_vdd2 = (max_current_caps2 &
+					SDHCI_MAX_CURRENT_VDD2_180_MASK) *
+					SDHCI_MAX_CURRENT_MULTIPLIER;
+	} else { /* TODO: shall I? */
+		mmc->caps &= ~MMC_CAP_UHS2;
+		mmc->flags &= ~MMC_UHS2_SUPPORT;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_add_host);
+
+void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead)
+{
+	if (!(host->mmc) || !(host->mmc->flags & MMC_UHS2_SUPPORT))
+		return;
+
+	if (!dead) {
+		sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_FULL);
+	}
+
+	sdhci_writel(host, 0, SDHCI_UHS2_ERR_INT_STATUS_EN);
+	sdhci_writel(host, 0, SDHCI_UHS2_ERR_INT_SIG_EN);
+	host->mmc->flags &= ~MMC_UHS2_SUPPORT;
+	host->mmc->flags &= ~MMC_UHS2_INITIALIZED;
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_remove_host);
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
new file mode 100644
index 0000000..524bf9f
--- /dev/null
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -0,0 +1,36 @@
+/*
+ *  linux/drivers/mmc/host/sdhci-uhs2.h - Secure Digital Host Controller
+ *  Interface driver
+ *
+ * Header file for Host Controller UHS2 related registers and I/O accessors.
+ *
+ *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ */
+#ifndef __SDHCI_UHS2_H
+#define __SDHCI_UHS2_H
+
+#include <linux/mmc/host.h>
+#include <linux/mmc/core.h>
+#include <linux/mmc/sdhci.h>
+#include <linux/mmc/uhs2.h>
+
+extern void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
+extern void sdhci_uhs2_set_transfer_mode(struct sdhci_host *host,
+					struct mmc_command *cmd);
+extern void sdhci_uhs2_send_command(struct sdhci_host *host,
+					struct mmc_command *cmd);
+extern void sdhci_uhs2_finish_command(struct sdhci_host *host);
+extern void sdhci_uhs2_do_set_ios(struct sdhci_host *host,
+					struct mmc_ios *ios);
+extern int sdhci_uhs2_do_detect_init(struct sdhci_host *host);
+extern int sdhci_uhs2_do_set_reg(struct sdhci_host *host, enum uhs2_act act);
+extern void sdhci_uhs2_irq(struct sdhci_host *host);
+extern int sdhci_uhs2_add_host(struct sdhci_host *host, u32 caps1);
+extern void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead);
+
+#endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index cbb245b..c7383a7 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2,6 +2,7 @@
  *  linux/drivers/mmc/host/sdhci.c - Secure Digital Host Controller Interface driver
  *
  *  Copyright (C) 2005-2008 Pierre Ossman, All Rights Reserved.
+ *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -29,8 +30,10 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/slot-gpio.h>
+#include <linux/mmc/uhs2.h>
 
 #include "sdhci.h"
+#include "sdhci-uhs2.h"
 
 #define DRIVER_NAME "sdhci"
 
@@ -47,18 +50,14 @@
 static unsigned int debug_quirks = 0;
 static unsigned int debug_quirks2;
 
-static void sdhci_finish_data(struct sdhci_host *);
-
 static void sdhci_finish_command(struct sdhci_host *);
 static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
 static void sdhci_tuning_timer(unsigned long data);
-static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
 
 #ifdef CONFIG_PM
 static int sdhci_runtime_pm_get(struct sdhci_host *host);
 static int sdhci_runtime_pm_put(struct sdhci_host *host);
 static void sdhci_runtime_pm_bus_on(struct sdhci_host *host);
-static void sdhci_runtime_pm_bus_off(struct sdhci_host *host);
 #else
 static inline int sdhci_runtime_pm_get(struct sdhci_host *host)
 {
@@ -71,12 +70,13 @@ static inline int sdhci_runtime_pm_put(struct sdhci_host *host)
 static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
 {
 }
-static void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
+void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
 {
 }
+EXPORT_SYMBOL_GPL(sdhci_runtime_pm_bus_off);
 #endif
 
-static void sdhci_dumpregs(struct sdhci_host *host)
+void sdhci_dumpregs(struct sdhci_host *host)
 {
 	pr_debug(DRIVER_NAME ": =========== REGISTER DUMP (%s)===========\n",
 		mmc_hostname(host->mmc));
@@ -84,12 +84,21 @@ static void sdhci_dumpregs(struct sdhci_host *host)
 	pr_debug(DRIVER_NAME ": Sys addr: 0x%08x | Version:  0x%08x\n",
 		sdhci_readl(host, SDHCI_DMA_ADDRESS),
 		sdhci_readw(host, SDHCI_HOST_VERSION));
-	pr_debug(DRIVER_NAME ": Blk size: 0x%08x | Blk cnt:  0x%08x\n",
-		sdhci_readw(host, SDHCI_BLOCK_SIZE),
-		sdhci_readw(host, SDHCI_BLOCK_COUNT));
-	pr_debug(DRIVER_NAME ": Argument: 0x%08x | Trn mode: 0x%08x\n",
-		sdhci_readl(host, SDHCI_ARGUMENT),
-		sdhci_readw(host, SDHCI_TRANSFER_MODE));
+	if (host->mmc && host->mmc->flags & MMC_UHS2_SUPPORT) {
+		pr_debug(DRIVER_NAME ": Blk size: 0x%08x | Blk cnt:  0x%08x\n",
+			sdhci_readw(host, SDHCI_UHS2_BLOCK_SIZE),
+			sdhci_readl(host, SDHCI_UHS2_BLOCK_COUNT));
+		pr_debug(DRIVER_NAME ": Argument: 0x%08x | Trn mode: 0x%08x\n",
+			sdhci_readl(host, SDHCI_ARGUMENT),
+			sdhci_readw(host, SDHCI_UHS2_TRANS_MODE));
+	} else {
+		pr_debug(DRIVER_NAME ": Blk size: 0x%08x | Blk cnt:  0x%08x\n",
+			sdhci_readw(host, SDHCI_BLOCK_SIZE),
+			sdhci_readw(host, SDHCI_BLOCK_COUNT));
+		pr_debug(DRIVER_NAME ": Argument: 0x%08x | Trn mode: 0x%08x\n",
+			sdhci_readl(host, SDHCI_ARGUMENT),
+			sdhci_readw(host, SDHCI_TRANSFER_MODE));
+	}
 	pr_debug(DRIVER_NAME ": Present:  0x%08x | Host ctl: 0x%08x\n",
 		sdhci_readl(host, SDHCI_PRESENT_STATE),
 		sdhci_readb(host, SDHCI_HOST_CONTROL));
@@ -111,12 +120,21 @@ static void sdhci_dumpregs(struct sdhci_host *host)
 	pr_debug(DRIVER_NAME ": Caps:     0x%08x | Caps_1:   0x%08x\n",
 		sdhci_readl(host, SDHCI_CAPABILITIES),
 		sdhci_readl(host, SDHCI_CAPABILITIES_1));
-	pr_debug(DRIVER_NAME ": Cmd:      0x%08x | Max curr: 0x%08x\n",
-		sdhci_readw(host, SDHCI_COMMAND),
-		sdhci_readl(host, SDHCI_MAX_CURRENT));
+	if (host->mmc && host->mmc->flags & MMC_UHS2_SUPPORT)
+		pr_debug(DRIVER_NAME ": Cmd:      0x%08x | Max curr: 0x%08x\n",
+			sdhci_readw(host, SDHCI_UHS2_COMMAND),
+			sdhci_readl(host, SDHCI_MAX_CURRENT));
+	else
+		pr_debug(DRIVER_NAME ": Cmd:      0x%08x | Max curr: 0x%08x\n",
+			sdhci_readw(host, SDHCI_COMMAND),
+			sdhci_readl(host, SDHCI_MAX_CURRENT));
 	pr_debug(DRIVER_NAME ": Host ctl2: 0x%08x\n",
 		sdhci_readw(host, SDHCI_HOST_CONTROL2));
 
+	if (host->mmc && host->mmc->flags & MMC_UHS2_SUPPORT)
+		pr_debug(DRIVER_NAME ": UHS2 Err INT: 0x%08x\n",
+			sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS));
+
 	if (host->flags & SDHCI_USE_ADMA) {
 		if (host->flags & SDHCI_USE_64_BIT_DMA)
 			pr_debug(DRIVER_NAME ": ADMA Err: 0x%08x | ADMA Ptr: 0x%08x%08x\n",
@@ -131,6 +149,7 @@ static void sdhci_dumpregs(struct sdhci_host *host)
 
 	pr_debug(DRIVER_NAME ": ===========================================\n");
 }
+EXPORT_SYMBOL_GPL(sdhci_dumpregs);
 
 /*****************************************************************************\
  *                                                                           *
@@ -914,6 +933,11 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	u16 mode;
 	struct mmc_data *data = cmd->data;
 
+	if (host->mmc->flags & MMC_UHS2_SUPPORT) {
+		sdhci_uhs2_set_transfer_mode(host, cmd);
+		return;
+	}
+
 	if (data == NULL) {
 		if (host->quirks2 &
 			SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD) {
@@ -952,7 +976,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	sdhci_writew(host, mode, SDHCI_TRANSFER_MODE);
 }
 
-static void sdhci_finish_data(struct sdhci_host *host)
+void sdhci_finish_data(struct sdhci_host *host)
 {
 	struct mmc_data *data;
 
@@ -983,6 +1007,14 @@ static void sdhci_finish_data(struct sdhci_host *host)
 	else
 		data->bytes_xfered = data->blksz * data->blocks;
 
+	/* TODO: shall we send CMD12 or ABORT packet to device for error case?
+	 */
+	if (host->mmc->flags & MMC_UHS2_SUPPORT) {
+		DBG("UHS2: End data transferring...\n");
+		tasklet_schedule(&host->finish_tasklet);
+		return;
+	}
+
 	/*
 	 * Need to send CMD12 if -
 	 * a) open-ended multiblock transfer (no CMD23)
@@ -1005,6 +1037,7 @@ static void sdhci_finish_data(struct sdhci_host *host)
 	} else
 		tasklet_schedule(&host->finish_tasklet);
 }
+EXPORT_SYMBOL_GPL(sdhci_finish_data);
 
 void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 {
@@ -1051,8 +1084,6 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 
 	sdhci_prepare_data(host, cmd);
 
-	sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
-
 	sdhci_set_transfer_mode(host, cmd);
 
 	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
@@ -1082,6 +1113,13 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	    cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200)
 		flags |= SDHCI_CMD_DATA;
 
+	if (host->mmc->flags &  MMC_UHS2_SUPPORT) {
+		sdhci_uhs2_send_command(host, cmd);
+		return;
+	}
+
+	sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
+
 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
 }
 EXPORT_SYMBOL_GPL(sdhci_send_command);
@@ -1092,7 +1130,9 @@ static void sdhci_finish_command(struct sdhci_host *host)
 
 	BUG_ON(host->cmd == NULL);
 
-	if (host->cmd->flags & MMC_RSP_PRESENT) {
+	if (host->mmc->flags & MMC_UHS2_SUPPORT)
+		sdhci_uhs2_finish_command(host);
+	else if (host->cmd->flags & MMC_RSP_PRESENT) {
 		if (host->cmd->flags & MMC_RSP_136) {
 			/* CRC is stripped so we need to do some shifting. */
 			for (i = 0;i < 4;i++) {
@@ -1151,6 +1191,9 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
 	case MMC_TIMING_MMC_HS400:
 		preset = sdhci_readw(host, SDHCI_PRESET_FOR_HS400);
 		break;
+	case MMC_TIMING_UHS2:
+		preset = sdhci_readw(host, SDHCI_PRESET_FOR_UHS2);
+		break;
 	default:
 		pr_warn("%s: Invalid UHS-I mode selected\n",
 			mmc_hostname(host->mmc));
@@ -1160,12 +1203,32 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
 	return preset;
 }
 
+static bool sdhci_wait_clock_stable(struct sdhci_host *host)
+{
+	u16 clk = 0;
+	unsigned long timeout;
+
+	/* Wait max 20 ms */
+	timeout = 2000;
+	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
+		& SDHCI_CLOCK_INT_STABLE)) {
+		if (timeout == 0) {
+			pr_err("%s: Internal clock never stabilised.\n",
+				mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			return false;
+		}
+		timeout--;
+		udelay(10);
+	}
+	return true;
+}
+
 void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	int div = 0; /* Initialized for compiler warning */
 	int real_div = div, clk_mul = 1;
 	u16 clk = 0;
-	unsigned long timeout;
 
 	host->mmc->actual_clock = 0;
 
@@ -1244,18 +1307,21 @@ clock_set:
 	clk |= SDHCI_CLOCK_INT_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
-	/* Wait max 20 ms */
-	timeout = 20;
-	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
-		& SDHCI_CLOCK_INT_STABLE)) {
-		if (timeout == 0) {
-			pr_err("%s: Internal clock never "
-				"stabilised.\n", mmc_hostname(host->mmc));
-			sdhci_dumpregs(host);
+	if (false == sdhci_wait_clock_stable(host)) {
+		pr_err("%s: clock failed to be stable.\n",
+			mmc_hostname(host->mmc));
+		return;
+	}
+
+	if (host->version >= SDHCI_SPEC_400 &&
+	    sdhci_readw(host, SDHCI_HOST_CONTROL2) & SDHCI_CTRL_HOST_4_EN) {
+		clk |= SDHCI_PLL_EN;
+		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+		if (false == sdhci_wait_clock_stable(host)) {
+			pr_err("%s: clock failed to be stable.\n",
+				mmc_hostname(host->mmc));
 			return;
 		}
-		timeout--;
-		mdelay(1);
 	}
 
 	clk |= SDHCI_CLOCK_CARD_EN;
@@ -1263,8 +1329,8 @@ clock_set:
 }
 EXPORT_SYMBOL_GPL(sdhci_set_clock);
 
-static void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
-			    unsigned short vdd)
+void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
+			    unsigned short vdd, unsigned short vdd2)
 {
 	struct mmc_host *mmc = host->mmc;
 	u8 pwr = 0;
@@ -1272,6 +1338,9 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 	if (!IS_ERR(mmc->supply.vmmc)) {
 		spin_unlock_irq(&host->lock);
 		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
+		if (mmc->caps & MMC_CAP_UHS2 &&
+		    !IS_ERR(mmc->supply.vmmc2))
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc2, vdd2);
 		spin_lock_irq(&host->lock);
 		return;
 	}
@@ -1294,6 +1363,16 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 		}
 	}
 
+	if (vdd2 != (unsigned short)-1) {
+		switch (1 << vdd2) {
+		case MMC_VDD2_165_195:
+			pwr |= SDHCI_VDD2_POWER_180;
+			break;
+		default:
+			BUG();
+		}
+	}
+
 	if (host->pwr == pwr)
 		return;
 
@@ -1321,6 +1400,8 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 			sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
 
 		pwr |= SDHCI_POWER_ON;
+		if (vdd2 != (unsigned short)-1)
+			pwr |= SDHCI_VDD2_POWER_ON;
 
 		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
 
@@ -1335,6 +1416,7 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 			mdelay(10);
 	}
 }
+EXPORT_SYMBOL_GPL(sdhci_set_power);
 
 /*****************************************************************************\
  *                                                                           *
@@ -1488,6 +1570,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 {
 	unsigned long flags;
 	u8 ctrl;
+	u16 ctrl_2;
 	struct mmc_host *mmc = host->mmc;
 
 	spin_lock_irqsave(&host->lock, flags);
@@ -1497,6 +1580,10 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		if (!IS_ERR(mmc->supply.vmmc) &&
 		    ios->power_mode == MMC_POWER_OFF)
 			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+		if (host->mmc->caps & MMC_CAP_UHS2 &&
+		    !IS_ERR(mmc->supply.vmmc2) &&
+		    ios->power_mode == MMC_POWER_OFF)
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc2, 0);
 		return;
 	}
 
@@ -1531,7 +1618,28 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		}
 	}
 
-	sdhci_set_power(host, ios->power_mode, ios->vdd);
+	sdhci_set_power(host, ios->power_mode, ios->vdd, -1);
+
+	/* 4.0 host support */
+	if (host->version >= SDHCI_SPEC_400) {
+		/* Host Control 2 register */
+		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		ctrl_2 |= SDHCI_CTRL_HOST_4_EN;
+		if (host->flags & SDHCI_USE_64_BIT_DMA)
+			ctrl_2 |= SDHCI_CTRL_ADDRESS_64_BIT;
+		/* TODO: shall we enable 26bit ADMA data length mode? */
+		sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+
+		/* UHS2 Support */
+		if (host->mmc->flags & MMC_UHS2_SUPPORT &&
+		    host->mmc->caps & MMC_CAP_UHS2 &&
+		    host->mmc->ocr_avail_uhs2 & MMC_VDD2_165_195) {
+			spin_unlock_irqrestore(&host->lock, flags);
+			sdhci_uhs2_do_set_ios(host, ios);
+			spin_lock_irqsave(&host->lock, flags);
+			goto out;
+		}
+	}
 
 	if (host->ops->platform_send_init_74_clocks)
 		host->ops->platform_send_init_74_clocks(host, ios->power_mode);
@@ -1548,7 +1656,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		ctrl &= ~SDHCI_CTRL_HISPD;
 
 	if (host->version >= SDHCI_SPEC_300) {
-		u16 clk, ctrl_2;
+		u16 clk;
 
 		/* In case of UHS-I modes, set High Speed Enable */
 		if ((ios->timing == MMC_TIMING_MMC_HS400) ||
@@ -1628,6 +1736,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 	if(host->quirks & SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS)
 		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
 
+out:
 	mmiowb();
 	spin_unlock_irqrestore(&host->lock, flags);
 }
@@ -1776,8 +1885,12 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 	/*
 	 * Signal Voltage Switching is only applicable for Host Controllers
 	 * v3.00 and above.
+	 * But for UHS2, the signal voltage is supplied by vdd2 which is
+	 * already 1.8v so no voltage siwtch required.
 	 */
-	if (host->version < SDHCI_SPEC_300)
+	if (host->version < SDHCI_SPEC_300 ||
+	    (host->version >= SDHCI_SPEC_400 &&
+	    host->flags & SDHCI_USE_UHS2))
 		return 0;
 
 	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
@@ -2077,7 +2190,7 @@ out:
 }
 
 
-static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
+void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
 {
 	/* Host Controller v3.00 defines preset value registers */
 	if (host->version < SDHCI_SPEC_300)
@@ -2105,6 +2218,7 @@ static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
 		host->preset_enabled = enable;
 	}
 }
+EXPORT_SYMBOL_GPL(sdhci_enable_preset_value);
 
 static void sdhci_card_event(struct mmc_host *mmc)
 {
@@ -2124,8 +2238,11 @@ static void sdhci_card_event(struct mmc_host *mmc)
 		pr_err("%s: Resetting controller.\n",
 			mmc_hostname(host->mmc));
 
-		sdhci_do_reset(host, SDHCI_RESET_CMD);
-		sdhci_do_reset(host, SDHCI_RESET_DATA);
+		if (host->mmc->flags & MMC_UHS2_INITIALIZED)
+			sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
+		else
+			sdhci_do_reset(host, SDHCI_RESET_CMD);
+			sdhci_do_reset(host, SDHCI_RESET_DATA);
 
 		host->mrq->cmd->error = -ENOMEDIUM;
 		tasklet_schedule(&host->finish_tasklet);
@@ -2134,6 +2251,30 @@ static void sdhci_card_event(struct mmc_host *mmc)
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
+static int sdhci_uhs2_detect_init(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	int ret;
+
+	sdhci_runtime_pm_get(host);
+	ret = sdhci_uhs2_do_detect_init(host);
+	sdhci_runtime_pm_put(host);
+
+	return ret;
+}
+
+static int sdhci_uhs2_set_reg(struct mmc_host *mmc, enum uhs2_act act)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	int ret;
+
+	sdhci_runtime_pm_get(host);
+	ret = sdhci_uhs2_do_set_reg(host, act);
+	sdhci_runtime_pm_put(host);
+
+	return ret;
+}
+
 static const struct mmc_host_ops sdhci_ops = {
 	.request	= sdhci_request,
 	.set_ios	= sdhci_set_ios,
@@ -2145,6 +2286,8 @@ static const struct mmc_host_ops sdhci_ops = {
 	.execute_tuning			= sdhci_execute_tuning,
 	.card_event			= sdhci_card_event,
 	.card_busy	= sdhci_card_busy,
+	.uhs2_detect_init	= sdhci_uhs2_detect_init,
+	.uhs2_set_reg	= sdhci_uhs2_set_reg,
 };
 
 /*****************************************************************************\
@@ -2192,10 +2335,14 @@ static void sdhci_tasklet_finish(unsigned long param)
 			/* This is to force an update */
 			host->ops->set_clock(host, host->clock);
 
-		/* Spec says we should do both at the same time, but Ricoh
-		   controllers do not like that. */
-		sdhci_do_reset(host, SDHCI_RESET_CMD);
-		sdhci_do_reset(host, SDHCI_RESET_DATA);
+		if (host->mmc->flags & MMC_UHS2_INITIALIZED)
+			sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
+		else {
+			/* Spec says we should do both at the same time, but
+			 Ricoh controllers do not like that. */
+			sdhci_do_reset(host, SDHCI_RESET_CMD);
+			sdhci_do_reset(host, SDHCI_RESET_DATA);
+		}
 	}
 
 	host->mrq = NULL;
@@ -2496,6 +2643,11 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 		DBG("*** %s got interrupt: 0x%08x\n",
 			mmc_hostname(host->mmc), intmask);
 
+		if (intmask & SDHCI_INT_ERROR &&
+		    host->mmc->flags & MMC_UHS2_SUPPORT) {
+			sdhci_uhs2_irq(host);
+		}
+
 		if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
 			u32 present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
 				      SDHCI_CARD_PRESENT;
@@ -2717,13 +2869,14 @@ static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
 	pm_runtime_get_noresume(host->mmc->parent);
 }
 
-static void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
+void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
 {
 	if (host->runtime_suspended || !host->bus_on)
 		return;
 	host->bus_on = false;
 	pm_runtime_put_noidle(host->mmc->parent);
 }
+EXPORT_SYMBOL_GPL(sdhci_runtime_pm_bus_off);
 
 int sdhci_runtime_suspend_host(struct sdhci_host *host)
 {
@@ -2847,12 +3000,13 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	override_timeout_clk = host->timeout_clk;
 
+	/* TODO: shall I reset UHS2 here? */
 	sdhci_do_reset(host, SDHCI_RESET_ALL);
 
 	host->version = sdhci_readw(host, SDHCI_HOST_VERSION);
 	host->version = (host->version & SDHCI_SPEC_VER_MASK)
 				>> SDHCI_SPEC_VER_SHIFT;
-	if (host->version > SDHCI_SPEC_300) {
+	if (host->version > SDHCI_SPEC_410) {
 		pr_err("%s: Unknown controller version (%d). "
 			"You may experience problems.\n", mmc_hostname(mmc),
 			host->version);
@@ -2866,6 +3020,13 @@ int sdhci_add_host(struct sdhci_host *host)
 			host->caps1 :
 			sdhci_readl(host, SDHCI_CAPABILITIES_1);
 
+	if (host->version >= SDHCI_SPEC_400) {
+		if (caps[1] & SDHCI_SUPPORT_UHS2) {
+			mmc->caps |= MMC_CAP_UHS2;
+			mmc->flags |= MMC_UHS2_SUPPORT;
+		}
+	}
+
 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
 		host->flags |= SDHCI_USE_SDMA;
 	else if (!(caps[0] & SDHCI_CAN_DO_SDMA))
@@ -3302,6 +3463,9 @@ int sdhci_add_host(struct sdhci_host *host)
 	 */
 	mmc->max_blk_count = (host->quirks & SDHCI_QUIRK_NO_MULTIBLOCK) ? 1 : 65535;
 
+	if (host->version >= SDHCI_SPEC_400)
+		sdhci_uhs2_add_host(host, caps[1]);
+
 	/*
 	 * Init tasklets.
 	 */
@@ -3365,6 +3529,8 @@ int sdhci_add_host(struct sdhci_host *host)
 
 #ifdef SDHCI_USE_LEDS_CLASS
 reset:
+	/* TODO: shall I reset UHS2 and clear UHS2 irq here? */
+	sdhci_uhs2_remove_host(host, 0);
 	sdhci_do_reset(host, SDHCI_RESET_ALL);
 	sdhci_writel(host, 0, SDHCI_INT_ENABLE);
 	sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
@@ -3407,8 +3573,11 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 	led_classdev_unregister(&host->led);
 #endif
 
-	if (!dead)
+	sdhci_uhs2_remove_host(host, dead);
+
+	if (!dead) {
 		sdhci_do_reset(host, SDHCI_RESET_ALL);
+	}
 
 	sdhci_writel(host, 0, SDHCI_INT_ENABLE);
 	sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 41a2c34..75091ee 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -4,6 +4,7 @@
  * Header file for Host Controller registers and I/O accessors.
  *
  *  Copyright (C) 2005-2008 Pierre Ossman, All Rights Reserved.
+ *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -24,13 +25,18 @@
  * Controller registers
  */
 
-#define SDHCI_DMA_ADDRESS	0x00
+#define SDHCI_DMA_ADDRESS	0x00	/* Host version less than 4.0 */
 #define SDHCI_ARGUMENT2		SDHCI_DMA_ADDRESS
+/*
+ * 32bit Block Count register is only selected when Host Version Enable
+ * is set to 4 and 16bit Block Count register is set to zero.
+ */
+#define SDHCI_32B_BLOCK_COUNT	SDHCI_DMA_ADDRESS /* Host version is 4.0 */
 
 #define SDHCI_BLOCK_SIZE	0x04
 #define  SDHCI_MAKE_BLKSZ(dma, blksz) (((dma & 0x7) << 12) | (blksz & 0xFFF))
 
-#define SDHCI_BLOCK_COUNT	0x06
+#define SDHCI_BLOCK_COUNT	0x06	/* 16bit Block Count */
 
 #define SDHCI_ARGUMENT		0x08
 
@@ -39,11 +45,34 @@
 #define  SDHCI_TRNS_BLK_CNT_EN	0x02
 #define  SDHCI_TRNS_AUTO_CMD12	0x04
 #define  SDHCI_TRNS_AUTO_CMD23	0x08
+/*
+ * Since Version 4.10, use of Auto CMD Auto Select is recommended rather
+ * than use of Auto CMD12 Enable or Auto CMD23 Enable.
+ * Selection of Auto CMD depends on setting of CMD23 Enable in the Host
+ * Control 2 register.
+ */
+#define  SDHCI_TRNS_AUTO_CMD_AUTO_SEL	0x0C
 #define  SDHCI_TRNS_READ	0x10
 #define  SDHCI_TRNS_MULTI	0x20
+/*
+ * Defined in Host Version 4.10.
+ * 1 - R5 (SDIO)
+ * 0 - R1 (Memory)
+ */
+#define  SDHCI_TRNS_RES_TYPE		0x40
+#define  SDHCI_TRNS_RES_ERR_CHECK	0x80
+#define  SDHCI_TRNS_RES_INT_DIS		0x0100
 
 #define SDHCI_COMMAND		0x0E
 #define  SDHCI_CMD_RESP_MASK	0x03
+/*
+ * Host Version 4.10 adds this bit to distinguish a main command or
+ * sub command.
+ * CMD53(SDIO) - main command
+ * CMD52(SDIO) - sub command which doesn't have data block or doesn't
+ * indicate busy.
+ */
+#define  SDHCI_CMD_SUB_CMD	0x04
 #define  SDHCI_CMD_CRC		0x08
 #define  SDHCI_CMD_INDEX	0x10
 #define  SDHCI_CMD_DATA		0x20
@@ -58,12 +87,17 @@
 #define SDHCI_GET_CMD(c) ((c>>8) & 0x3f)
 
 #define SDHCI_RESPONSE		0x10
+#define  SDHCI_RESPONSE_CM_TRAN_ABORT_OFFSET	0x10
+#define  SDHCI_RESPONSE_CM_TRAN_ABORT_SIZE	4
+#define  SDHCI_RESPONSE_SD_TRAN_ABORT_OFFSET	0x18
+#define  SDHCI_RESPONSE_SD_TRAN_ABORT_SIZE	8
 
 #define SDHCI_BUFFER		0x20
 
 #define SDHCI_PRESENT_STATE	0x24
 #define  SDHCI_CMD_INHIBIT	0x00000001
 #define  SDHCI_DATA_INHIBIT	0x00000002
+#define  SDHCI_DATA_HIGH_LVL_MASK	0x000000F0
 #define  SDHCI_DOING_WRITE	0x00000100
 #define  SDHCI_DOING_READ	0x00000200
 #define  SDHCI_SPACE_AVAILABLE	0x00000400
@@ -73,6 +107,12 @@
 #define  SDHCI_DATA_LVL_MASK	0x00F00000
 #define   SDHCI_DATA_LVL_SHIFT	20
 #define   SDHCI_DATA_0_LVL_MASK	0x00100000
+#define  SDHCI_HOST_REGULATOR_STABLE	0x02000000
+#define  SDHCI_CMD_NOT_ISSUE_ERR	0x08000000
+#define  SDHCI_SUB_CMD_STATUS		0x10000000
+#define  SDHCI_UHS2_IN_DORMANT_STATE	0x20000000
+#define  SDHCI_UHS2_LANE_SYNC		0x40000000
+#define  SDHCI_UHS2_IF_DETECT		0x80000000
 
 #define SDHCI_HOST_CONTROL	0x28
 #define  SDHCI_CTRL_LED		0x01
@@ -90,6 +130,10 @@
 #define  SDHCI_POWER_180	0x0A
 #define  SDHCI_POWER_300	0x0C
 #define  SDHCI_POWER_330	0x0E
+/* VDD2 - UHS2 */
+#define  SDHCI_VDD2_POWER_ON		0x10
+#define  SDHCI_VDD2_POWER_180		0xA0
+#define  SDHCI_VDD2_POWER_120		0x80
 
 #define SDHCI_BLOCK_GAP_CONTROL	0x2A
 
@@ -105,6 +149,7 @@
 #define  SDHCI_DIV_MASK_LEN	8
 #define  SDHCI_DIV_HI_MASK	0x300
 #define  SDHCI_PROG_CLOCK_MODE	0x0020
+#define  SDHCI_PLL_EN	0x0008
 #define  SDHCI_CLOCK_CARD_EN	0x0004
 #define  SDHCI_CLOCK_INT_STABLE	0x0002
 #define  SDHCI_CLOCK_INT_EN	0x0001
@@ -128,6 +173,8 @@
 #define  SDHCI_INT_CARD_INSERT	0x00000040
 #define  SDHCI_INT_CARD_REMOVE	0x00000080
 #define  SDHCI_INT_CARD_INT	0x00000100
+/* Host Version 4.10 */
+#define  SDHCI_INT_FX_EVENT	0x00002000
 #define  SDHCI_INT_ERROR	0x00008000
 #define  SDHCI_INT_TIMEOUT	0x00010000
 #define  SDHCI_INT_CRC		0x00020000
@@ -139,6 +186,8 @@
 #define  SDHCI_INT_BUS_POWER	0x00800000
 #define  SDHCI_INT_ACMD12ERR	0x01000000
 #define  SDHCI_INT_ADMA_ERROR	0x02000000
+/* Host Version 4.0 */
+#define  SDHCI_INT_RESPONSE_ERROR	0x08000000
 
 #define  SDHCI_INT_NORMAL_MASK	0x00007FFF
 #define  SDHCI_INT_ERROR_MASK	0xFFFF8000
@@ -153,6 +202,8 @@
 #define SDHCI_INT_ALL_MASK	((unsigned int)-1)
 
 #define SDHCI_ACMD12_ERR	0x3C
+/* Host Version 4.10 */
+#define  SDHCI_ACMD_RESPONSE_ERROR	0x0020
 
 #define SDHCI_HOST_CONTROL2		0x3E
 #define  SDHCI_CTRL_UHS_MASK		0x0007
@@ -162,14 +213,23 @@
 #define   SDHCI_CTRL_UHS_SDR104		0x0003
 #define   SDHCI_CTRL_UHS_DDR50		0x0004
 #define   SDHCI_CTRL_HS400		0x0005 /* Non-standard */
-#define  SDHCI_CTRL_VDD_180		0x0008
-#define  SDHCI_CTRL_DRV_TYPE_MASK	0x0030
+/* UHS2 */
+#define   SDHCI_CTRL_UHS_2		0x0007
+#define  SDHCI_CTRL_VDD_180		0x0008	/* UHS-I only */
+#define  SDHCI_CTRL_DRV_TYPE_MASK	0x0030	/* UHS-I only */
 #define   SDHCI_CTRL_DRV_TYPE_B		0x0000
 #define   SDHCI_CTRL_DRV_TYPE_A		0x0010
 #define   SDHCI_CTRL_DRV_TYPE_C		0x0020
 #define   SDHCI_CTRL_DRV_TYPE_D		0x0030
-#define  SDHCI_CTRL_EXEC_TUNING		0x0040
-#define  SDHCI_CTRL_TUNED_CLK		0x0080
+#define  SDHCI_CTRL_EXEC_TUNING		0x0040	/* UHS-I only */
+#define  SDHCI_CTRL_TUNED_CLK		0x0080	/* UHS-I only */
+/* UHS2 */
+#define  SDHCI_CTRL_UHS2_INTERFACE_EN	0x0100
+#define  SDHCI_CTRL_ADMA2_LEN_MODE	0x0400
+#define  SDHCI_CTRL_CMD23_EN		0x0800
+#define  SDHCI_CTRL_HOST_4_EN		0x1000
+#define  SDHCI_CTRL_ADDRESS_64_BIT	0x2000
+#define  SDHCI_CTRL_ASYNC_INT_EN	0x4000
 #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
 
 #define SDHCI_CAPABILITIES	0x40
@@ -189,7 +249,10 @@
 #define  SDHCI_CAN_VDD_330	0x01000000
 #define  SDHCI_CAN_VDD_300	0x02000000
 #define  SDHCI_CAN_VDD_180	0x04000000
+/* Host Version 4.10 */
+#define  SDHCI_CAN_64BIT_V4	0x08000000
 #define  SDHCI_CAN_64BIT	0x10000000
+#define  SDHCI_CAN_ASYNC_INT	0x20000000
 
 #define  SDHCI_SUPPORT_SDR50	0x00000001
 #define  SDHCI_SUPPORT_SDR104	0x00000002
@@ -204,11 +267,17 @@
 #define  SDHCI_RETUNING_MODE_SHIFT		14
 #define  SDHCI_CLOCK_MUL_MASK	0x00FF0000
 #define  SDHCI_CLOCK_MUL_SHIFT	16
+/* UHS2 */
+#define  SDHCI_SUPPORT_VDD2_180	0x10000000
 #define  SDHCI_SUPPORT_HS400	0x80000000 /* Non-standard */
 
 #define SDHCI_CAPABILITIES_1	0x44
+/* UHS2 */
+#define  SDHCI_SUPPORT_UHS2	0x00000008
+#define  SDHCI_CAN_DO_ADMA3	0x08000000
 
 #define SDHCI_MAX_CURRENT		0x48
+#define SDHCI_MAX_CURRENT_1		0x4C
 #define  SDHCI_MAX_CURRENT_LIMIT	0xFF
 #define  SDHCI_MAX_CURRENT_330_MASK	0x0000FF
 #define  SDHCI_MAX_CURRENT_330_SHIFT	0
@@ -216,12 +285,19 @@
 #define  SDHCI_MAX_CURRENT_300_SHIFT	8
 #define  SDHCI_MAX_CURRENT_180_MASK	0xFF0000
 #define  SDHCI_MAX_CURRENT_180_SHIFT	16
+/* UHS2 */
+#define  SDHCI_MAX_CURRENT_VDD2_180_MASK	0x0000000FF
 #define   SDHCI_MAX_CURRENT_MULTIPLIER	4
 
 /* 4C-4F reserved for more max current */
 
 #define SDHCI_SET_ACMD12_ERROR	0x50
+/* Host Version 4.10 */
+#define SDHCI_SET_ACMD_RESPONSE_ERROR	0x20
 #define SDHCI_SET_INT_ERROR	0x52
+/* Host Version 4.10 */
+#define SDHCI_SET_INT_TUNING_ERROR	0x0400
+#define SDHCI_SET_INT_RESPONSE_ERROR	0x0800
 
 #define SDHCI_ADMA_ERROR	0x54
 
@@ -237,7 +313,10 @@
 #define SDHCI_PRESET_FOR_SDR50 0x6A
 #define SDHCI_PRESET_FOR_SDR104        0x6C
 #define SDHCI_PRESET_FOR_DDR50 0x6E
+/* TODO: 0x74 is used for UHS2 in 4.10. How about HS400? */
 #define SDHCI_PRESET_FOR_HS400 0x74 /* Non-standard */
+/* UHS2 */
+#define SDHCI_PRESET_FOR_UHS2  0x74
 #define SDHCI_PRESET_DRV_MASK  0xC000
 #define SDHCI_PRESET_DRV_SHIFT  14
 #define SDHCI_PRESET_CLKGEN_SEL_MASK   0x400
@@ -245,6 +324,219 @@
 #define SDHCI_PRESET_SDCLK_FREQ_MASK   0x3FF
 #define SDHCI_PRESET_SDCLK_FREQ_SHIFT	0
 
+#define SDHCI_ADMA3_ADDRESS	0x78
+
+/* UHS-II */
+#define SDHCI_UHS2_BLOCK_SIZE	0x80
+#define  SDHCI_UHS2_MAKE_BLKSZ(dma, blksz) \
+	(((dma & 0x7) << 12) | (blksz & 0xFFF))
+
+#define SDHCI_UHS2_BLOCK_COUNT	0x84
+
+#define SDHCI_UHS2_CMD_PACKET	0x88
+#define  SDHCI_UHS2_CMD_PACK_MAX_LEN	20
+
+#define SDHCI_UHS2_TRANS_MODE	0x9C
+#define  SDHCI_UHS2_TRNS_DMA		0x0001
+#define  SDHCI_UHS2_TRNS_BLK_CNT_EN	0x0002
+#define  SDHCI_UHS2_TRNS_DATA_TRNS_WRT	0x0010
+#define  SDHCI_UHS2_TRNS_BLK_BYTE_MODE	0x0020
+#define  SDHCI_UHS2_TRNS_RES_R5		0x0040
+#define  SDHCI_UHS2_TRNS_RES_ERR_CHECK_EN	0x0080
+#define  SDHCI_UHS2_TRNS_RES_INT_DIS	0x0100
+#define  SDHCI_UHS2_TRNS_WAIT_EBSY	0x4000
+#define  SDHCI_UHS2_TRNS_2L_HD		0x8000
+
+#define SDHCI_UHS2_COMMAND	0x9E
+#define  SDHCI_UHS2_COMMAND_SUB_CMD	0x0004
+#define  SDHCI_UHS2_COMMAND_DATA	0x0020
+#define  SDHCI_UHS2_COMMAND_TRNS_ABORT	0x0040
+#define  SDHCI_UHS2_COMMAND_CMD12	0x0080
+#define  SDHCI_UHS2_COMMAND_DORMANT	0x00C0
+#define  SDHCI_UHS2_COMMAND_PACK_LEN_MASK	0x1F00
+#define  SDHCI_UHS2_COMMAND_PACK_LEN_SHIFT	8
+
+#define SDHCI_UHS2_RESPONSE	0xA0
+#define  SDHCI_UHS2_RESPONSE_MAX_LEN	20
+
+#define SDHCI_UHS2_MSG_SELECT	0xB4
+#define SDHCI_UHS2_MSG_SELECT_CURR	0x0
+#define SDHCI_UHS2_MSG_SELECT_ONE	0x1
+#define SDHCI_UHS2_MSG_SELECT_TWO	0x2
+#define SDHCI_UHS2_MSG_SELECT_THREE	0x3
+
+#define SDHCI_UHS2_MSG		0xB8
+
+#define SDHCI_UHS2_DEV_INT_STATUS	0xBC
+
+#define SDHCI_UHS2_DEV_SELECT	0xBE
+#define SDHCI_UHS2_DEV_SELECT_DEV_SEL_MASK	0x0F
+#define SDHCI_UHS2_DEV_SELECT_INT_MSG_EN	0x80
+
+#define SDHCI_UHS2_DEV_INT_CODE	0xBF
+
+#define SDHCI_UHS2_SW_RESET	0xC0
+#define SDHCI_UHS2_SW_RESET_FULL	0x0001
+#define SDHCI_UHS2_SW_RESET_SD		0x0002
+
+#define SDHCI_UHS2_TIMER_CTRL	0xC2
+#define SDHCI_UHS2_TIMER_CTRL_DEADLOCK_SHIFT	4
+
+#define SDHCI_UHS2_ERR_INT_STATUS	0xC4
+#define SDHCI_UHS2_ERR_INT_STATUS_EN	0xC8
+#define SDHCI_UHS2_ERR_INT_SIG_EN	0xCC
+#define SDHCI_UHS2_ERR_INT_STATUS_HEADER	0x00000001
+#define SDHCI_UHS2_ERR_INT_STATUS_RES		0x00000002
+#define SDHCI_UHS2_ERR_INT_STATUS_RETRY_EXP	0x00000004
+#define SDHCI_UHS2_ERR_INT_STATUS_CRC		0x00000008
+#define SDHCI_UHS2_ERR_INT_STATUS_FRAME		0x00000010
+#define SDHCI_UHS2_ERR_INT_STATUS_TID		0x00000020
+#define SDHCI_UHS2_ERR_INT_STATUS_UNRECOVER	0x00000080
+#define SDHCI_UHS2_ERR_INT_STATUS_EBUSY		0x00000100
+#define SDHCI_UHS2_ERR_INT_STATUS_ADMA		0x00008000
+#define SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT	0x00010000
+#define SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT	0x00020000
+#define SDHCI_UHS2_ERR_INT_STATUS_VENDOR	0x08000000
+#define SDHCI_UHS2_ERR_INT_STATUS_MASK	\
+		(SDHCI_UHS2_ERR_INT_STATUS_HEADER |	\
+		SDHCI_UHS2_ERR_INT_STATUS_RES |		\
+		SDHCI_UHS2_ERR_INT_STATUS_RETRY_EXP |	\
+		SDHCI_UHS2_ERR_INT_STATUS_CRC |		\
+		SDHCI_UHS2_ERR_INT_STATUS_FRAME |	\
+		SDHCI_UHS2_ERR_INT_STATUS_TID |		\
+		SDHCI_UHS2_ERR_INT_STATUS_UNRECOVER |	\
+		SDHCI_UHS2_ERR_INT_STATUS_EBUSY |	\
+		SDHCI_UHS2_ERR_INT_STATUS_ADMA |	\
+		SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT |	\
+		SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT)
+#define SDHCI_UHS2_ERR_INT_STATUS_CMD_MASK	\
+		(SDHCI_UHS2_ERR_INT_STATUS_HEADER |	\
+		SDHCI_UHS2_ERR_INT_STATUS_RES |		\
+		SDHCI_UHS2_ERR_INT_STATUS_FRAME |	\
+		SDHCI_UHS2_ERR_INT_STATUS_TID |		\
+		SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT)
+/* TODO: CRC is for data or cmd? */
+#define SDHCI_UHS2_ERR_INT_STATUS_DATA_MASK	\
+		(SDHCI_UHS2_ERR_INT_STATUS_RETRY_EXP |	\
+		SDHCI_UHS2_ERR_INT_STATUS_CRC |		\
+		SDHCI_UHS2_ERR_INT_STATUS_UNRECOVER |	\
+		SDHCI_UHS2_ERR_INT_STATUS_EBUSY |	\
+		SDHCI_UHS2_ERR_INT_STATUS_ADMA |	\
+		SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT)
+
+#define SDHCI_UHS2_SET_PTR	0xE0
+#define  SDHCI_UHS2_GEN_SET	(SDHCI_UHS2_SET_PTR + 0)
+#define   SDHCI_UHS2_GEN_SET_POWER_LOW	0x0001
+#define   SDHCI_UHS2_GEN_SET_N_LANES_POS	8
+#define   SDHCI_UHS2_GEN_SET_2L_FD_HD	0x0
+#define   SDHCI_UHS2_GEN_SET_2D1U_FD	0x2
+#define   SDHCI_UHS2_GEN_SET_1D2U_FD	0x3
+#define   SDHCI_UHS2_GEN_SET_2D2U_FD	0x4
+
+#define  SDHCI_UHS2_PHY_SET	(SDHCI_UHS2_SET_PTR + 4)
+#define   SDHCI_UHS2_PHY_SET_SPEED_POS	6
+#define   SDHCI_UHS2_PHY_SET_HIBER_EN	0x00008000
+#define   SDHCI_UHS2_PHY_SET_N_LSS_SYN_MASK	0x000F0000
+#define   SDHCI_UHS2_PHY_SET_N_LSS_SYN_POS	16
+#define   SDHCI_UHS2_PHY_SET_N_LSS_DIR_MASK	0x00F00000
+#define   SDHCI_UHS2_PHY_SET_N_LSS_DIR_POS	20
+
+#define  SDHCI_UHS2_TRAN_SET	(SDHCI_UHS2_SET_PTR + 8)
+#define   SDHCI_UHS2_TRAN_SET_N_FCU_MASK	0x0000FF00
+#define   SDHCI_UHS2_TRAN_SET_N_FCU_POS	8
+#define   SDHCI_UHS2_TRAN_SET_RETRY_CNT_MASK	0x00030000
+#define   SDHCI_UHS2_TRAN_SET_RETRY_CNT_POS	16
+
+#define  SDHCI_UHS2_TRAN_SET_1	(SDHCI_UHS2_SET_PTR + 12)
+#define   SDHCI_UHS2_TRAN_SET_1_N_DAT_GAP_MASK	0x000000FF
+
+#define SDHCI_UHS2_HOST_CAPS_PTR	0xE2
+#define  SDHCI_UHS2_HOST_CAPS_GEN_OFFSET	0
+#define   SDHCI_UHS2_HOST_CAPS_GEN_DAP_MASK	0x0000000F
+#define   SDHCI_UHS2_HOST_CAPS_GEN_DAP(dap)	({	\
+		if (dap == 0)				\
+			return 360;			\
+		else					\
+			return dap * 360; })
+#define   SDHCI_UHS2_HOST_CAPS_GEN_GAP_MASK	0x000000F0
+#define   SDHCI_UHS2_HOST_CAPS_GEN_GAP(gap)	(gap * 360)
+#define   SDHCI_UHS2_HOST_CAPS_GEN_LANE_MASK	0x00003F00
+#define   SDHCI_UHS2_HOST_CAPS_GEN_LANE_SHIFT	8
+#define    SDHCI_UHS2_HOST_CAPS_GEN_2L_HD_FD	1
+#define    SDHCI_UHS2_HOST_CAPS_GEN_2D1U_FD	2
+#define    SDHCI_UHS2_HOST_CAPS_GEN_1D2U_FD	4
+#define    SDHCI_UHS2_HOST_CAPS_GEN_2D2U_FD	8
+#define   SDHCI_UHS2_HOST_CAPS_GEN_ADDR_64	0x00004000
+#define   SDHCI_UHS2_HOST_CAPS_GEN_BOOT		0x00008000
+#define   SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_MASK	0x00030000
+#define   SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_SHIFT	16
+#define    SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_RMV	0
+#define    SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_EMB	1
+#define    SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_EMB_RMV	2
+#define   SDHCI_UHS2_HOST_CAPS_GEN_NUM_DEV_MASK		0x003C0000
+#define   SDHCI_UHS2_HOST_CAPS_GEN_NUM_DEV_SHIFT	18
+#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_MASK	0x00C00000
+#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_SHIFT	22
+#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_P2P		0
+#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_RING	1
+#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_HUB		2
+#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_HUB_RING	3
+
+#define  SDHCI_UHS2_HOST_CAPS_PHY_OFFSET	4
+#define   SDHCI_UHS2_HOST_CAPS_PHY_REV_MASK	0x0000003F
+#define   SDHCI_UHS2_HOST_CAPS_PHY_RANGE_MASK	0x000000C0
+#define   SDHCI_UHS2_HOST_CAPS_PHY_RANGE_SHIFT	6
+#define   SDHCI_UHS2_HOST_CAPS_PHY_RANGE_A	0
+#define   SDHCI_UHS2_HOST_CAPS_PHY_RANGE_B	1
+#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_MASK	0x000F0000
+#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_SHIFT	16
+#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN(n_lss) ({	\
+		if (n_lss == 0)				\
+			return 16 * 4;			\
+		else					\
+			return n_lss * 4; })
+#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_MASK	0x00F00000
+#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_SHIFT	20
+#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR(n_lss) ({	\
+		if (n_lss == 0)				\
+			return 16 * 8;			\
+		else					\
+			return n_lss * 8; })
+
+#define  SDHCI_UHS2_HOST_CAPS_TRAN_OFFSET	8
+#define   SDHCI_UHS2_HOST_CAPS_TRAN_LINK_REV_MASK	0x0000003F
+#define   SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_MASK	0x0000FF00
+#define   SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_SHIFT	8
+#define   SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU(n_fcu) ({	\
+		if (n_fcu == 0)				\
+			return 256;			\
+		else					\
+			return n_fcu; })
+#define   SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_MASK	0x00070000
+#define   SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_SHIFT	16
+#define   SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_MASK	0xFFF00000
+#define   SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_SHIFT	20
+
+#define  SDHCI_UHS2_HOST_CAPS_TRAN_1_OFFSET	12
+#define  SDHCI_UHS2_HOST_CAPS_TRAN_1_N_DATA_GAP_MASK	0x000000FF
+
+#define SDHCI_UHS2_TEST_PTR	0xE4
+#define  SDHCI_UHS2_TEST_ERR_HEADER	0x00000001
+#define  SDHCI_UHS2_TEST_ERR_RES	0x00000002
+#define  SDHCI_UHS2_TEST_ERR_RETRY_EXP	0x00000004
+#define  SDHCI_UHS2_TEST_ERR_CRC	0x00000008
+#define  SDHCI_UHS2_TEST_ERR_FRAME	0x00000010
+#define  SDHCI_UHS2_TEST_ERR_TID	0x00000020
+#define  SDHCI_UHS2_TEST_ERR_UNRECOVER	0x00000080
+#define  SDHCI_UHS2_TEST_ERR_EBUSY	0x00000100
+#define  SDHCI_UHS2_TEST_ERR_ADMA	0x00008000
+#define  SDHCI_UHS2_TEST_ERR_RES_TIMEOUT	0x00010000
+#define  SDHCI_UHS2_TEST_ERR_DEADLOCK_TIMEOUT	0x00020000
+#define  SDHCI_UHS2_TEST_ERR_VENDOR	0x08000000
+
+#define SDHCI_UHS2_EMBED_CTRL	0xE6
+#define SDHCI_UHS2_VENDOR	0xE8
+
 #define SDHCI_SLOT_INT_STATUS	0xFC
 
 #define SDHCI_HOST_VERSION	0xFE
@@ -255,6 +547,8 @@
 #define   SDHCI_SPEC_100	0
 #define   SDHCI_SPEC_200	1
 #define   SDHCI_SPEC_300	2
+#define   SDHCI_SPEC_400	3
+#define   SDHCI_SPEC_410	4
 
 /*
  * End of controller registers.
@@ -458,4 +752,11 @@ extern int sdhci_runtime_suspend_host(struct sdhci_host *host);
 extern int sdhci_runtime_resume_host(struct sdhci_host *host);
 #endif
 
+/* sdhci_uhs2.c needed */
+extern void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
+extern void sdhci_dumpregs(struct sdhci_host *host);
+extern void sdhci_finish_data(struct sdhci_host *);
+extern void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
+			unsigned short vdd, unsigned short vdd2);
+extern void sdhci_runtime_pm_bus_off(struct sdhci_host *host);
 #endif /* __SDHCI_HW_H */
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 375af80..fc938fc 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -2,6 +2,7 @@
  *  linux/include/linux/mmc/sdhci.h - Secure Digital Host Controller Interface
  *
  *  Copyright (C) 2005-2008 Pierre Ossman, All Rights Reserved.
+ *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -137,6 +138,7 @@ struct sdhci_host {
 #define SDHCI_SDR104_NEEDS_TUNING (1<<10)	/* SDR104/HS200 needs tuning */
 #define SDHCI_USING_RETUNING_TIMER (1<<11)	/* Host is using a retuning timer for the card */
 #define SDHCI_USE_64_BIT_DMA	(1<<12)	/* Use 64-bit DMA */
+#define SDHCI_USE_UHS2		(1<<13)	/* Support UHS2 */
 
 	unsigned int version;	/* SDHCI spec. version */
 
-- 
1.7.9.5

