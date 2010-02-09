From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 5/5] SDIO: put active devices into 1-bit mode during suspend
Date: Tue, 09 Feb 2010 15:29:26 -0500
Message-ID: <1265747366-6676-6-git-send-email-nico@fluxnic.net>
References: <1265747366-6676-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:12186 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605Ab0BIU3x (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Feb 2010 15:29:53 -0500
Received: from localhost.localdomain ([66.130.28.92])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KXL00I4TCXNVXE0@VL-MH-MR002.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Tue, 09 Feb 2010 15:29:49 -0500 (EST)
In-reply-to: <1265747366-6676-1-git-send-email-nico@fluxnic.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org

From: Daniel Drake <dsd@laptop.org>

And bring them back to 4-bit mode during resume.

Signed-off-by: Daniel Drake <dsd@laptop.org>
Signed-off-by: Nicolas Pitre <nico@marvell.com>
---
 drivers/mmc/core/sdio.c  |   43 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/sdio.h |    2 ++
 2 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 5840de1..2dd4cfe 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -188,6 +188,40 @@ static int sdio_disable_cd(struct mmc_card *card)
 }
 
 /*
+ * Devices that remain active during a system suspend are
+ * put back into 1-bit mode.
+ */
+static int sdio_disable_wide(struct mmc_card *card)
+{
+	int ret;
+	u8 ctrl;
+
+	if (!(card->host->caps & MMC_CAP_4_BIT_DATA))
+		return 0;
+
+	if (card->cccr.low_speed && !card->cccr.wide_bus)
+		return 0;
+
+	ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_IF, 0, &ctrl);
+	if (ret)
+		return ret;
+
+	if (!(ctrl & SDIO_BUS_WIDTH_4BIT))
+		return 0;
+
+	ctrl &= ~SDIO_BUS_WIDTH_4BIT;
+	ctrl |= SDIO_BUS_ASYNC_INT;
+
+	ret = mmc_io_rw_direct(card, 1, 0, SDIO_CCCR_IF, ctrl, NULL);
+	if (ret)
+		return ret;
+
+	mmc_set_bus_width(card->host, MMC_BUS_WIDTH_1);
+
+	return 0;
+}
+
+/*
  * Test if the card supports high-speed mode and, if so, switch to it.
  */
 static int sdio_enable_hs(struct mmc_card *card)
@@ -427,6 +461,12 @@ static int mmc_sdio_suspend(struct mmc_host *host)
 		}
 	}
 
+	if (!err && host->pm_flags & MMC_PM_KEEP_POWER) {
+		mmc_claim_host(host);
+		sdio_disable_wide(host->card);
+		mmc_release_host(host);
+	}
+
 	return err;
 }
 
@@ -441,6 +481,9 @@ static int mmc_sdio_resume(struct mmc_host *host)
 	mmc_claim_host(host);
 	err = mmc_sdio_init_card(host, host->ocr, host->card,
 				 (host->pm_flags & MMC_PM_KEEP_POWER));
+	if (!err)
+		/* We may have switched to 1-bit mode during suspend. */
+		err = sdio_enable_wide(host->card);
 	if (!err && host->sdio_irqs)
 		mmc_signal_sdio_irq(host);
 	mmc_release_host(host);
diff --git a/include/linux/mmc/sdio.h b/include/linux/mmc/sdio.h
index 47ba464..0ebaef5 100644
--- a/include/linux/mmc/sdio.h
+++ b/include/linux/mmc/sdio.h
@@ -95,6 +95,8 @@
 #define  SDIO_BUS_WIDTH_1BIT	0x00
 #define  SDIO_BUS_WIDTH_4BIT	0x02
 
+#define  SDIO_BUS_ASYNC_INT	0x20
+
 #define  SDIO_BUS_CD_DISABLE     0x80	/* disable pull-up on DAT3 (pin 1) */
 
 #define SDIO_CCCR_CAPS		0x08
-- 
1.7.0.rc2.1.g694b5

