From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH V9 2/2] mmc: host: Adds support for eMMC 4.5 HS200 mode
Date: Fri,  6 Jan 2012 09:56:39 +0530
Message-ID: <1325823999-21770-3-git-send-email-girish.shivananjappa@linaro.org>
References: <1325823999-21770-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54579 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758640Ab2AFE0z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Jan 2012 23:26:55 -0500
In-Reply-To: <1325823999-21770-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: patches@linaro.org, linux-samsung-soc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>, Chris Ball <cjb@laptop.org>

This patch adds support for the HS200 mode on the host side.
Also enables the tuning feature required when the HS200 mode
is selected.

cc: Chris Ball <cjb@laptop.org>
Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
---
 drivers/mmc/host/sdhci.c  |   45 ++++++++++++++++++++++++++++++++++-----------
 drivers/mmc/host/sdhci.h  |    1 +
 include/linux/mmc/sdhci.h |    1 +
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a8f1f7e..4be50ea 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -49,7 +49,7 @@ static void sdhci_finish_data(struct sdhci_host *);
 
 static void sdhci_send_command(struct sdhci_host *, struct mmc_command *);
 static void sdhci_finish_command(struct sdhci_host *);
-static int sdhci_execute_tuning(struct mmc_host *mmc);
+static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
 static void sdhci_tuning_timer(unsigned long data);
 
 #ifdef CONFIG_PM_RUNTIME
@@ -1014,7 +1014,8 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		flags |= SDHCI_CMD_INDEX;
 
 	/* CMD19 is special in that the Data Present Select should be set */
-	if (cmd->data || (cmd->opcode == MMC_SEND_TUNING_BLOCK))
+	if (cmd->data || (cmd->opcode == MMC_SEND_TUNING_BLOCK) ||
+	    (cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200))
 		flags |= SDHCI_CMD_DATA;
 
 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
@@ -1287,7 +1288,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		if ((host->flags & SDHCI_NEEDS_RETUNING) &&
 		    !(present_state & (SDHCI_DOING_WRITE | SDHCI_DOING_READ))) {
 			spin_unlock_irqrestore(&host->lock, flags);
-			sdhci_execute_tuning(mmc);
+			sdhci_execute_tuning(mmc, mrq->cmd->opcode);
 			spin_lock_irqsave(&host->lock, flags);
 
 			/* Restore original mmc_request structure */
@@ -1382,7 +1383,8 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		unsigned int clock;
 
 		/* In case of UHS-I modes, set High Speed Enable */
-		if ((ios->timing == MMC_TIMING_UHS_SDR50) ||
+		if ((ios->timing == MMC_TIMING_MMC_HS200) ||
+		    (ios->timing == MMC_TIMING_UHS_SDR50) ||
 		    (ios->timing == MMC_TIMING_UHS_SDR104) ||
 		    (ios->timing == MMC_TIMING_UHS_DDR50) ||
 		    (ios->timing == MMC_TIMING_UHS_SDR25))
@@ -1435,7 +1437,9 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 			ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 			/* Select Bus Speed Mode for host */
 			ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
-			if (ios->timing == MMC_TIMING_UHS_SDR12)
+			if (ios->timing == MMC_TIMING_MMC_HS200)
+				ctrl_2 |= SDHCI_CTRL_HS_SDR200;
+			else if (ios->timing == MMC_TIMING_UHS_SDR12)
 				ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
 			else if (ios->timing == MMC_TIMING_UHS_SDR25)
 				ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
@@ -1682,7 +1686,7 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 	return err;
 }
 
-static int sdhci_execute_tuning(struct mmc_host *mmc)
+static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct sdhci_host *host;
 	u16 ctrl;
@@ -1703,10 +1707,13 @@ static int sdhci_execute_tuning(struct mmc_host *mmc)
 	 * Host Controller needs tuning only in case of SDR104 mode
 	 * and for SDR50 mode when Use Tuning for SDR50 is set in
 	 * Capabilities register.
+	 * If the Host Controller supports the HS200 mode then tuning
+	 * function has to be executed.
 	 */
 	if (((ctrl & SDHCI_CTRL_UHS_MASK) == SDHCI_CTRL_UHS_SDR104) ||
 	    (((ctrl & SDHCI_CTRL_UHS_MASK) == SDHCI_CTRL_UHS_SDR50) &&
-	    (host->flags & SDHCI_SDR50_NEEDS_TUNING)))
+	    (host->flags & SDHCI_SDR50_NEEDS_TUNING)) ||
+	    (host->flags & SDHCI_HS200_NEEDS_TUNING))
 		ctrl |= SDHCI_CTRL_EXEC_TUNING;
 	else {
 		spin_unlock(&host->lock);
@@ -1742,7 +1749,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc)
 		if (!tuning_loop_counter && !timeout)
 			break;
 
