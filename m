From: akpm@linux-foundation.org
Subject: [patch 14/20] drivers/mmc/host/sdhci-s3c.c: use the correct mutex and card detect function
Date: Thu, 19 Aug 2010 14:13:37 -0700
Message-ID: <201008192113.o7JLDbpa008704@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59239 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753138Ab0HSVNl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Aug 2010 17:13:41 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, kyungmin.park@samsung.com, linux-mmc@vger.kernel.org

From: Kyungmin Park <kyungmin.park@samsung.com>

There's some merge problem between sdhic core and sdhci-s3c host.  After
mutex is changed to spinlock.  It needs to use use spin lock functions and
use the correct card detection function.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/sdhci-s3c.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/mmc/host/sdhci-s3c.c~drivers-mmc-host-sdhci-s3cc-use-the-correct-mutex-and-card-detect-function drivers/mmc/host/sdhci-s3c.c
--- a/drivers/mmc/host/sdhci-s3c.c~drivers-mmc-host-sdhci-s3cc-use-the-correct-mutex-and-card-detect-function
+++ a/drivers/mmc/host/sdhci-s3c.c
@@ -242,7 +242,7 @@ static void sdhci_s3c_notify_change(stru
 {
 	struct sdhci_host *host = platform_get_drvdata(dev);
 	if (host) {
-		mutex_lock(&host->lock);
+		spin_lock(&host->lock);
 		if (state) {
 			dev_dbg(&dev->dev, "card inserted.\n");
 			host->flags &= ~SDHCI_DEVICE_DEAD;
@@ -252,8 +252,8 @@ static void sdhci_s3c_notify_change(stru
 			host->flags |= SDHCI_DEVICE_DEAD;
 			host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 		}
-		sdhci_card_detect(host);
-		mutex_unlock(&host->lock);
+		tasklet_schedule(&host->card_tasklet);
+		spin_unlock(&host->lock);
 	}
 }
 
_
