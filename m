From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V3 27/30] omap_hsmmc: protect the card when the cover is open
Date: Wed, 09 Sep 2009 14:59:55 +0300
Message-ID: <20090909115955.12833.35087.sendpatchset@ahunter-laptop>
References: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:43218 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130AbZIIMAf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Sep 2009 08:00:35 -0400
In-Reply-To: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Pierre Ossman <pierre@ossman.eu>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Matt Fleming <matt@console-pimps.org>

>From bed30ea9b2f8c88199578df12faca269c0c5a91b Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Fri, 22 May 2009 16:53:49 +0300
Subject: [PATCH] omap_hsmmc: protect the card when the cover is open

Depending on the manufacturer, there is a small possibility that
removing a card while it is being written to, can render the
card permanently unusable.  To prevent that, the card is made
inaccessible when the cover is open.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   63 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4249723..047e656 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -165,6 +165,8 @@ struct omap_hsmmc_host {
 	int			context_loss;
 	int			dpm_state;
 	int			vdd;
+	int			protect_card;
+	int			reqs_blocked;
 
 	struct	omap_mmc_platform_data	*pdata;
 };
@@ -349,6 +351,9 @@ static void send_init_stream(struct omap_hsmmc_host *host)
 	int reg = 0;
 	unsigned long timeout;
 
+	if (host->protect_card)
+		return;
+
 	disable_irq(host->irq);
 	OMAP_HSMMC_WRITE(host->base, CON,
 		OMAP_HSMMC_READ(host->base, CON) | INIT_STREAM);
@@ -779,6 +784,30 @@ err:
 	return ret;
 }
 
+/* Protect the card while the cover is open */
+static void omap_hsmmc_protect_card(struct omap_hsmmc_host *host)
+{
+	if (!mmc_slot(host).get_cover_state)
+		return;
+
+	host->reqs_blocked = 0;
+	if (mmc_slot(host).get_cover_state(host->dev, host->slot_id)) {
+		if (host->protect_card) {
+			printk(KERN_INFO "%s: cover is closed, "
+					 "card is now accessible\n",
+					 mmc_hostname(host->mmc));
+			host->protect_card = 0;
+		}
+	} else {
+		if (!host->protect_card) {
+			printk(KERN_INFO "%s: cover is open, "
+					 "card is now inaccessible\n",
+					 mmc_hostname(host->mmc));
+			host->protect_card = 1;
+		}
+	}
+}
+
 /*
  * Work Item to notify the core about card insertion/removal
  */
@@ -796,8 +825,10 @@ static void omap_hsmmc_detect(struct work_struct *work)
 
 	if (slot->card_detect)
 		carddetect = slot->card_detect(slot->card_detect_irq);
-	else
+	else {
+		omap_hsmmc_protect_card(host);
 		carddetect = -ENOSYS;
+	}
 
 	if (carddetect) {
 		mmc_detect_change(host->mmc, (HZ * 200) / 1000);
@@ -1033,8 +1064,32 @@ static void omap_hsmmc_request(struct mmc_host *mmc, struct mmc_request *req)
 	 * interrupts, but not if we are already in interrupt context i.e.
 	 * retries.
 	 */
-	if (!in_interrupt())
+	if (!in_interrupt()) {
 		spin_lock_irqsave(&host->irq_lock, host->flags);
+		/*
+		 * Protect the card from I/O if there is a possibility
+		 * it can be removed.
+		 */
+		if (host->protect_card) {
+			if (host->reqs_blocked < 3) {
+				/*
+				 * Ensure the controller is left in a consistent
+				 * state by resetting the command and data state
+				 * machines.
+				 */
+				omap_hsmmc_reset_controller_fsm(host, SRD);
+				omap_hsmmc_reset_controller_fsm(host, SRC);
+				host->reqs_blocked += 1;
+			}
+			req->cmd->error = -EBADF;
+			if (req->data)
+				req->data->error = -EBADF;
+			spin_unlock_irqrestore(&host->irq_lock, host->flags);
+			mmc_request_done(mmc, req);
+			return;
+		} else if (host->reqs_blocked)
+			host->reqs_blocked = 0;
+	}
 	WARN_ON(host->mrq != NULL);
 	host->mrq = req;
 	err = omap_hsmmc_prepare_data(host, req);
@@ -1725,6 +1780,8 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 
 	mmc_host_lazy_disable(host->mmc);
 
+	omap_hsmmc_protect_card(host);
+
 	mmc_add_host(mmc);
 
 	if (mmc_slot(host).name != NULL) {
@@ -1890,6 +1947,8 @@ static int omap_hsmmc_resume(struct platform_device *pdev)
 					"Unmask interrupt failed\n");
 		}
 
+		omap_hsmmc_protect_card(host);
+
 		/* Notify the core to resume the host */
 		ret = mmc_resume_host(host->mmc);
 		if (ret == 0)
-- 
1.5.6.3

