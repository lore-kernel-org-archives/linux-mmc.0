From: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
Subject: [PATCH 5/8] sdhci: Delay led blinking
Date: Tue, 9 Jul 2013 17:44:09 +0200
Message-ID: <1373384652-21958-6-git-send-email-jeremie.samuel.ext@parrot.com>
References: <1373384652-21958-1-git-send-email-jeremie.samuel.ext@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:45925 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751942Ab3GIPoq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 9 Jul 2013 11:44:46 -0400
In-Reply-To: <1373384652-21958-1-git-send-email-jeremie.samuel.ext@parrot.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, matthieu.castet@parrot.com, gregor.boirie@parrot.com, Jeremie Samuel <jeremie.samuel.ext@parrot.com>

The function sdhci_led_control is called in an atomic context by the
led_trigger driver. So, it is necessary to delay the activation or
deactivation of the led.

Signed-off-by: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
---
 drivers/mmc/host/sdhci.c  |   42 ++++++++++++++++++++++--------------------
 include/linux/mmc/sdhci.h |    1 +
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 21ef1e0..9a7471c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -281,8 +281,14 @@ static void sdhci_activate_led(struct sdhci_host *host)
 	u8 ctrl;
 
 	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
-	ctrl |= SDHCI_CTRL_LED;
-	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+#ifdef SDHCI_USE_LEDS_CLASS
+	if (host->brightness && !(ctrl & SDHCI_CTRL_LED)) {
+#else
+	if (!(ctrl & SDHCI_CTRL_LED)) {
+#endif
+		ctrl |= SDHCI_CTRL_LED;
+		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+	}
 }
 
 static void sdhci_deactivate_led(struct sdhci_host *host)
@@ -290,8 +296,14 @@ static void sdhci_deactivate_led(struct sdhci_host *host)
 	u8 ctrl;
 
 	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
-	ctrl &= ~SDHCI_CTRL_LED;
-	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+#ifdef SDHCI_USE_LEDS_CLASS
+	if (!host->brightness && (ctrl & SDHCI_CTRL_LED)) {
+#else
+	if (ctrl & SDHCI_CTRL_LED) {
+#endif
+		ctrl &= ~SDHCI_CTRL_LED;
+		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+	}
 }
 
 #ifdef SDHCI_USE_LEDS_CLASS
@@ -299,19 +311,11 @@ static void sdhci_led_control(struct led_classdev *led,
 	enum led_brightness brightness)
 {
 	struct sdhci_host *host = container_of(led, struct sdhci_host, led);
-	unsigned long flags;
-
-	spin_lock_irqsave(&host->lock, flags);
 
 	if (host->runtime_suspended)
-		goto out;
+		return;
 
-	if (brightness == LED_OFF)
-		sdhci_deactivate_led(host);
-	else
-		sdhci_activate_led(host);
-out:
-	spin_unlock_irqrestore(&host->lock, flags);
+	host->brightness = brightness;
 }
 #endif
 
@@ -1338,9 +1342,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	WARN_ON(host->mrq != NULL);
 
-#ifndef SDHCI_USE_LEDS_CLASS
 	sdhci_activate_led(host);
-#endif
 
 	/*
 	 * Ensure we don't send the STOP for non-SET_BLOCK_COUNTED
@@ -2164,15 +2166,15 @@ static void sdhci_finish_work(struct work_struct *wk)
 	host->cmd = NULL;
 	host->data = NULL;
 
-#ifndef SDHCI_USE_LEDS_CLASS
-	sdhci_deactivate_led(host);
-#endif
-
 	mmiowb();
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	mmc_request_done(host->mmc, mrq);
 	sdhci_runtime_pm_put(host);
+
+	spin_lock_irqsave(&host->lock, flags);
+	sdhci_deactivate_led(host);
+	spin_unlock_irqrestore(&host->lock, flags);
 }
 
 static void sdhci_timeout_work(struct work_struct *wk)
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 0cc97ce..adb95c3 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -115,6 +115,7 @@ struct sdhci_host {
 #if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
 	struct led_classdev led;	/* LED control */
 	char led_name[32];
+	enum led_brightness brightness;
 #endif
 
 	spinlock_t lock;	/* Mutex */
-- 
1.7.10.4

