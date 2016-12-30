From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 2/2] mmc: sdhci-iproc: Increase max_blk_size for bcm2835
Date: Fri, 30 Dec 2016 15:24:33 +0000
Message-ID: <1483111474-29907-3-git-send-email-stefan.wahren@i2se.com>
References: <1483111474-29907-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:58436 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754167AbcL3PZ3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Dec 2016 10:25:29 -0500
In-Reply-To: <1483111474-29907-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eric Anholt <eric@anholt.net>, Gerd Hoffmann <kraxel@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, Stefan Wahren <stefan.wahren@i2se.com>

According to the BCM2835 datasheet the maximum block size for the
eMMC module is restricted to the internal data FIFO which is 1024 byte.
But this is still an improvement to the default of 512 byte.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/mmc/host/sdhci-iproc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 30b3fdf..3275d49 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -218,7 +218,9 @@ static void sdhci_iproc_writeb(struct sdhci_host *host, u8 val, int reg)
 
 static const struct sdhci_iproc_data bcm2835_data = {
 	.pdata = &sdhci_bcm2835_pltfm_data,
-	.caps = SDHCI_CAN_VDD_330 |
+	.caps = ((0x1 << SDHCI_MAX_BLOCK_SHIFT)
+			& SDHCI_MAX_BLOCK_MASK) |
+		SDHCI_CAN_VDD_330 |
 		SDHCI_CAN_DO_HISPD,
 	.caps1 = SDHCI_DRIVER_TYPE_A |
 		 SDHCI_DRIVER_TYPE_C,
-- 
1.7.9.5

