From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/3] mmc: extend the slot-gpio card-detection to use host's
 .card_event() method
Date: Tue, 4 Dec 2012 16:51:36 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1212041648280.26918@axis700.grange>
References: <Pine.LNX.4.64.1212041633470.26918@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:60927 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316Ab2LDPvp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Dec 2012 10:51:45 -0500
In-Reply-To: <Pine.LNX.4.64.1212041633470.26918@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Mike Rapoport <mike@compulab.co.il>, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>

The slot-gpio API provides a generic card-detection handler. To support a
wider range of hosts it has to call the host's card-event callback, if
implemented. Also increase the debounce interval to 200ms to match the 
SDHCI driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/core/slot-gpio.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 08c6b3d..16a1c0b 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -27,7 +27,13 @@ struct mmc_gpio {
 static irqreturn_t mmc_gpio_cd_irqt(int irq, void *dev_id)
 {
 	/* Schedule a card detection after a debounce timeout */
-	mmc_detect_change(dev_id, msecs_to_jiffies(100));
+	struct mmc_host *host = dev_id;
+
+	if (host->ops->card_event)
+		host->ops->card_event(host);
+
+	mmc_detect_change(host, msecs_to_jiffies(200));
+
 	return IRQ_HANDLED;
 }
 
-- 
1.7.2.5

