From: Will Newton <will.newton@gmail.com>
Subject: [PATCH v2] omap_hsmmc: Reduce max_segs for reliability
Date: Thu, 22 Jun 2017 11:57:53 +0100
Message-ID: <20170622105753.28708-1-willn@resin.io>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36273 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752743AbdFVK6N (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Jun 2017 06:58:13 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, tony@atomide.com, kishon@ti.com, rk@ti.com, Will Newton <willn@resin.io>

Reduce max_segs to 64, a value that allows allocation of an entire
EDMA descriptor list within a single page - EDMA descriptors
are 40 bytes and the header is much larger. This avoids doing a
higher order GFP_ATOMIC allocation in edma_prep_slave_sg
when setting up a transfer which can potentially fail due to
fragmentation under heavy I/O load.

The current value of 1024 is unusually high in comparison to
other mmc host drivers which mostly use values of between 1
and 256. The EDMA driver at present splits lists above 20
segments in any case so reducing the size of lists we pass to
it shouldn't add much overhead.

Signed-off-by: Will Newton <willn@resin.io>
---
 drivers/mmc/host/omap_hsmmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Changes in v2:
 - More verbose commit message
 - Rebased onto current master

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 8c39dcc..bbcca93 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2097,9 +2097,9 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		host->dbclk = NULL;
 	}
 
-	/* Since we do only SG emulation, we can have as many segs
-	 * as we want. */
-	mmc->max_segs = 1024;
+	/* Set this to a value that allows allocating an entire descriptor
+	 * list within a page (zero order allocation). */
+	mmc->max_segs = 64;
 
 	mmc->max_blk_size = 512;       /* Block Length at max can be 1024 */
 	mmc->max_blk_count = 0xFFFF;    /* No. of Blocks is 16 bits */
-- 
2.9.4

