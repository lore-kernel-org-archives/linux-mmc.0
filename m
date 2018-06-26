From: "ernest.zhang" <ernest.zhang@bayhubtech.com>
Subject: [PATCH V6 2/3] mmc: sdhci: Add support for O2 hardware tuning
Date: Tue, 26 Jun 2018 23:46:46 +0800
Message-ID: <20180626154647.11623-2-ernest.zhang@bayhubtech.com>
References: <20180626154647.11623-1-ernest.zhang@bayhubtech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180626154647.11623-1-ernest.zhang@bayhubtech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ernest.zhang@bayhubtech.com, chuanjin.pang@bayhubtech.com, mike.li@bayhubtech.com, chevron.li@bayhubtech.com, shirley.her@bayhubtech.com, xiaoguang.yu@bayhubtech.com, bobby.wu@bayhubtech.com
List-Id: linux-mmc@vger.kernel.org

Add hardware tuning function instead of software tuning because O2/Bayhub
SD host controller support hardware tuning.

Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
---
Changes in V6:
	1. From module 'sdhci' export the symbols 'sdhci_start_tuning',
	'sdhci_end_tuning','sdhci_send_tuning' and 'sdhci_reset_tuning'.
	2. Remove local tuning related functions in sdhci-pci-o2-micro.c
	instead of above function exported in sdhci module.
	3. Remove unneeded braces in function sdhci_set_transfer_mode.
	4. Move change log to correct place.

Changes in V5:
	In function sdhci_o2_send_tuning, mrq.data should set to NULL for
	cmd.data has been set to NULL.

Changes in V4:
	Patch V3 delete register SDHCI_TRANSFER_MODE write operation before
	send hardware tuning command in function sdhci_o2_send_tuning. This
	is a mistake. The write operation is essential for tuning command.
	Add it back.

Changes in V3:
	Rebase the patch on the mmc tree 'next' branch.

Changes in V2:
	Modify code format, and delete unused code path.

Changes in V1:
	Add many functions to execute hardware tuning for eMMC 1.8V HS200
	mode, the hardware tuning procedure is based on O2/Bayhub hardware
	tuning spec.
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 81 ++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c             | 16 ++++---
 drivers/mmc/host/sdhci.h             |  5 +++
 3 files changed, 97 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 94cf3cd..7747e8b 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -17,6 +17,9 @@
  */
 
 #include <linux/pci.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/delay.h>
 
 #include "sdhci.h"
 #include "sdhci-pci.h"
@@ -55,6 +58,82 @@
 
 #define O2_SD_VENDOR_SETTING	0x110
 #define O2_SD_VENDOR_SETTING2	0x1C8
+#define O2_SD_HW_TUNING_DISABLE	BIT(4)
+
+static void sdhci_o2_set_tuning_mode(struct sdhci_host *host)
+{
+	u16 reg;
+
+	/* enable hardware tuning */
+	reg = sdhci_readw(host, O2_SD_VENDOR_SETTING);
+	reg &= ~O2_SD_HW_TUNING_DISABLE;
+	sdhci_writew(host, reg, O2_SD_VENDOR_SETTING);
+}
+
+static void __sdhci_o2_execute_tuning(struct sdhci_host *host, u32 opcode)
+{
+	int i;
+
+	sdhci_send_tuning(host, MMC_SEND_TUNING_BLOCK_HS200);
+
+	for (i = 0; i < 150; i++) {
+		u16 ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+
+		if (!(ctrl & SDHCI_CTRL_EXEC_TUNING)) {
+			if (ctrl & SDHCI_CTRL_TUNED_CLK) {
+				host->tuning_done = true;
+				return;
+			}
+			pr_warn("%s: HW tuning failed !\n",
+				mmc_hostname(host->mmc));
+			break;
+		}
+
+		mdelay(1);
+	}
+
+	pr_info("%s: Tuning failed, falling back to fixed sampling clock\n",
+		mmc_hostname(host->mmc));
+	sdhci_reset_tuning(host);
+}
+
+static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	int current_bus_width = 0;
+
+	/*
+	 * This handler only implements the eMMC tuning that is specific to
+	 * this controller.  Fall back to the standard method for other TIMING.
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
+		sdhci_set_bus_width(host, MMC_BUS_WIDTH_4);
+	}
+
+	sdhci_o2_set_tuning_mode(host);
+
+	sdhci_start_tuning(host);
+
+	__sdhci_o2_execute_tuning(host, opcode);
+
+	sdhci_end_tuning(host);
+
+	if (current_bus_width == MMC_BUS_WIDTH_8)
+		sdhci_set_bus_width(host, current_bus_width);
+
+	host->flags &= ~SDHCI_HS400_TUNING;
+	return 0;
+}
 
 static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
 {
@@ -215,6 +294,8 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 			}
 		}
 
+		host->mmc_host_ops.execute_tuning = sdhci_o2_execute_tuning;
+
 		if (chip->pdev->device != PCI_DEVICE_ID_O2_FUJIN2)
 			break;
 		/* set dll watch dog timer */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1c828e0..4f3e3c2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1029,7 +1029,9 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	if (data == NULL) {
 		if (host->quirks2 &
 			SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD) {
-			sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
+			/* must not clear SDHCI_TRANSFER_MODE when tuning */
+			if (cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
+				sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
 		} else {
 		/* clear Auto CMD settings for no data CMDs */
 			mode = sdhci_readw(host, SDHCI_TRANSFER_MODE);
@@ -2103,7 +2105,7 @@ static int sdhci_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
 	return 0;
 }
 
-static void sdhci_start_tuning(struct sdhci_host *host)
+void sdhci_start_tuning(struct sdhci_host *host)
 {
 	u16 ctrl;
 
@@ -2126,14 +2128,16 @@ static void sdhci_start_tuning(struct sdhci_host *host)
 	sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_INT_ENABLE);
 	sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_SIGNAL_ENABLE);
 }
+EXPORT_SYMBOL_GPL(sdhci_start_tuning);
 
-static void sdhci_end_tuning(struct sdhci_host *host)
+void sdhci_end_tuning(struct sdhci_host *host)
 {
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 }
+EXPORT_SYMBOL_GPL(sdhci_end_tuning);
 
-static void sdhci_reset_tuning(struct sdhci_host *host)
+void sdhci_reset_tuning(struct sdhci_host *host)
 {
 	u16 ctrl;
 
@@ -2142,6 +2146,7 @@ static void sdhci_reset_tuning(struct sdhci_host *host)
 	ctrl &= ~SDHCI_CTRL_EXEC_TUNING;
 	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 }
+EXPORT_SYMBOL_GPL(sdhci_reset_tuning);
 
 static void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode)
 {
@@ -2162,7 +2167,7 @@ static void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode)
  * interrupt setup is different to other commands and there is no timeout
  * interrupt so special handling is needed.
  */
-static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
+void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
 {
 	struct mmc_host *mmc = host->mmc;
 	struct mmc_command cmd = {};
@@ -2212,6 +2217,7 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
 			   msecs_to_jiffies(50));
 
 }
+EXPORT_SYMBOL_GPL(sdhci_send_tuning);
 
 static void __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 23966f8..2a09c0a 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -748,4 +748,9 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
 
 void sdhci_dumpregs(struct sdhci_host *host);
 
+void sdhci_start_tuning(struct sdhci_host *host);
+void sdhci_end_tuning(struct sdhci_host *host);
+void sdhci_send_tuning(struct sdhci_host *host, u32 opcode);
+void sdhci_reset_tuning(struct sdhci_host *host);
+
 #endif /* __SDHCI_HW_H */
-- 
2.7.4
