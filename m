From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 12/12] mmc: sdhci: add support for retuning mode 1
Date: Tue, 15 Feb 2011 15:05:10 +0530
Message-ID: <1297762510-2696-13-git-send-email-arindam.nath@amd.com>
References: <1297762510-2696-1-git-send-email-arindam.nath@amd.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59070 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754297Ab1BOJik (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Feb 2011 04:38:40 -0500
Received: by iyj8 with SMTP id 8so5731090iyj.19
        for <linux-mmc@vger.kernel.org>; Tue, 15 Feb 2011 01:38:39 -0800 (PST)
In-Reply-To: <1297762510-2696-1-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com, Arindam Nath <arindam.nath@amd.com>

Host Controller v3.00 can support retuning modes 1,2 or 3 depending on
the bits 46-47 of the Capabilities register. Also, the timer count for
retuning is indicated by bits 40-43 of the same register. We initialize
timer_list for retuning after successfull UHS-I initialization. Since
retuning mode 1 sets a limit of 4MB on the maximum data length, we set
max_blk_count appropriately. Once the tuning timer expires, we set
SDHCI_NEEDS_RETUNING flag, and if the flag is set, we execute tuning
procedure before sending the next command. We need to restore mmc_request
structure after executing retuning procedure since host->mrq is used
inside the procedure to send CMD19. We also disable and re-enable this
flag during suspend and resume respectively, as per the spec v3.00.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/mmc/core/sd.c     |    3 +
 drivers/mmc/host/sdhci.c  |  109 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.h  |    6 ++-
 include/linux/mmc/host.h  |    1 +
 include/linux/mmc/sdhci.h |    6 +++
 5 files changed, 122 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 1a625cc..e3daafb 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -628,6 +628,9 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
 	if (!mmc_host_is_spi(card->host))
 		card->host->ops->execute_tuning(card->host);
 
+	/* Initialize and start re-tuning timer */
+	card->host->ops->start_retuning_timer(card->host);
+
 out:
 	kfree(status);
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9f8fb84..8c1ec6c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -48,6 +48,8 @@ static void sdhci_finish_data(struct sdhci_host *);
 
 static void sdhci_send_command(struct sdhci_host *, struct mmc_command *);
 static void sdhci_finish_command(struct sdhci_host *);
+static void sdhci_execute_tuning(struct mmc_host *mmc);
+static void sdhci_tuning_timer(unsigned long data);
 
 static struct mmc_command *abort_cmd;
 
@@ -1246,8 +1248,34 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
 		host->mrq->cmd->error = -ENOMEDIUM;
 		tasklet_schedule(&host->finish_tasklet);
-	} else
+	} else {
+		u32 present_state;
+
+		present_state = sdhci_readl(host, SDHCI_PRESENT_STATE);
+		/*
+		 * Check if the re-tuning timer has already expired and there
+		 * is no on-going data transfer. If so, we need to execute
+		 * tuning procedure before sending command.
+		 */
+		if ((host->flags & SDHCI_NEEDS_RETUNING) &&
+		    !(present_state & (SDHCI_DOING_WRITE |
+		     SDHCI_DOING_READ))) {
+			host->flags &= ~SDHCI_NEEDS_RETUNING;
+			/* Reload the new initial value for timer */
+			if (host->tuning_mode == SDHCI_TUNING_MODE_1)
+				mod_timer(&host->tuning_timer, jiffies +
+					host->tuning_count * HZ);
+
+			spin_unlock_irqrestore(&host->lock, flags);
+			sdhci_execute_tuning(mmc);
+			spin_lock_irqsave(&host->lock, flags);
+
+			/* Restore original mmc_request structure */
+			host->mrq = mrq;
+		}
+
 		sdhci_send_command(host, mrq->cmd);
+	}
 
 	mmiowb();
 	spin_unlock_irqrestore(&host->lock, flags);
@@ -1679,6 +1707,26 @@ static void sdhci_disable_preset_value(struct sdhci_host *host)
 	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 }
 
