From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH] mmc: core: Assemble the codes of related to eMMC4.5
Date: Mon, 24 Oct 2011 19:31:25 +0900
Message-ID: <001b01cc9238$156a65a0$403f30e0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:23025 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754208Ab1JXKb2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2011 06:31:28 -0400
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com

Code cleanup. The codes of related to eMMC4.5 are scattered.
This patch removes a duplicate if-statement and assembles all.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/core/mmc.c |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index fb5bf01..3627044 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -467,29 +467,27 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		card->ext_csd.rst_n_function = ext_csd[EXT_CSD_RST_N_FUNCTION];
 	}

-	/* eMMC v4.5 or later */
-	if (card->ext_csd.rev >= 6)
-		card->ext_csd.feature_support |= MMC_DISCARD_FEATURE;
-
 	card->ext_csd.raw_erased_mem_count = ext_csd[EXT_CSD_ERASED_MEM_CONT];
 	if (ext_csd[EXT_CSD_ERASED_MEM_CONT])
 		card->erased_byte = 0xFF;
 	else
 		card->erased_byte = 0x0;

+	/* eMMC v4.5 or later */
 	if (card->ext_csd.rev >= 6) {
+		card->ext_csd.feature_support |= MMC_DISCARD_FEATURE;
+
 		card->ext_csd.generic_cmd6_time = 10 *
 			ext_csd[EXT_CSD_GENERIC_CMD6_TIME];
 		card->ext_csd.power_off_longtime = 10 *
 			ext_csd[EXT_CSD_POWER_OFF_LONG_TIME];
-	} else
-		card->ext_csd.generic_cmd6_time = 0;

-	card->ext_csd.cache_size =
-		ext_csd[EXT_CSD_CACHE_SIZE + 0] << 0 |
-		ext_csd[EXT_CSD_CACHE_SIZE + 1] << 8 |
-		ext_csd[EXT_CSD_CACHE_SIZE + 2] << 16 |
-		ext_csd[EXT_CSD_CACHE_SIZE + 3] << 24;
+		card->ext_csd.cache_size =
+			ext_csd[EXT_CSD_CACHE_SIZE + 0] << 0 |
+			ext_csd[EXT_CSD_CACHE_SIZE + 1] << 8 |
+			ext_csd[EXT_CSD_CACHE_SIZE + 2] << 16 |
+			ext_csd[EXT_CSD_CACHE_SIZE + 3] << 24;
+	}

 out:
 	return err;
--
1.7.0.4


