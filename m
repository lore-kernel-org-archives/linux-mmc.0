From: <dinguyen@altera.com>
Subject: [PATCH 1/2] mmc: dw_mmc: Enable the hold reg for certain speed modes
Date: Fri, 6 Dec 2013 10:10:22 -0600
Message-ID: <1386346223-18464-2-git-send-email-dinguyen@altera.com>
References: <1386346223-18464-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:14267
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753168Ab3LFQMO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Dec 2013 11:12:14 -0500
In-Reply-To: <1386346223-18464-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com, arnd@arndb.de, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com
Cc: linux-mmc@vger.kernel.org, Dinh Nguyen <dinguyen@altera.com>

From: Dinh Nguyen <dinguyen@altera.com>

This patch will enable the SDMMC_CMD_USE_HOLD_REG bit when the slot is
operating all timing modes, except for SDR50, DDR50, SDR104, and MMC_HS200.

According to the Synopsys databook :"To meet the relatively high Input Hold
Time requirement for SDR12, SDR25, and other MMC speed modes, you should
program bit[29]use_hold_Reg of the CMD register to 1'b1;"..."However, for
the higher speed modes of SDR104, SDR50 and DDR50, you can meet the much
smaller Input Hold Time requirement of 0.8ns by bypassing the Hold Register
(Path A in Figure 10-8, programming CMD.use_hold_reg = 1'b0) and then adding
delay elements on the output path as indicated."

This information is taking from the v2.50a of the Synopsys Designware Cores
Mobile Storage Host Databook.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
 drivers/mmc/host/dw_mmc.c  |   14 ++++++++++++++
 include/linux/mmc/dw_mmc.h |    1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 4bce0de..7075248 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -279,6 +279,9 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
 			cmdr |= SDMMC_CMD_DAT_WR;
 	}
 
+	if (slot->host->use_hold_reg)
+		cmdr |= SDMMC_CMD_USE_HOLD_REG;
+
 	if (drv_data && drv_data->prepare_command)
 		drv_data->prepare_command(slot->host, &cmdr);
 
@@ -969,6 +972,17 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	mci_writel(slot->host, UHS_REG, regs);
 	slot->host->timing = ios->timing;
 
+	switch (slot->host->timing) {
+	case MMC_TIMING_UHS_SDR50:
+	case MMC_TIMING_UHS_SDR104:
+	case MMC_TIMING_UHS_DDR50:
+	case MMC_TIMING_MMC_HS200:
+		slot->host->use_hold_reg = 0;
+		break;
+	default:
+		slot->host->use_hold_reg = 1;
+	}
+
 	/*
 	 * Use mirror of ios->clock to prevent race with mmc
 	 * core ios update when finding the minimum.
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 6ce7d2c..b9bf3b8 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -191,6 +191,7 @@ struct dw_mci {
 	struct regulator	*vmmc;	/* Power regulator */
 	unsigned long		irq_flags; /* IRQ flags */
 	int			irq;
+	bool			use_hold_reg;
 };
 
 /* DMA ops for Internal/External DMAC interface */
-- 
1.7.9.5


