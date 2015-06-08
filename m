From: Daniel Lockyer <thisisdaniellockyer@gmail.com>
Subject: [PATCH] MMC: host: Fixed multiple checkpatch.pl issues in 4 files.
Date: Mon, 8 Jun 2015 14:24:52 +0100
Message-ID: <20150608132452.GA19476@eve.soton.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37985 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984AbbFHNYy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Jun 2015 09:24:54 -0400
Received: by wibdq8 with SMTP id dq8so85189933wib.1
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2015 06:24:53 -0700 (PDT)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org

Changes include indenting and spacing.

Also replaced a few asm/ includes with linux/. Sometimes the
new include has already been included so just removed the /asm.

Signed-off-by: Daniel Lockyer <thisisdaniellockyer@gmail.com>
---
 drivers/mmc/host/android-goldfish.c | 14 ++++++--------
 drivers/mmc/host/atmel-mci.c        | 14 +++++---------
 drivers/mmc/host/au1xmmc.c          | 16 +++++++---------
 drivers/mmc/host/mmci.c             |  6 ++----
 4 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/drivers/mmc/host/android-goldfish.c b/drivers/mmc/host/android-goldfish.c
index 8b4e20a..afea796 100644
--- a/drivers/mmc/host/android-goldfish.c
+++ b/drivers/mmc/host/android-goldfish.c
@@ -43,13 +43,11 @@
 #include <linux/timer.h>
 #include <linux/clk.h>
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/irq.h>
-#include <asm/scatterlist.h>
-
+#include <linux/scatterlist.h>
 #include <asm/types.h>
-#include <asm/io.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 
 #define DRIVER_NAME "goldfish_mmc"
 
@@ -309,10 +307,10 @@ static irqreturn_t goldfish_mmc_irq(int irq, void *dev_id)
 		if (status & MMC_STAT_STATE_CHANGE)
 			state_changed = 1;
 
-                if (status & MMC_STAT_CMD_TIMEOUT) {
+		if (status & MMC_STAT_CMD_TIMEOUT) {
 			end_command = 0;
 			cmd_timeout = 1;
-                }
+		}
 	}
 
 	if (cmd_timeout) {
@@ -353,7 +351,7 @@ static irqreturn_t goldfish_mmc_irq(int irq, void *dev_id)
 	if (!end_command && !end_transfer &&
 	    !transfer_error && !state_changed && !cmd_timeout) {
 		status = GOLDFISH_MMC_READ(host, MMC_INT_STATUS);
-		dev_info(mmc_dev(host->mmc),"spurious irq 0x%04x\n", status);
+		dev_info(mmc_dev(host->mmc), "spurious irq 0x%04x\n", status);
 		if (status != 0) {
 			GOLDFISH_MMC_WRITE(host, MMC_INT_STATUS, status);
 			GOLDFISH_MMC_WRITE(host, MMC_INT_ENABLE, 0);
diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 9a39e0b..e5d2216 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -42,7 +42,6 @@
 #include <linux/pinctrl/consumer.h>
 
 #include <asm/cacheflush.h>
-#include <asm/io.h>
 #include <asm/unaligned.h>
 
 #include "atmel-mci-regs.h"
@@ -1390,9 +1389,8 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		}
 		if (!any_slot_active) {
 			atmci_writel(host, ATMCI_CR, ATMCI_CR_MCIDIS);
-			if (host->mode_reg) {
+			if (host->mode_reg)
 				atmci_readl(host, ATMCI_MR);
-			}
 			host->mode_reg = 0;
 		}
 		spin_unlock_bh(&host->lock);
@@ -1830,13 +1828,12 @@ static void atmci_tasklet_func(unsigned long priv)
 				host->stop_transfer(host);
 				host->data = NULL;
 				if (data) {
-					if (status & ATMCI_DTOE) {
+					if (status & ATMCI_DTOE)
 						data->error = -ETIMEDOUT;
-					} else if (status & ATMCI_DCRCE) {
+					else if (status & ATMCI_DCRCE)
 						data->error = -EILSEQ;
-					} else {
+					else
 						data->error = -EIO;
-					}
 				}
 			}
 
@@ -1995,9 +1992,8 @@ static void atmci_sdio_interrupt(struct atmel_mci *host, u32 status)
 
 	for (i = 0; i < ATMCI_MAX_NR_SLOTS; i++) {
 		struct atmel_mci_slot *slot = host->slot[i];
-		if (slot && (status & slot->sdio_irq)) {
+		if (slot && (status & slot->sdio_irq))
 			mmc_signal_sdio_irq(slot->mmc);
-		}
 	}
 }
 
diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index ed77fbf..044206d 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -43,8 +43,8 @@
 #include <linux/leds.h>
 #include <linux/mmc/host.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 
-#include <asm/io.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
 #include <asm/mach-au1x00/au1100_mmc.h>
@@ -352,7 +352,7 @@ static void au1xmmc_data_complete(struct au1xmmc_host *host, u32 status)
 	data->error = 0;
 	dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len, host->dma.dir);
 
-        /* Process any errors */
+	/* Process any errors */
 	crc = (status & (SD_STATUS_WC | SD_STATUS_RC));
 	if (host->flags & HOST_F_XMIT)
 		crc |= ((status & 0x07) == 0x02) ? 0 : 1;
@@ -491,8 +491,7 @@ static void au1xmmc_receive_pio(struct au1xmmc_host *host)
 			DBG("RX Overrun [%d + %d]\n", host->pdev->id,
 					host->pio.len, count);
 			break;
-		}
-		else if (status & SD_STATUS_RU) {
+		} else if (status & SD_STATUS_RU) {
 			DBG("RX Underrun [%d + %d]\n", host->pdev->id,
 					host->pio.len,	count);
 			break;
@@ -567,7 +566,7 @@ static void au1xmmc_cmd_complete(struct au1xmmc_host *host, u32 status)
 		}
 	}
 
-        /* Figure out errors */
+	/* Figure out errors */
 	if (status & (SD_STATUS_SC | SD_STATUS_WC | SD_STATUS_RC))
 		cmd->error = -EILSEQ;
 
@@ -589,7 +588,7 @@ static void au1xmmc_cmd_complete(struct au1xmmc_host *host, u32 status)
 		if (host->flags & HOST_F_RECV) {
 			u32 mask = SD_STATUS_DB | SD_STATUS_NE;
 
-			while((status & mask) != mask)
+			while ((status & mask) != mask)
 				status = __raw_readl(HOST_STATUS(host));
 		}
 
@@ -685,7 +684,7 @@ dataerr:
 }
 
 /* This actually starts a command or data transaction */
-static void au1xmmc_request(struct mmc_host* mmc, struct mmc_request* mrq)
+static void au1xmmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct au1xmmc_host *host = mmc_priv(mmc);
 	int ret = 0;
@@ -758,9 +757,8 @@ static void au1xmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	if (ios->power_mode == MMC_POWER_OFF)
 		au1xmmc_set_power(host, 0);
-	else if (ios->power_mode == MMC_POWER_ON) {
+	else if (ios->power_mode == MMC_POWER_ON)
 		au1xmmc_set_power(host, 1);
-	}
 
 	if (ios->clock && ios->clock != host->clock) {
 		au1xmmc_set_clock(host, ios->clock);
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index fb26674..653d7bea 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -39,7 +39,6 @@
 #include <linux/pinctrl/consumer.h>
 
 #include <asm/div64.h>
-#include <asm/io.h>
 #include <asm/sizes.h>
 
 #include "mmci.h"
@@ -968,11 +967,10 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 			/* The error clause is handled above, success! */
 			data->bytes_xfered = data->blksz * data->blocks;
 
-		if (!data->stop || host->mrq->sbc) {
+		if (!data->stop || host->mrq->sbc)
 			mmci_request_end(host, data->mrq);
-		} else {
+		else
 			mmci_start_command(host, data->stop, 0);
-		}
 	}
 }
 
-- 
2.4.2

