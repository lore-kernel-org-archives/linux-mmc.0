From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
Subject: [PATCH] mmc: core: Quirk for long data read time
Date: Thu, 3 Nov 2011 09:44:12 +0100
Message-ID: <1320309852-21893-1-git-send-email-stefan.xk.nilsson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:45796 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755083Ab1KCIqE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Nov 2011 04:46:04 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>

Adds a quirk that sets the data read timeout to a fixed value instead
of relying on the information in the CSD. The timeout value choosen
is 300ms since that has proven enough for the problematic cards found,
but could be increased if other cards require this.

This patch also enables this quirk for certain Micron cards known to
have this problem.

Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
---
 drivers/mmc/card/block.c |    7 +++++++
 drivers/mmc/core/core.c  |   12 ++++++++++++
 include/linux/mmc/card.h |    6 ++++++
 3 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 4fd5723..04af5e5 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1603,6 +1603,13 @@ static const struct mmc_fixup blk_fixups[] =
 		  MMC_QUIRK_BLK_NO_CMD23),
 	MMC_FIXUP("MMC32G", 0x11, CID_OEMID_ANY, add_quirk_mmc,
 		  MMC_QUIRK_BLK_NO_CMD23),
+
+	/*
+	 * Some Micron MMC cards needs longer data read timeout than
+	 * indicated in CSD.
+	 */
+	MMC_FIXUP("", 0x13, 0x200, add_quirk_mmc, MMC_QUIRK_LONG_READ_TIME),
+
 	END_FIXUP
 };
 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5278ffb..74a012a 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -529,6 +529,18 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
 			data->timeout_clks = 0;
 		}
 	}
+
+	/*
+	 * Some cards require longer data read timeout than indicated in CSD.
+	 * Address this by setting the read timeout to a "reasonably high"
+	 * value. For the cards tested, 300ms has proven enough. If necessary,
+	 * this value can be increased if other problematic cards require this.
+	 */
+	if (mmc_card_long_read_time(card) && data->flags & MMC_DATA_READ) {
+		data->timeout_ns = 300000000;
+		data->timeout_clks = 0;
+	}
+
 	/*
 	 * Some cards need very high timeouts if driven in SPI mode.
 	 * The worst observed timeout was 900ms after writing a
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 6e04e10..7ecd79d 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -218,6 +218,7 @@ struct mmc_card {
 #define MMC_QUIRK_INAND_CMD38	(1<<6)		/* iNAND devices have broken CMD38 */
 #define MMC_QUIRK_BLK_NO_CMD23	(1<<7)		/* Avoid CMD23 for regular multiblock */
 #define MMC_QUIRK_BROKEN_BYTE_MODE_512 (1<<8)	/* Avoid sending 512 bytes in */
+#define MMC_QUIRK_LONG_READ_TIME (1<<9)		/* Data read time > CSD says */
 						/* byte mode */
 	unsigned int    poweroff_notify_state;	/* eMMC4.5 notify feature */
 #define MMC_NO_POWER_NOTIFICATION	0
@@ -433,6 +434,11 @@ static inline int mmc_card_broken_byte_mode_512(const struct mmc_card *c)
 	return c->quirks & MMC_QUIRK_BROKEN_BYTE_MODE_512;
 }
 
+static inline int mmc_card_long_read_time(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_LONG_READ_TIME;
+}
+
 #define mmc_card_name(c)	((c)->cid.prod_name)
 #define mmc_card_id(c)		(dev_name(&(c)->dev))
 
-- 
1.7.7

