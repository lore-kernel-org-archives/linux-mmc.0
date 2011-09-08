From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH] mmc: core: Fix the incorrect calculation for erase unit size.
Date: Thu,  8 Sep 2011 14:59:25 +0900
Message-ID: <1315461565-16009-1-git-send-email-tgih.jun@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com, Seungwon Jeon <tgih.jun@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Erase unit size of high capacity is multiple of 512KiB not 1024KiB.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/core/mmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index b148bb1..7991ecf 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -332,7 +332,7 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		card->ext_csd.hc_erase_timeout = 300 *
 			ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT];
 		card->ext_csd.hc_erase_size =
-			ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE] << 10;
+			ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE] << 9;

 		card->ext_csd.rel_sectors = ext_csd[EXT_CSD_REL_WR_SEC_C];

--
1.7.0.4
