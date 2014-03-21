From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 1/7] mmc: dw_mmc: fix the max_blk_count in IDMAC
Date: Fri, 21 Mar 2014 23:03:01 +0900
Message-ID: <001b01cf450e$458f9490$d0aebdb0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:45425 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867AbaCUODC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Mar 2014 10:03:02 -0400
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Alim Akhtar' <alim.akhtar@samsung.com>

Even though 1MB is reserved for descriptor table in IDMAC,
the dw_mmc host driver is allowed to receive only maximum
128KB block length in one request. This is caused by setting
improper max_blk_count. It needs to be e adjusted so that
descriptor table is used fully. It is found that the performance
is improved with the increased the max_blk_count.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 3a6721e..aeb38f9 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2101,9 +2101,9 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
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
1.7.4.1


