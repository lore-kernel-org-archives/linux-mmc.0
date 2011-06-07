From: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] libertas: add sd8686 reset_card support
Date: Tue,  7 Jun 2011 18:15:57 +0100 (BST)
Message-ID: <20110607171557.7F65D9D401C@zog.reactivated.net>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org, dcbw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, libertas-dev-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

At http://dev.laptop.org/ticket/10748 we are seeing a case of the
libertas firmware randomly stopping responding to commands after
resume. Careful monitoring of communications indicates a firmware or
hardware bug, which has been reported to Marvell.

Work around this issue by adding a reset_card method; this is
automatically called when command timeouts are detected and provides an
instant recovery to this situation.

Signed-off-by: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
---
 drivers/net/wireless/libertas/if_sdio.c |   34 +++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

linux-mmc: any comments on this? is there a better way to do it?
We do want a full card reset where everything is properly removed and
re-probed, so that userspace knows to reprogram wifi security keys,
re-establish connections, etc.

diff --git a/drivers/net/wireless/libertas/if_sdio.c b/drivers/net/wireless/libertas/if_sdio.c
index a7b5cb0..13c9dbe 100644
--- a/drivers/net/wireless/libertas/if_sdio.c
+++ b/drivers/net/wireless/libertas/if_sdio.c
@@ -892,6 +892,37 @@ static int if_sdio_reset_deep_sleep_wakeup(struct lbs_private *priv)
 
 }
 
+static struct mmc_host *reset_host;
+
+static void if_sdio_reset_card_worker(struct work_struct *work)
+{
+	/*
+	 * The actual reset operation must be run outside of lbs_thread. This
+	 * is because mmc_remove_host() will cause the device to be instantly
+	 * destroyed, and the libertas driver then needs to end lbs_thread,
+	 * leading to a deadlock.
+	 *
+	 * We run it in a workqueue totally independent from the if_sdio_card
+	 * instance for that reason.
+	 */
+
+	lbs_pr_info("Resetting card...");
+	mmc_remove_host(reset_host);
+	mmc_add_host(reset_host);
+}
+static DECLARE_WORK(card_reset_work, if_sdio_reset_card_worker);
+
+static void if_sdio_reset_card(struct lbs_private *priv)
+{
+	struct if_sdio_card *card = priv->card;
+
+	if (work_pending(&card_reset_work))
+		return;
+
+	reset_host = card->func->card->host;
+	schedule_work(&card_reset_work);
+}
+
 /*******************************************************************/
 /* SDIO callbacks                                                  */
 /*******************************************************************/
@@ -1069,6 +1100,7 @@ static int if_sdio_probe(struct sdio_func *func,
 	priv->enter_deep_sleep = if_sdio_enter_deep_sleep;
 	priv->exit_deep_sleep = if_sdio_exit_deep_sleep;
 	priv->reset_deep_sleep_wakeup = if_sdio_reset_deep_sleep_wakeup;
+	priv->reset_card = if_sdio_reset_card;
 
 	sdio_claim_host(func);
 
@@ -1290,6 +1322,8 @@ static void __exit if_sdio_exit_module(void)
 	/* Set the flag as user is removing this module. */
 	user_rmmod = 1;
 
+	cancel_work_sync(&card_reset_work);
+
 	sdio_unregister_driver(&if_sdio_driver);
 
 	lbs_deb_leave(LBS_DEB_SDIO);
-- 
1.7.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
