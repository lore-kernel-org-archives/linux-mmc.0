From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: [PATCH] mmc: dw_mmc: fix pio mode when internal dmac is enabled
Date: Mon, 03 Aug 2015 17:04:10 +0200
Message-ID: <3018549.c8iX1Dbrhm@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:59011 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753122AbbHCPEQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Aug 2015 11:04:16 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

The dw_mci_init_dma() may decide to not use dma, but pio instead, caused
by things like wrong dma settings in the system.

Till now the code dw_mci_init_slot() always assumed that dma is available
when CONFIG_MMC_DW_IDMAC was defined, ignoring the host->use_dma var
set during dma init.

So when now the dma init failed for whatever reason, the transfer sizes
would still be set for dma transfers, especially including the maximum
block-count calculated from host->ring_size and resulting in a

[    4.991109] ------------[ cut here ]------------
[    4.991111] kernel BUG at drivers/mmc/core/core.c:256!
[    4.991113] Internal error: Oops - BUG: 0 [#1] SMP ARM

because host->ring_size is 0 in this case and the slot init code uses
the wrong code to calculate the values.

Fix this by selecting the correct calculations using the host->use_dma
variable instead of the CONFIG_MMC_DW_IDMAC config option.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/mmc/host/dw_mmc.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 40e9d8e..9ec3521 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2391,19 +2391,20 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 		mmc->max_seg_size = host->pdata->blk_settings->max_seg_size;
 	} else {
 		/* Useful defaults if platform data is unset. */
-#ifdef CONFIG_MMC_DW_IDMAC
-		mmc->max_segs = host->ring_size;
-		mmc->max_blk_size = 65536;
-		mmc->max_seg_size = 0x1000;
-		mmc->max_req_size = mmc->max_seg_size * host->ring_size;
-		mmc->max_blk_count = mmc->max_req_size / 512;
-#else
-		mmc->max_segs = 64;
-		mmc->max_blk_size = 65536; /* BLKSIZ is 16 bits */
-		mmc->max_blk_count = 512;
-		mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
-		mmc->max_seg_size = mmc->max_req_size;
-#endif /* CONFIG_MMC_DW_IDMAC */
+		if (host->use_dma) {
+			mmc->max_segs = host->ring_size;
+			mmc->max_blk_size = 65536;
+			mmc->max_seg_size = 0x1000;
+			mmc->max_req_size = mmc->max_seg_size * host->ring_size;
+			mmc->max_blk_count = mmc->max_req_size / 512;
+		} else {
+			mmc->max_segs = 64;
+			mmc->max_blk_size = 65536; /* BLKSIZ is 16 bits */
+			mmc->max_blk_count = 512;
+			mmc->max_req_size = mmc->max_blk_size *
+					    mmc->max_blk_count;
+			mmc->max_seg_size = mmc->max_req_size;
+		}
 	}
 
 	if (dw_mci_get_cd(mmc))
-- 
2.1.4


