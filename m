From: akpm@linux-foundation.org
Subject: [patch 12/20] sdhci: add no hi-speed bit quirk support
Date: Thu, 19 Aug 2010 14:13:35 -0700
Message-ID: <201008192113.o7JLDZhP008698@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48587 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753138Ab0HSVNk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Aug 2010 17:13:40 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, kyungmin.park@samsung.com, linux-mmc@vger.kernel.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Some SDHCI controllers like s5pc110 don't have an HISPD bit in the HOSTCTL
register.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/sdhci.c |    3 ++-
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff -puN drivers/mmc/host/sdhci.c~sdhci-add-no-hi-speed-bit-quirk-support drivers/mmc/host/sdhci.c
--- a/drivers/mmc/host/sdhci.c~sdhci-add-no-hi-speed-bit-quirk-support
+++ a/drivers/mmc/host/sdhci.c
@@ -1180,7 +1180,8 @@ static void sdhci_set_ios(struct mmc_hos
 	else
 		ctrl &= ~SDHCI_CTRL_4BITBUS;
 
-	if (ios->timing == MMC_TIMING_SD_HS)
+	if (ios->timing == MMC_TIMING_SD_HS &&
+	    !(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT))
 		ctrl |= SDHCI_CTRL_HISPD;
 	else
 		ctrl &= ~SDHCI_CTRL_HISPD;
diff -puN drivers/mmc/host/sdhci.h~sdhci-add-no-hi-speed-bit-quirk-support drivers/mmc/host/sdhci.h
--- a/drivers/mmc/host/sdhci.h~sdhci-add-no-hi-speed-bit-quirk-support
+++ a/drivers/mmc/host/sdhci.h
@@ -245,6 +245,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_MISSING_CAPS			(1<<27)
 /* Controller uses Auto CMD12 command to stop the transfer */
 #define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<28)
+/* Controller doesn't have HISPD bit field in HI-SPEED SD card */
+#define SDHCI_QUIRK_NO_HISPD_BIT			(1<<29)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
_
