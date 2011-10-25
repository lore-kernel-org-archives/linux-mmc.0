From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH RESEND] mmc: core: Assemble the codes of related to eMMC4.5
Date: Tue, 25 Oct 2011 09:43:12 +0900
Message-ID: <002401cc92af$13358b30$39a0a190$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com
List-Id: linux-mmc@vger.kernel.org

Code cleanup. The codes of related to eMMC4.5 are scattered.
This patch removes one if-statement and assembles all. And it also
removes variable initialization below else-statement. It is obvious
for previous version but seems unnecessary. All members of card structure
are already set to zero at card-init.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/core/mmc.c |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 6354eb3..6354bac 100644
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