-		cmd.opcode = MMC_SEND_TUNING_BLOCK;
+		cmd.opcode = opcode;
 		cmd.arg = 0;
 		cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
 		cmd.retries = 0;
@@ -1757,7 +1764,17 @@ static int sdhci_execute_tuning(struct mmc_host *mmc)
 		 * block to the Host Controller. So we set the block size
 		 * to 64 here.
 		 */
-		sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64), SDHCI_BLOCK_SIZE);
+		if (cmd.opcode == MMC_SEND_TUNING_BLOCK_HS200) {
+			if (mmc->ios.bus_width == MMC_BUS_WIDTH_8)
+				sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 128),
+					     SDHCI_BLOCK_SIZE);
+			else if (mmc->ios.bus_width == MMC_BUS_WIDTH_4)
+				sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64),
+					     SDHCI_BLOCK_SIZE);
+		} else {
+			sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64),
+				     SDHCI_BLOCK_SIZE);
+		}
 
 		/*
 		 * The tuning block is sent by the card to the host controller.
@@ -2140,12 +2157,14 @@ static void sdhci_show_adma_error(struct sdhci_host *host) { }
 
 static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 {
+	u32 command;
 	BUG_ON(intmask == 0);
 
 	/* CMD19 generates _only_ Buffer Read Ready interrupt */
 	if (intmask & SDHCI_INT_DATA_AVAIL) {
-		if (SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND)) ==
-		    MMC_SEND_TUNING_BLOCK) {
+		command = SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND));
+		if ((command == MMC_SEND_TUNING_BLOCK) ||
+		    (command == MMC_SEND_TUNING_BLOCK_HS200)) {
 			host->tuning_done = 1;
 			wake_up(&host->buf_ready_int);
 			return;
@@ -2750,6 +2769,10 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (caps[1] & SDHCI_USE_SDR50_TUNING)
 		host->flags |= SDHCI_SDR50_NEEDS_TUNING;
 
+	/* Does the host needs tuning for HS200? */
+	if (mmc->caps2 & MMC_CAP2_HS200)
+		host->flags |= SDHCI_HS200_NEEDS_TUNING;
+
 	/* Driver Type(s) (A, C, D) supported by the host */
 	if (caps[1] & SDHCI_DRIVER_TYPE_A)
 		mmc->caps |= MMC_CAP_DRIVER_TYPE_A;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index a04d4d0..46fd2ac 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -158,6 +158,7 @@
 #define   SDHCI_CTRL_UHS_SDR50		0x0002
 #define   SDHCI_CTRL_UHS_SDR104		0x0003
 #define   SDHCI_CTRL_UHS_DDR50		0x0004
+#define   SDHCI_CTRL_HS_SDR200		0x0005 /*reserved value in SDIO spec */
 #define  SDHCI_CTRL_VDD_180		0x0008
 #define  SDHCI_CTRL_DRV_TYPE_MASK	0x0030
 #define   SDHCI_CTRL_DRV_TYPE_B		0x0000
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index dad7a46..c750f85 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -119,6 +119,7 @@ struct sdhci_host {
 #define SDHCI_AUTO_CMD23	(1<<7)	/* Auto CMD23 support */
 #define SDHCI_PV_ENABLED	(1<<8)	/* Preset value enabled */
 #define SDHCI_SDIO_IRQ_ENABLED	(1<<9)	/* SDIO irq enabled */
+#define SDHCI_HS200_NEEDS_TUNING (1<<10)	/* HS200 needs tuning */
 
 	unsigned int version;	/* SDHCI spec. version */
 
-- 
1.7.1

