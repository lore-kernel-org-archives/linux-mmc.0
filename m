From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v3 3/3] mmc: core: Re-work HW reset for SDIO cards
Date: Tue, 12 Nov 2019 13:40:21 +0100
Message-ID: <20191112124021.8718-4-ulf.hansson@linaro.org>
References: <20191112124021.8718-1-ulf.hansson@linaro.org>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20191112124021.8718-1-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wen Gong <wgong-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Erik Stromdahl <erik.stromdahl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

It have turned out that it's not a good idea to unconditionally do a power
cycle and then to re-initialize the SDIO card, as currently done through
mmc_hw_reset() -> mmc_sdio_hw_reset(). This because there may be multiple
SDIO func drivers probed, who also shares the same SDIO card.

To address these scenarios, one may be tempted to use a notification
mechanism, as to allow the core to inform each of the probed func drivers,
about an ongoing HW reset. However, supporting such an operation from the
func driver point of view, may not be entirely trivial.

Therefore, let's use a more simplistic approach to solve the problem, by
instead forcing the card to be removed and re-detected, via scheduling a
rescan-work. In this way, we can rely on existing infrastructure, as the
func driver's ->remove() and ->probe() callbacks, becomes invoked to deal
with the cleanup and the re-initialization.

This solution may be considered as rather heavy, especially if a func
driver doesn't share its card with other func drivers. To address this,
let's keep the current immediate HW reset option as well, but run it only
when there is one func driver probed for the card.

Finally, to allow the caller of mmc_hw_reset(), to understand if the reset
is being asynchronously managed from a scheduled work, it returns 1
(propagated from mmc_sdio_hw_reset()). If the HW reset is executed
successfully and synchronously it returns 0, which maintains the existing
behaviour.

Reviewed-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Tested-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/mmc/core/core.c     |  5 ++---
 drivers/mmc/core/core.h     |  2 ++
 drivers/mmc/core/sdio.c     | 28 +++++++++++++++++++++++++++-
 drivers/mmc/core/sdio_bus.c |  9 ++++++++-
 include/linux/mmc/card.h    |  1 +
 5 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 6f8342702c73..abf8f5eb0a1c 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1469,8 +1469,7 @@ void mmc_detach_bus(struct mmc_host *host)
 	mmc_bus_put(host);
 }
 
-static void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
-				bool cd_irq)
+void _mmc_detect_change(struct mmc_host *host, unsigned long delay, bool cd_irq)
 {
 	/*
 	 * If the device is configured as wakeup, we prevent a new sleep for
@@ -2129,7 +2128,7 @@ int mmc_hw_reset(struct mmc_host *host)
 	ret = host->bus_ops->hw_reset(host);
 	mmc_bus_put(host);
 
-	if (ret)
+	if (ret < 0)
 		pr_warn("%s: tried to HW reset card, got error %d\n",
 			mmc_hostname(host), ret);
 
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 328c78dbee66..575ac0257af2 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -70,6 +70,8 @@ void mmc_rescan(struct work_struct *work);
 void mmc_start_host(struct mmc_host *host);
 void mmc_stop_host(struct mmc_host *host);
 
+void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
+			bool cd_irq);
 int _mmc_detect_card_removed(struct mmc_host *host);
 int mmc_detect_card_removed(struct mmc_host *host);
 
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 26cabd53ddc5..ebb387aa5158 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1048,9 +1048,35 @@ static int mmc_sdio_runtime_resume(struct mmc_host *host)
 	return ret;
 }
 
+/*
+ * SDIO HW reset
+ *
+ * Returns 0 if the HW reset was executed synchronously, returns 1 if the HW
+ * reset was asynchronously scheduled, else a negative error code.
+ */
 static int mmc_sdio_hw_reset(struct mmc_host *host)
 {
-	mmc_power_cycle(host, host->card->ocr);
+	struct mmc_card *card = host->card;
+
+	/*
+	 * In case the card is shared among multiple func drivers, reset the
+	 * card through a rescan work. In this way it will be removed and
+	 * re-detected, thus all func drivers becomes informed about it.
+	 */
+	if (atomic_read(&card->sdio_funcs_probed) > 1) {
+		if (mmc_card_removed(card))
+			return 1;
+		host->rescan_entered = 0;
+		mmc_card_set_removed(card);
+		_mmc_detect_change(host, 0, false);
+		return 1;
+	}
+
+	/*
+	 * A single func driver has been probed, then let's skip the heavy
+	 * hotplug dance above and execute the reset immediately.
+	 */
+	mmc_power_cycle(host, card->ocr);
 	return mmc_sdio_reinit_card(host);
 }
 
diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 2963e6542958..3cc928282af7 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -138,6 +138,8 @@ static int sdio_bus_probe(struct device *dev)
 	if (ret)
 		return ret;
 
+	atomic_inc(&func->card->sdio_funcs_probed);
+
 	/* Unbound SDIO functions are always suspended.
 	 * During probe, the function is set active and the usage count
 	 * is incremented.  If the driver supports runtime PM,
@@ -153,7 +155,10 @@ static int sdio_bus_probe(struct device *dev)
 	/* Set the default block size so the driver is sure it's something
 	 * sensible. */
 	sdio_claim_host(func);
-	ret = sdio_set_block_size(func, 0);
+	if (mmc_card_removed(func->card))
+		ret = -ENOMEDIUM;
+	else
+		ret = sdio_set_block_size(func, 0);
 	sdio_release_host(func);
 	if (ret)
 		goto disable_runtimepm;
@@ -165,6 +170,7 @@ static int sdio_bus_probe(struct device *dev)
 	return 0;
 
 disable_runtimepm:
+	atomic_dec(&func->card->sdio_funcs_probed);
 	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
 		pm_runtime_put_noidle(dev);
 	dev_pm_domain_detach(dev, false);
@@ -181,6 +187,7 @@ static int sdio_bus_remove(struct device *dev)
 		pm_runtime_get_sync(dev);
 
 	drv->remove(func);
+	atomic_dec(&func->card->sdio_funcs_probed);
 
 	if (func->irq_handler) {
 		pr_warn("WARNING: driver %s did not remove its interrupt handler!\n",
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 9b6336ad3266..e459b38ef33c 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -291,6 +291,7 @@ struct mmc_card {
 	struct sd_switch_caps	sw_caps;	/* switch (CMD6) caps */
 
 	unsigned int		sdio_funcs;	/* number of SDIO functions */
+	atomic_t		sdio_funcs_probed; /* number of probed SDIO funcs */
 	struct sdio_cccr	cccr;		/* common card info */
 	struct sdio_cis		cis;		/* common tuple info */
 	struct sdio_func	*sdio_func[SDIO_MAX_FUNCS]; /* SDIO functions (devices) */
-- 
2.17.1
