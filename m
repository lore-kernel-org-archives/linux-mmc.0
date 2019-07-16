From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 1/2] mmc: core: Add sdio_trigger_replug() API
Date: Tue, 16 Jul 2019 09:42:08 -0700
Message-ID: <20190716164209.62320-2-dianders@chromium.org>
References: <20190716164209.62320-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190716164209.62320-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kalle Valo <kvalo@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Ganapathi Bhat <gbhat@marvell.com>, linux-wireless@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Amitkumar Karwar <amitkarwar@gmail.com>, linux-rockchip@lists.infradead.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Nishant Sarmukadam <nishants@marvell.com>, netdev@vger.kernel.org, Avri Altman <avri.altman@wdc.com>, linux-mmc@vger.kernel.org, davem@davemloft.net, Xinming Hu <huxinming820@gmail.com>, Douglas Anderson <dianders@chromium.org>, Jiong Wu <lohengrin1024@gmail.com>, Ritesh Harjani <riteshh@codeaurora.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
List-Id: linux-mmc@vger.kernel.org

When using Marvell WiFi SDIO cards, it is not uncommon for Linux WiFi
driver to fully lose the communication channel to the firmware running
on the card.  Presumably the firmware on the card has a bug or two in
it and occasionally crashes.

The Marvell WiFi driver attempts to recover from this problem.
Specifically the driver has the function mwifiex_sdio_card_reset()
which is called when communcation problems are found.  That function
attempts to reset the state of things by utilizing the mmc_hw_reset()
function.

The current solution is a bit complex because the Marvell WiFi driver
needs to manually deinit and reinit the WiFi driver around the reset
call.  This means it's going through a bunch of code paths that aren't
normally tested.  However, complexity isn't our only problem.  The
other (bigger) problem is that Marvell WiFi cards are often combo
WiFi/Bluetooth cards and Bluetooth runs on a second SDIO func.  While
the WiFi driver knows that it should re-init its own state around the
mmc_hw_reset() call there is no good way to inform the Bluetooth
driver.  That means that in Linux today when you reset the Marvell
WiFi driver you lose all Bluetooth communication.  Doh!

One way to fix the above problems is to leverage a more standard way
to reset the Marvell WiFi card where we go through the same code paths
as card unplug and the card plug.  In this patch we introduce a new
API call for doing just that: sdio_trigger_replug().  This API call
will trigger an unplug of the SDIO card followed by a plug of the
card.  As part of this the card will be nicely reset.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/mmc/core/core.c       | 28 ++++++++++++++++++++++++++--
 drivers/mmc/core/sdio_io.c    | 20 ++++++++++++++++++++
 include/linux/mmc/host.h      | 15 ++++++++++++++-
 include/linux/mmc/sdio_func.h |  2 ++
 4 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 9020cb2490f7..48a7d23aed26 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2164,6 +2164,12 @@ int mmc_sw_reset(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_sw_reset);
 
