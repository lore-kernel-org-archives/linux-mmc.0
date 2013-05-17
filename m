From: Jackey Shen <jackey.shen@amd.com>
Subject: [PATCH] mmc: clean up the duplicate code
Date: Fri, 17 May 2013 17:17:43 +0800
Message-ID: <1368782263-10133-1-git-send-email-jackey.shen@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:28518 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752647Ab3EQJSZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 May 2013 05:18:25 -0400
Received: from mail112-tx2 (localhost [127.0.0.1])	by
 mail112-tx2-R.bigfish.com (Postfix) with ESMTP id 908F7120159	for
 <linux-mmc@vger.kernel.org>; Fri, 17 May 2013 09:18:24 +0000 (UTC)
Received: from TX2EHSMHS034.bigfish.com (unknown [10.9.14.233])	by
 mail112-tx2.bigfish.com (Postfix) with ESMTP id 813E9320058	for
 <linux-mmc@vger.kernel.org>; Fri, 17 May 2013 09:18:22 +0000 (UTC)
Received: from sausexedgep02.amd.com (sausexedgep02-ext.amd.com
 [163.181.249.73])	(using TLSv1 with cipher AES128-SHA (128/128 bits))	(No
 client certificate requested)	by ausb3twp02.amd.com (Axway MailGate 3.8.1)
 with ESMTP id 2B1C6C801A	for <linux-mmc@vger.kernel.org>; Fri, 17 May 2013
 04:18:19 -0500 (CDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jackey Shen <jackey.shen@amd.com>

clean up the duplicate micros:
mmc_sd_card_uhs -> mmc_card_uhs
mmc_sd_card_set_uhs -> mmc_card_set_uhs

Signed-off-by: Jackey Shen <jackey.shen@amd.com>
---
 drivers/mmc/core/bus.c            |    2 +-
 drivers/mmc/host/rtsx_pci_sdmmc.c |    2 +-
 include/linux/mmc/card.h          |    2 --
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index e219c97..820f6fa 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -298,7 +298,7 @@ int mmc_add_card(struct mmc_card *card)
 		break;
 	}
 
-	if (mmc_sd_card_uhs(card) &&
+	if (mmc_card_uhs(card) &&
 		(card->sd_bus_speed < ARRAY_SIZE(uhs_speeds)))
 		uhs_bus_speed_mode = uhs_speeds[card->sd_bus_speed];
 
diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index ad13f42..c979b86 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -359,7 +359,7 @@ static int sd_rw_multi(struct realtek_pci_sdmmc *host, struct mmc_request *mrq)
 	struct mmc_host *mmc = host->mmc;
 	struct mmc_card *card = mmc->card;
 	struct mmc_data *data = mrq->data;
-	int uhs = mmc_sd_card_uhs(card);
+	int uhs = mmc_card_uhs(card);
 	int read = (data->flags & MMC_DATA_READ) ? 1 : 0;
 	u8 cfg2, trans_mode;
 	int err;
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index f31725b..8ac2079 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -412,7 +412,6 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_blockaddr(c)	((c)->state & MMC_STATE_BLOCKADDR)
 #define mmc_card_ddr_mode(c)	((c)->state & MMC_STATE_HIGHSPEED_DDR)
 #define mmc_card_uhs(c)		((c)->state & MMC_STATE_ULTRAHIGHSPEED)
-#define mmc_sd_card_uhs(c)	((c)->state & MMC_STATE_ULTRAHIGHSPEED)
 #define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
 #define mmc_card_removed(c)	((c) && ((c)->state & MMC_CARD_REMOVED))
 #define mmc_card_doing_bkops(c)	((c)->state & MMC_STATE_DOING_BKOPS)
@@ -424,7 +423,6 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_set_blockaddr(c) ((c)->state |= MMC_STATE_BLOCKADDR)
 #define mmc_card_set_ddr_mode(c) ((c)->state |= MMC_STATE_HIGHSPEED_DDR)
 #define mmc_card_set_uhs(c) ((c)->state |= MMC_STATE_ULTRAHIGHSPEED)
-#define mmc_sd_card_set_uhs(c) ((c)->state |= MMC_STATE_ULTRAHIGHSPEED)
 #define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
 #define mmc_card_set_removed(c) ((c)->state |= MMC_CARD_REMOVED)
 #define mmc_card_set_doing_bkops(c)	((c)->state |= MMC_STATE_DOING_BKOPS)
-- 
1.7.10.4


