From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: sdhci-s3c: remove unnecessary code in
 sdhci_s3c_notify_change
Date: Tue, 15 Nov 2011 13:24:48 +0900
Message-ID: <4EC1E990.2060600@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:34641 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366Ab1KOEZA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Nov 2011 23:25:00 -0500
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LUO007TYPL253D0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 15 Nov 2011 13:24:59 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LUO00CZHPLMOQ20@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 15 Nov 2011 13:24:59 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

This patch is removed the DEVICE_DEAD flag for sdhci-s3c.

I didn't know why this flag is assigned.
If this flag is set When card is removed,
ENSDCLK bit in CLOCK control register is always set in sdhci_set_ios().
Because if device dead, be skipped set_ios.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index c992e4f..995b11d 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -334,11 +334,9 @@ static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
 		spin_lock_irqsave(&host->lock, flags);
 		if (state) {
 			dev_dbg(&dev->dev, "card inserted.\n");
-			host->flags &= ~SDHCI_DEVICE_DEAD;
 			host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 		} else {
 			dev_dbg(&dev->dev, "card removed.\n");
-			host->flags |= SDHCI_DEVICE_DEAD;
 			host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 		}
 		tasklet_schedule(&host->card_tasklet);
