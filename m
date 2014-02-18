From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 03/31] mmc: sdio_irq: rework sdio irq handling
Date: Tue, 18 Feb 2014 15:09:17 +0000
Message-ID: <E1WFmIP-0006li-SO@rmk-PC.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40444 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756592AbaBRPJU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2014 10:09:20 -0500
In-Reply-To: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>

Rather than the SDIO support spawning it's own thread for handling card
interrupts, use the generic IRQ infrastructure for this, triggering it
from the host interface's interrupt handling directly.

This avoids a race between the parent thread waiting to receive an
interrupt response from the card, and the slow startup from the sdio
irq thread, which can occur as a result of high system load (eg, while
udev is running.)

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
=-DO NOT APPLY-=
 drivers/mmc/core/sdio_irq.c | 41 +++++++++++++++++++++++++++++++----------
 include/linux/mmc/host.h    |  3 +++
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index aaa90460ed23..f23d73993dc6 100644
=-DO NOT APPLY-= a/drivers/mmc/core/sdio_irq.c
=+DO NOT APPLY+= b/drivers/mmc/core/sdio_irq.c
@@ -90,6 +90,15 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
 	return ret;
 }
 
=+DO NOT APPLY+=void sdio_run_irqs(struct mmc_host *host)
=+DO NOT APPLY+={
=+DO NOT APPLY+=	mmc_claim_host(host);
=+DO NOT APPLY+=	host->sdio_irq_pending = true;
=+DO NOT APPLY+=	process_sdio_pending_irqs(host);
=+DO NOT APPLY+=	mmc_release_host(host);
=+DO NOT APPLY+=}
=+DO NOT APPLY+=EXPORT_SYMBOL_GPL(sdio_run_irqs);
=+DO NOT APPLY+=
 static int sdio_irq_thread(void *_host)
 {
 	struct mmc_host *host = _host;
@@ -189,14 +198,20 @@ static int sdio_card_irq_get(struct mmc_card *card)
 	WARN_ON(!host->claimed);
 
 	if (!host->sdio_irqs++) {
-		atomic_set(&host->sdio_irq_thread_abort, 0);
-		host->sdio_irq_thread =
-			kthread_run(sdio_irq_thread, host, "ksdioirqd/%s",
-				mmc_hostname(host));
-		if (IS_ERR(host->sdio_irq_thread)) {
-			int err = PTR_ERR(host->sdio_irq_thread);
-			host->sdio_irqs--;
-			return err;
=+DO NOT APPLY+=		if (!(host->caps2 & MMC_CAP2_SDIO_NOTHREAD)) {
=+DO NOT APPLY+=			atomic_set(&host->sdio_irq_thread_abort, 0);
=+DO NOT APPLY+=			host->sdio_irq_thread =
=+DO NOT APPLY+=				kthread_run(sdio_irq_thread, host,
=+DO NOT APPLY+=					    "ksdioirqd/%s", mmc_hostname(host));
=+DO NOT APPLY+=			if (IS_ERR(host->sdio_irq_thread)) {
=+DO NOT APPLY+=				int err = PTR_ERR(host->sdio_irq_thread);
=+DO NOT APPLY+=				host->sdio_irqs--;
=+DO NOT APPLY+=				return err;
=+DO NOT APPLY+=			}
=+DO NOT APPLY+=		} else {
=+DO NOT APPLY+=			mmc_host_clk_hold(host);
=+DO NOT APPLY+=			host->ops->enable_sdio_irq(host, 1);
=+DO NOT APPLY+=			mmc_host_clk_release(host);
 		}
 	}
 
@@ -211,8 +226,14 @@ static int sdio_card_irq_put(struct mmc_card *card)
 	BUG_ON(host->sdio_irqs < 1);
 
 	if (!--host->sdio_irqs) {
-		atomic_set(&host->sdio_irq_thread_abort, 1);
-		kthread_stop(host->sdio_irq_thread);
=+DO NOT APPLY+=		if (!(host->caps2 & MMC_CAP2_SDIO_NOTHREAD)) {
=+DO NOT APPLY+=			atomic_set(&host->sdio_irq_thread_abort, 1);
=+DO NOT APPLY+=			kthread_stop(host->sdio_irq_thread);
=+DO NOT APPLY+=		} else {
=+DO NOT APPLY+=			mmc_host_clk_hold(host);
=+DO NOT APPLY+=			host->ops->enable_sdio_irq(host, 0);
=+DO NOT APPLY+=			mmc_host_clk_release(host);
=+DO NOT APPLY+=		}
 	}
 
 	return 0;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 99f5709ac343..52bcfd4233e7 100644
=-DO NOT APPLY-= a/include/linux/mmc/host.h
=+DO NOT APPLY+= b/include/linux/mmc/host.h
@@ -282,6 +282,7 @@ struct mmc_host {
 				 MMC_CAP2_PACKED_WR)
 #define MMC_CAP2_NO_PRESCAN_POWERUP (1 << 14)	/* Don't power up before scan */
 #define MMC_CAP2_SANITIZE	(1 << 15)		/* Support Sanitize */
=+DO NOT APPLY+=#define MMC_CAP2_SDIO_NOTHREAD	(1 << 16)	/* don't have separate thread */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
@@ -397,6 +398,8 @@ static inline void mmc_signal_sdio_irq(struct mmc_host *host)
 	wake_up_process(host->sdio_irq_thread);
 }
 
=+DO NOT APPLY+=void sdio_run_irqs(struct mmc_host *host);
=+DO NOT APPLY+=
 #ifdef CONFIG_REGULATOR
 int mmc_regulator_get_ocrmask(struct regulator *supply);
 int mmc_regulator_set_ocr(struct mmc_host *mmc,
-- 
1.8.3.1

