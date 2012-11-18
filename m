From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Subject: [PATCH] mmc: sdhci-s3c: fix missing clock for gpio card-detect
Date: Sun, 18 Nov 2012 19:50:05 +0100
Message-ID: <201211181950.06005.heiko@sntech.de>
References: <201211072357.15572.heiko@sntech.de> <87pq3c7wza.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:38124 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752003Ab2KRTiZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 18 Nov 2012 14:38:25 -0500
In-Reply-To: <87pq3c7wza.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Chander Kashyap <chander.kashyap@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>

Commit 2abeb5c5ded2 (Add clk_(enable/disable) in runtime suspend/resume)
added the capability to stop the clocks when the device is runtime
suspended, but forgot to handle the case of the card-detect using
an external gpio.

Therefore in the case that runtime-pm is enabled, start the io-clock
when a card is inserted and stop it again once it is removed.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/mmc/host/sdhci-s3c.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

This _should_ go into 3.7 because currently it causes a regression there.
Nevertheless it applies to both 3.7-rc6 and linux-next.

I also tried to use pm_runtime_get_sync (and _put) there, but it didn't
seem to work and the clock was still missing. With the changes in this
patch, the gpio-card-detect works again on my machine - all of insert,
remove and reinsert.

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index a54dd5d..c9ec725 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -373,18 +373,25 @@ static struct sdhci_ops sdhci_s3c_ops = {
 static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
 {
 	struct sdhci_host *host = platform_get_drvdata(dev);
+	struct sdhci_s3c *sc = sdhci_priv(host);
 	unsigned long flags;
 
 	if (host) {
 		spin_lock_irqsave(&host->lock, flags);
 		if (state) {
 			dev_dbg(&dev->dev, "card inserted.\n");
+#ifdef CONFIG_PM_RUNTIME
+			clk_prepare_enable(sc->clk_io);
+#endif
 			host->flags &= ~SDHCI_DEVICE_DEAD;
 			host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 		} else {
 			dev_dbg(&dev->dev, "card removed.\n");
 			host->flags |= SDHCI_DEVICE_DEAD;
 			host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+#ifdef CONFIG_PM_RUNTIME
+			clk_disable_unprepare(sc->clk_io);
+#endif
 		}
 		tasklet_schedule(&host->card_tasklet);
 		spin_unlock_irqrestore(&host->lock, flags);
-- 
1.7.2.3

