From: Balaji T K <balajitk@ti.com>
Subject: [PATCHv4 1/3] MMC: OMAP: HSMMC: Remove lazy_disable
Date: Fri, 1 Jul 2011 22:09:34 +0530
Message-ID: <1309538376-23260-2-git-send-email-balajitk@ti.com>
References: <1309538376-23260-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1309538376-23260-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: tony@atomide.com, madhu.cr@ti.com, khilman@ti.com, b-cousson@ti.com, paul@pwsan.com, kishore.kadiyala@ti.com, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

lazy_disable framework in OMAP HSMMC manages multiple low power states
and Card is powered off after inactivity time of 8 seconds.
Based on previous discussion on the list, card power (regulator)
handling (when to power OFF/ON) should ideally be handled by core layer.
Remove usage of lazy disable to allow core layer _only_ to handle card power.
With the removal of lazy disable framework, MMC regulators
are left ON until MMC_POWER_OFF via set_ios.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |  246 +----------------------------------------
 1 files changed, 2 insertions(+), 244 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index cd317af..819ff08 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -120,11 +120,6 @@
 #define OMAP_MMC_MASTER_CLOCK	96000000
 #define DRIVER_NAME		"omap_hsmmc"
 
-/* Timeouts for entering power saving states on inactivity, msec */
-#define OMAP_MMC_DISABLED_TIMEOUT	100
-#define OMAP_MMC_SLEEP_TIMEOUT		1000
-#define OMAP_MMC_OFF_TIMEOUT		8000
-
 /*
  * One controller can have multiple slots, like on some omap boards using
  * omap.c controller driver. Luckily this is not currently done on any known
@@ -1628,8 +1623,6 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	if (host->power_mode == MMC_POWER_OFF)
 		mmc_host_disable(host->mmc);
-	else
-		mmc_host_lazy_disable(host->mmc);
 }
 
 static int omap_hsmmc_get_cd(struct mmc_host *mmc)
@@ -1685,220 +1678,6 @@ static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
 	set_sd_bus_power(host);
 }
 
-/*
- * Dynamic power saving handling, FSM:
- *   ENABLED -> DISABLED -> CARDSLEEP / REGSLEEP -> OFF
- *     ^___________|          |                      |
- *     |______________________|______________________|
- *
- * ENABLED:   mmc host is fully functional
- * DISABLED:  fclk is off
- * CARDSLEEP: fclk is off, card is asleep, voltage regulator is asleep
- * REGSLEEP:  fclk is off, voltage regulator is asleep
- * OFF:       fclk is off, voltage regulator is off
- *
- * Transition handlers return the timeout for the next state transition
- * or negative error.
- */
-
-enum {ENABLED = 0, DISABLED, CARDSLEEP, REGSLEEP, OFF};
-
-/* Handler for [ENABLED -> DISABLED] transition */
-static int omap_hsmmc_enabled_to_disabled(struct omap_hsmmc_host *host)
-{
-	omap_hsmmc_context_save(host);
-	clk_disable(host->fclk);
-	host->dpm_state = DISABLED;
-
-	dev_dbg(mmc_dev(host->mmc), "ENABLED -> DISABLED\n");
-
-	if (host->power_mode == MMC_POWER_OFF)
-		return 0;
-
-	return OMAP_MMC_SLEEP_TIMEOUT;
-}
-
-/* Handler for [DISABLED -> REGSLEEP / CARDSLEEP] transition */
-static int omap_hsmmc_disabled_to_sleep(struct omap_hsmmc_host *host)
-{
-	int err, new_state;
-
-	if (!mmc_try_claim_host(host->mmc))
-		return 0;
-
-	clk_enable(host->fclk);
-	omap_hsmmc_context_restore(host);
-	if (mmc_card_can_sleep(host->mmc)) {
-		err = mmc_card_sleep(host->mmc);
-		if (err < 0) {
-			clk_disable(host->fclk);
-			mmc_release_host(host->mmc);
-			return err;
-		}
-		new_state = CARDSLEEP;
-	} else {
-		new_state = REGSLEEP;
-	}
-	if (mmc_slot(host).set_sleep)
-		mmc_slot(host).set_sleep(host->dev, host->slot_id, 1, 0,
-					 new_state == CARDSLEEP);
-	/* FIXME: turn off bus power and perhaps interrupts too */
-	clk_disable(host->fclk);
-	host->dpm_state = new_state;
-
-	mmc_release_host(host->mmc);
-
-	dev_dbg(mmc_dev(host->mmc), "DISABLED -> %s\n",
-		host->dpm_state == CARDSLEEP ? "CARDSLEEP" : "REGSLEEP");
-
-	if (mmc_slot(host).no_off)
-		return 0;
-
-	if ((host->mmc->caps & MMC_CAP_NONREMOVABLE) ||
-	    mmc_slot(host).card_detect ||
-	    (mmc_slot(host).get_cover_state &&
-	     mmc_slot(host).get_cover_state(host->dev, host->slot_id)))
-		return OMAP_MMC_OFF_TIMEOUT;
-
-	return 0;
-}
-
-/* Handler for [REGSLEEP / CARDSLEEP -> OFF] transition */
-static int omap_hsmmc_sleep_to_off(struct omap_hsmmc_host *host)
-{
-	if (!mmc_try_claim_host(host->mmc))
-		return 0;
-
-	if (mmc_slot(host).no_off)
-		return 0;
-
-	if (!((host->mmc->caps & MMC_CAP_NONREMOVABLE) ||
-	      mmc_slot(host).card_detect ||
-	      (mmc_slot(host).get_cover_state &&
-	       mmc_slot(host).get_cover_state(host->dev, host->slot_id)))) {
-		mmc_release_host(host->mmc);
-		return 0;
-	}
-
-	mmc_slot(host).set_power(host->dev, host->slot_id, 0, 0);
-	host->vdd = 0;
-	host->power_mode = MMC_POWER_OFF;
-
-	dev_dbg(mmc_dev(host->mmc), "%s -> OFF\n",
-		host->dpm_state == CARDSLEEP ? "CARDSLEEP" : "REGSLEEP");
-
-	host->dpm_state = OFF;
-
-	mmc_release_host(host->mmc);
-
-	return 0;
-}
-
-/* Handler for [DISABLED -> ENABLED] transition */
-static int omap_hsmmc_disabled_to_enabled(struct omap_hsmmc_host *host)
-{
-	int err;
-
-	err = clk_enable(host->fclk);
-	if (err < 0)
-		return err;
-
-	omap_hsmmc_context_restore(host);
-	host->dpm_state = ENABLED;
-
-	dev_dbg(mmc_dev(host->mmc), "DISABLED -> ENABLED\n");
-
-	return 0;
-}
-
-/* Handler for [SLEEP -> ENABLED] transition */
-static int omap_hsmmc_sleep_to_enabled(struct omap_hsmmc_host *host)
-{
-	if (!mmc_try_claim_host(host->mmc))
-		return 0;
-
-	clk_enable(host->fclk);
-	omap_hsmmc_context_restore(host);
-	if (mmc_slot(host).set_sleep)
-		mmc_slot(host).set_sleep(host->dev, host->slot_id, 0,
-			 host->vdd, host->dpm_state == CARDSLEEP);
-	if (mmc_card_can_sleep(host->mmc))
-		mmc_card_awake(host->mmc);
-
-	dev_dbg(mmc_dev(host->mmc), "%s -> ENABLED\n",
-		host->dpm_state == CARDSLEEP ? "CARDSLEEP" : "REGSLEEP");
-
-	host->dpm_state = ENABLED;
-
-	mmc_release_host(host->mmc);
-
-	return 0;
-}
-
-/* Handler for [OFF -> ENABLED] transition */
-static int omap_hsmmc_off_to_enabled(struct omap_hsmmc_host *host)
-{
-	clk_enable(host->fclk);
-
-	omap_hsmmc_context_restore(host);
-	omap_hsmmc_conf_bus_power(host);
-	mmc_power_restore_host(host->mmc);
-
-	host->dpm_state = ENABLED;
-
-	dev_dbg(mmc_dev(host->mmc), "OFF -> ENABLED\n");
-
-	return 0;
-}
-
-/*
- * Bring MMC host to ENABLED from any other PM state.
- */
-static int omap_hsmmc_enable(struct mmc_host *mmc)
-{
-	struct omap_hsmmc_host *host = mmc_priv(mmc);
-
-	switch (host->dpm_state) {
-	case DISABLED:
-		return omap_hsmmc_disabled_to_enabled(host);
-	case CARDSLEEP:
-	case REGSLEEP:
-		return omap_hsmmc_sleep_to_enabled(host);
-	case OFF:
-		return omap_hsmmc_off_to_enabled(host);
-	default:
-		dev_dbg(mmc_dev(host->mmc), "UNKNOWN state\n");
-		return -EINVAL;
-	}
-}
-
-/*
- * Bring MMC host in PM state (one level deeper).
- */
-static int omap_hsmmc_disable(struct mmc_host *mmc, int lazy)
-{
-	struct omap_hsmmc_host *host = mmc_priv(mmc);
-
-	switch (host->dpm_state) {
-	case ENABLED: {
-		int delay;
-
-		delay = omap_hsmmc_enabled_to_disabled(host);
-		if (lazy || delay < 0)
-			return delay;
-		return 0;
-	}
-	case DISABLED:
-		return omap_hsmmc_disabled_to_sleep(host);
-	case CARDSLEEP:
-	case REGSLEEP:
-		return omap_hsmmc_sleep_to_off(host);
-	default:
-		dev_dbg(mmc_dev(host->mmc), "UNKNOWN state\n");
-		return -EINVAL;
-	}
-}
-
 static int omap_hsmmc_enable_fclk(struct mmc_host *mmc)
 {
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
@@ -1933,17 +1712,6 @@ static const struct mmc_host_ops omap_hsmmc_ops = {
 	/* NYET -- enable_sdio_irq */
 };
 
-static const struct mmc_host_ops omap_hsmmc_ps_ops = {
-	.enable = omap_hsmmc_enable,
-	.disable = omap_hsmmc_disable,
-	.request = omap_hsmmc_request,
-	.set_ios = omap_hsmmc_set_ios,
-	.get_cd = omap_hsmmc_get_cd,
-	.get_ro = omap_hsmmc_get_ro,
-	.init_card = omap_hsmmc_init_card,
-	/* NYET -- enable_sdio_irq */
-};
-
 #ifdef CONFIG_DEBUG_FS
 
 static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
@@ -1965,7 +1733,7 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
 			host->dpm_state, mmc->nesting_cnt,
 			host->context_loss, context_loss);
 
