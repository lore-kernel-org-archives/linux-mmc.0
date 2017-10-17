From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 1/2] mmc: renesas_sdhi: fix swiotlb buffer is full
Date: Tue, 17 Oct 2017 16:30:20 +0900
Message-ID: <1508225421-25405-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1508225421-25405-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:20302 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933031AbdJQHeU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Oct 2017 03:34:20 -0400
In-Reply-To: <1508225421-25405-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: wsa+renesas@sang-engineering.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Since the commit de3ee99b097d ("mmc: Delete bounce buffer handling")
deletes the bounce buffer handling, a request data size will be referred
to max_{req,seg}_size instead of MMC_QUEUE_BOUNCESZ (64k bytes).

In other hand, renesas_sdhi_internal_dmac.c will set very big value of
max_{req,seg}_size because the max_blk_count is set to 0xffffffff.
And then, "swiotlb buffer is full" happens because swiotlb can handle
a memory size up to 256k bytes only (IO_TLB_SEGSIZE = 128 and
IO_TLB_SHIFT = 11).

So, this patch fixes the issue to set max_blk_count to 512. Then,
the max_{req,seg}_size will be set to 256k bytes.

Reported-by: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index f905f23..6c9b4b2 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -80,8 +80,9 @@
 	.scc_offset	= 0x1000,
 	.taps		= rcar_gen3_scc_taps,
 	.taps_num	= ARRAY_SIZE(rcar_gen3_scc_taps),
-	/* Gen3 SDHI DMAC can handle 0xffffffff blk count, but seg = 1 */
-	.max_blk_count	= 0xffffffff,
+	/* The swiotlb can handle memory size up to 256 kbytes for now. */
+	.max_blk_count	= 512,
+	/* Gen3 SDHI DMAC cannot handle scatter-gather. So, max_segs = 1 */
 	.max_segs	= 1,
 };
 
-- 
1.9.1

