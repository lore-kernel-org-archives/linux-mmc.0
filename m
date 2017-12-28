From: "ernest.zhang" <ernest.zhang@bayhubtech.com>
Subject: [PATCH 3/3] mmc: sdhci: fix o2 eMMC init bug and add support for hardware tuning
Date: Thu, 28 Dec 2017 18:00:08 +0800
Message-ID: <20171228100008.4056-1-ernest.zhang@bayhubtech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-sn1nam02on0103.outbound.protection.outlook.com ([104.47.36.103]:13324
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753127AbdL1KAa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 28 Dec 2017 05:00:30 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yuxiang.wan@bayhubtech.com, xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com

In some case of eMMC used as boot device, the eMMC signaling voltage is
fixed to 1.8v, bios can set o2 sd host controller register 0x308 bit4 to
let host controller skip try 3.3.v signaling voltage in eMMC initialize
process.
O2 sd host controller has a function named hardware tuning. In software
tuning mode CPU should send multiple command to host controller but in
hardware tuning mode, CPU need send only one tuning command to sd host
controller. It can improve the speed linux boot from eMMC.

Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 218 ++++++++++++++++++++++++++++++++++-
 1 file changed, 217 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 14273ca00641..fd244d88b07e 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -16,11 +16,211 @@
  */
 
 #include <linux/pci.h>
-
+#include <linux/platform_device.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/delay.h>
 #include "sdhci.h"
 #include "sdhci-pci.h"
 #include "sdhci-pci-o2micro.h"
 
+static void sdhci_o2_start_tuning(struct sdhci_host *host)
+{
+	u16 ctrl;
+
+	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	ctrl |= SDHCI_CTRL_EXEC_TUNING;
+	if (host->quirks2 & SDHCI_QUIRK2_TUNING_WORK_AROUND)
+		ctrl |= SDHCI_CTRL_TUNED_CLK;
+	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+
+	/*
+	 * As per the Host Controller spec v3.00, tuning command
+	 * generates Buffer Read Ready interrupt, so enable that.
+	 *
+	 * Note: The spec clearly says that when tuning sequence
+	 * is being performed, the controller does not generate
+	 * interrupts other than Buffer Read Ready interrupt. But
+	 * to make sure we don't hit a controller bug, we _only_
+	 * enable Buffer Read Ready interrupt here.
+	 */
+	sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_INT_ENABLE);
+	sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_SIGNAL_ENABLE);
+}
+
+static void sdhci_o2_end_tuning(struct sdhci_host *host)
+{
+	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+}
+
+static inline bool sdhci_data_line_cmd(struct mmc_command *cmd)
+{
+	return cmd->data || cmd->flags & MMC_RSP_BUSY;
+}
+
+static void sdhci_del_timer(struct sdhci_host *host, struct mmc_request *mrq)
+{
+	if (sdhci_data_line_cmd(mrq->cmd))
+		del_timer(&host->data_timer);
+	else
+		del_timer(&host->timer);
+}
+
+static void sdhci_o2_set_tuning_mode(struct sdhci_host *host, bool hw)
+{
+	u16 reg;
+
+	if (hw) {
+		// enable hardware tuning
+		reg = sdhci_readw(host, O2_SD_VENDOR_SETTING);
+		reg &= (~O2_SD_HW_TUNING_ENABLE);
+		sdhci_writew(host, reg, O2_SD_VENDOR_SETTING);
+	} else {
+		reg = sdhci_readw(host, O2_SD_VENDOR_SETTING);
+		reg |= O2_SD_HW_TUNING_ENABLE;
+		sdhci_writew(host, reg, O2_SD_VENDOR_SETTING);
+	}
+}
+
+static u8 data_buf[64];
+
+static void sdhci_o2_send_tuning(struct sdhci_host *host, u32 opcode)
+{
+	struct mmc_command cmd = { };
+	struct mmc_data data = { };
+	struct scatterlist sg;
+	struct mmc_request mrq = { };
+	unsigned long flags;
+	u32 b = host->sdma_boundary;
+	int size = sizeof(data_buf);
+
+	cmd.opcode = opcode;
+	cmd.flags = MMC_RSP_PRESENT | MMC_RSP_OPCODE | MMC_RSP_CRC;
+	cmd.mrq = &mrq;
+	mrq.cmd = &cmd;
+	mrq.data = &data;
+	data.blksz = size;
+	data.blocks = 1;
+	data.flags = MMC_DATA_READ;
+
+	data.timeout_ns = 150 * NSEC_PER_MSEC;
+
+	data.sg = &sg;
+	data.sg_len = 1;
+	sg_init_one(&sg, data_buf, size);
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	sdhci_writew(host, SDHCI_MAKE_BLKSZ(b, 64), SDHCI_BLOCK_SIZE);
+
+	/*
+	 * The tuning block is sent by the card to the host controller.
+	 * So we set the TRNS_READ bit in the Transfer Mode register.
+	 * This also takes care of setting DMA Enable and Multi Block
+	 * Select in the same register to 0.
+	 */
+	sdhci_writew(host, SDHCI_TRNS_READ, SDHCI_TRANSFER_MODE);
+
+	sdhci_send_command(host, &cmd);
+
+	host->cmd = NULL;
+
+	sdhci_del_timer(host, &mrq);
+
+	host->tuning_done = 0;
+
+	mmiowb();
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	/* Wait for Buffer Read Ready interrupt */
+	wait_event_timeout(host->buf_ready_int, (host->tuning_done == 1),
+			   msecs_to_jiffies(50));
+
+}
+
+static void sdhci_o2_reset_tuning(struct sdhci_host *host)
+{
+	u16 ctrl;
+
+	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	ctrl &= ~SDHCI_CTRL_TUNED_CLK;
+	ctrl &= ~SDHCI_CTRL_EXEC_TUNING;
+	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+}
+
+static void __sdhci_o2_execute_tuning(struct sdhci_host *host, u32 opcode)
+{
+	int i;
+
+	sdhci_o2_send_tuning(host, MMC_SEND_TUNING_BLOCK_HS200);
+
+	for (i = 0; i < 150; i++) {
+		u16 ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+
+		if (!(ctrl & SDHCI_CTRL_EXEC_TUNING)) {
+			if (ctrl & SDHCI_CTRL_TUNED_CLK) {
+				pr_info("%s: HW tuning ok !\n",
+					mmc_hostname(host->mmc));
+				host->tuning_done = true;
+				return;
+			}
+			pr_warn("%s: HW tuning failed !\n",
+				   mmc_hostname(host->mmc));
+			break;
+		}
+
+		mdelay(1);
+	}
+
+	pr_info("%s: Tuning failed, falling back to fixed sampling clock\n",
+		mmc_hostname(host->mmc));
+	sdhci_o2_reset_tuning(host);
+}
+
+static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	int current_bus_width = 0;
+
+	/*
+	 * This handler only implements the eMMC tuning that is specific to
+	 * this controller.  Fall back to the standard method for other TINMING.
+	 */
+	if (host->timing != MMC_TIMING_MMC_HS200)
+		return sdhci_execute_tuning(mmc, opcode);
+
+	if (WARN_ON(opcode != MMC_SEND_TUNING_BLOCK_HS200))
+		return -EINVAL;
+
+	/*
+	 * o2 sdhci host didn't support 8bit emmc tuning
+	 */
+	if (mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
+		current_bus_width = mmc->ios.bus_width;
+		mmc->ios.bus_width = MMC_BUS_WIDTH_4;
+		mmc->ops->set_ios(mmc, &mmc->ios);
+	}
+
+	sdhci_o2_set_tuning_mode(host, true);
+
+	sdhci_o2_start_tuning(host);
+
+	__sdhci_o2_execute_tuning(host, opcode);
+
+	sdhci_o2_end_tuning(host);
+
+	if (current_bus_width == MMC_BUS_WIDTH_8) {
+		mmc->ios.bus_width = current_bus_width;
+		mmc->ops->set_ios(mmc, &mmc->ios);
+	}
+
+	host->flags &= ~SDHCI_HS400_TUNING;
+	return 0;
+}
+
 static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
 {
 	u32 scratch_32;
@@ -151,6 +351,7 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 	struct sdhci_pci_chip *chip;
 	struct sdhci_host *host;
 	u32 reg;
+	int ret;
 
 	chip = slot->chip;
 	host = slot->host;
@@ -164,6 +365,21 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 		if (reg & 0x1)
 			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
 
+		if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD0) {
+			ret = pci_read_config_dword(chip->pdev,
+						    O2_SD_MISC_SETTING, &reg);
+			if (ret)
+				return -EIO;
+			if (reg & (1 << 4)) {
+				pr_info("%s: emmc 1.8v flag is set, force 1.8v signaling voltage\n",
+				     mmc_hostname(host->mmc));
+				host->flags &= ~(SDHCI_SIGNALING_330);
+				host->flags |= SDHCI_SIGNALING_180;
+			}
+		}
+
+		host->mmc_host_ops.execute_tuning = sdhci_o2_execute_tuning;
+
 		if (chip->pdev->device != PCI_DEVICE_ID_O2_FUJIN2)
 			break;
 		/* set dll watch dog timer */
-- 
2.14.1

