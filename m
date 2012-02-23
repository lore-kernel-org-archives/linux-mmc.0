From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [RFC] mmc: dw_mmc: Fix the max_blk_count in IDMAC
Date: Thu, 23 Feb 2012 16:26:00 +0900
Message-ID: <000301ccf1fc$64e5dbe0$2eb193a0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:26302 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446Ab2BWH0K (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Feb 2012 02:26:10 -0500
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LZU008MS4MXRBK0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 23 Feb 2012 16:26:01 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Exchange Server 7u4-19.01
 64bit (built Sep  7 2010)) with ESMTPA id <0LZU00FP44NDM9E0@mmp1.samsung.com>
 for linux-mmc@vger.kernel.org; Thu, 23 Feb 2012 16:26:01 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, will.newton@imgtec.com, 'James Hogan' <james.hogan@imgtec.com>

Hi all,

Even though 1MB is reserved for descriptor table in IDMAC,
the dw_mmc host driver is allowed to receive only maximum
128KB block length in one request. This is caused by setting
improper max_blk_count. It needs to be e adjusted so that
descriptor table is used fully.

It is found that the performance is improved with the increased the
max_blk_count. In my case, there is 82%(6%) improvement in sequential
write(read). Is there anybody who knows the reason about the old setting?

Best regards,
Seungwon Jeon.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index bf3c9b4..af2b901 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1804,9 +1804,9 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
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
1.7.0.4


