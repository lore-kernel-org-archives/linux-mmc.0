From: Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v3 1/3] mmc: dw_mmc: fix the max_blk_count in IDMAC
Date: Mon, 22 Dec 2014 17:42:02 +0530
Message-ID: <1419250324-11743-2-git-send-email-alim.akhtar@samsung.com>
References: <1419250324-11743-1-git-send-email-alim.akhtar@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:53384 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754401AbaLVMTq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Dec 2014 07:19:46 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NGZ00CMNGWXJN00@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 22 Dec 2014 21:19:45 +0900 (KST)
In-reply-to: <1419250324-11743-1-git-send-email-alim.akhtar@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, jh80.chung@samsung.com, tgih.jun@samsung.com, dianders@chromium.org, alim.akhtar@gmail.com, linux-arm-kernel@lists.infradead.org

From: Seungwon Jeon <tgih.jun@samsung.com>

Even though 1MB is reserved for descriptor table in IDMAC,
the dw_mmc host driver is allowed to receive only maximum
128KB block length in one request. This is caused by setting
improper max_blk_count. It needs to be e adjusted so that
descriptor table is used fully. It is found that the performance
is improved with the increased the max_blk_count.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 64ea042..a1b80e5 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2332,9 +2332,9 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 #ifdef CONFIG_MMC_DW_IDMAC
 		mmc->max_segs = host->ring_size;
 		mmc->max_blk_size = 65536;
-		mmc->max_blk_count = host->ring_size;
 		mmc->max_seg_size = 0x1000;
-		mmc->max_req_size = mmc->max_seg_size * mmc->max_blk_count;
+		mmc->max_req_size = mmc->max_seg_size * host->ring_size;
+		mmc->max_blk_count = mmc->max_req_size / 512;
 #else
 		mmc->max_segs = 64;
 		mmc->max_blk_size = 65536; /* BLKSIZ is 16 bits */
-- 
1.7.9.5

