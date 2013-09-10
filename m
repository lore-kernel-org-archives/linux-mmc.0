From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RFC PATCH] mmc: core: remove the mmc_sd_card_uhs()
Date: Tue, 10 Sep 2013 14:44:19 +0900
Message-ID: <522EB1B3.6020402@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:8270 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753454Ab3IJFn4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Sep 2013 01:43:56 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSW00M6LAL66QM0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 10 Sep 2013 14:43:54 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: 'Chris Ball' <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, 'Konstantin Dorfman' <kdorfman@codeaurora.org>, Wei WANG <wei_wang@realsil.com.cn>

mmc_sd_card_uhs() didn't has difference with mmc_card_uhs().
And mmc_sd_card_set_uhs() didn't use anywhere.

I'm not sure why mmc_sd_card_uhs() used.
If need to check whether card is sd or not, then we can use the mmc_card_sd().

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/core/bus.c            |    2 +-
 drivers/mmc/host/rtsx_pci_sdmmc.c |    2 +-
 include/linux/mmc/card.h          |    2 --
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 704bf66..cdca8a7 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -340,7 +340,7 @@ int mmc_add_card(struct mmc_card *card)
 		break;
 	}
 
-	if (mmc_sd_card_uhs(card) &&
+	if (mmc_card_uhs(card) &&
 		(card->sd_bus_speed < ARRAY_SIZE(uhs_speeds)))
 		uhs_bus_speed_mode = uhs_speeds[card->sd_bus_speed];
 
diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 82a35b9..b6964a1 100644
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
index 842de3e..f42cdbd 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -420,7 +420,6 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_blockaddr(c)	((c)->state & MMC_STATE_BLOCKADDR)
 #define mmc_card_ddr_mode(c)	((c)->state & MMC_STATE_HIGHSPEED_DDR)
 #define mmc_card_uhs(c)		((c)->state & MMC_STATE_ULTRAHIGHSPEED)
-#define mmc_sd_card_uhs(c)	((c)->state & MMC_STATE_ULTRAHIGHSPEED)
 #define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
 #define mmc_card_removed(c)	((c) && ((c)->state & MMC_CARD_REMOVED))
 #define mmc_card_doing_bkops(c)	((c)->state & MMC_STATE_DOING_BKOPS)
@@ -432,7 +431,6 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_set_blockaddr(c) ((c)->state |= MMC_STATE_BLOCKADDR)
 #define mmc_card_set_ddr_mode(c) ((c)->state |= MMC_STATE_HIGHSPEED_DDR)
 #define mmc_card_set_uhs(c) ((c)->state |= MMC_STATE_ULTRAHIGHSPEED)
-#define mmc_sd_card_set_uhs(c) ((c)->state |= MMC_STATE_ULTRAHIGHSPEED)
 #define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
 #define mmc_card_set_removed(c) ((c)->state |= MMC_CARD_REMOVED)
 #define mmc_card_set_doing_bkops(c)	((c)->state |= MMC_STATE_DOING_BKOPS)
-- 
1.7.9.5
