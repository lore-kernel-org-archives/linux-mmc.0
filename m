From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 1/3] mwifiex: Re-work support for SDIO HW reset
Date: Sat,  9 Nov 2019 11:30:44 +0100
Message-ID: <20191109103046.26445-2-ulf.hansson@linaro.org>
References: <20191109103046.26445-1-ulf.hansson@linaro.org>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20191109103046.26445-1-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wen Gong <wgong-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Erik Stromdahl <erik.stromdahl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

The SDIO HW reset procedure in mwifiex_sdio_card_reset_work() is broken,
when the SDIO card is shared with another SDIO func driver. This is the
case when the Bluetooth btmrvl driver is being used in combination with
mwifiex. More precisely, when mwifiex_sdio_card_reset_work() runs to resets
the SDIO card, the btmrvl driver doesn't get notified about it. Beyond that
point, the btmrvl driver will fail to communicate with the SDIO card.

This is a generic problem for SDIO func drivers sharing an SDIO card, which
are about to be addressed in subsequent changes to the mmc core and the
mmc_hw_reset() interface. In principle, these changes means the
mmc_hw_reset() interface starts to return 1 if the are multiple drivers for
the SDIO card, as to indicate to the caller that the reset needed to be
scheduled asynchronously through a hotplug mechanism of the SDIO card.

Let's prepare the mwifiex driver to support the upcoming new behaviour of
mmc_hw_reset(), which means extending the mwifiex_sdio_card_reset_work() to
support the asynchronous SDIO HW reset path. This also means, we need to
allow the ->remove() callback to run, without waiting for the FW to be
loaded. Additionally, during system suspend, mwifiex_sdio_suspend() may be
called when a reset has been scheduled, but waiting to be executed. In this
scenario let's simply return -EBUSY to abort the suspend process, as to
allow the reset to be completed first.

Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/net/wireless/marvell/mwifiex/main.c |  6 +++-
 drivers/net/wireless/marvell/mwifiex/main.h |  1 +
 drivers/net/wireless/marvell/mwifiex/sdio.c | 33 ++++++++++++++-------
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index a9657ae6d782..dbdbdd6769a9 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -76,6 +76,7 @@ static int mwifiex_register(void *card, struct device *dev,
 	*padapter = adapter;
 	adapter->dev = dev;
 	adapter->card = card;
+	adapter->is_adapter_up = false;
 
 	/* Save interface specific operations in adapter */
 	memmove(&adapter->if_ops, if_ops, sizeof(struct mwifiex_if_ops));
@@ -631,6 +632,7 @@ static int _mwifiex_fw_dpc(const struct firmware *firmware, void *context)
 
 	mwifiex_drv_get_driver_version(adapter, fmt, sizeof(fmt) - 1);
 	mwifiex_dbg(adapter, MSG, "driver_version = %s\n", fmt);
+	adapter->is_adapter_up = true;
 	goto done;
 
 err_add_intf:
@@ -1469,6 +1471,7 @@ int mwifiex_shutdown_sw(struct mwifiex_adapter *adapter)
 	mwifiex_deauthenticate(priv, NULL);
 
 	mwifiex_uninit_sw(adapter);
+	adapter->is_adapter_up = false;
 
 	if (adapter->if_ops.down_dev)
 		adapter->if_ops.down_dev(adapter);
@@ -1730,7 +1733,8 @@ int mwifiex_remove_card(struct mwifiex_adapter *adapter)
 	if (!adapter)
 		return 0;
 
-	mwifiex_uninit_sw(adapter);
+	if (adapter->is_adapter_up)
+		mwifiex_uninit_sw(adapter);
 
 	if (adapter->irq_wakeup >= 0)
 		device_init_wakeup(adapter->dev, false);
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 095837fba300..7703d2e5d2e0 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1017,6 +1017,7 @@ struct mwifiex_adapter {
 
 	/* For synchronizing FW initialization with device lifecycle. */
 	struct completion *fw_done;
+	bool is_adapter_up;
 
 	bool ext_scan;
 	u8 fw_api_ver;
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index 24c041dad9f6..2417c94c29c0 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -444,6 +444,9 @@ static int mwifiex_sdio_suspend(struct device *dev)
 		return 0;
 	}
 
+	if (!adapter->is_adapter_up)
+		return -EBUSY;
+
 	mwifiex_enable_wake(adapter);
 
 	/* Enable the Host Sleep */
@@ -2220,22 +2223,30 @@ static void mwifiex_sdio_card_reset_work(struct mwifiex_adapter *adapter)
 	struct sdio_func *func = card->func;
 	int ret;
 
+	/* Prepare the adapter for the reset. */
 	mwifiex_shutdown_sw(adapter);
+	clear_bit(MWIFIEX_IFACE_WORK_DEVICE_DUMP, &card->work_flags);
+	clear_bit(MWIFIEX_IFACE_WORK_CARD_RESET, &card->work_flags);
 
-	/* power cycle the adapter */
+	/* Run a HW reset of the SDIO interface. */
 	sdio_claim_host(func);
-	mmc_hw_reset(func->card->host);
+	ret = mmc_hw_reset(func->card->host);
 	sdio_release_host(func);
 
-	/* Previous save_adapter won't be valid after this. We will cancel
-	 * pending work requests.
-	 */
-	clear_bit(MWIFIEX_IFACE_WORK_DEVICE_DUMP, &card->work_flags);
-	clear_bit(MWIFIEX_IFACE_WORK_CARD_RESET, &card->work_flags);