-	if (host->suspended || host->dpm_state == OFF) {
+	if (host->suspended) {
 		seq_printf(s, "host suspended, can't read registers\n");
 		return 0;
 	}
@@ -2078,10 +1846,7 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, host);
 	INIT_WORK(&host->mmc_carddetect_work, omap_hsmmc_detect);
 
-	if (mmc_slot(host).power_saving)
-		mmc->ops	= &omap_hsmmc_ps_ops;
-	else
-		mmc->ops	= &omap_hsmmc_ops;
+	mmc->ops	= &omap_hsmmc_ops;
 
 	/*
 	 * If regulator_disable can only put vcc_aux to sleep then there is
@@ -2112,9 +1877,6 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	omap_hsmmc_context_save(host);
 
 	mmc->caps |= MMC_CAP_DISABLE;
-	mmc_set_disable_delay(mmc, OMAP_MMC_DISABLED_TIMEOUT);
-	/* we start off in DISABLED state */
-	host->dpm_state = DISABLED;
 
 	if (clk_enable(host->iclk) != 0) {
 		clk_put(host->iclk);
@@ -2237,8 +1999,6 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 
 	omap_hsmmc_disable_irq(host);
 
-	mmc_host_lazy_disable(host->mmc);
-
 	omap_hsmmc_protect_card(host);
 
 	mmc_add_host(mmc);
@@ -2417,8 +2177,6 @@ static int omap_hsmmc_resume(struct device *dev)
 		ret = mmc_resume_host(host->mmc);
 		if (ret == 0)
 			host->suspended = 0;
-
-		mmc_host_lazy_disable(host->mmc);
 	}
 
 	return ret;
-- 
1.7.0.4