+static void sdhci_start_retuning_timer(struct mmc_host *mmc)
+{
+	struct sdhci_host *host;
+	unsigned long flags;
+
+	host = mmc_priv(mmc);
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (host->tuning_count &&
+	    (host->tuning_mode == SDHCI_TUNING_MODE_1)) {
+		mod_timer(&host->tuning_timer, jiffies + host->tuning_count *
+			HZ);
+		/* Tuning mode 1 limits the maximum data length to 4MB */
+		mmc->max_blk_count = (4 * 1024 * 1024) / mmc->max_blk_size;
+	}
+
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
 static const struct mmc_host_ops sdhci_ops = {
 	.request	= sdhci_request,
 	.set_ios	= sdhci_set_ios,
@@ -1688,6 +1736,7 @@ static const struct mmc_host_ops sdhci_ops = {
 	.get_max_current_180		= sdhci_get_max_current_180,
 	.execute_tuning			= sdhci_execute_tuning,
 	.enable_preset_value		= sdhci_enable_preset_value,
+	.start_retuning_timer		= sdhci_start_retuning_timer,
 };
 
 /*****************************************************************************\
@@ -1737,6 +1786,10 @@ static void sdhci_tasklet_finish(unsigned long param)
 
 	del_timer(&host->timer);
 
+	if (host->version >= SDHCI_SPEC_300)
+		del_timer(&host->tuning_timer);
+
+
 	mrq = host->mrq;
 
 	/*
@@ -1811,6 +1864,20 @@ static void sdhci_timeout_timer(unsigned long data)
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
+static void sdhci_tuning_timer(unsigned long data)
+{
+	struct sdhci_host *host;
+	unsigned long flags;
+
+	host = (struct sdhci_host *)data;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	host->flags |= SDHCI_NEEDS_RETUNING;
+
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Interrupt handling                                                        *
@@ -2069,6 +2136,15 @@ int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state)
 
 	sdhci_disable_card_detection(host);
 
+	/* Disable tuning since we are suspending */
+	if ((host->version >= SDHCI_SPEC_300) &&
+	    host->tuning_count &&
+	    (host->tuning_mode == SDHCI_TUNING_MODE_1)) {
+		host->flags &= ~SDHCI_NEEDS_RETUNING;
+		mod_timer(&host->tuning_timer, jiffies +
+			host->tuning_count * HZ);
+	}
+
 	ret = mmc_suspend_host(host->mmc);
 	if (ret)
 		return ret;
@@ -2110,6 +2186,12 @@ int sdhci_resume_host(struct sdhci_host *host)
 	ret = mmc_resume_host(host->mmc);
 	sdhci_enable_card_detection(host);
 
+	/* Set the re-tuning expiration flag */
+	if ((host->version >= SDHCI_SPEC_300) &&
+	    host->tuning_count &&
+	    (host->tuning_mode == SDHCI_TUNING_MODE_1))
+		host->flags |= SDHCI_NEEDS_RETUNING;
+
 	return ret;
 }
 
@@ -2356,6 +2438,21 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (caps[1] & SDHCI_DRIVER_TYPE_D)
 		mmc->caps |= MMC_CAP_DRIVER_TYPE_D;
 
+	/* Initial value for re-tuning timer count */
+	host->tuning_count = (caps[1] & SDHCI_RETUNING_TIMER_COUNT_MASK) >>
+			      SDHCI_RETUNING_TIMER_COUNT_SHIFT;
+
+	/*
+	 * In case Re-tuning Timer is not disabled, the actual value of
+	 * re-tuning timer will be 2 ^ (n - 1).
+	 */
+	if (host->tuning_count)
+		host->tuning_count = 1 << (host->tuning_count - 1);
+
+	/* Re-tuning mode supported by the Host Controller */
+	host->tuning_mode = (caps[1] & SDHCI_RETUNING_MODE_MASK) >>
+			     SDHCI_RETUNING_MODE_SHIFT;
+
 	ocr_avail = 0;
 	/*
 	 * According to SD Host Controller spec v3.00, if the Host System
@@ -2491,9 +2588,15 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	setup_timer(&host->timer, sdhci_timeout_timer, (unsigned long)host);
 
-	if (host->version >= SDHCI_SPEC_300)
+	if (host->version >= SDHCI_SPEC_300) {
 		init_waitqueue_head(&host->buf_ready_int);
 
+		/* Initialize re-tuning timer */
+		init_timer(&host->tuning_timer);
+		host->tuning_timer.data = (unsigned long)host;
+		host->tuning_timer.function = sdhci_tuning_timer;
+	}
+
 	ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
 		mmc_hostname(mmc), host);
 	if (ret)
@@ -2587,6 +2690,8 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 	free_irq(host->irq, host);
 
 	del_timer_sync(&host->timer);
+	if (host->version >= SDHCI_SPEC_300)
+		del_timer_sync(&host->tuning_timer);
 
 	tasklet_kill(&host->card_tasklet);
 	tasklet_kill(&host->finish_tasklet);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 37a8c32..53d5909 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -190,7 +190,11 @@
 #define  SDHCI_DRIVER_TYPE_A	0x00000010
 #define  SDHCI_DRIVER_TYPE_C	0x00000020
 #define  SDHCI_DRIVER_TYPE_D	0x00000040
-#define  SDHCI_USE_SDR50_TUNING	0x00002000
+#define  SDHCI_RETUNING_TIMER_COUNT_MASK	0x00000F00
+#define  SDHCI_RETUNING_TIMER_COUNT_SHIFT	8
+#define  SDHCI_USE_SDR50_TUNING			0x00002000
+#define  SDHCI_RETUNING_MODE_MASK		0x0000C000
+#define  SDHCI_RETUNING_MODE_SHIFT		14
 #define  SDHCI_CLOCK_MUL_MASK	0x00FF0000
 #define  SDHCI_CLOCK_MUL_SHIFT	16
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index a47accd..a8b8fdb 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -131,6 +131,7 @@ struct mmc_host_ops {
 	int	(*get_max_current_180)(struct mmc_host *mmc);
 	void	(*execute_tuning)(struct mmc_host *host);
 	void	(*enable_preset_value)(struct mmc_host *host);
+	void	(*start_retuning_timer)(struct mmc_host *host);
 };
 
 struct mmc_card;
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 1e7a654..8bd9244 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -110,6 +110,7 @@ struct sdhci_host {
 #define SDHCI_REQ_USE_DMA	(1<<2)	/* Use DMA for this req. */
 #define SDHCI_DEVICE_DEAD	(1<<3)	/* Device unresponsive */
 #define SDHCI_SDR50_NEEDS_TUNING (1<<4)	/* SDR50 needs tuning */
+#define SDHCI_NEEDS_RETUNING	(1<<5)	/* Host needs retuning */
 
 	unsigned int version;	/* SDHCI spec. version */
 
@@ -150,6 +151,11 @@ struct sdhci_host {
 	wait_queue_head_t	buf_ready_int;	/* Waitqueue for Buffer Read Ready interrupt */
 	unsigned int		tuning_done;	/* Condition flag set when CMD19 succeeds */
 
+	unsigned int		tuning_count;	/* Timer count for re-tuning */
+	unsigned int		tuning_mode;	/* Re-tuning mode supported by host */
+#define SDHCI_TUNING_MODE_1	0
+	struct timer_list	tuning_timer;	/* Timer for tuning */
+
 	unsigned long private[0] ____cacheline_aligned;
 };
 #endif /* __SDHCI_H */
-- 
1.7.1

