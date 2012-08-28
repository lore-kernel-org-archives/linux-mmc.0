From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 4/5] mmc: dw-mmc: add the use_hold_reg in CMD register
Date: Tue, 28 Aug 2012 16:55:44 +0900
Message-ID: <503C7980.9040109@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:32195 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254Ab2H1Hzs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Aug 2012 03:55:48 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M9G000OYGNEIH00@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 28 Aug 2012 16:55:47 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M9G00G8GGOYHPB0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 28 Aug 2012 16:55:47 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <James.Hogan@imgtec.com>, Thomas Abraham <thomas.abraham@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>

This patch is added the use_hold_reg bit in CMD register.

In upper version than 2.40a, bit[29] of CMD register is used the use_hold_reg.
Some SoC is affected by this bit.
(This bit means whether use hold register when send data and cmd.
 And related with cclk_in_drv phase)

Now i known that HOLD-register is using only Exynos-SoC.
But hold-register is supported basically feature at Synopsys-IP.
If Other SoC is used hold regster, we can change the _CLKSEL_REG_.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/dw_mmc.c  |   36 ++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/dw_mmc.h  |    1 +
 include/linux/mmc/dw_mmc.h |    3 +++
 3 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 437fdf8..3642455 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -265,11 +265,45 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
 static void dw_mci_start_command(struct dw_mci *host,
 				 struct mmc_command *cmd, u32 cmd_flags)
 {
+	struct dw_mci_slot *slot = host->cur_slot;
+	struct mmc_ios *ios = &slot->mmc->ios;
+
 	host->cmd = cmd;
 	dev_vdbg(&host->dev,
 		 "start command: ARGR=0x%08x CMDR=0x%08x\n",
 		 cmd->arg, cmd_flags);
 
+	if (host->quirks & DW_MCI_QUIRK_USE_CLKSEL_REG) {
+		/*
+		 * If use HOLD register and SDR12/SDSR25,
+		 * CMD and DATA sent to card through HOLD regster by default.
+		 * But if mode is SDR50/DDR50/SDR104,
+		 * only use the hold register when cclk_in_drv value is greater than 0.
+		 */
+		switch (ios->timing) {
+		case MMC_TIMING_UHS_SDR50:
+		case MMC_TIMING_UHS_DDR50:
+		case MMC_TIMING_UHS_SDR104:
+			if (host->pdata->get_clk_drv &&
+					host->pdata->get_clk_drv(host) &&
+					host->use_hold_reg) {
+				cmd_flags |= SDMMC_CMD_USE_HOLD_REG;
+				break;
+			}
+
+			cmd_flags &= ~SDMMC_CMD_USE_HOLD_REG;
+			break;
+		case MMC_TIMING_UHS_SDR12:
+		case MMC_TIMING_UHS_SDR25:
+			if (host->use_hold_reg) {
+				cmd_flags |= SDMMC_CMD_USE_HOLD_REG;
+				break;
+			}
+		default:
+			cmd_flags &= ~SDMMC_CMD_USE_HOLD_REG;
+		}
+	}
+
 	mci_writel(host, CMDARG, cmd->arg);
 	wmb();
 
@@ -2015,6 +2049,8 @@ int dw_mci_probe(struct dw_mci *host)
 		host->data_shift = 2;
 	}
 
+	host->use_hold_reg = (mci_readl(host, HCON) >> 22) & 0x1;
+
 	/* Reset all blocks */
 	if (!mci_wait_reset(&host->dev, host))
 		return -ENODEV;
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index b6a1a78..cc905ee 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -111,6 +111,7 @@
 #define SDMMC_INT_ERROR			0xbfc2
 /* Command register defines */
 #define SDMMC_CMD_START			BIT(31)
+#define SDMMC_CMD_USE_HOLD_REG		BIT(29)
 #define SDMMC_CMD_CCS_EXP		BIT(23)
 #define SDMMC_CMD_CEATA_RD		BIT(22)
 #define SDMMC_CMD_UPD_CLK		BIT(21)
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index f20979c..803a80d 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -156,6 +156,7 @@ struct dw_mci {
 	u32			fifoth_val;
 	u16			verid;
 	u16			data_offset;
+	bool			use_hold_reg;
 	struct device		dev;
 	struct dw_mci_board	*pdata;
 	struct dw_mci_slot	*slot[MAX_MCI_SLOTS];
@@ -201,6 +202,8 @@ struct dw_mci_dma_ops {
 #define DW_MCI_QUIRK_HIGHSPEED			BIT(2)
 /* Unreliable card detection */
 #define DW_MCI_QUIRK_BROKEN_CARD_DETECTION	BIT(3)
+/* To use the CLKSEL register for phase-shift */
+#define DW_MCI_QUIRK_USE_CLKSEL_REG		BIT(4)
 
 
 struct dma_pdata;
-- 
1.7.4.1
