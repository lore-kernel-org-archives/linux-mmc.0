From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V3 01/15] mmc: host: Add facility to support re-tuning
Date: Tue, 10 Mar 2015 14:42:56 +0200
Message-ID: <1425991390-4983-2-git-send-email-adrian.hunter@intel.com>
References: <1425991390-4983-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3552 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752382AbbCJMpL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 Mar 2015 08:45:11 -0400
In-Reply-To: <1425991390-4983-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Currently, there is core support for tuning during
initialization. There can also be a need to re-tune
periodically (e.g. sdhci) or to re-tune after the
host controller is powered off (e.g. after PM
runtime suspend / resume) or to re-tune in response
to CRC errors.

The main requirements for re-tuning are:
  - ability to enable / disable re-tuning
  - ability to flag that re-tuning is needed
  - ability to re-tune before any request
  - ability to hold off re-tuning if the card is busy
  - ability to hold off re-tuning if re-tuning is in
  progress
  - ability to run a re-tuning timer

To support those requirements 6 members are added to struct
mmc_host:

  unsigned int		can_retune:1;	/* re-tuning can be used */
  unsigned int		doing_retune:1;	/* re-tuning in progress */
  unsigned int		retune_now:1;   /* do re-tuning at next req */
  int			need_retune;	/* re-tuning is needed */
  int			hold_retune;	/* hold off re-tuning */
  struct timer_list	retune_timer;	/* for periodic re-tuning */

need_retune is an integer so it can be set without needing
synchronization. hold_retune is a integer to allow nesting.

Various simple functions are provided to set / clear those
variables. Also host operations are added to let the host
know when re-tuning is held, for example, to enable
synchronization with runtime suspend / resume.

Subsequent patches take those functions into use.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/host.c  | 78 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h | 34 +++++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 8be0df7..fe6aa57 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -301,6 +301,83 @@ static inline void mmc_host_clk_sysfs_init(struct mmc_host *host)
 
 #endif
 
+void mmc_retune_enable(struct mmc_host *host, unsigned int period)
+{
+	host->can_retune = 1;
+	if (period)
+		mod_timer(&host->retune_timer, jiffies + period * HZ);
+}
+EXPORT_SYMBOL(mmc_retune_enable);
+
+void mmc_retune_disable(struct mmc_host *host)
+{
+	host->can_retune = 0;
+	del_timer_sync(&host->retune_timer);
+	host->retune_now = 0;
+	host->need_retune = 0;
+}
+EXPORT_SYMBOL(mmc_retune_disable);
+
+void mmc_retune_timer_stop(struct mmc_host *host)
+{
+	del_timer_sync(&host->retune_timer);
+}
+EXPORT_SYMBOL(mmc_retune_timer_stop);
+
+void mmc_retune_hold(struct mmc_host *host)
+{
+	if (!host->hold_retune) {
+		if (host->ops->hold_tuning)
+			host->ops->hold_tuning(host);
+		host->retune_now = 1;
+	}
+	host->hold_retune += 1;
+}
+EXPORT_SYMBOL(mmc_retune_hold);
+
+void mmc_retune_release(struct mmc_host *host)
+{
+	if (host->hold_retune) {
+		host->hold_retune -= 1;
+		if (!host->hold_retune && host->ops->release_tuning)
+			host->ops->release_tuning(host);
+	} else {
+		WARN_ON(1);
+	}
+}
+EXPORT_SYMBOL(mmc_retune_release);
+
+int mmc_retune(struct mmc_host *host)
+{
+	int err;
+
+	if (host->retune_now)
+		host->retune_now = 0;
+	else
+		return 0;
+
+	if (!host->need_retune || host->doing_retune || !host->card)
+		return 0;
+
+	host->need_retune = 0;
+
+	host->doing_retune = 1;
+
+	err = mmc_execute_tuning(host->card);
+
+	host->doing_retune = 0;
+
+	return err;
+}
+EXPORT_SYMBOL(mmc_retune);
+
+static void mmc_retune_timer(unsigned long data)
+{
+	struct mmc_host *host = (struct mmc_host *)data;
+
+	mmc_retune_needed(host);
+}
+
 /**
  *	mmc_of_parse() - parse host's device-tree node
  *	@host: host whose node should be parsed.
@@ -504,6 +581,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 #ifdef CONFIG_PM
 	host->pm_notify.notifier_call = mmc_pm_notify;
 #endif
+	setup_timer(&host->retune_timer, mmc_retune_timer, (unsigned long)host);
 
 	/*
 	 * By default, hosts do not support SGIO or large requests.
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 0c8cbe5..bf08e3e 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -12,6 +12,7 @@
 
 #include <linux/leds.h>
 #include <linux/mutex.h>
+#include <linux/timer.h>
 #include <linux/sched.h>
 #include <linux/device.h>
 #include <linux/fault-inject.h>
@@ -134,6 +135,8 @@ struct mmc_host_ops {
 
 	/* The tuning command opcode value is different for SD and eMMC cards */
 	int	(*execute_tuning)(struct mmc_host *host, u32 opcode);
+	void	(*hold_tuning)(struct mmc_host *host);
+	void	(*release_tuning)(struct mmc_host *host);
 
 	/* Prepare HS400 target operating frequency depending host driver */
 	int	(*prepare_hs400_tuning)(struct mmc_host *host, struct mmc_ios *ios);
@@ -327,10 +330,17 @@ struct mmc_host {
 #ifdef CONFIG_MMC_DEBUG
 	unsigned int		removed:1;	/* host is being removed */
 #endif
+	unsigned int		can_retune:1;	/* re-tuning can be used */
+	unsigned int		doing_retune:1;	/* re-tuning in progress */
+	unsigned int		retune_now:1;	/* do re-tuning at next req */
 
 	int			rescan_disable;	/* disable card detection */
 	int			rescan_entered;	/* used with nonremovable devices */
 
+	int			need_retune;	/* re-tuning is needed */
+	int			hold_retune;	/* hold off re-tuning */
+	struct timer_list	retune_timer;	/* for periodic re-tuning */
+
 	bool			trigger_card_event; /* card_event necessary */
 
 	struct mmc_card		*card;		/* device attached to this host */
@@ -519,4 +529,28 @@ static inline bool mmc_card_hs400(struct mmc_card *card)
 	return card->host->ios.timing == MMC_TIMING_MMC_HS400;
 }
 
+void mmc_retune_enable(struct mmc_host *host, unsigned int period);
+void mmc_retune_disable(struct mmc_host *host);
+void mmc_retune_timer_stop(struct mmc_host *host);
+void mmc_retune_hold(struct mmc_host *host);
+void mmc_retune_release(struct mmc_host *host);
+int mmc_retune(struct mmc_host *host);
+
+static inline void mmc_retune_needed(struct mmc_host *host)
+{
+	if (host->can_retune)
+		host->need_retune = 1;
+}
+
+static inline void mmc_retune_not_needed(struct mmc_host *host)
+{
+	host->need_retune = 0;
+}
+
+static inline void mmc_retune_recheck(struct mmc_host *host)
+{
+	if (host->hold_retune <= 1)
+		host->retune_now = 1;
+}
+
 #endif /* LINUX_MMC_HOST_H */
-- 
1.9.1

