From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH V6 2/2] mmc: host: Adds support for eMMC 4.5 HS200 mode
Date: Mon, 19 Dec 2011 12:06:34 +0530
Message-ID: <1324276594-16412-3-git-send-email-girish.shivananjappa@linaro.org>
References: <1324276594-16412-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53715 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283Ab1LSGcF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Dec 2011 01:32:05 -0500
In-Reply-To: <1324276594-16412-1-git-send-email-girish.shivananjappa@linaro.org>
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
 drivers/mmc/host/sdhci.c  |   43 +++++++++++++++++++++++++++++++++----------
 drivers/mmc/host/sdhci.h  |    1 +
 include/linux/mmc/host.h  |   11 ++++++++++-
 include/linux/mmc/sdhci.h |    1 +
 4 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ab6018f..049d51d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -49,7 +49,7 @@ static void sdhci_finish_data(struct sdhci_host *);
 
 static void sdhci_send_command(struct sdhci_host *, struct mmc_command *);
 static void sdhci_finish_command(struct sdhci_host *);
-static int sdhci_execute_tuning(struct mmc_host *mmc);
+static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
 static void sdhci_tuning_timer(unsigned long data);
 
 #ifdef CONFIG_PM_RUNTIME
@@ -1016,7 +1016,8 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
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
@@ -1375,7 +1376,8 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		    (ios->timing == MMC_TIMING_UHS_SDR104) ||
 		    (ios->timing == MMC_TIMING_UHS_DDR50) ||
 		    (ios->timing == MMC_TIMING_UHS_SDR25) ||
-		    (ios->timing == MMC_TIMING_UHS_SDR12))
+		    (ios->timing == MMC_TIMING_UHS_SDR12) ||
+		    (ios->timing == MMC_TIMING_MMC_HS200))
 			ctrl |= SDHCI_CTRL_HISPD;
 
 		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
@@ -1435,6 +1437,8 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 				ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
 			else if (ios->timing == MMC_TIMING_UHS_DDR50)
 				ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
+			else if (ios->timing == MMC_TIMING_MMC_HS200)
+				ctrl_2 |= SDHCI_CTRL_HS_SDR200;
 			sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
 		}
 
@@ -1673,7 +1677,7 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 	return err;
 }
 
-static int sdhci_execute_tuning(struct mmc_host *mmc)
+static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct sdhci_host *host;
 	u16 ctrl;
@@ -1694,10 +1698,13 @@ static int sdhci_execute_tuning(struct mmc_host *mmc)
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
@@ -1733,7 +1740,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc)
 		if (!tuning_loop_counter && !timeout)
 			break;
 
-		cmd.opcode = MMC_SEND_TUNING_BLOCK;
+		cmd.opcode = opcode;
 		cmd.arg = 0;
 		cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
 		cmd.retries = 0;
@@ -1748,7 +1755,17 @@ static int sdhci_execute_tuning(struct mmc_host *mmc)
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
@@ -2131,12 +2148,14 @@ static void sdhci_show_adma_error(struct sdhci_host *host) { }
 
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
@@ -2741,6 +2760,10 @@ int sdhci_add_host(struct sdhci_host *host)
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
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 9a03d03..606c8c3 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -56,10 +56,13 @@ struct mmc_ios {
 #define MMC_TIMING_UHS_SDR50	3
 #define MMC_TIMING_UHS_SDR104	4
 #define MMC_TIMING_UHS_DDR50	5
+#define MMC_TIMING_MMC_HS200	6
 
 #define MMC_SDR_MODE		0
 #define MMC_1_2V_DDR_MODE	1
 #define MMC_1_8V_DDR_MODE	2
+#define MMC_1_2V_SDR_MODE	3
+#define MMC_1_8V_SDR_MODE	4
 
 	unsigned char	signal_voltage;		/* signalling voltage (1.8V or 3.3V) */
 
@@ -148,7 +151,9 @@ struct mmc_host_ops {
 	void	(*init_card)(struct mmc_host *host, struct mmc_card *card);
 
 	int	(*start_signal_voltage_switch)(struct mmc_host *host, struct mmc_ios *ios);
-	int	(*execute_tuning)(struct mmc_host *host);
+
+	/* The tuning command opcode value is different for SD and eMMC cards */
+	int	(*execute_tuning)(struct mmc_host *host, u32 opcode);
 	void	(*enable_preset_value)(struct mmc_host *host, bool enable);
 	int	(*select_drive_strength)(unsigned int max_dtr, int host_drv, int card_drv);
 	void	(*hw_reset)(struct mmc_host *host);
@@ -242,6 +247,10 @@ struct mmc_host {
 #define MMC_CAP2_CACHE_CTRL	(1 << 1)	/* Allow cache control */
 #define MMC_CAP2_POWEROFF_NOTIFY (1 << 2)	/* Notify poweroff supported */
 #define MMC_CAP2_NO_MULTI_READ	(1 << 3)	/* Multiblock reads don't work */
+#define MMC_CAP2_HS200_1_8V_SDR	(1 << 4)	/* can support */
+#define MMC_CAP2_HS200_1_2V_SDR	(1 << 5)	/* can support */
+#define MMC_CAP2_HS200		(MMC_CAP2_HS200_1_8V_SDR | \
+				 MMC_CAP2_HS200_1_2V_SDR)
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 	unsigned int        power_notify_type;
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index e4b6935..d9a2222 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -121,6 +121,7 @@ struct sdhci_host {
 #define SDHCI_AUTO_CMD23	(1<<7)	/* Auto CMD23 support */
 #define SDHCI_PV_ENABLED	(1<<8)	/* Preset value enabled */
 #define SDHCI_SDIO_IRQ_ENABLED	(1<<9)	/* SDIO irq enabled */
+#define SDHCI_HS200_NEEDS_TUNING (1<<10)	/* HS200 needs tuning */
 
 	unsigned int version;	/* SDHCI spec. version */
 
-- 
1.7.1

