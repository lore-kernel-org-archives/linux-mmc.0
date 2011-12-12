From: Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: [PATCH] mmc: core: Ensure clocks are always enabled before host interaction
Date: Mon, 12 Dec 2011 13:51:44 +0530
Message-ID: <1323678104-28854-1-git-send-email-sthumma@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:54335 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912Ab1LLIVy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Dec 2011 03:21:54 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Sujit Reddy Thumma <sthumma@codeaurora.org>, cjb@laptop.org

Ensure clocks are always enabled before any interaction with the
host controller driver. This makes sure that there is no race
between host execution and the core layer turning off clocks
in different context with clock gating framework.

Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
---
 drivers/mmc/core/core.c     |   19 ++++++++++++++++---
 drivers/mmc/core/host.h     |   21 ---------------------
 drivers/mmc/core/sd.c       |   22 ++++++++++++++++++----
 drivers/mmc/core/sdio.c     |   12 ++++++++++--
 drivers/mmc/core/sdio_irq.c |   10 ++++++++--
 include/linux/mmc/host.h    |   19 +++++++++++++++++++
 6 files changed, 71 insertions(+), 32 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index a2aa860..03ad9fa 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -290,8 +290,11 @@ static void mmc_wait_for_req_done(struct mmc_host *host,
 static void mmc_pre_req(struct mmc_host *host, struct mmc_request *mrq,
 		 bool is_first_req)
 {
-	if (host->ops->pre_req)
+	if (host->ops->pre_req) {
+		mmc_host_clk_hold(host);
 		host->ops->pre_req(host, mrq, is_first_req);
+		mmc_host_clk_release(host);
+	}
 }
 
 /**
@@ -306,8 +309,11 @@ static void mmc_pre_req(struct mmc_host *host, struct mmc_request *mrq,
 static void mmc_post_req(struct mmc_host *host, struct mmc_request *mrq,
 			 int err)
 {
-	if (host->ops->post_req)
+	if (host->ops->post_req) {
+		mmc_host_clk_hold(host);
 		host->ops->post_req(host, mrq, err);
+		mmc_host_clk_release(host);
+	}
 }
 
 /**
@@ -620,7 +626,9 @@ int mmc_host_enable(struct mmc_host *host)
 		int err;
 
 		host->en_dis_recurs = 1;
+		mmc_host_clk_hold(host);
 		err = host->ops->enable(host);
+		mmc_host_clk_release(host);
 		host->en_dis_recurs = 0;
 
 		if (err) {
@@ -640,7 +648,9 @@ static int mmc_host_do_disable(struct mmc_host *host, int lazy)
 		int err;
 
 		host->en_dis_recurs = 1;
+		mmc_host_clk_hold(host);
 		err = host->ops->disable(host, lazy);
+		mmc_host_clk_release(host);
 		host->en_dis_recurs = 0;
 
 		if (err < 0) {
@@ -1203,8 +1213,11 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, bool cmd11
 
 	host->ios.signal_voltage = signal_voltage;
 
-	if (host->ops->start_signal_voltage_switch)
+	if (host->ops->start_signal_voltage_switch) {
+		mmc_host_clk_hold(host);
 		err = host->ops->start_signal_voltage_switch(host, &host->ios);
+		mmc_host_clk_release(host);
+	}
 
 	return err;
 }
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index fb8a5cd..08a7852 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -14,27 +14,6 @@
 
 int mmc_register_host_class(void);
 void mmc_unregister_host_class(void);
-
-#ifdef CONFIG_MMC_CLKGATE
-void mmc_host_clk_hold(struct mmc_host *host);
-void mmc_host_clk_release(struct mmc_host *host);
-unsigned int mmc_host_clk_rate(struct mmc_host *host);
-
-#else
-static inline void mmc_host_clk_hold(struct mmc_host *host)
-{
-}
-
-static inline void mmc_host_clk_release(struct mmc_host *host)
-{
-}
-
-static inline unsigned int mmc_host_clk_rate(struct mmc_host *host)
-{
-	return host->ios.clock;
-}
-#endif
-
 void mmc_host_deeper_disable(struct work_struct *work);
 
 #endif
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 6f27d35..b5212b8 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -451,9 +451,11 @@ static int sd_select_driver_type(struct mmc_card *card, u8 *status)
 	 * information and let the hardware specific code
 	 * return what is possible given the options
 	 */
+	mmc_host_clk_hold(card->host);
 	drive_strength = card->host->ops->select_drive_strength(
 		card->sw_caps.uhs_max_dtr,
 		host_drv_type, card_drv_type);
+	mmc_host_clk_release(card->host);
 
 	err = mmc_sd_switch(card, 1, 2, drive_strength, status);
 	if (err)
@@ -660,8 +662,11 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
 		goto out;
 
 	/* SPI mode doesn't define CMD19 */
-	if (!mmc_host_is_spi(card->host) && card->host->ops->execute_tuning)
+	if (!mmc_host_is_spi(card->host) && card->host->ops->execute_tuning) {
+		mmc_host_clk_hold(card->host);
 		err = card->host->ops->execute_tuning(card->host);
+		mmc_host_clk_release(card->host);
+	}
 
 out:
 	kfree(status);
@@ -849,8 +854,11 @@ int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
 	if (!reinit) {
 		int ro = -1;
 
-		if (host->ops->get_ro)
+		if (host->ops->get_ro) {
+			mmc_host_clk_hold(host);
 			ro = host->ops->get_ro(host);
+			mmc_host_clk_release(host);
+		}
 
 		if (ro < 0) {
 			pr_warning("%s: host does not "
@@ -966,8 +974,11 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 		 * Since initialization is now complete, enable preset
 		 * value registers for UHS-I cards.
 		 */
-		if (host->ops->enable_preset_value)
+		if (host->ops->enable_preset_value) {
+			mmc_host_clk_hold(host);
 			host->ops->enable_preset_value(host, true);
+			mmc_host_clk_release(host);
+		}
 	} else {
 		/*
 		 * Attempt to change to high-speed (if supported)
@@ -1150,8 +1161,11 @@ int mmc_attach_sd(struct mmc_host *host)
 		return err;
 
 	/* Disable preset value enable if already set since last time */
-	if (host->ops->enable_preset_value)
+	if (host->ops->enable_preset_value) {
+		mmc_host_clk_hold(host);
 		host->ops->enable_preset_value(host, false);
+		mmc_host_clk_release(host);
+	}
 
 	err = mmc_send_app_op_cond(host, 0, &ocr);
 	if (err)
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index b77f770..c9c2424 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -438,9 +438,11 @@ static void sdio_select_driver_type(struct mmc_card *card)
 	 * information and let the hardware specific code
 	 * return what is possible given the options
 	 */
+	mmc_host_clk_hold(card->host);
 	drive_strength = card->host->ops->select_drive_strength(
 		card->sw_caps.uhs_max_dtr,
 		host_drv_type, card_drv_type);
+	mmc_host_clk_release(card->host);
 
 	/* if error just use default for drive strength B */
 	err = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_DRIVE_STRENGTH, 0,
@@ -555,8 +557,11 @@ static int mmc_sdio_init_uhs_card(struct mmc_card *card)
 		goto out;
 
 	/* Initialize and start re-tuning timer */
-	if (!mmc_host_is_spi(card->host) && card->host->ops->execute_tuning)
+	if (!mmc_host_is_spi(card->host) && card->host->ops->execute_tuning) {
+		mmc_host_clk_hold(card->host);
 		err = card->host->ops->execute_tuning(card->host);
+		mmc_host_clk_release(card->host);
+	}
 
 out:
 
@@ -626,8 +631,11 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	/*
 	 * Call the optional HC's init_card function to handle quirks.
 	 */
-	if (host->ops->init_card)
+	if (host->ops->init_card) {
+		mmc_host_clk_hold(host);
 		host->ops->init_card(host, card);
+		mmc_host_clk_release(host);
+	}
 
 	/*
 	 * If the host and card support UHS-I mode request the card
diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 68f81b9..f573e7f 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -146,15 +146,21 @@ static int sdio_irq_thread(void *_host)
 		}
 
 		set_current_state(TASK_INTERRUPTIBLE);
-		if (host->caps & MMC_CAP_SDIO_IRQ)
+		if (host->caps & MMC_CAP_SDIO_IRQ) {
+			mmc_host_clk_hold(host);
 			host->ops->enable_sdio_irq(host, 1);
+			mmc_host_clk_release(host);
+		}
 		if (!kthread_should_stop())
 			schedule_timeout(period);
 		set_current_state(TASK_RUNNING);
 	} while (!kthread_should_stop());
 
-	if (host->caps & MMC_CAP_SDIO_IRQ)
+	if (host->caps & MMC_CAP_SDIO_IRQ) {
+		mmc_host_clk_hold(host);
 		host->ops->enable_sdio_irq(host, 0);
+		mmc_host_clk_release(host);
+	}
 
 	pr_debug("%s: IRQ thread exiting with code %d\n",
 		 mmc_hostname(host), ret);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 9a03d03..aa2d7ee 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -428,4 +428,23 @@ static inline int mmc_boot_partition_access(struct mmc_host *host)
 	return !(host->caps2 & MMC_CAP2_BOOTPART_NOACC);
 }
 
+#ifdef CONFIG_MMC_CLKGATE
+void mmc_host_clk_hold(struct mmc_host *host);
+void mmc_host_clk_release(struct mmc_host *host);
+unsigned int mmc_host_clk_rate(struct mmc_host *host);
+
+#else
+static inline void mmc_host_clk_hold(struct mmc_host *host)
+{
+}
+
+static inline void mmc_host_clk_release(struct mmc_host *host)
+{
+}
+
+static inline unsigned int mmc_host_clk_rate(struct mmc_host *host)
+{
+	return host->ios.clock;
+}
+#endif
 #endif /* LINUX_MMC_HOST_H */
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

