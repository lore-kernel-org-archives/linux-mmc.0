From: "Steven J. Hill" <steven.hill@cavium.com>
Subject: [PATCH 1/4] mmc: core: Export API to allow hosts to get the card address
Date: Mon, 24 Apr 2017 13:41:55 -0500
Message-ID: <1493059318-767-2-git-send-email-steven.hill@cavium.com>
References: <1493059318-767-1-git-send-email-steven.hill@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam03on0042.outbound.protection.outlook.com ([104.47.42.42]:48489
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S973056AbdDXSo3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Apr 2017 14:44:29 -0400
In-Reply-To: <1493059318-767-1-git-send-email-steven.hill@cavium.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Daney <david.daney@cavium.com>, Jan Glauber <jglauber@cavium.com>, linux-mmc@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Some hosts controllers, like Cavium, needs to know whether the card
operates in byte- or block-address mode. Therefore export a new API,
mmc_card_is_blockaddr(), which provides this information.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 drivers/mmc/core/core.c  | 6 ++++++
 include/linux/mmc/card.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 926e0fd..f9fae34 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2555,6 +2555,12 @@ unsigned int mmc_calc_max_discard(struct mmc_card *card)
 }
 EXPORT_SYMBOL(mmc_calc_max_discard);
 
+bool mmc_card_is_blockaddr(struct mmc_card *card)
+{
+       return card ? mmc_card_blockaddr(card) : false;
+}
+EXPORT_SYMBOL(mmc_card_is_blockaddr);
+
 int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen)
 {
 	struct mmc_command cmd = {};
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 77e61e0..4cd9450 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -307,6 +307,8 @@ static inline bool mmc_large_sector(struct mmc_card *card)
 	return card->ext_csd.data_sector_size == 4096;
 }
 
+bool mmc_card_is_blockaddr(struct mmc_card *card);
+
 #define mmc_card_mmc(c)		((c)->type == MMC_TYPE_MMC)
 #define mmc_card_sd(c)		((c)->type == MMC_TYPE_SD)
 #define mmc_card_sdio(c)	((c)->type == MMC_TYPE_SDIO)
-- 
2.1.4

