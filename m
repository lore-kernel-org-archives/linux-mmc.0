From: Olof Johansson <olof@lixom.net>
Subject: [PATCH 1/4] sdhci: add quirk for max len ADMA descriptors
Date: Tue, 14 Dec 2010 22:49:33 -0600
Message-ID: <1292388576-25600-2-git-send-email-olof@lixom.net>
References: <1292388576-25600-1-git-send-email-olof@lixom.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.lixom.net ([70.86.134.90]:38599 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760510Ab0LOE5b (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Dec 2010 23:57:31 -0500
In-Reply-To: <1292388576-25600-1-git-send-email-olof@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Olof Johansson <olof@lixom.net>

Some controllers misparse segment length 0 as being 0, not 65536. Add
a quirk to deal with it.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/mmc/host/sdhci.c  |   10 +++++++---
 include/linux/mmc/sdhci.h |    2 ++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a25db426..c0094c1 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1928,10 +1928,14 @@ int sdhci_add_host(struct sdhci_host *host)
 	 * of bytes. When doing hardware scatter/gather, each entry cannot
 	 * be larger than 64 KiB though.
 	 */
-	if (host->flags & SDHCI_USE_ADMA)
-		mmc->max_seg_size = 65536;
-	else
+	if (host->flags & SDHCI_USE_ADMA) {
+		if (host->quirks & SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC)
+			mmc->max_seg_size = 65535;
+		else
+			mmc->max_seg_size = 65536;
+	} else {
 		mmc->max_seg_size = mmc->max_req_size;
+	}
 
 	/*
 	 * Maximum block size. This varies from controller to controller and
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 1fdc673..dfb2106 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -83,6 +83,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<28)
 /* Controller doesn't have HISPD bit field in HI-SPEED SD card */
 #define SDHCI_QUIRK_NO_HISPD_BIT			(1<<29)
+/* Controller treats ADMA descriptors with length 0000h incorrectly */
+#define SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC		(1<<30)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.7.3.GIT

