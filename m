From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] mmc: Set pref erase size based on size.
Date: Thu,  2 Jun 2016 15:56:24 -0700
Message-ID: <1464908184-20153-1-git-send-email-gwendal@chromium.org>
References: <x49pozyljvs.fsf@segfault.boston.devel.redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <x49pozyljvs.fsf@segfault.boston.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: grundler@chromium.org, axboe@kernel.dk, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

If available, eMMC stack uses HC_ERASE_GRP_SIZE as preferred erase size.
However, that size is the minimal size we must use, not the optimal size.
Calculate the optimal size based on whole device size and fall back to
HC_ERASE_GRP_SIZE if too small.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/mmc/core/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index ef76b1c..2874160 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1996,8 +1996,6 @@ void mmc_init_erase(struct mmc_card *card)
 	if (mmc_card_sd(card) && card->ssr.au) {
 		card->pref_erase = card->ssr.au;
 		card->erase_shift = ffs(card->ssr.au) - 1;
-	} else if (card->ext_csd.hc_erase_size) {
-		card->pref_erase = card->ext_csd.hc_erase_size;
 	} else if (card->erase_size) {
 		sz = (card->csd.capacity << (card->csd.read_blkbits - 9)) >> 11;
 		if (sz < 128)
@@ -2015,6 +2013,8 @@ void mmc_init_erase(struct mmc_card *card)
 			if (sz)
 				card->pref_erase += card->erase_size - sz;
 		}
+		if (card->ext_csd.hc_erase_size > card->pref_erase)
+			card->pref_erase = card->ext_csd.hc_erase_size;
 	} else
 		card->pref_erase = 0;
 }
-- 
2.8.0.rc3.226.g39d4020