+void mmc_trigger_replug(struct mmc_host *host)
+{
+	host->trigger_replug_state = MMC_REPLUG_STATE_UNPLUG;
+	_mmc_detect_change(host, 0, false);
+}
+
 static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 {
 	host->f_init = freq;
@@ -2217,6 +2223,11 @@ int _mmc_detect_card_removed(struct mmc_host *host)
 	if (!host->card || mmc_card_removed(host->card))
 		return 1;
 
+	if (host->trigger_replug_state == MMC_REPLUG_STATE_UNPLUG) {
+		mmc_card_set_removed(host->card);
+		return 1;
+	}
+
 	ret = host->bus_ops->alive(host);
 
 	/*
@@ -2329,8 +2340,21 @@ void mmc_rescan(struct work_struct *work)
 	mmc_bus_put(host);
 
 	mmc_claim_host(host);
-	if (mmc_card_is_removable(host) && host->ops->get_cd &&
-			host->ops->get_cd(host) == 0) {
+
+	/*
+	 * Move through the state machine if we're triggering an unplug
+	 * followed by a re-plug.
+	 */
+	if (host->trigger_replug_state == MMC_REPLUG_STATE_UNPLUG) {
+		host->trigger_replug_state = MMC_REPLUG_STATE_PLUG;
+		_mmc_detect_change(host, 0, false);
+	} else if (host->trigger_replug_state == MMC_REPLUG_STATE_PLUG) {
+		host->trigger_replug_state = MMC_REPLUG_STATE_NONE;
+	}
+
+	if (host->trigger_replug_state == MMC_REPLUG_STATE_PLUG ||
+	    (mmc_card_is_removable(host) && host->ops->get_cd &&
+			host->ops->get_cd(host) == 0)) {
 		mmc_power_off(host);
 		mmc_release_host(host);
 		goto out;
diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index 2ba00acf64e6..1c5c2a3ebe5e 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -811,3 +811,23 @@ void sdio_retune_release(struct sdio_func *func)
 	mmc_retune_release(func->card->host);
 }
 EXPORT_SYMBOL_GPL(sdio_retune_release);
+
+/**
+ *	sdio_trigger_replug - trigger an "unplug" + "plug" of the card
+ *	@func: SDIO function attached to host
+ *
+ *	When you call this function we will schedule events that will
+ *	make it look like the card contining the given SDIO func was
+ *	unplugged and then re-plugged-in.  This is as close as possible
+ *	to a full reset of the card that can be achieved.
+ *
+ *	NOTE: routnine will temporarily make the card look as if it is
+ *	removable even if it is marked non-removable.
+ *
+ *	This function should be called while the host is claimed.
+ */
+void sdio_trigger_replug(struct sdio_func *func)
+{
+	mmc_trigger_replug(func->card->host);
+}
+EXPORT_SYMBOL(sdio_trigger_replug);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index a9b12322c775..e0d41a1bcf17 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -410,6 +410,12 @@ struct mmc_host {
 
 	bool			trigger_card_event; /* card_event necessary */
 
+	/* state machine for triggering unplug/replug */
+#define MMC_REPLUG_STATE_NONE	0		/* not doing unplug/replug */
+#define MMC_REPLUG_STATE_UNPLUG	1		/* do unplug next */
+#define MMC_REPLUG_STATE_PLUG	2		/* do plug next */
+	u8			trigger_replug_state;
+
 	struct mmc_card		*card;		/* device attached to this host */
 
 	wait_queue_head_t	wq;
@@ -530,7 +536,12 @@ int mmc_regulator_get_supply(struct mmc_host *mmc);
 
 static inline int mmc_card_is_removable(struct mmc_host *host)
 {
-	return !(host->caps & MMC_CAP_NONREMOVABLE);
+	/*
+	 * A non-removable card briefly looks removable if code has forced
+	 * a re-plug of the card.
+	 */
+	return host->trigger_replug_state != MMC_REPLUG_STATE_NONE ||
+		!(host->caps & MMC_CAP_NONREMOVABLE);
 }
 
 static inline int mmc_card_keep_power(struct mmc_host *host)
@@ -583,4 +594,6 @@ static inline enum dma_data_direction mmc_get_dma_dir(struct mmc_data *data)
 int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
 int mmc_abort_tuning(struct mmc_host *host, u32 opcode);
 
+void mmc_trigger_replug(struct mmc_host *host);
+
 #endif /* LINUX_MMC_HOST_H */
diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
index 5a177f7a83c3..0d6c73768ae3 100644
--- a/include/linux/mmc/sdio_func.h
+++ b/include/linux/mmc/sdio_func.h
@@ -173,4 +173,6 @@ extern void sdio_retune_crc_enable(struct sdio_func *func);
 extern void sdio_retune_hold_now(struct sdio_func *func);
 extern void sdio_retune_release(struct sdio_func *func);
 
+extern void sdio_trigger_replug(struct sdio_func *func);
+
 #endif /* LINUX_MMC_SDIO_FUNC_H */
-- 
2.22.0.510.g264f2c817a-goog
