From: "Shen, Jackey" <Jackey.Shen@amd.com>
Subject: RE: [PATCH] mmc: clean up the duplicate code
Date: Wed, 31 Jul 2013 09:12:17 +0000
Message-ID: <0C8FBB70FF40A94D98BE847F9C171A9803A89B3A@SCYBEXDAG04.amd.com>
References: <1368782263-10133-1-git-send-email-jackey.shen@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:18031
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755480Ab3GaJMe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 31 Jul 2013 05:12:34 -0400
In-Reply-To: <1368782263-10133-1-git-send-email-jackey.shen@amd.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Shen, Jackey" <Jackey.Shen@amd.com>

Hi Chris,

Could you please push into mmc-next if you have no comments?

Thanks,
Jackey 

-----Original Message-----
From: Jackey Shen [mailto:jackey.shen@amd.com] 
Sent: Friday, May 17, 2013 5:18 PM
To: linux-mmc@vger.kernel.org
Cc: Shen, Jackey
Subject: [PATCH] mmc: clean up the duplicate code

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


