From: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
Subject: [PATCH 5/8] sdhci: Delay led blinking
Date: Fri, 24 May 2013 18:00:39 +0200
Message-ID: <1369411242-20515-6-git-send-email-jeremie.samuel.ext@parrot.com>
References: <1369411242-20515-1-git-send-email-jeremie.samuel.ext@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:35680 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755322Ab3EXQBe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 24 May 2013 12:01:34 -0400
In-Reply-To: <1369411242-20515-1-git-send-email-jeremie.samuel.ext@parrot.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: matthieu.castet@parrot.com, gregor.boirie@parrot.com, Jeremie Samuel <jeremie.samuel.ext@parrot.com>

The function sdhci_led_control is called in an atomic context by the
led_trigger driver. So, it is necessary to delay the activation or
deactivation of the led.

Signed-off-by: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
---
 drivers/mmc/host/sdhci.c  |   42 ++++++++++++++++++++++--------------------
 include/linux/mmc/sdhci.h |    1 +
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f361fec..c2585dd 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -269,8 +269,14 @@ static void sdhci_activate_led(struct sdhci_host *host)
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
@@ -278,8 +284,14 @@ static void sdhci_deactivate_led(struct sdhci_host *host)
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
@@ -287,19 +299,11 @@ static void sdhci_led_control(struct led_classdev *led,
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
 
@@ -1321,9 +1325,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	WARN_ON(host->mrq != NULL);
 
-#ifndef SDHCI_USE_LEDS_CLASS
 	sdhci_activate_led(host);
-#endif
 
 	/*
 	 * Ensure we don't send the STOP for non-SET_BLOCK_COUNTED
@@ -2145,15 +2147,15 @@ static void sdhci_finish_work(struct work_struct *wk)
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
index 152acb5..8002d17 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -112,6 +112,7 @@ struct sdhci_host {
 #if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
 	struct led_classdev led;	/* LED control */
 	char led_name[32];
+	enum led_brightness brightness;
 #endif
 
 	spinlock_t lock;	/* Mutex */
-- 
1.7.10.4

